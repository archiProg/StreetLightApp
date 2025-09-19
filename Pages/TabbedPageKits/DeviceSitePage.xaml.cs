using Microsoft.Maui;
using Microsoft.Maui.Controls;
using Newtonsoft.Json;
using RestSharp;
using StreetLightApp.Models;
using StreetLightApp.Services;
using System.Collections.ObjectModel;
using System.Text.RegularExpressions;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class DeviceSitePage : ContentPage
{

    Site CurrentSite = null;
    int ContactId = 0;
    int GroupId = 0;

    private List<MyDevice> _allDevices = new();
    private List<MyDevice> SelectDevices = new();
    List<MyDevice> filteredDevices;


    private int _loadedCount = 0;
    private const int PageSize = 20;
    private bool _isLoading = false;

    private bool IsSelectAll = false;


    Dictionary<int, string> ContactsList = new Dictionary<int, string>
{
    { 0, "All" }
};
    Dictionary<int, string> GroupsList = new Dictionary<int, string>
{
    { 0, "All" }
};

    public DeviceSitePage(Site _site)
    {
        InitializeComponent();
        Console.WriteLine("DeviceSitePage .Show:::::::::::::::::::::::::");

        Title = _site.site_name;
        CurrentSite = _site;

        if (!Provider.MapSites.ContainsKey(CurrentSite.site_id))
        {

            try
            {

                Dispatcher.Dispatch(async () =>
                {
                    await Indicator(true);
                    await GetAllDevice();
                    Provider.UpdateStatusDataHandle += Provider_UpdateStatusDataHandle;
                    _allDevices = Provider.MapSites[CurrentSite.site_id];
                    filteredDevices = Provider.MapSites[CurrentSite.site_id];
                    DeviceStack.Children.Clear();
                    ContactPick.ItemsSource = ContactsList.ToList();
                    ContactPick.ItemDisplayBinding = new Binding("Value");
                    ContactPick.SelectedIndex = 0;


                    GroupPick.ItemsSource = GroupsList.ToList();
                    GroupPick.ItemDisplayBinding = new Binding("Value");
                    GroupPick.SelectedIndex = 0;
                    _loadedCount = 0;
                    await LoadFristItems();
                    TotalDevices.Text = $"({filteredDevices.Count})";
                    TotalSelects.Text = $"(Up to {filteredDevices.Count(x => x.type != "gateway")} Items)";
                    await Indicator(false);
                });


            }
            catch (Exception error)
            {
                Console.WriteLine("FloorPlanControllerPage.Error:" + error);
            }


        }
        else
        {

            foreach (var device in Provider.MapSites[CurrentSite.site_id])
            {
                if (device.contract_id != null && !ContactsList.ContainsKey(device.contract_id))
                {
                    ContactsList[device.contract_id] = device.contract_number;
                }

                if (device.group_id.HasValue && !GroupsList.ContainsKey(device.group_id.Value))
                {
                    GroupsList[device.group_id.Value] = device.group_name;
                }
            }


            Dispatcher.Dispatch(async () =>
            {
                Provider.UpdateStatusDataHandle += Provider_UpdateStatusDataHandle;
                _allDevices = Provider.MapSites[CurrentSite.site_id];
                filteredDevices = Provider.MapSites[CurrentSite.site_id];
                DeviceStack.Children.Clear();
                ContactPick.ItemsSource = ContactsList.ToList();
                ContactPick.ItemDisplayBinding = new Binding("Value");
                ContactPick.SelectedIndex = 0;


                GroupPick.ItemsSource = GroupsList.ToList();
                GroupPick.ItemDisplayBinding = new Binding("Value");
                GroupPick.SelectedIndex = 0;
                _loadedCount = 0;

                LoadMoreItems();
                TotalDevices.Text = $"({filteredDevices.Count})";
                TotalSelects.Text = $"(Up to {filteredDevices.Count(x => x.type != "gateway")} Items)";
            });

        }
    }


    async Task Indicator(bool running)
    {
        Dispatcher.Dispatch(() =>
        {
            indicator.IsVisible = running;
        });
    }
    async Task IndicatorSenddata(bool running)
    {
        Dispatcher.Dispatch(() =>
        {
            indicatorSenddata.IsVisible = running;
            mySlider.IsEnabled = !running;
            sw.IsEnabled = !running;
        });

        await Task.Delay(100);
    }


    private void Provider_UpdateStatusDataHandle(object? sender, UpdateStatusDataParam e)
    {
        Dispatcher.Dispatch(() =>
        {
            if (SelectDevices.Count == 1)
            {
                if (SelectDevices[0].device_id == e.Device)
                {
                    if (e.Ctrl == 1)
                    {
                        lbSlider.Text = $"{e.V}%";
                        mySlider.DragCompleted -= mySlider_DragCompleted;
                        mySlider.Value = e.V;
                        mySlider.DragCompleted += mySlider_DragCompleted;
                    }
                    else if (e.Ctrl == 2)
                    {
                        sw.Toggled -= OnToggled;
                        sw.IsToggled = e.V == 1;
                        sw.Toggled += OnToggled;
                    }

                }
            }
        });
    }

    private async Task LoadFristItems()
    {
        if (_isLoading) return;
        _isLoading = true;
        SelectAllCheckBox.IsEnabled = false;
        LoadingIndicator.IsVisible = true;
        LoadingIndicator.IsRunning = true;



        int remaining = filteredDevices.Count - _loadedCount;
        int toLoad = Math.Min(PageSize, remaining);

        var newItems = new List<View>();

        for (int i = 0; i < toLoad; i++)
        {

            var dev = filteredDevices[_loadedCount++];
            if (dev != null)
            {
                View deviceItem = null;

                if (dev.type == "gateway")
                {
                    deviceItem = new Views.DeviceItems(dev);
                }
                else
                {

                    switch (dev.device_style)
                    {
                        case 3: // Dimmer
                            if (dev is Dimmer dimmer)
                            {
                                var dimmerItem = new Views.DimmerItem(dimmer);

                                dimmerItem.SetChecked(IsSelectAll);

                                dimmerItem.CheckedChanged += DeviceItem_CheckedChanged;

                                deviceItem = dimmerItem;
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

            int remaining = filteredDevices.Count - _loadedCount;
            int toLoad = Math.Min(PageSize, remaining);

            var newItems = new List<View>();

            for (int i = 0; i < toLoad; i++)
            {

                var dev = filteredDevices[_loadedCount++];
                if (dev != null)
                {
                    View deviceItem = null;

                    if (dev.type == "gateway")
                    {
                        deviceItem = new Views.DeviceItems(dev);
                    }
                    else
                    {

                        switch (dev.device_style)
                        {
                            case 3: // Dimmer
                                if (dev is Dimmer dimmer)
                                {
                                    var dimmerItem = new Views.DimmerItem(dimmer);

                                    dimmerItem.SetChecked(IsSelectAll);

                                    dimmerItem.CheckedChanged += DeviceItem_CheckedChanged;

                                    deviceItem = dimmerItem;
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
        if (sender is MyDevice item)
        {
            bool isChecked = e.Value;
            if (isChecked)
            {
                if (SelectDevices.Count == 0)
                {
                    ControlMenu.IsVisible = true;
                    BVControlMenu.IsVisible = true;
                    if (item is Dimmer dimmer)
                    {
                        lbSlider.Text = $"{(int)dimmer.Dimvalue}%";

                        mySlider.DragCompleted -= mySlider_DragCompleted;
                        mySlider.Value = (int)dimmer.Dimvalue;
                        mySlider.DragCompleted += mySlider_DragCompleted;
                        sw.Toggled -= OnToggled;
                        sw.IsToggled = (int)dimmer.Status == 1;
                        sw.Toggled += OnToggled;


                    }
                }
                else
                {

                    lbSlider.Text = $"50%";

                    mySlider.DragCompleted -= mySlider_DragCompleted;
                    mySlider.Value = 50;
                    mySlider.DragCompleted += mySlider_DragCompleted;
                    sw.Toggled -= OnToggled;
                    sw.IsToggled = false;
                    sw.Toggled += OnToggled;


                }
                SelectDevices.Add(item);
                if (SelectDevices.Count == filteredDevices.Count(x => x.type != "gateway"))
                {
                    SelectAllCheckBox.IsChecked = true;
                }
            }
            else
            {
                if (SelectDevices.Count == filteredDevices.Count(x => x.type != "gateway"))
                {
                    SelectAllCheckBox.CheckedChanged -= OnSelectAllCheckedChanged;
                    SelectAllCheckBox.IsChecked = false;
                    SelectAllCheckBox.CheckedChanged += OnSelectAllCheckedChanged;
                    IsSelectAll = false;
                }
                else if (IsSelectAll)
                {
                    SelectAllCheckBox.CheckedChanged -= OnSelectAllCheckedChanged;
                    SelectAllCheckBox.IsChecked = false;
                    SelectAllCheckBox.CheckedChanged += OnSelectAllCheckedChanged;
                    IsSelectAll = false;
                    SelectDevices = filteredDevices.FindAll(x => x.type != "gateway");
                }
                SelectDevices.Remove(item);
                if (SelectDevices.Count == 1)
                {
                    if (item is Dimmer dimmer)
                    {
                        lbSlider.Text = $"{(int)dimmer.Dimvalue}%";
                        mySlider.Value = (int)dimmer.Dimvalue;
                        sw.IsToggled = (int)dimmer.Status == 1;
                    }
                }
                if (SelectDevices.Count == 0)
                {
                    ControlMenu.IsVisible = false;
                    BVControlMenu.IsVisible = false;
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
        //if (deviceList == null || deviceList.Count == 0)
        //    return;

        if (Provider.MapSites == null)
            Provider.MapSites = new Dictionary<int, List<MyDevice>>();

        if (!Provider.MapSites.ContainsKey(CurrentSite.site_id))
        {
            Provider.MapSites[CurrentSite.site_id] = new List<MyDevice>();
        }

        ContactsList = new Dictionary<int, string>
                {
                    { 0, "All" }
                };
        GroupsList = new Dictionary<int, string>
                {
                    { 0, "All" }
                };
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
            {
                Provider.MapSites[CurrentSite.site_id].Add(finalDevice);
            }
        }
        ContactPick.ItemsSource = ContactsList.ToList();
        ContactPick.ItemDisplayBinding = new Binding("Value");
        ContactPick.SelectedIndex = 0;
        GroupPick.ItemsSource = GroupsList.ToList();
        GroupPick.ItemDisplayBinding = new Binding("Value");
        GroupPick.SelectedIndex = 0;
        Console.WriteLine("GetAllDevice::::end");
    }



    private void OnSelectAllCheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        bool isChecked = e.Value;
        IsSelectAll = isChecked;

        if (isChecked)
        {
            ControlMenu.IsVisible = true;
            BVControlMenu.IsVisible = true;
            foreach (var child in DeviceStack.Children)
            {
                if (child is Views.DimmerItem deviceItem)
                {

                    deviceItem.SetChecked(true);
                }
            }
            lbSlider.Text = $"50%";
            mySlider.DragCompleted -= mySlider_DragCompleted;
            mySlider.Value = 50;
            mySlider.DragCompleted += mySlider_DragCompleted;
            SelectDevices = filteredDevices.Where(x => x.type != "gateway").ToList();
        }
        else
        {
            ControlMenu.IsVisible = false;
            BVControlMenu.IsVisible = false;
            SelectDevices = new();

            foreach (var child in DeviceStack.Children)
            {
                if (child is Views.DimmerItem deviceItem)
                {
                    deviceItem.SetChecked(false);
                }
            }
        }

        LbDevicelist.Text = $"Control ({filteredDevices.Count(x => x.type != "gateway")} Lamps)";
    }


    private void OnClearlChecked(object sender, EventArgs e)
    {
        DeviceStack.Children.Clear();
        LoadingIndicator.IsVisible = true;
        LoadingIndicator.IsRunning = true;
        SelectAllCheckBox.IsEnabled = false;
        SelectAllCheckBox.IsChecked = false;
        DeviceSearchTxt.IsEnabled = false;

        IsSelectAll = false;
        ControlMenu.IsVisible = false;
        BVControlMenu.IsVisible = false;
        DeviceSearchTxt.Text = "";

        filteredDevices = _allDevices;

        ContactPick.SelectedIndex = 0;
        GroupPick.SelectedIndex = 0;
        
        _loadedCount = 0;
        LoadMoreItems();
        DeviceSearchTxt.IsEnabled = true;
        TotalDevices.Text = $"({filteredDevices.Count})";
        TotalSelects.Text = $"(Up to {filteredDevices.Count(x => x.type != "gateway")} Items)";
    }

    private void OnSearchButtonClicked(object sender, EventArgs e)
    {
        string searchText = DeviceSearchTxt.Text?.Trim().ToLower();
        DeviceStack.Children.Clear();
        LoadingIndicator.IsVisible = true;
        LoadingIndicator.IsRunning = true;
        SelectAllCheckBox.IsEnabled = false;
        SelectAllCheckBox.IsChecked = false;
        DeviceSearchTxt.IsEnabled = false;

        if (string.IsNullOrEmpty(searchText))
        {
            filteredDevices = new();
            foreach (var device in _allDevices)
            {
                int selectedContactId = ContactId;
                int selectedGroupId = GroupId;

                bool matchContact = selectedContactId == 0 || device.contract_id == selectedContactId;
                bool matchGroup = selectedGroupId == 0 || (device.group_id.HasValue && device.group_id.Value == selectedGroupId);
                if (matchContact && matchGroup)
                {
                    filteredDevices.Add(device);
                }
            }
        }
        else if (!string.IsNullOrEmpty(searchText))
        {
            filteredDevices = new();

            var _DevicesFilterName = _allDevices
               .Where(d =>
                   (!string.IsNullOrEmpty(d.device_name) && d.device_name.Contains(searchText, StringComparison.OrdinalIgnoreCase)) ||
                   (!string.IsNullOrEmpty(d.gateway_name) && d.gateway_name.Contains(searchText, StringComparison.OrdinalIgnoreCase) && d.type == "gateway")
               )
               .Distinct()
               .ToList();
            foreach (var device in _DevicesFilterName)
            {
                int selectedContactId = ContactId;
                int selectedGroupId = GroupId;

                bool matchContact = selectedContactId == 0 || device.contract_id == selectedContactId;
                bool matchGroup = selectedGroupId == 0 || (device.group_id.HasValue && device.group_id.Value == selectedGroupId);
                if (matchContact && matchGroup)
                {
                    filteredDevices.Add(device);
                }
            }



        }
        _loadedCount = 0;
        LoadMoreItems();
        DeviceSearchTxt.IsEnabled = true;
        TotalDevices.Text = $"({filteredDevices.Count})";
        TotalSelects.Text = $"(Up to {filteredDevices.Count(x => x.type != "gateway")} Items)";
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
        await Navigation.PushAsync(new ManageDevicePage(CurrentSite, SelectDevices));
    }



    private void mySlider_HandlerChanged(object sender, EventArgs e)
    {
        if (sender is Slider slider)
        {
            lbSlider.Text = $"{(int)slider.Value}%";
        }
    }

    private void mySlider_DragCompleted(object sender, EventArgs e)
    {
        if (sender is Slider slider)
        {
            Dispatcher.Dispatch(async () =>
            {
                try
                {
                    await IndicatorSenddata(true);
                    if ((int)slider.Value == 0)
                    {
                        sw.Toggled -= OnToggled;
                        sw.IsToggled = false;
                        sw.Toggled += OnToggled;
                    }
                    else
                    {
                        sw.Toggled -= OnToggled;
                        sw.IsToggled = true;
                        sw.Toggled += OnToggled;
                    }
                    foreach (var device in SelectDevices)
                    {
                        await Provider.SendWsAsync("3", new
                        {
                            Member = device.gateway_id,
                            Device = device.device_id,
                            Ctrl = 1,
                            V = (int)slider.Value
                        });
                    }
                }
                finally
                {
                    await IndicatorSenddata(false);
                }
            });
        }
    }

    private async void OnToggled(object sender, ToggledEventArgs e)
    {
        await IndicatorSenddata(true);
        foreach (var device in SelectDevices)
        {
            if (device is Dimmer dimmer)
            {
                if (dimmer.Dimvalue == 0)
                {
                    await Provider.SendWsAsync("3", new
                    {
                        Member = dimmer.gateway_id,
                        Device = dimmer.device_id,
                        Ctrl = 1,
                        V = 100
                    });
                }
                else
                {
                    await Provider.SendWsAsync("3", new
                    {
                        Member = dimmer.gateway_id,
                        Device = dimmer.device_id,
                        Ctrl = 1,
                        V = dimmer.Dimvalue
                    });
                }

                await Provider.SendWsAsync("3", new
                {
                    Member = dimmer.gateway_id,
                    Device = dimmer.device_id,
                    Ctrl = 2,
                    V = e.Value ? 1 : 0
                });
            }
        }
        await IndicatorSenddata(false);


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
                Console.WriteLine($"selectedIndex: {selectedIndex} selectedContactName {selectedContactName}");
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
                Console.WriteLine($"selectedIndex: {selectedIndex} selectedGroupName {selectedGroupName}");

                // Lookup the ID from the dictionary
                GroupId = GroupsList.FirstOrDefault(x => x.Value == selectedGroupName).Key;
            }

        }
    }
}