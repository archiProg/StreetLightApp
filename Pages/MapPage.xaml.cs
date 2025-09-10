using Microsoft.Maui.ApplicationModel.Communication;
using Microsoft.Maui.Controls;
using Microsoft.Maui.Controls.Maps;
using Microsoft.Maui.Maps;
using Newtonsoft.Json;
using StreetLightApp.Models;
using StreetLightApp.Services;
using System.Runtime.CompilerServices;

namespace StreetLightApp.Pages;

public partial class MapPage : ContentPage
{
    Site CurrentSite = null;
    int ContactPickIndex = 0;
    int GroupPickIndex = 0;

    public MapPage(Site _site)
    {
        InitializeComponent();
        CurrentSite = _site;

        MyMap2.PropertyChanged += MyMap2_PropertyChanged;
        SitePick.ItemsSource = Provider.SiteList;
        var index = Provider.SiteList.FindIndex(x => x.site_id == _site.site_id);
        if (index >= 0)
        {
            SitePick.SelectedIndex = index;
        }
        SitePick.SelectedIndexChanged += SitePick_SelectedIndexChanged;
        Dispatcher.Dispatch(async () =>
        {
            if (!Provider.MapSites.ContainsKey(CurrentSite.site_id))
            {
                await GetAllDevice();
            }
            await ShowDevicesOnMap();
        });

        List<string> apiGroups = ["1200", "1300", "1400"];
        var groups = new List<string> { "All Group" };
        if (apiGroups != null && apiGroups.Count > 0)
        {
            groups.AddRange(apiGroups);
        }
        GroupPick.ItemsSource = groups;
        GroupPick.SelectedIndex = 0;

        List<string> apiContacts = ["1200", "1300", "1400"];
        var contacts = new List<string> { "All Contacts" };
        if (apiContacts != null && apiContacts.Count > 0)
        {
            contacts.AddRange(apiContacts);
        }
        ContactPick.ItemsSource = contacts;
        ContactPick.SelectedIndex = 0;
    }


    private void SitePick_SelectedIndexChanged(object sender, EventArgs e)
    {
        var picker = (Picker)sender;
        int selectedIndex = picker.SelectedIndex;

        if (picker.SelectedIndex != -1)
        {
            var selectedSite = (Site)picker.SelectedItem;
            CurrentSite = selectedSite;
        }
    }


    private void ContactPick_SelectedIndexChanged(object sender, EventArgs e)
    {
        var picker = (Picker)sender;
        int selectedIndex = picker.SelectedIndex;

        if (selectedIndex != -1)
        {
            if (selectedIndex == 0)
            {
                ContactPickIndex = selectedIndex;
            }
            else
            {
                string selectedGroup = (string)picker.SelectedItem;
                ContactPickIndex = selectedIndex;
            }
        }
    }

    private void GroupPick_SelectedIndexChanged(object sender, EventArgs e)
    {
        var picker = (Picker)sender;
        int selectedIndex = picker.SelectedIndex;

        if (selectedIndex != -1)
        {
            if (selectedIndex == 0)
            {
                GroupPickIndex = selectedIndex;
            }
            else
            {
                string selectedGroup = (string)picker.SelectedItem;
                GroupPickIndex = selectedIndex;
            }
        }
    }


    async Task GetAllDevice()
    {
        Console.WriteLine($"{Provider.APIHost}/api/get-devicelist/{CurrentSite.site_id}");
        var response = await RequestApi.GetAPIJWT($"{Provider.APIHost}/api/get-devicelist/{CurrentSite.site_id}");

        if (response.HttpStatusCode != System.Net.HttpStatusCode.OK)
        {
            await DisplayAlert("Error", $"Failed to get device list: {response.Message}", "OK");
            return;
        }

        Console.WriteLine($"GetAllDevice:::{response.Message}");
        var deviceList = JsonConvert.DeserializeObject<List<MyDevice>>(response?.Message?.ToString());
        if (deviceList == null || deviceList.Count == 0)
            return;

        if (Provider.MapSites == null)
            Provider.MapSites = new Dictionary<int, List<MyDevice>>();

        if (!Provider.MapSites.ContainsKey(CurrentSite.site_id))
        {
            Provider.MapSites[CurrentSite.site_id] = new List<MyDevice>();
        }

        foreach (var device in deviceList)
        {
            MyDevice finalDevice = null;

            if (device.type == "gateway")
            {
                finalDevice = new DeviceNode(device)
                {
                    controls = device.controls,
                    config = device.config
                };
            }
            else
            {
                switch (device.device_style)
                {
                    case 3: // Dimmer
                        Dimmer dimmer = new Dimmer(device)
                        {
                            config = device.config
                        };

                        foreach (var control in device.controls)
                        {
                            switch (control.control_id)
                            {
                                case 0:
                                    dimmer.SetOnline((int)control.last_value); break;
                                case 1:
                                    dimmer.SetDim((int)control.last_value); break;
                                case 2:
                                    dimmer.SetStatus((int)control.last_value); break;
                                case 10:
                                    dimmer.SetPercentage((int)control.last_value); break;
                                case 11:
                                    dimmer.SetTemp(control.last_value); break;
                                case 12:
                                    dimmer.SetCharge((int)control.last_value); break;
                                case 13:
                                    dimmer.SetPowerVolt(control.last_value); break;
                                case 14:
                                    dimmer.SetPowerCurrent(control.last_value); break;
                                case 15:
                                    dimmer.SetPowerOutVolt(control.last_value); break;
                                case 16:
                                    dimmer.SetPowerOutCurrent(control.last_value); break;
                                case 17:
                                    dimmer.SetBattVolt(control.last_value); break;
                                case 18:
                                    dimmer.SetCapacity(control.last_value); break;
                                case 19:
                                    dimmer.SetBattHealth((int)control.last_value); break;
                                case 20:
                                    dimmer.SetCycleCount((int)control.last_value); break;
                            }
                        }

                        finalDevice = dimmer;
                        break;

                    default:
                        // handle other device types if needed
                        finalDevice = new DeviceNode(device)
                        {
                            controls = device.controls,
                            config = device.config
                        };
                        break;
                }
            }

            if (finalDevice != null)
                Provider.MapSites[CurrentSite.site_id].Add(finalDevice);
        }
    }


    async Task ShowDevicesOnMap()
    {
        MyMap2.Pins.Clear();

        if (!Provider.MapSites.TryGetValue(CurrentSite.site_id, out var devices))
        {
            await DisplayAlert("No Devices", $"No devices found for site: {CurrentSite.site_name}", "OK");
            return;
        }


        double? minLat = null, maxLat = null, minLong = null, maxLong = null;


        foreach (var device in devices)
        {
            if (ContactPickIndex == 0 && GroupPickIndex == 0)
            {
                if (device.lat.HasValue && device.@long.HasValue)
                {
                    var pin = new Pin
                    {
                        Label = device.device_name,
                        Address = device.description,
                        Location = new Location(device.lat.Value, device.@long.Value),
                        Type = PinType.Place,
                    };
                    MyMap2.Pins.Add(pin);

                    // Track bounds for zoom
                    minLat = minLat.HasValue ? Math.Min(minLat.Value, device.lat.Value) : device.lat.Value;
                    maxLat = maxLat.HasValue ? Math.Max(maxLat.Value, device.lat.Value) : device.lat.Value;
                    minLong = minLong.HasValue ? Math.Min(minLong.Value, device.@long.Value) : device.@long.Value;
                    maxLong = maxLong.HasValue ? Math.Max(maxLong.Value, device.@long.Value) : device.@long.Value;
                }
            }
        }

        if (MyMap2.Pins.Count == 0) {
            //await DisplayAlert("No Devices", $"No devices found for site: {CurrentSite.site_name} Contact: {}  Group:", "OK");
        }

        if (minLat.HasValue && minLong.HasValue && maxLat.HasValue && maxLong.HasValue)
        {
            // Center of all devices
            var centerLat = (minLat.Value + maxLat.Value) / 2;
            var centerLong = (minLong.Value + maxLong.Value) / 2;

            // Approximate visible distance (1 degree ~ 111 km)
            var latDistance = maxLat.Value - minLat.Value;
            var longDistance = maxLong.Value - minLong.Value;
            var radiusMeters = Math.Max(latDistance, longDistance) * 111000 / 2;

            MyMap2.MoveToRegion(MapSpan.FromCenterAndRadius(
                new Location(centerLat, centerLong),
                Distance.FromMeters(radiusMeters)
            ));
        }
    }



    private void MyMap2_PropertyChanged(object? sender, System.ComponentModel.PropertyChangedEventArgs e)
    {
        if (e.PropertyName == nameof(MyMap2.VisibleRegion))
        {
            var zoomLevel = CalculateZoomLevel(MyMap2.VisibleRegion);
            Console.WriteLine("Map zoom changed. Estimated Zoom Level: " + zoomLevel);
        }
    }

    private int CalculateZoomLevel(MapSpan region)
    {
        double latitudeDelta = region.LatitudeDegrees;

        // Rough approximation
        double zoomLevel = Math.Log(360 / latitudeDelta, 2);
        return (int)Math.Round(zoomLevel);
    }

    private void DeviceSearchTxt_Focused(object sender, FocusEventArgs e)
    {

    }

    private void DeviceSearchTxt_Unfocused(object sender, FocusEventArgs e)
    {

    }

    private void OnSearchButtonClicked(object sender, EventArgs e)
    {
        Dispatcher.Dispatch(async () =>
        {
            if (!Provider.MapSites.ContainsKey(CurrentSite.site_id))
            {
                await GetAllDevice();
            }
            await ShowDevicesOnMap();
        });
    }


}