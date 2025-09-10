using Microsoft.Extensions.Logging;
using StreetLightApp.Models;
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
        public static string APIHost = "http://192.168.1.66:5000";
        public static string ProfileName = "User";
        public static string Username = "@Username";
        //public static string HostImage = "http://100.76.74.10:5000/images/profile/";
        public static string HostImage = "http://192.168.1.66:5000/images/profile/";
        public static string UserImage = "";
        public static string UserEmail = "";
        public static string UserToken = "";
        public static UserRole UserRole = UserRole.None;
        public static WatsonWsClient _WssClient = null;


        public static List<Site> SiteList = new List<Site>();

        public static List<MyDevice> SiteDevices = new List<MyDevice>();

        public static Dictionary<int, List<MyDevice>> MapSites = new();

        public static event EventHandler<UpdateStatusDataParam> UpdateStatusDataHandle;

        public async static void Initialize()
        {
            //await ConnectWssServer("ws://100.76.74.10:8000/echo");
            await ConnectWssServer("ws://192.168.1.66:8000/echo");
        }

        public static async Task ConnectWssServer(string _ServerIp)
        {
            if (_WssClient != null) _WssClient.Dispose();

            _WssClient = new WatsonWsClient(new Uri(_ServerIp));
            _WssClient.AcceptInvalidCertificates = false;
            _WssClient.ServerConnected += WsServerConnected;
            _WssClient.ServerDisconnected += WsServerDisconnected;
            _WssClient.MessageReceived += MessageReceived;
            _WssClient.Logger = WsLogger;
            _WssClient.Start();

            string token = Preferences.Get("token", "");
            await SendLoginWssAsync(token);

            Console.WriteLine("Client connected: " + _WssClient.Connected);
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

        static void WsServerConnected(object sender, EventArgs args)
        {
            Console.WriteLine("WsServer connected::::::::::::::");
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
                    case (int)CmdType.UpdateDevices:
                        var updateStatusData = baseMessage.Param.Deserialize<UpdateStatusDataParam>();

                        WsUpdateDevices(updateStatusData);
                        UpdateStatusDataHandle?.Invoke(null, updateStatusData);
                        break;
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine($"[ERROR] Failed to parse message: {ex.Message}");
            }
        }


        static async void WsUpdateDevices(UpdateStatusDataParam updateStatusData)
        {
            var device = SiteDevices.FirstOrDefault(g => g.gateway_id == updateStatusData.Member && g.device_id == updateStatusData.Device);
            if (device != null)
            {
                Console.WriteLine($"device.device_style::::::::::{device.device_style}");
                switch (device.device_style)
                {
                    case 3: // Dimmer
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
                        else
                        {
                            Console.WriteLine($"Device {device.device_id} expected to be Dimmer but is {device.GetType().Name}");
                        }
                        break;

                    default:
                        Console.WriteLine($"Unknown device type {device.device_style} for device {device.device_id}");
                        break;
                }
            }
            else
            {
                Console.WriteLine($"Device {updateStatusData.Device} not found in gateway {updateStatusData.Member}");
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

        static void WsLogger(string msg)
        {
            Console.WriteLine(msg);
        }

    }
}
