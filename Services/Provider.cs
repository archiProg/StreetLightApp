using Microsoft.Extensions.Logging;
using Microsoft.Maui.Controls;
using Microsoft.Maui.Maps;
using StreetLightApp.Models;
using StreetLightApp.Pages;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using WatsonWebsocket;

namespace StreetLightApp.Services
{
    public static class Provider
    {
        //public static string APIHost = "http://100.76.74.10:5000";
        //public static string APIHost = "http://192.168.1.66:5000";
        public static string APIHost = "https://cloudbatt.com";
        public static string ProfileName = "User";
        public static string Username = "@Username";
        public static int MemberId = 0;
        //public static string HostImage = "http://100.76.74.10:5000/images/profile/";
        //public static string HostImage = "http://192.168.1.66:5000/images/profile/";
        public static string HostImage = "https://cloudbatt.com/images/profile/";
        public static string UserImage = "";
        public static string UserEmail = "";
        public static string UserToken = "";
        public static UserRole UserRole = UserRole.None;
        public static WatsonWsClient _WssClient = null;


        public static List<Site> SiteList = new List<Site>();

        //public static List<MyDevice> SiteDevices = new List<MyDevice>();

        public static Dictionary<int, List<MyDevice>> MapSites = new();
        public static Dictionary<int, List<Member>> MemberSites = new();

        public static List<string> GatewayList = new List<string>();

        public static InitDashboard DataDashboard = new InitDashboard();

        public static event EventHandler<UpdateStatusDataParam> UpdateStatusDataHandle;
        public static event EventHandler<UpdateStatusGatewayParam> UpdateStatusGatewayHandle;
        public static event EventHandler<InitDashboard> InitDashboardHandle;

        public async static void Initialize()
        {
            Console.WriteLine("Provider Initialize:::::::::::::::");
            await ConnectWssServer("wss://cloudbatt.com:8000/echo");
        }

        public static async Task ConnectWssServer(string _ServerIp)
        {
            if (_WssClient != null)
            {
                _WssClient.Dispose();
            }

            _WssClient = new WatsonWsClient(new Uri(_ServerIp));
            _WssClient.AcceptInvalidCertificates = false;
            _WssClient.ServerConnected += WsServerConnected;
            _WssClient.ServerDisconnected += WsServerDisconnected;
            _WssClient.MessageReceived += MessageReceived;
            _WssClient.Logger = WsLogger;
            _WssClient.Start();


        }

        private static async Task SendLoginWssAsync(string token)
        {
            if (_WssClient != null && _WssClient.Connected)
            {
                var loginPayload = new
                {
                    cmd = 1,
                    param = new
                    { Username = "bird", Password = "123456789" }
                };

                string json = JsonSerializer.Serialize(loginPayload);
                await _WssClient.SendAsync(json);
                Console.WriteLine($"Login json:::::{json}");
                Console.WriteLine("Login message sent.");
            }
            else
            {
                Console.WriteLine("WebSocket is not connected.");
            }
        }

        static async void WsServerConnected(object sender, EventArgs args)
        {
            string token = Preferences.Get("token", "");
            await SendLoginWssAsync(token);
            Console.WriteLine("Client connected: " + _WssClient.Connected);
            Console.WriteLine("WsServer connected::::::::::::::");
            var param = new
            { lamp_member_id = MemberId };


        }

        static void WsServerDisconnected(object sender, EventArgs args)
        {
            Console.WriteLine("WsServer disconnected");
        }

        static void MessageReceived(object sender, MessageReceivedEventArgs args)
        {
            string msg = "(null)";
            if (args.Data != null && args.Data.Count > 0)
                msg = Encoding.UTF8.GetString(args.Data.Array, 0, args.Data.Count);

            Console.WriteLine("from server: " + msg);

            try
            {
                var baseMessage = JsonSerializer.Deserialize<WsMessage<JsonElement>>(msg);

                switch (baseMessage.Cmd)
                {
                    case (int)CmdType.LOGIN:
                        var loginStatus = baseMessage.Param.Deserialize<LoginParam>();
                        if (loginStatus.Success)
                        {
                            var param = new
                            {
                                lamp_member_id = MemberId
                            }
                        ;
                            MainThread.BeginInvokeOnMainThread(async () => {
                                await SendWsAsync("999", param);
                            });
                        }
                        break;

                    case (int)CmdType.UpdateDevices:
                        var updateStatusData = baseMessage.Param.Deserialize<UpdateStatusDataParam>();

                        //WsUpdateDevices(updateStatusData);
                        WsUpdateDevicesMap(updateStatusData);
                        UpdateStatusDataHandle?.Invoke(null, updateStatusData);
                        break;

                    case (int)CmdType.UpdateStatusGateWay:
                        var updateStatusGateway = baseMessage.Param.Deserialize<UpdateStatusGatewayParam>();
                        WsUpdateGatewayMap(updateStatusGateway);
                        UpdateStatusGatewayHandle?.Invoke(null, updateStatusGateway);
                        break;

                    case (int)CmdType.UpdateStatusAllGateway:
                        var updateStatusAllGateway = baseMessage.Param.Deserialize<UpdateStatusAllGatewayParam>();
                        WsUpdateAllGateway(updateStatusAllGateway);
                        break;

                    case (int)CmdType.UpdateDashboard:
                        var updateDashboard = baseMessage.Param.Deserialize<UpdateDashboard>();
                        if (updateDashboard.Type == "Gateway")
                        {
                            if (updateDashboard.Status == 1)
                            {
                                DataDashboard.onlineGateway++;
                                DataDashboard.offlineGateway--;
                            }
                            else
                            {
                                DataDashboard.onlineGateway--;
                                DataDashboard.offlineGateway++;
                            }
                        }
                        else if (updateDashboard.Type == "Device")
                        {
                            if (updateDashboard.Status == 1)
                            {
                                DataDashboard.onlineDevice++;
                                DataDashboard.offlineDevice--;
                            }
                            else
                            {
                                DataDashboard.onlineDevice--;
                                DataDashboard.offlineDevice++;
                            }
                        }
                        InitDashboardHandle?.Invoke(null, DataDashboard);
                        break;

                    case (int)CmdType.InitDashboard:
                        var initDashboard = baseMessage.Param.Deserialize<InitDashboard>();
                        DataDashboard = initDashboard;
                        InitDashboardHandle?.Invoke(null, initDashboard);
                        break;
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine($"[ERROR] Failed to parse message: {ex.Message}");
            }
        }

        static async void WsUpdateAllGateway(UpdateStatusAllGatewayParam updateStatusAllGateway)
        {
            foreach (var gatewayWs in updateStatusAllGateway.Member)
            {
                if (GatewayList.Contains(gatewayWs.Key))
                {
                    continue;
                }
                foreach (var gatewayMap in MapSites.Values)
                {

                    var gateway = gatewayMap.FirstOrDefault(x => x.gateway_id.ToString() == gatewayWs.Key && x.type == "gateway");
                    if (gateway != null)
                    {
                        var lastGateway = gateway as DeviceNode;
                        if (lastGateway != null)
                        {
                            lastGateway.SetOnline(gatewayWs.Value.Status);
                            GatewayList.Add(lastGateway.gateway_id.ToString());
                            break;
                        }

                    }
                }
            }
        }

        static async void WsUpdateGatewayMap(UpdateStatusGatewayParam updateStatusGateway)
        {
            Console.WriteLine($"updateStatusGateway MemberID: {updateStatusGateway.MemberID} | Online: {updateStatusGateway.Status}");
            try
            {
                foreach (var siteDevicesPair in MapSites)
                {
                    var gateway = siteDevicesPair.Value
                        .FirstOrDefault(d => d.gateway_id == updateStatusGateway.MemberID && d.type == "gateway");
                    Console.WriteLine($"SiteId {siteDevicesPair.Key}");
                    if (gateway != null)
                    {
                        Console.WriteLine($"SiteId2:: {siteDevicesPair.Key}");
                        if (gateway is DeviceNode deviceNode)
                        {
                            Console.WriteLine($"SiteId3:: {siteDevicesPair.Key}");

                            try
                            {
                                deviceNode.SetOnline(updateStatusGateway.Status);
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine($"[ERROR] SiteId3::: {ex}");
                            }

                            Console.WriteLine($"deviceNode name {deviceNode.gateway_name}");
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[ERROR] WsUpdateDevicesMap: {ex.Message}");
            }
        }

        static async void WsUpdateDevicesMap(UpdateStatusDataParam updateStatusData)
        {
            try
            {
                // Find the device in MapSites by gateway_id and device_id
                foreach (var siteDevicesPair in MapSites)
                {
                    var device = siteDevicesPair.Value
                        .FirstOrDefault(d => d.gateway_id == updateStatusData.Member && d.device_id == updateStatusData.Device);

                    if (device != null)
                    {
                        // If device is Dimmer, update its properties
                        if (device is Dimmer dimmer)
                        {
                            switch (updateStatusData.Ctrl)
                            {
                                case 0: dimmer.SetOnline(updateStatusData.V); break;
                                case 1: dimmer.SetDim(updateStatusData.V); break;
                                case 2: dimmer.SetStatus(updateStatusData.V); break;
                                case 10: dimmer.SetPercentage(updateStatusData.V); break;
                                case 11: dimmer.SetTemp(updateStatusData.V); break;
                                case 12: dimmer.SetCharge(updateStatusData.V); break;
                                case 13: dimmer.SetPowerVolt(updateStatusData.V); break;
                                case 14: dimmer.SetPowerCurrent(updateStatusData.V); break;
                                case 15: dimmer.SetPowerOutVolt(updateStatusData.V); break;
                                case 16: dimmer.SetPowerOutCurrent(updateStatusData.V); break;
                                case 17: dimmer.SetBattVolt(updateStatusData.V); break;
                                case 18: dimmer.SetCapacity(updateStatusData.V); break;
                                case 19: dimmer.SetBattHealth(updateStatusData.V); break;
                                case 20: dimmer.SetCycleCount(updateStatusData.V); break;
                            }
                        }
                        UpdateStatusDataHandle?.Invoke(null, updateStatusData);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[ERROR] WsUpdateDevicesMap: {ex.Message}");
            }
        }


        public static async Task SendWsAsync(string cmd, object _param)
        {
            if (_WssClient != null && _WssClient.Connected)
            {
                var payload = new
                {
                    cmd = cmd,
                    param = _param

                };

                string json = JsonSerializer.Serialize(payload);
                await _WssClient.SendAsync(json);
                Console.WriteLine($"Send:::::::::::{payload}");
            }
            else
            {
                Console.WriteLine("WebSocket is not connected.");
            }
        }
        public static async Task LogoutWsAsync()
        {
            try
            {
                ProfileName = "User";
                Username = "@Username";
                UserImage = "";
                UserEmail = "";
                UserToken = "";
                MemberId = 0;
                UserRole = UserRole.None;
                SiteList.Clear();
                MapSites.Clear();
                MemberSites.Clear();
                GatewayList.Clear();

                if (_WssClient != null)
                {
                    _WssClient.Stop();
                    _WssClient.Dispose();
                    _WssClient = null;
                }

                AppPreferences.Email = "";
                AppPreferences.Password = "";

                Application.Current.MainPage = new NavigationPage(new StartUpPage());

                Console.WriteLine("Logout completed. WebSocket disconnected.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[ERROR] LogoutWsAsync failed: {ex.Message}");
            }
        }



        static void WsLogger(string msg)
        {
            Console.WriteLine(msg);
        }

    }
}
