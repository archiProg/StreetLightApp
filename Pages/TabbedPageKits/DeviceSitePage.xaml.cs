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
        Title = _site.site_name;
        CurrentSite = _site;
        GetAllDevice();

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
        if (response.HttpStatusCode == System.Net.HttpStatusCode.OK)
        {
            Console.WriteLine($"GetAllDevice:::{response.Message}");
            var deviceList = JsonConvert.DeserializeObject<List<DeviceNode>>(response?.Message?.ToString());

            if (deviceList != null)
            {
                _allDevices = deviceList;
                totalDevices = deviceList.FindAll(x => x.type != "gateway").Count;
                SelectAllDevices = deviceList.FindAll(x => x.type != "gateway");
                _loadedCount = 0;
                DeviceStack.Children.Clear();
                LoadMoreItems();
            }
            TotalDevices.Text = $"({totalDevices.ToString()})";
            TotalSelects.Text = $"(Up to {totalDevices} Items)";
        }
        else
        {
            await DisplayAlert("Error", $"Failed to get device list: {response.Message}", "OK");
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
            filtered = _allDevices;
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