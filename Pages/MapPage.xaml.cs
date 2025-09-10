using Microsoft.Maui.Controls;
using Microsoft.Maui.Controls.Maps;
using Microsoft.Maui.Maps;
using Newtonsoft.Json;
using StreetLightApp.Models;
using StreetLightApp.Services;
using System.Runtime.CompilerServices;

namespace StreetLightApp.Pages;
using Map = Microsoft.Maui.Controls.Maps.Map;

public partial class MapPage : ContentPage
{
    Site CurrentSite = null;
    public MapPage(Site _site)
    {
        InitializeComponent();
        CurrentSite = _site;
        Dispatcher.Dispatch(async () =>
        {
            await GetAllDevice();
            await ShowDevicesOnMap();
        });
 
 
        MyMap2.PropertyChanged += MyMap2_PropertyChanged;
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
        if (!Provider.MapSites.TryGetValue(CurrentSite.site_id, out var devices))
            return;

        MyMap2.Pins.Clear();

        double? minLat = null, maxLat = null, minLong = null, maxLong = null;


        foreach (var device in devices)
        {
            if (device.lat.HasValue && device.@long.HasValue)
            {
                var pin = new Pin
                {
                    Label = device.device_name,
                    Address = device.description,
                    Location = new Location(device.lat.Value, device.@long.Value),
                    Type = PinType.Place
                };
                MyMap2.Pins.Add(pin);

                // Track bounds for zoom
                minLat = minLat.HasValue ? Math.Min(minLat.Value, device.lat.Value) : device.lat.Value;
                maxLat = maxLat.HasValue ? Math.Max(maxLat.Value, device.lat.Value) : device.lat.Value;
                minLong = minLong.HasValue ? Math.Min(minLong.Value, device.@long.Value) : device.@long.Value;
                maxLong = maxLong.HasValue ? Math.Max(maxLong.Value, device.@long.Value) : device.@long.Value;
            }
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

    }
}