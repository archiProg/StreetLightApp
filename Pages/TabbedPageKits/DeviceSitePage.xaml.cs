using Microsoft.Maui.Controls;
using Newtonsoft.Json;
using RestSharp;
using StreetLightApp.Models;
using StreetLightApp.Services;
using System.Collections.ObjectModel;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class DeviceSitePage : ContentPage
{

    Site CurrentSite = null;
    private List<DeviceNode> _allDevices = new();
    private List<DeviceNode> SelectDevices = new();
    private List<DeviceNode> SelectAllDevices = new();

    private int _loadedCount = 0;
    private const int PageSize = 20;
    private bool _isLoading = false;
    int totalDevices = 0;

    private bool _isUpdatingSelectAll = false;
    private bool IsSelectAll = false;

    public DeviceSitePage(Site _site)
    {
        InitializeComponent();
        Provider.FocusSite.Clear();
        Title = _site.site_name;
        CurrentSite = _site;
        GetAllDevice();

    }

    protected override void OnDisappearing()
    {
        base.OnDisappearing();
    }

    private async void LoadMoreItems()
    {
        if (_isLoading) return;
        _isLoading = true;
        SelectAllCheckBox.IsEnabled = false;
        LoadingIndicator.IsVisible = true;
        LoadingIndicator.IsRunning = true;

        new Thread(() =>
        {

            int remaining = _allDevices.Count - _loadedCount;
            int toLoad = Math.Min(PageSize, remaining);

            var newItems = new List<Views.DeviceItems>();

            for (int i = 0; i < toLoad; i++)
            {

                var dev = _allDevices[_loadedCount++];
                if (dev != null)
                {
                    var deviceItem = new Views.DeviceItems(dev);

                    deviceItem.CheckedChanged += DeviceItem_CheckedChanged;
                    if (dev.type != "gateway")
                    {
                        deviceItem.SetChecked(IsSelectAll);
                    }
                    if (dev.type == "gateway") {
                        Console.WriteLine($"Gateway:::::::::::{dev.gateway_name}");
                    }
                    newItems.Add(deviceItem);
                }
            }

            MainThread.BeginInvokeOnMainThread(() =>
           {
               foreach (var item in newItems)
               {
                   DeviceStack.Children.Add(item);
               }

               LoadingIndicator.IsRunning = false;
               LoadingIndicator.IsVisible = false;

               _isLoading = false;
               SelectAllCheckBox.IsEnabled = true;
           });


        }).Start();

    }
    private void OnDeviceScroll(object sender, ScrolledEventArgs e)
    {
        var scroll = (ScrollView)sender;

        if (e.ScrollY >= scroll.ContentSize.Height - scroll.Height - 50)
        {
            LoadMoreItems();
        }
    }


    private async void GenItems() { 
    
    
    
    }


    private void DeviceItem_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        if (sender is DeviceNode item)
        {
            bool isChecked = e.Value;
            if (isChecked)
            {
                if (SelectDevices.Count == 0)
                {
                    ControlMenu.IsVisible = true;
                }
                SelectDevices.Add(item);
                if (SelectDevices.Count == totalDevices)
                {
                    SelectAllCheckBox.IsChecked = true;
                }
            }
            else
            {
                if (SelectDevices.Count == totalDevices)
                {
                    _isUpdatingSelectAll = true;
                    SelectAllCheckBox.IsChecked = false;
                    _isUpdatingSelectAll = false;
                    IsSelectAll = false;
                }
                SelectDevices.Remove(item);
                if (SelectDevices.Count == 0)
                {
                    ControlMenu.IsVisible = false;
                }
            }

            if (!IsSelectAll)
            {
                LbDevicelist.Text = $"Control ({SelectDevices.Count} Lamps)";
            }
            Console.WriteLine($"Device {item.device_name} {(isChecked ? "Checked" : "Unchecked")}");
        }
    }

    async Task GetAllDevice()
    {
        Console.WriteLine($"{Provider.APIHost}/api/get-devicelist/{CurrentSite.site_id}");
        var response = await RequestApi.GetAPIJWT($"{Provider.APIHost}/api/get-devicelist/{CurrentSite.site_id}");
        if (response.HttpStatusCode == System.Net.HttpStatusCode.OK)
        {
            Console.WriteLine($"GetAllDevice:::{response.Message}");
            var deviceList = JsonConvert.DeserializeObject<List<DeviceNode>>(response?.Message?.ToString());
            if (deviceList != null)
            {

                foreach (var device in deviceList)
                {
                    if (device.type == "gateway")
                    {
                        Console.WriteLine($"gateway::::::::::::::::::::::::::::::: {device.gateway_name}");
                        var gateway = new FocusGatewayModel
                        {
                            gateway_id = device.gateway_id,
                            GatewayName = device.gateway_name,
                            Status = 1,
                            contract_id = device.contract_id,
                            contract_number = device.contract_number,
                            gateway_lat = device.gateway_lat,
                            gateway_long = device.gateway_long,
                        };
                        if (!Provider.FocusSite.Any(g => g.gateway_id == device.gateway_id))
                        {
                            Provider.FocusSite.Add(gateway);
                            Console.WriteLine($"GW:::::::::::{gateway.GatewayName}");
                        }
                    }
                    else
                    {
                        var gateway = Provider.FocusSite.FirstOrDefault(g => g.gateway_id == device.gateway_id);
                        if (gateway == null)
                        {
                            Console.WriteLine($"Gateway not found for device {device.device_name}");
                            continue;
                        }
                        Console.WriteLine($"Devices:::::::::::::::::::device.device_style  {device.device_style}:::::::::::::::::::::::");
                        switch (device.device_style)
                        {
                            case 1://Air condition
                                foreach (var control in device.controls)
                                {
                                    switch (control.control_id)
                                    {
                                        case 0://Online

                                            break;
                                        case 1://Status

                                            break;
                                    }
                                }
                                break;
                            case 2://Curtain
                                foreach (var control in device.controls)
                                {

                                    switch (control.control_id)
                                    {
                                        case 0://Online

                                            break;
                                        case 1://Status 1

                                            break;
                                        case 2://Status 2

                                            break;
                                    }
                                }
                                break;
                            case 3://Dimmer
                                Console.WriteLine("case 3://Dimmer::::::::::::::::::::::::::::::::::");
                                Dimmer dimmer = new Dimmer
                                {
                                    Name = device.device_name,
                                    DeviceID = device.device_id == null ? 0 : (int)device.device_id,
                                    MemberID = device.gateway_id,
                                };
                                Console.WriteLine($"dimmer:::::{dimmer.Name} | {dimmer.DeviceID} | {dimmer.MemberID}::::::::::::::::::::::::::");
                                foreach (var control in device.controls)
                                {

                                    switch (control.control_id)
                                    {
                                        case 0://Online
                                            dimmer.Online = (int)control.last_value;
                                            dimmer.SetOnline((int)control.last_value);
                                            break;
                                        case 1://Brightness %
                                            dimmer.Dimvalue = (int)control.last_value;
                                            dimmer.SetDim((int)control.last_value);
                                            break;
                                        case 2://Status 
                                            dimmer.Status = (int)control.last_value;
                                            dimmer.SetStatus((int)control.last_value);
                                            break;
                                        case 10://percentage batt
                                            dimmer.Percentage = (int)control.last_value;
                                            dimmer.SetPercentage((int)control.last_value);
                                            break;
                                        case 11://temp ℃
                                            dimmer.Temp = control.last_value;
                                            dimmer.SetTemp(control.last_value);
                                            break;
                                        case 12://Status charge
                                            dimmer.Charge = (int)control.last_value;
                                            dimmer.SetCharge((int)control.last_value);
                                            break;
                                        case 13:// Input powerVolt  V xxx
                                            dimmer.PowerVolt = control.last_value;
                                            dimmer.SetPowerVolt(control.last_value);
                                            break;
                                        case 14://Input powerCurrent mA
                                            dimmer.PowerCurrent = control.last_value;
                                            dimmer.SetPowerCurrent(control.last_value);
                                            break;
                                        case 15://powerOutVolt V xxx
                                            dimmer.PowerOutVolt = control.last_value;
                                            dimmer.SetPowerOutVolt(control.last_value);
                                            break;
                                        case 16://powerOutCurrent mA
                                            dimmer.PowerOutCurrent = control.last_value;
                                            dimmer.SetPowerOutCurrent(control.last_value);
                                            break;
                                        case 17://batt_volt V
                                            dimmer.BattVolt = control.last_value;
                                            dimmer.SetBattVolt(control.last_value);
                                            break;
                                        case 18://capacity Ah
                                            dimmer.Capacity = control.last_value;
                                            dimmer.SetCapacity(control.last_value);
                                            break;
                                        case 19://batt_health %
                                            dimmer.BattHealth = (int)control.last_value;
                                            dimmer.SetBattHealth((int)control.last_value);
                                            break;
                                        case 20://cycle_count 
                                            dimmer.CycleCount = (int)control.last_value;
                                            dimmer.SetCycleCount((int)control.last_value);
                                            break;
                                    }

                                }
                                gateway.Dimmers.Add(dimmer);
                                Console.WriteLine($"dimmer.DeviceID:::::::::::::::::::::::::::{dimmer.DeviceID}");
                                gateway.DEVICE_TYPE.Add(new Dictionary<int, int> { { dimmer.DeviceID, 3 } });
                                break;

                        }
                    }

                    _allDevices = deviceList;
                    totalDevices = deviceList.FindAll(x => x.type != "gateway").Count;
                    SelectAllDevices = deviceList.FindAll(x => x.type != "gateway");
                    _loadedCount = 0;
                    DeviceStack.Children.Clear();
                    LoadMoreItems();
                    //GenItems();
                }
                TotalDevices.Text = $"({totalDevices.ToString()})";
                TotalSelects.Text = $"(Up to {totalDevices} Items)";
            }
            else
            {
                await DisplayAlert("Error", $"Failed to get device list: {response.Message}", "OK");
            }
        }
    }


    private void OnSelectAllCheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        if (_isUpdatingSelectAll) return;

        bool isChecked = e.Value;
        IsSelectAll = isChecked;

        if (isChecked)
        {
            ControlMenu.IsVisible = true;
            foreach (var child in DeviceStack.Children)
            {
                if (child is Views.DeviceItems deviceItem)
                {
                    deviceItem.SetChecked(true);
                }
            }
        }
        else
        {
            ControlMenu.IsVisible = false;
            SelectDevices.Clear();

            foreach (var child in DeviceStack.Children)
            {
                if (child is Views.DeviceItems deviceItem)
                {
                    deviceItem.SetChecked(false);
                }
            }
        }

        LbDevicelist.Text = $"Control ({SelectAllDevices.Count} Lamps)";
    }


    private void OnClearlChecked(object sender, EventArgs e)
    {
        IsSelectAll = false;
        ControlMenu.IsVisible = false;
        SelectDevices.Clear();
        SelectAllCheckBox.IsChecked = false;
        foreach (var child in DeviceStack.Children)
        {
            if (child is Views.DeviceItems deviceItem)
            {
                deviceItem.SetChecked(false);
            }
        }
    }

    private void OnSearchButtonClicked(object sender, EventArgs e)
    {
        string keyword = DeviceSearchTxt.Text?.Trim().ToLower() ?? string.Empty;
        _loadedCount = 0;
        DeviceStack.Children.Clear();
        List<DeviceNode> filtered;
        if (string.IsNullOrEmpty(keyword))
        {
            filtered = _allDevices.ToList();
        }
        else
        {
            filtered = _allDevices
                .Where(d =>
                    (!string.IsNullOrEmpty(d.device_name) && d.device_name.ToLower().Contains(keyword))
                )
                .ToList();
        }

        var originalAllDevices = _allDevices;
        _allDevices = filtered;
        LoadMoreItems();
        _allDevices = originalAllDevices;
    }

    private void DeviceSearchTxt_Focused(object sender, FocusEventArgs e)
    {
        searchIcon.IsVisible = false;
    }

    private void DeviceSearchTxt_Unfocused(object sender, FocusEventArgs e)
    {
        searchIcon.IsVisible = true;
    }

    private async void OnManageClicked(object sender, EventArgs e)
    {
        if (IsSelectAll)
        {
            await Navigation.PushAsync(new ManageDevicePage(CurrentSite, SelectAllDevices));

        }
        else
        {
            await Navigation.PushAsync(new ManageDevicePage(CurrentSite, SelectDevices));

        }

    }

    private void mySlider_HandlerChanged(object sender, EventArgs e)
    {

    }

    private void mySlider_DragCompleted(object sender, EventArgs e)
    {

    }
}