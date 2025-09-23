using Newtonsoft.Json;
using StreetLightApp.Models;
using StreetLightApp.Services;
using System.Text.RegularExpressions;

namespace StreetLightApp.Pages.Log;

public partial class LogSitePage : ContentPage
{
    Site CurrentSite = null;
    String SelectGateway = "";
    string memberId = "all";
    string gatewayId = "all";
    string deviceId = "all";
    string type = "usage";
    string deviceName = "All Devices";
    string dateStart;
    string dateEnd;
    Dictionary<int, string> MemberList = new Dictionary<int, string> { { 0, "All" } };
    Dictionary<int, string> GatewayList = new Dictionary<int, string> { { 0, "All" } };
    Dictionary<int, List<MyDevice>> GatewayDeviceList = new();
    Dictionary<int, string> DeviceList = new Dictionary<int, string> { { 0, "All" } };

    List<string> TypeList = ["Usage", "Log"];

    private DateTime _selectedStartDate;

    private DateTime _selectedEndDate;
    public LogSitePage(Site _site)
    {
        InitializeComponent();
        Title = "Log " + _site.site_name;
        CurrentSite = _site;
        StartDatePicker.Date = DateTime.Today;
        StartDatePicker.MaximumDate = DateTime.Today;
        EndDatePicker.Date = DateTime.Today;
        EndDatePicker.MaximumDate = DateTime.Today;
        TypePick.ItemsSource = TypeList.ToList();
        TypePick.SelectedIndex = 0;
        DevicePick.ItemsSource = DeviceList.ToList();
        DevicePick.ItemDisplayBinding = new Binding("Value");
        DevicePick.SelectedIndex = 0;

        Dispatcher.Dispatch(async () =>
        {
            await Indicator(true);
            if (!Provider.MapSites.ContainsKey(CurrentSite.site_id))
            {
                await GetAllDevice();
            }
            else
            {
                foreach (var device in Provider.MapSites[CurrentSite.site_id])
                {
                    if (device.type == "gateway")
                    {
                        GatewayList[device.gateway_id] = device.gateway_name;
                        if (!GatewayDeviceList.ContainsKey(device.gateway_id))
                        {
                            GatewayDeviceList[device.gateway_id] = new List<MyDevice>();
                        }

                    }
                    else
                    {
                        if (!GatewayDeviceList.ContainsKey(device.gateway_id))
                        {
                            GatewayDeviceList[device.gateway_id] = new List<MyDevice>();
                        }
                        GatewayDeviceList[device.gateway_id].Add(device);

                    }
                }
                GatewayPick.ItemsSource = GatewayList.ToList();
                GatewayPick.ItemDisplayBinding = new Binding("Value");
                GatewayPick.SelectedIndex = 0;



            }

            if (!Provider.MemberSites.ContainsKey(CurrentSite.site_id))
            {
                await GetAllMember();
            }
            else
            {
                foreach (var member in Provider.MemberSites[CurrentSite.site_id])
                {
                    MemberList[member.id] = member.member_name;
                    Console.WriteLine($"nameMember:::::{member.member_name} {member.id}");
                }
                MemberPick.ItemsSource = MemberList.ToList();
                MemberPick.ItemDisplayBinding = new Binding("Value");
                MemberPick.SelectedIndex = 0;
            }
            await Indicator(false);
        });




    }

    async Task Indicator(bool running)
    {
        Dispatcher.Dispatch(() =>
        {
            indicator.IsVisible = running;
        });
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
                GatewayList[device.gateway_id] = device.gateway_name;


                finalDevice = new DeviceNode(device)
                {
                    controls = device.controls,
                    config = device.config
                };
            }
            else
            {
                if (!GatewayDeviceList.ContainsKey(device.gateway_id))
                {
                    GatewayDeviceList[device.gateway_id] = new List<MyDevice>();
                }
                GatewayDeviceList[device.gateway_id].Add(device);

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
        GatewayPick.ItemsSource = GatewayList.ToList();
        GatewayPick.ItemDisplayBinding = new Binding("Value");
        GatewayPick.SelectedIndex = 0;


        await Provider.SendWsAsync("32", new { });

    }



    async Task GetAllMember()
    {
        var response = await RequestApi.GetAPIJWT($"{Provider.APIHost}/api/get-member/{CurrentSite.site_id}");

        if (response.HttpStatusCode != System.Net.HttpStatusCode.OK)
        {
            await DisplayAlert("Error", $"Failed to get device list: {response.Message}", "OK");
            return;
        }

        Console.WriteLine($"GetAllMember:::{response.Message}");
        var deviceList = JsonConvert.DeserializeObject<List<MemberApiResponse>>(response?.Message?.ToString());
        if (deviceList == null || deviceList[0].members.Count == 0)
            return;

        if (Provider.MemberSites == null)
        {
            Provider.MemberSites = new Dictionary<int, List<Member>>();
        }

        if (!Provider.MemberSites.ContainsKey(CurrentSite.site_id))
        {
            Provider.MemberSites[CurrentSite.site_id] = new List<Member>();
        }




        foreach (var member in deviceList[0].members)
        {
            Provider.MemberSites[CurrentSite.site_id].Add(member);
            MemberList[member.id] = member.member_name;
            Console.WriteLine($"nameMember:::::{member.member_name} {member.id}");
        }
        MemberPick.ItemsSource = MemberList.ToList();
        MemberPick.ItemDisplayBinding = new Binding("Value");
        MemberPick.SelectedIndex = 0;
    }




    private void MemberPick_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    private void GatewayPick_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (GatewayPick.SelectedItem is KeyValuePair<int, string> selectedGateway)
        {
            int gatewayId = selectedGateway.Key;

            if (GatewayDeviceList.ContainsKey(gatewayId))
            {
                DeviceList = new Dictionary<int, string> { { 0, "All" } };
                foreach (var device in GatewayDeviceList[gatewayId])
                {
                    DeviceList[(int)device.device_id] = device.device_name;
                    Console.WriteLine($"Device:::::{device.device_name} {device.device_id}");
                }
                DevicePick.ItemsSource = DeviceList.ToList();
                DevicePick.ItemDisplayBinding = new Binding("Value");
                DevicePick.SelectedIndex = 0;
            }
            else
            {
                DeviceList = new Dictionary<int, string> { { 0, "All" } };
                DevicePick.ItemsSource = DeviceList.ToList();
                DevicePick.ItemDisplayBinding = new Binding("Value");
                DevicePick.SelectedIndex = 0;
            }
        }
    }

    private void DevicePick_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    private void TypePick_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    private void DateStartPicker_DateSelected(object sender, DateChangedEventArgs e)
    {
        _selectedStartDate = e.NewDate;
        Console.WriteLine($"Selected date: {_selectedStartDate:dd/MM/yyyy}");
    }

    private void DateEndPicker_DateSelected(object sender, DateChangedEventArgs e)
    {
        _selectedEndDate = e.NewDate;
        Console.WriteLine($"Selected date: {_selectedEndDate:dd/MM/yyyy}");
    }

    async Task<List<LogModelData>> GetLogsAsync()
    {
        if (CurrentSite == null) return null;



        if (MemberPick.SelectedItem is KeyValuePair<int, string> selectedMember)
            memberId = selectedMember.Key == 0 ? "all" : selectedMember.Key.ToString();

        if (GatewayPick.SelectedItem is KeyValuePair<int, string> selectedGateway)
            gatewayId = selectedGateway.Key == 0 ? "all" : selectedGateway.Key.ToString();

        if (DevicePick.SelectedItem is KeyValuePair<int, string> selectedDevice)
        {
            deviceId = selectedDevice.Key == 0 ? "all" : selectedDevice.Key.ToString();
            deviceName = selectedDevice.Key == 0 ? "All Devices" : selectedDevice.Value.ToString();
        }
             
            

        if (TypePick.SelectedItem is string selectedType)
            type = selectedType.ToLower();

        dateStart = _selectedStartDate == default ? DateTime.Today.ToString("yyyy-MM-dd") : _selectedStartDate.ToString("yyyy-MM-dd");
        dateEnd = _selectedEndDate == default ? DateTime.Today.ToString("yyyy-MM-dd") : _selectedEndDate.ToString("yyyy-MM-dd");

        string url = $"{Provider.APIHost}/api/get-log/{CurrentSite.site_id}?" +
                     $"member_id={memberId}&gateway_id={gatewayId}&device_id={deviceId}&type={type}&" +
                     $"search_data=&date_start={dateStart}&date_end={dateEnd}";

        Console.WriteLine($"Fetching logs: {url}");

        var response = await RequestApi.GetAPIJWT(url);

        if (response.HttpStatusCode != System.Net.HttpStatusCode.OK)
        {
            await DisplayAlert("Error", $"Failed to get logs: {response.Message}", "OK");
            return null;
        }

        // Deserialize into LogModel
        var logModel = JsonConvert.DeserializeObject<LogModel>(response.Message.ToString());
        return logModel?.data ?? new List<LogModelData>();
    }

    private async void Button_Clicked(object sender, EventArgs e)
    {
        await Indicator(true);

        var logs = await GetLogsAsync();  

        await Indicator(false);  

        if (logs.Count > 0)
        {
            await Navigation.PushAsync(new LogDetailSitePage(logs, dateStart, dateEnd, TypePick.SelectedItem.ToString(), deviceName));
        }
        else
        {
            DisplayAlert("Log", "No data!", "ok");
        }
    }
}