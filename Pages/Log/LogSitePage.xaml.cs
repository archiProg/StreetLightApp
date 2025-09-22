using Newtonsoft.Json;
using StreetLightApp.Models;
using StreetLightApp.Services;
using System.Text.RegularExpressions;

namespace StreetLightApp.Pages.Log;

public partial class LogSitePage : ContentPage
{
    Site CurrentSite = null;
    List<string> GatewayList = new();
    String SelectGateway = "";
    Dictionary<int, string> MemberList = new Dictionary<int, string>
{
    { 0, "All" } };
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

        Dispatcher.Dispatch(async () =>
        {
            await Indicator(true);
            if (!Provider.MapSites.ContainsKey(CurrentSite.site_id))
            {
                Console.WriteLine("GetAllDevice::::");
                await GetAllDevice();
            }
            if (!Provider.MemberSites.ContainsKey(CurrentSite.site_id))
            {
                Console.WriteLine("GetAllMember::::");
                await GetAllMember();
            }
            else
            {
                int count = 1;
                foreach (var member in Provider.MemberSites[CurrentSite.site_id])
                {
                    MemberList[count] = member.member_name;
                    count++;
                }
            }
            await Indicator(false);
        });

        MemberPick.ItemsSource = MemberList.ToList();
        MemberPick.ItemDisplayBinding = new Binding("Value");
        MemberPick.SelectedIndex = 0;


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

        Console.WriteLine($"GetAllDevice:::{response.Message}");
        var deviceList = JsonConvert.DeserializeObject<List<MemberApiResponse>>(response?.Message?.ToString());
        if (deviceList == null || deviceList[0].members.Count == 0)
            return;

        if (Provider.MemberSites == null)
            Provider.MemberSites = new Dictionary<int, List<Member>>();

        if (!Provider.MemberSites.ContainsKey(CurrentSite.site_id))
        {
            Provider.MemberSites[CurrentSite.site_id] = new List<Member>();
        }


        int count = 1;
        foreach (var member in Provider.MemberSites[CurrentSite.site_id].ToList())
        {
            MemberList[count] = member.member_name;
            count++;
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
        var picker = (Picker)sender;
        int selectedIndex = picker.SelectedIndex;

        if (selectedIndex != -1)
        {
            if (selectedIndex == 0)
            {
                SelectGateway = "All";

            }
            else
            {
                string selectedGroupName = picker.Items[selectedIndex];
                Console.WriteLine($"selectedIndex: {selectedIndex} selectedGroupName {selectedGroupName}");
                SelectGateway = picker.Items[selectedIndex];
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
}