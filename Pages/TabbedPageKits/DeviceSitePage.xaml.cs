using Microsoft.Maui.Controls;
using Newtonsoft.Json;
using RestSharp;
using StreetLightApp.Models;
using StreetLightApp.Services;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class DeviceSitePage : ContentPage
{

    Site CurrentSite = null;
    private List<DeviceNode> _allDevices = new();

    private int _loadedCount = 0;
    private const int PageSize = 20;
    private bool _isLoading = false;

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

                    // Subscribe to the CheckedChanged event
                    deviceItem.CheckedChanged += DeviceItem_CheckedChanged;

                    newItems.Add(deviceItem);
                }
            }

            // Update UI on the main thread
            MainThread.BeginInvokeOnMainThread(() =>
            {
                foreach (var item in newItems)
                    DeviceStack.Children.Add(item);

                LoadingIndicator.IsRunning = false;
                LoadingIndicator.IsVisible = false;

                _isLoading = false;
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
 
            // Do something with the checked device
            Console.WriteLine($"Device {(isChecked ? "Checked" : "Unchecked")}");
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
                _loadedCount = 0;
                DeviceStack.Children.Clear();
                LoadMoreItems();
            }
        }
        else
        {
            await DisplayAlert("Error", $"Failed to get device list: {response.Message}", "OK");
        }
    }


    private void OnSelectAllCheckedChanged(object sender, CheckedChangedEventArgs e)
    {

    }

    private void OnClearlChecked(object sender, EventArgs e)
    {

    }

    private void OnSearchButtonClicked(object sender, EventArgs e)
    {
        string keyword = DeviceSearchTxt.Text?.Trim().ToLower() ?? string.Empty;
        // Reset stack and counters
        _loadedCount = 0;
        DeviceStack.Children.Clear();

        // Filter devices
        List<DeviceNode> filtered;
        if (string.IsNullOrEmpty(keyword))
        {
            filtered = _allDevices; // show all devices
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

}