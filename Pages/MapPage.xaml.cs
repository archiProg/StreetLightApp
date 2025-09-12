using Microsoft.Maui.ApplicationModel.Communication;
using Microsoft.Maui.Controls;
using Microsoft.Maui.Controls.Maps;
using Microsoft.Maui.Maps;
using Newtonsoft.Json;
using StreetLightApp.Models;
using StreetLightApp.Services;
using System.Collections.ObjectModel;
using System.Net.NetworkInformation;
using System.Runtime.CompilerServices;

namespace StreetLightApp.Pages;

public partial class MapPage : ContentPage
{
    Site CurrentSite = null;
    int ContactId = 0;
    int GroupId = 0;
    private bool CanToggle = true;

    private bool ShowMoreDetail = false;
    private bool IsDetailDevice = false;

    Dimmer CurrentDevice;

    Dictionary<int, string> ContactsList = new Dictionary<int, string>
{
    { 0, "Contact Number All" }
};
    Dictionary<int, string> GroupsList = new Dictionary<int, string>
{
    { 0, "Group All" }
};

    Dictionary<string, MapPin> devicePins = new Dictionary<string, MapPin>();

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
                // "All Contacts" selected
                ContactId = 0;
            }
            else
            {
                // Get the selected contact name
                string selectedContactName = picker.Items[selectedIndex];

                // Lookup the ID from the dictionary
                ContactId = ContactsList.FirstOrDefault(x => x.Value == selectedContactName).Key;

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
                // "All Group" selected
                GroupId = 0;
            }
            else
            {
                // Get the selected group name
                string selectedGroupName = picker.Items[selectedIndex];

                // Lookup the ID from the dictionary
                GroupId = GroupsList.FirstOrDefault(x => x.Value == selectedGroupName).Key;
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
            if (device.contract_id != null && !ContactsList.ContainsKey(device.contract_id))
            {
                ContactsList[device.contract_id] = device.contract_number;
            }

            if (device.group_id.HasValue && !GroupsList.ContainsKey(device.group_id.Value))
            {
                GroupsList[device.group_id.Value] = device.group_name;
            }
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

        ContactPick.ItemsSource = ContactsList.ToList();
        ContactPick.ItemDisplayBinding = new Binding("Value");
        ContactPick.SelectedIndex = 0;


        GroupPick.ItemsSource = GroupsList.ToList();
        GroupPick.ItemDisplayBinding = new Binding("Value");
        GroupPick.SelectedIndex = 0;
    }


    async Task ShowDevicesOnMap()
    {
        Title = CurrentSite.site_name;
        MyMap2.CustomPins.Clear();
        devicePins.Clear();
        var list = new ObservableCollection<MapPin>();
        if (!Provider.MapSites.TryGetValue(CurrentSite.site_id, out var devices))
        {
            MyMap2.CustomPins = list;
            await DisplayAlert("No Devices", $"No devices found for site: {CurrentSite.site_name}", "OK");
            return;
        }


        double? minLat = null, maxLat = null, minLong = null, maxLong = null;


        foreach (var device in devices)
        {
            if (ContactPick.SelectedIndex == 0 && GroupPick.SelectedIndex == 0)
            {
                if (device.lat.HasValue && device.@long.HasValue)
                {
                    MapPin pin = null;

                    if (device.type == "gateway")
                    {
                        if (device is DeviceNode deviceNode)
                        {
                            pin = new MapPin(MapPinClicked)
                            {
                                Id = Guid.NewGuid().ToString(),
                                Position = new Location(deviceNode.lat.Value, deviceNode.@long.Value),
                                IconSrc = GetGateWayIcon(deviceNode),
                                Label = deviceNode.gateway_name,
                                Address = deviceNode.contract_id.ToString(),
                                DeviceType = deviceNode.type,
                                Online = deviceNode.Online,

                            };
                            deviceNode.OnlineHandler += (s, online) => UpdateGateWayStatus((DeviceNode)s);
                        }

                    }
                    else
                    {

                        if (device is Dimmer dimmer)
                        {
                            pin = new MapPin(MapPinClicked)
                            {
                                Id = Guid.NewGuid().ToString(),
                                Position = new Location(dimmer.lat.Value, device.@long.Value),
                                IconSrc = GetDimmerIcon(dimmer),
                                Label = dimmer.device_name,
                                Address = dimmer.description,
                                DeviceType = "dimmer",
                                Online = dimmer.Online,
                                Status = dimmer.Status,
                                DeviceId = (int)dimmer.device_id,
                                GateWayId = dimmer.gateway_id

                            };

                            dimmer.OnlineHandler += (s, online) => UpdateDeviceStatus((Dimmer)s);
                            dimmer.StatusHandler += (s, status) => UpdateDeviceStatus((Dimmer)s);
                        }


                    }

                    if (pin != null)
                    {
                        list.Add(pin);
                        if (device.type == "gateway")
                        {
                            devicePins[device.gateway_id.ToString()] = pin;
                        }
                        else
                        {
                            pin.MarkerClickHandler += Pin_MarkerClickHandler;
                            devicePins[((int)device.device_id).ToString() + device.gateway_id.ToString()] = pin;
                        }
                    }

                    // Track bounds for zoom
                    minLat = minLat.HasValue ? Math.Min(minLat.Value, device.lat.Value) : device.lat.Value;
                    maxLat = maxLat.HasValue ? Math.Max(maxLat.Value, device.lat.Value) : device.lat.Value;
                    minLong = minLong.HasValue ? Math.Min(minLong.Value, device.@long.Value) : device.@long.Value;
                    maxLong = maxLong.HasValue ? Math.Max(maxLong.Value, device.@long.Value) : device.@long.Value;
                }
            }
            else
            {
                // Get selected ContactId and GroupId
                int selectedContactId = ContactId; // store when ContactPick_SelectedIndexChanged is triggered
                int selectedGroupId = GroupId;     // store when GroupPick_SelectedIndexChanged is triggered

                // Check if device matches selected contact and/or group
                bool matchContact = selectedContactId == 0 || device.contract_id == selectedContactId;
                bool matchGroup = selectedGroupId == 0 || (device.group_id.HasValue && device.group_id.Value == selectedGroupId);

                if (matchContact && matchGroup && device.lat.HasValue && device.@long.HasValue)
                {
                    MapPin pin = null;

                    if (device.type == "gateway" && device is DeviceNode deviceNode)
                    {
                        pin = new MapPin(MapPinClicked)
                        {
                            Id = Guid.NewGuid().ToString(),
                            Position = new Location(deviceNode.lat.Value, deviceNode.@long.Value),
                            IconSrc = GetGateWayIcon(deviceNode),
                            Label = deviceNode.gateway_name,
                            Address = deviceNode.contract_id.ToString(),
                            DeviceType = deviceNode.type,
                            Online = deviceNode.Online,
                        };
                        deviceNode.OnlineHandler += (s, online) => UpdateGateWayStatus((DeviceNode)s);
                    }
                    else if (device is Dimmer dimmer)
                    {
                        pin = new MapPin(MapPinClicked)
                        {
                            Id = Guid.NewGuid().ToString(),
                            Position = new Location(dimmer.lat.Value, device.@long.Value),
                            IconSrc = GetDimmerIcon(dimmer),
                            Label = dimmer.device_name,
                            Address = dimmer.description,
                            DeviceType = "dimmer",
                            Online = dimmer.Online,
                            Status = dimmer.Status,
                            DeviceId = (int)dimmer.device_id,
                            GateWayId = dimmer.gateway_id

                        };
                        dimmer.OnlineHandler += (s, online) => UpdateDeviceStatus((Dimmer)s);
                        dimmer.StatusHandler += (s, status) => UpdateDeviceStatus((Dimmer)s);
                    }

                    if (pin != null)
                    {
                        list.Add(pin);
                        if (device.type == "gateway")
                            devicePins[device.gateway_id.ToString()] = pin;
                        else
                            pin.MarkerClickHandler += Pin_MarkerClickHandler;
                        devicePins[((int)device.device_id).ToString() + device.gateway_id.ToString()] = pin;
                    }

                    // Update map bounds
                    minLat = minLat.HasValue ? Math.Min(minLat.Value, device.lat.Value) : device.lat.Value;
                    maxLat = maxLat.HasValue ? Math.Max(maxLat.Value, device.lat.Value) : device.lat.Value;
                    minLong = minLong.HasValue ? Math.Min(minLong.Value, device.@long.Value) : device.@long.Value;
                    maxLong = maxLong.HasValue ? Math.Max(maxLong.Value, device.@long.Value) : device.@long.Value;
                }
            }
        }

        MyMap2.CustomPins = list;

        if (MyMap2.CustomPins.Count == 0)
        {
            await DisplayAlert("No Devices",
                $"No devices found for site: {CurrentSite.site_name} Contact: {ContactsList[ContactId]}  Group: {GroupsList[GroupId]}", "OK");
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

    private void Pin_MarkerClickHandler(object? sender, int e)
    {
        if (sender is MapPin pin)
        {
            if (pin.DeviceType != "gateway")
            {
                IsDetailDevice = true;
                SearchDetailDevice.IsVisible = false;
                DetailDevice.IsVisible = true;
                BtBack.IsVisible = true;
                var _SelectDevice = Provider.MapSites[CurrentSite.site_id].Find(d => d.device_id == pin.DeviceId && d.gateway_id == pin.GateWayId);
                if (_SelectDevice is Dimmer dimmer)
                {
                    ShowMoreDetail = true;
                    ButtomSheet.Source = ShowMoreDetail? "off_buttom_sheet_icon.png": "open_buttom_sheet_icon.png";
                    CurrentDevice = dimmer;
                    DeviceName.Text = dimmer.device_name;
                    lbSlider.Text = $"{(int)dimmer.Dimvalue}%";
                    mySlider.Value = (int)dimmer.Dimvalue;
                    statusSwitch.IsToggled = (int)dimmer.Status == 1;
                    SetStatus(dimmer.Status);
                    SetDimmer(dimmer.Dimvalue);
                    SetTemp(dimmer.Temp);
                    SetBatteryLevel(dimmer.Percentage);
                    SetBatteryIn(dimmer.PowerCurrent);
                    SetBatteryOut(dimmer.PowerOutCurrent);
                    SetBattVoltOut(dimmer.BattVolt);
                    SetBattCapacity(dimmer.Capacity);
                    SetBattHealt(dimmer.BattHealth);
                    SetCycleCount(dimmer.CycleCount);
                    SetCharge(dimmer.Charge);
                    dimmer.StatusHandler += Dimmer_StatusHandler;
                    dimmer.DimChangeHandler += Dimmer_DimChangeHandler;
                    dimmer.TempHandler += Dimmer_TempHandler;
                    dimmer.PercentageHandler += Dimmer_PercentageHandler;
                    dimmer.PowerCurrentHandler += Dimmer_PowerCurrentHandler;
                    dimmer.PowerOutCurrentHandler += Dimmer_PowerOutCurrentHandler;
                    dimmer.BattVoltHandler += Dimmer_BattVoltHandler;
                    dimmer.CapacityHandler += Dimmer_CapacityHandler;
                    dimmer.BattHealthHandler += Dimmer_BattHealthHandler;
                    dimmer.CycleCountHandler += Dimmer_CycleCountHandler;
                    dimmer.ChargeHandler += Dimmer_ChargeHandler;
                }
            }
        }
    }

    private string GetDimmerIcon(Dimmer dimmer)
    {
        if (dimmer.Online != 1) return "lamp_offline";
        return dimmer.Status == 1 ? "lamp_on" : "lamp_off";
    }

    private void UpdateDeviceStatus(Dimmer dimmer)
    {
        if (devicePins.TryGetValue(((int)dimmer.device_id).ToString() + dimmer.gateway_id.ToString(), out var pin))
        {
            pin.IconSrc = GetDimmerIcon(dimmer);
            pin.Online = dimmer.Online;
            pin.Status = dimmer.Status;

            UpdatePinOnMap(pin);
        }
    }


    private string GetGateWayIcon(DeviceNode _deviceNode)
    {
        return _deviceNode.Online == 1 ? "gateway_online" : "gateway_offline";
    }

    private void UpdateGateWayStatus(DeviceNode _deviceNode)
    {
        if (devicePins.TryGetValue(((int)_deviceNode.device_id).ToString() + _deviceNode.gateway_id.ToString(), out var pin))
        {
            pin.IconSrc = GetGateWayIcon(_deviceNode);
            pin.Online = _deviceNode.Online;

            UpdatePinOnMap(pin);
        }
    }

    private void UpdatePinOnMap(MapPin pin)
    {
        Dispatcher.Dispatch(() =>
        {
#if ANDROID
            if (MyMap2?.Handler is StreetLightApp.Platforms.Android.Handlers.CustomMapHandler handler)
            {
                handler.UpdatePin(pin);
            }
#endif
        });
    }

    private void MapPinClicked(MapPin pin)
    {
        // Handle pin click
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
        ShowMoreDetail = true;
        ButtomSheet.Source = ShowMoreDetail
    ? "off_buttom_sheet_icon.png"
    : "open_buttom_sheet_icon.png";
        Dispatcher.Dispatch(async () =>
        {
            if (ShowMoreDetail)
            {

                if (IsDetailDevice)
                {

                    DetailDevice.IsVisible = true;
                    DetailDevice.TranslationY = 50;
                    await Task.WhenAll(
        DetailDevice.FadeTo(1, 250, Easing.CubicOut),
        DetailDevice.TranslateTo(0, 0, 250, Easing.CubicOut)
    );
                }
                else
                {
                    MoreDetail.IsVisible = true;
                    MoreDetail.TranslationY = 50;
                    await Task.WhenAll(
        MoreDetail.FadeTo(1, 250, Easing.CubicOut),
        MoreDetail.TranslateTo(0, 0, 250, Easing.CubicOut)
    );
                }
            }
            else
            {
                if (IsDetailDevice)
                {



                    await Task.WhenAll(
                        DetailDevice.FadeTo(0, 250, Easing.CubicIn),
                        DetailDevice.TranslateTo(0, 50, 250, Easing.CubicIn)

                    );
                    DetailDevice.IsVisible = false;
                }
                else
                {
                    await Task.WhenAll(
                        MoreDetail.FadeTo(0, 250, Easing.CubicIn),
                        MoreDetail.TranslateTo(0, 50, 250, Easing.CubicIn)

                    );
                    MoreDetail.IsVisible = false;
                }


            }
        });
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


    private async void Button_Clicked(object sender, EventArgs e)
    {
        if (!CanToggle) return;
        CanToggle = false;

        ShowMoreDetail = !ShowMoreDetail;
        ButtomSheet.Source = ShowMoreDetail
            ? "off_buttom_sheet_icon.png"
            : "open_buttom_sheet_icon.png";

        if (ShowMoreDetail)
        {
            if (IsDetailDevice)
            {

                DetailDevice.IsVisible = true;
                DetailDevice.TranslationY = 50;
                await Task.WhenAll(
    DetailDevice.FadeTo(1, 250, Easing.CubicOut),
    DetailDevice.TranslateTo(0, 0, 250, Easing.CubicOut)
);
            }
            else
            {
                MoreDetail.IsVisible = true;
                MoreDetail.TranslationY = 50;
                await Task.WhenAll(
    MoreDetail.FadeTo(1, 250, Easing.CubicOut),
    MoreDetail.TranslateTo(0, 0, 250, Easing.CubicOut)
);
            }
        }
        else
        {
            if (IsDetailDevice)
            {
                await Task.WhenAll(
                    DetailDevice.FadeTo(0, 250, Easing.CubicIn),
                    DetailDevice.TranslateTo(0, 50, 250, Easing.CubicIn)

                );
                DetailDevice.IsVisible = false;
            }
            else
            {
                await Task.WhenAll(
                    MoreDetail.FadeTo(0, 250, Easing.CubicIn),
                    MoreDetail.TranslateTo(0, 50, 250, Easing.CubicIn)

                );
                MoreDetail.IsVisible = false;
            }
        }

        await Task.Delay(200);
        CanToggle = true;

        Console.WriteLine("Tapped handler executed!");
    }



    // detail device
    private void BtBack_Clicked(object sender, EventArgs e)
    {
        IsDetailDevice = false;
        if (ShowMoreDetail)
        {
            MoreDetail.IsVisible = true;
        }
        else
        {

            MoreDetail.IsVisible = false;
        }
        SearchDetailDevice.IsVisible = true;
        DetailDevice.IsVisible = false;
        BtBack.IsVisible = false;
    }

    private void SetCharge(int charge)
    {
        Dispatcher.Dispatch(() =>
        {
            ShowStatusChargring.IsVisible = charge == 1;
        });
    }

    private void SetStatus(int status)
    {
        Dispatcher.Dispatch(() =>
        {
            statusSwitch.IsToggled = status == 1;
            LbPowerSatatusValue.Text = status == 1 ? "ON" : "OFF";
            LbPowerSatatusValue.TextColor = status == 1 ? Color.FromArgb("#52C68C") : Color.FromArgb("#EF8484");
        });
    }
    private void SetDimmer(int dimvalue)
    {
        Dispatcher.Dispatch(() =>
        {
            lbSlider.Text = $"{dimvalue}%";
            LbBrightnessValue.Text = $"{dimvalue}%";
            mySlider.Value = dimvalue;
        });
    }

    private void SetTemp(double temp)
    {
        Dispatcher.Dispatch(() =>
        {
            LbTemperatureValue.Text = $"{temp}°C";
        });
    }

    private void SetBatteryLevel(int percentage)
    {
        Dispatcher.Dispatch(() =>
        {
            LbBatteryLevelValue.Text = $"{percentage}%";
        });
    }


    private void SetBatteryIn(double powerCurrent)
    {
        Dispatcher.Dispatch(() =>
        {
            LbBatteryInValue.Text = $"{(powerCurrent / 1000).ToString("N2")} mA";
        });
    }

    private void SetBatteryOut(double powerOutCurrent)
    {
        Dispatcher.Dispatch(() =>
        {
            LbBatteryCurrentOutValue.Text = $"{(powerOutCurrent / 1000).ToString("N2")} mA";
        });
    }

    private void SetBattVoltOut(double battVolt)
    {
        Dispatcher.Dispatch(() =>
        {
            LbBatteryVoltOutValue.Text = $"{(battVolt / 1000).ToString("N2")} mA";
        });
    }

    private void SetBattCapacity(double capacity)
    {
        Dispatcher.Dispatch(() =>
        {
            LbCapacityValue.Text = $"{(capacity / 1000).ToString("N2")} Ah";
        });
    }

    private void SetBattHealt(int battHealth)
    {
        Dispatcher.Dispatch(() =>
        {
            LbBatteryHealthValue.Text = $"{battHealth}%";
        });
    }

    private void SetCycleCount(int cycleCount)
    {
        Dispatcher.Dispatch(() =>
        {
            LbCycleValue.Text = $"{cycleCount}";
        });
    }


    private void Dimmer_StatusHandler(object? sender, int e)
    {
        SetStatus(e);
    }

    private void Dimmer_DimChangeHandler(object? sender, int e)
    {
        SetDimmer(e);
    }

    private void Dimmer_TempHandler(object? sender, double e)
    {
        SetTemp(e);
    }


    private void Dimmer_PercentageHandler(object? sender, int e)
    {
        SetBatteryLevel(e);
    }

    private void Dimmer_PowerCurrentHandler(object? sender, double e)
    {
        SetBatteryIn(e);
    }

    private void Dimmer_PowerOutCurrentHandler(object? sender, double e)
    {
        SetBatteryOut(e);
    }
    private void Dimmer_BattVoltHandler(object? sender, double e)
    {
        SetBattVoltOut(e);
    }

    private void Dimmer_CapacityHandler(object? sender, double e)
    {
        SetBattCapacity(e);
    }

    private void Dimmer_BattHealthHandler(object? sender, int e)
    {
        SetBattHealt(e);
    }


    private void Dimmer_CycleCountHandler(object? sender, int e)
    {
        SetCycleCount(e);
    }

    private void Dimmer_ChargeHandler(object? sender, int e)
    {
        SetCharge(e);
    }

    private void mySlider_DragCompleted(object sender, EventArgs e)
    {
        if (sender is Slider slider)
        {
            Dispatcher.Dispatch(async () =>
            {
                await Provider.SendWsAsync(
                    "3",
                    new
                    {
                        Member = CurrentDevice.gateway_id,
                        Device = CurrentDevice.device_id,
                        Ctrl = 1,
                        V = (int)slider.Value
                    }
                );
            });
        }
    }

    private void mySlider_HandlerChanged(object sender, ValueChangedEventArgs e)
    {
        if (sender is Slider slider)
        {
            lbSlider.Text = $"{(int)slider.Value}%";
        }
    }

    private void statusSwitch_Toggled(object sender, ToggledEventArgs e)
    {
        statusLbl.Text = $"{(e.Value ? "ON" : "OFF")}";
        statusLbl.TextColor = Color.FromArgb($"#{(e.Value ? "52C68C" : "EF8484")}");
        Dispatcher.Dispatch(async () =>
        {

            if (e.Value)
            {
                await Provider.SendWsAsync(
                    "3",
                    new
                    {
                        Member = CurrentDevice.gateway_id,
                        Device = CurrentDevice.device_id,
                        Ctrl = 1,
                        V = CurrentDevice.Dimvalue
                    }
                );
            }
            await Provider.SendWsAsync(
                "3",
                new
                {
                    Member = CurrentDevice.gateway_id,
                    Device = CurrentDevice.device_id,
                    Ctrl = 2,
                    V = e.Value ? 1 : 0
                }
            );

        });
    }
}