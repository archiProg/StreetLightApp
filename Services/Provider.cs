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
        public static string APIHost = "http://100.76.74.10:5000";
        public static string ProfileName = "User";
        public static string Username = "@Username";
        public static string HostImage = "http://100.76.74.10:5000/images/profile/";
        public static string UserImage = "";
        public static string UserEmail = "";
        public static string UserToken = "";
        public static UserRole UserRole = UserRole.None;
        public static WatsonWsClient _WssClient = null;


        public static List<Site> SiteList = new List<Site>();

        public static List<FocusGatewayModel> FocusSite = new List<FocusGatewayModel>();


        public async static void Initialize()
        {
            await ConnectWssServer("ws://100.76.74.10:8000/echo");
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
                        break;
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine($"[ERROR] Failed to parse message: {ex.Message}");
            }
        }


        static void WsUpdateDevices(UpdateStatusDataParam updateStatusData)
        {
            var gateway = FocusSite.FirstOrDefault(g => g.gateway_id == updateStatusData.Member);

            if (gateway != null)
            {
                var deviceType = gateway.DEVICE_TYPE.FirstOrDefault(d => d.ContainsKey(updateStatusData.Device));
                if (deviceType != null)
                {
                    int type = deviceType[updateStatusData.Device];
                    switch (type)
                    {
                        case 3: // Dimmer
                            var dimmer = gateway.Dimmers.FirstOrDefault(d => d.DeviceID == updateStatusData.Device);
                            if (dimmer != null)
                            {
                                dimmer.Status = updateStatusData.V;
                                Console.WriteLine($"Dimmer {dimmer.DeviceID} status updated to {dimmer.Status}");
                            }
                            else
                            {
                                Console.WriteLine($"Dimmer {updateStatusData.Device} not found in gateway {gateway.gateway_id}");
                            }
                            break;
                        // Handle other device types here
                        default:
                            Console.WriteLine($"Unknown device type {type} for device {updateStatusData.Device}");
                            break;
                    }
                }
                else
                {
                    Console.WriteLine($"Device {updateStatusData.Device} not found in gateway {gateway.gateway_id}");
                }

            }
            else
            {
                Console.WriteLine($"Gateway {updateStatusData.Member} not found.");
            }


        }

        static void WsLogger(string msg)
        {
            Console.WriteLine(msg);
        }

    }
}
