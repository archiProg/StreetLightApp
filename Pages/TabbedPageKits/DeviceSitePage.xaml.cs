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
    private List<MyDevice> _allDevices = new();
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
        Provider.SiteDevices.Clear();
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

            var newItems = new List<View>();

            for (int i = 0; i < toLoad; i++)
            {

                var dev = _allDevices[_loadedCount++];
                if (dev != null)
                {
                    View deviceItem = null;

                    if (dev.type == "gateway") {
                        deviceItem = new Views.DeviceItems(dev);
                    }
                    else
                    {

                        switch (dev.device_style)
                        {
                            case 3: // Dimmer
                                if (dev is Dimmer dimmer)
                                {
                                    deviceItem = new Views.DimmerItem(dimmer);
                                    ((Views.DimmerItem)deviceItem).CheckedChanged += DeviceItem_CheckedChanged;
                                }
                                break;

                            default:
                                deviceItem = new Label
                                {
                                    Text = $"Device: {dev.device_name} (Type {dev.device_style})",
                                    Margin = new Thickness(5)
                                }; break;
                        }
                    }
                    if (deviceItem != null)
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

        if (response.HttpStatusCode != System.Net.HttpStatusCode.OK)
        {
            await DisplayAlert("Error", $"Failed to get device list: {response.Message}", "OK");
            return;
        }

        Console.WriteLine($"GetAllDevice:::{response.Message}");
        var deviceList = JsonConvert.DeserializeObject<List<MyDevice>>(response?.Message?.ToString());
        if (deviceList == null || deviceList.Count == 0)
            return;

        Provider.SiteDevices.Clear(); // clear old data

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
                Provider.SiteDevices.Add(finalDevice);
        }

        // update UI
        _allDevices = Provider.SiteDevices;
        totalDevices = Provider.SiteDevices.Count(d => d.type != "gateway");
        DeviceStack.Children.Clear();
        _loadedCount = 0;
        LoadMoreItems();

        TotalDevices.Text = $"({totalDevices})";
        TotalSelects.Text = $"(Up to {totalDevices} Items)";
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
                if (child is Views.DimmerItem deviceItem)
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
                if (child is Views.DimmerItem deviceItem)
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
        //string keyword = DeviceSearchTxt.Text?.Trim().ToLower() ?? string.Empty;
        //_loadedCount = 0;
        //DeviceStack.Children.Clear();
        //List<DeviceNode> filtered;
        //if (string.IsNullOrEmpty(keyword))
        //{
        //    filtered = _allDevices.ToList();
        //}
        //else
        //{
        //    filtered = _allDevices
        //        .Where(d =>
        //            (!string.IsNullOrEmpty(d.device_name) && d.device_name.ToLower().Contains(keyword))
        //        )
        //        .ToList();
        //}

        //var originalAllDevices = _allDevices;
        //_allDevices = filtered;
        //LoadMoreItems();
        //_allDevices = originalAllDevices;
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