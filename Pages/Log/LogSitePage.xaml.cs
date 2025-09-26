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
    string gatewayName = "All Gateway";
    string dateStart;
    string dateEnd;
    Dictionary<int, string> MemberList = new Dictionary<int, string> { { 0, "All" } };
    Dictionary<int, string> GatewayList = new Dictionary<int, string> { { 0, "All" } };
    Dictionary<int, List<MyDevice>> GatewayDeviceList = new();
    Dictionary<int, string> DeviceList = new Dictionary<int, string> { { 0, "All" } };

    Dictionary<int, string> GatewayReportList = new();
    Dictionary<int, List<MyDevice>> GatewayReportDeviceList = new();
    Dictionary<int, string> DeviceReportList = new();

    List<string> TypeList = ["Usage", "Log", "Schedule"];

    private DateTime _selectedStartDate;

    private DateTime _selectedEndDate;

    private DateTime _selectedStartDateReport;

    private DateTime _selectedEndDateReport;
    public LogSitePage(Site _site)
    {
        InitializeComponent();
        Title = _site.site_name;
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
        StartDatePickerReport.Date = DateTime.Today;
        StartDatePickerReport.MaximumDate = DateTime.Today;
        EndDatePickerReport.Date = DateTime.Today;
        EndDatePickerReport.MaximumDate = DateTime.Today;
 
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
                        GatewayReportList[device.gateway_id] = device.gateway_name;
                        if (!GatewayDeviceList.ContainsKey(device.gateway_id))
                        {
                            GatewayDeviceList[device.gateway_id] = new List<MyDevice>();
                            GatewayReportDeviceList[device.gateway_id] = new List<MyDevice>();
                        }

                    }
                    else
                    {
                        if (!GatewayDeviceList.ContainsKey(device.gateway_id))
                        {
                            GatewayDeviceList[device.gateway_id] = new List<MyDevice>();
                            GatewayReportDeviceList[device.gateway_id] = new List<MyDevice>();
                        }
                        GatewayDeviceList[device.gateway_id].Add(device);
                        GatewayReportDeviceList[device.gateway_id].Add(device);

                    }
                }
                GatewayPick.ItemsSource = GatewayList.ToList();
                GatewayPick.ItemDisplayBinding = new Binding("Value");
                GatewayPick.SelectedIndex = 0;

                GatewayPickReport.ItemsSource = GatewayReportList.ToList();
                GatewayPickReport.ItemDisplayBinding = new Binding("Value");
                GatewayPickReport.SelectedIndex = 0;


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



        RadioButtonMaintenace.IsChecked = true;
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
                GatewayReportList[device.gateway_id] = device.gateway_name;


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
                    GatewayReportDeviceList[device.gateway_id] = new List<MyDevice>();
                }
                GatewayDeviceList[device.gateway_id].Add(device);
                GatewayReportDeviceList[device.gateway_id].Add(device);

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

        GatewayPickReport.ItemsSource = GatewayReportList.ToList();
        GatewayPickReport.ItemDisplayBinding = new Binding("Value");
        GatewayPickReport.SelectedIndex = 0;


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
        if (StartDatePicker.Date > e.NewDate)
        {
            StartDatePicker.MaximumDate = e.NewDate;
        }
        Console.WriteLine($"Selected date: {_selectedEndDate:dd/MM/yyyy}");
    }

    async Task<List<LogModelData>> GetLogsAsync()
    {
        if (CurrentSite == null) return null;



        if (MemberPick.SelectedItem is KeyValuePair<int, string> selectedMember)
            memberId = selectedMember.Key == 0 ? "all" : selectedMember.Key.ToString();

        if (GatewayPick.SelectedItem is KeyValuePair<int, string> selectedGateway)
        {
            gatewayId = selectedGateway.Key == 0 ? "all" : selectedGateway.Key.ToString();
            gatewayName = selectedGateway.Key == 0 ? "All Gateway" : selectedGateway.Value.ToString();
        }


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
            await Navigation.PushAsync(new LogDetailSitePage(logs, dateStart, dateEnd, TypePick.SelectedItem.ToString(), deviceName, gatewayName));
        }
        else
        {
            DisplayAlert("Log", "No data!", "ok");
        }
    }


    //private void CheckBoxRepair_CheckedChanged(object sender, CheckedChangedEventArgs e)
    //{
    //    if (e.Value)
    //    {
    //        CheckBoxInspection.IsChecked = false;
    //    }
    //}

    //private void CheckBoxInspection_CheckedChanged(object sender, CheckedChangedEventArgs e)
    //{
    //    if (e.Value)
    //    {
    //        CheckBoxRepair.IsChecked = false;
    //    }
    //}

    private void Select_Report_Clicked(object sender, EventArgs e)
    {
        Dispatcher.Dispatch(async () =>
        {
            LogDetail.IsVisible = false;
            AllReportDetail.IsVisible = true;
            await AllReportDetail.FadeTo(0, 10);
            await AllReportDetail.FadeTo(1, 10);
            Select_Report.TextColor = Colors.Black;
            Select_Report.BackgroundColor = Colors.White;
            Select_Log.TextColor = Color.FromArgb("#8B9DB2");
            Select_Log.BackgroundColor = Color.FromArgb("#F1F5F9");
            await Select_Report.FadeTo(0, 200);
            await Select_Report.FadeTo(1, 200);
        });
    }

    private void Select_Log_Clicked(object sender, EventArgs e)
    {
        Dispatcher.Dispatch(async () =>
        {
            LogDetail.IsVisible = true;
            AllReportDetail.IsVisible = false;
            await LogDetail.FadeTo(0, 10);
            await LogDetail.FadeTo(1, 10);
            Select_Report.TextColor = Color.FromArgb("#8B9DB2");
            Select_Report.BackgroundColor = Color.FromArgb("#F1F5F9");
            Select_Log.TextColor = Colors.Black;
            Select_Log.BackgroundColor = Colors.White;
            await Select_Log.FadeTo(0, 200);
            await Select_Log.FadeTo(1, 200);
        });

    }
    private void RadioButtonDevice_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        SearchButtonReport.Text = "Search Device";
        RadioButtonMaintenace.CheckedChanged -= RadioButtonMaintenace_CheckedChanged;
        RadioButtonMaintenace.IsChecked = false;
        RadioButtonMaintenace.CheckedChanged += RadioButtonMaintenace_CheckedChanged;
        ReportDetail.IsVisible = true;
        MaintenaceDetail.IsVisible = false;
        DeviceDetail.IsVisible = true;
    }

    private void RadioButtonMaintenace_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        SearchButtonReport.Text = "Search Maintenace";
        RadioButtonDevice.CheckedChanged -= RadioButtonDevice_CheckedChanged;
        RadioButtonDevice.IsChecked = false;
        RadioButtonDevice.CheckedChanged += RadioButtonDevice_CheckedChanged;
        ReportDetail.IsVisible = true;
        MaintenaceDetail.IsVisible = true;
        DeviceDetail.IsVisible = false;
    }

    private async void OnSearchButtonClicked(object sender, EventArgs e)
    {
        if (RadioButtonMaintenace.IsChecked)
        {

            await Indicator(true);

            var report_maintenace = await GetReportMaintenaceAsync();

            await Indicator(false);

            if (report_maintenace.Count > 0)
            {
                Console.WriteLine($"RadioButtonMaintenace::::::::::::::::::{report_maintenace.Count}:::::::::::::::::::::::::::::::::");
                await Navigation.PushAsync(new ReportMaintenacePage(report_maintenace));

            }
            else
            {
                DisplayAlert("Log", "No data!", "ok");
            }
        }
        else if (RadioButtonDevice.IsChecked)
        {
            await Indicator(true);


            var report_device = await GetReportDeviceAsync();

            await Indicator(false);

            if (report_device.Count > 0)
            {
                Console.WriteLine($"RadioButtonDevice::::::::::::::::::{report_device.Count}:::::::::::::::::::::::::::::::::");
                await Navigation.PushAsync(new ReportDevicePage(report_device, deviceName, gatewayName, _selectedStartDateReport.ToString("yyyy-MM-dd"), _selectedEndDateReport.ToString("yyyy-MM-dd")));

            }
            else
            {
                DisplayAlert("Log", "No data!", "ok");
            }
        }
    }

    async Task<List<ReportDeviceModel>> GetReportDeviceAsync()
    {
        string gatewayId = "all";
        string deviceId = "all";



        if (CurrentSite == null) return null;

        if (GatewayPickReport.SelectedItem is KeyValuePair<int, string> selectedGateway)
        {
            gatewayId = selectedGateway.Key == 0 ? "all" : selectedGateway.Key.ToString();
            gatewayName = selectedGateway.Key == 0 ? "All Gateway" : selectedGateway.Value.ToString();
        }


        if (DevicePickReport.SelectedItem is KeyValuePair<int, string> selectedDevice)
        {
            deviceId = selectedDevice.Key == 0 ? "all" : selectedDevice.Key.ToString();
            deviceName = selectedDevice.Key == 0 ? "All Devices" : selectedDevice.Value.ToString();
        }




        string dateStart = _selectedStartDateReport == default ? DateTime.Today.ToString("yyyy-MM-dd") : _selectedStartDateReport.ToString("yyyy-MM-dd");
        string dateEnd = _selectedEndDateReport == default ? DateTime.Today.ToString("yyyy-MM-dd") : _selectedEndDateReport.ToString("yyyy-MM-dd");

        string url = $"{Provider.APIHost}/api/get-chart2/{CurrentSite.site_id}?device_id={deviceId}&gateway_id={gatewayId}&date_start={dateStart}&date_end={dateEnd}";

        Console.WriteLine($"Fetching logs: {url}");

        var response = await RequestApi.GetAPIJWT(url);

        if (response.HttpStatusCode != System.Net.HttpStatusCode.OK)
        {
            await DisplayAlert("Error", $"Failed to get logs: {response.Message}", "OK");
            return null;
        }

        // Deserialize into LogModel
        var reportModel = JsonConvert.DeserializeObject<RootReportDevice>(response.Message.ToString());
        return reportModel.data ?? new List<ReportDeviceModel>();
    }


    async Task<List<MaintenanceModel>> GetReportMaintenaceAsync()
    {

        if (CurrentSite == null) return null;

        string url = $"{Provider.APIHost}/api/get-maintenance/{CurrentSite.site_id}";

        Console.WriteLine($"Fetching logs: {url}");

        var response = await RequestApi.GetAPIJWT(url);

        if (response.HttpStatusCode != System.Net.HttpStatusCode.OK)
        {
            await DisplayAlert("Error", $"Failed to get logs: {response.Message}", "OK");
            return null;
        }

        // Deserialize into LogModel
        var reportModel = JsonConvert.DeserializeObject<List<MaintenanceModel>>(response.Message.ToString());
        return reportModel ?? new List<MaintenanceModel>();
    }


    private void GatewayPickReport_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (GatewayPickReport.SelectedItem is KeyValuePair<int, string> selectedGateway)
        {
            int gatewayId = selectedGateway.Key;
            DeviceReportList = new();
            if (GatewayDeviceList.ContainsKey(gatewayId))
            {
                foreach (var device in GatewayDeviceList[gatewayId])
                {
                    DeviceReportList[(int)device.device_id] = device.device_name;
                }
                DevicePickReport.ItemsSource = DeviceReportList.ToList();
                DevicePickReport.ItemDisplayBinding = new Binding("Value");
                DevicePickReport.SelectedIndex = 0;
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

    private void DevicePickReport_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    private void DateStartPickerReport_DateSelected(object sender, DateChangedEventArgs e)
    {
        _selectedStartDateReport = e.NewDate;
        Console.WriteLine($"Selected date: {_selectedStartDateReport:dd/MM/yyyy}");
    }

    private void DateEndPickerReport_DateSelected(object sender, DateChangedEventArgs e)
    {
        _selectedEndDateReport = e.NewDate;
        if (StartDatePickerReport.Date > e.NewDate)
        {
            StartDatePickerReport.MaximumDate = e.NewDate;
        }
        Console.WriteLine($"Selected date: {_selectedEndDateReport:dd/MM/yyyy}");
    }

}