using Microsoft.Extensions.Logging;
using StreetLightApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using WatsonWebsocket;

namespace StreetLightApp.Services
{
    public static class Provider
    {
        public static string APIHost = "http://192.168.1.66:5000";
        public static string ProfileName = "User";
        public static string Username = "@Username";
        public static string HostImage = "http://192.168.1.66:5000/images/profile/";
        public static string UserImage = "";
        public static string UserEmail = "";
        public static string UserToken = "";
        public static UserRole UserRole = UserRole.None;
        public static WatsonWsClient _WssClient = null;


        public static List<Site> SiteList = new List<Site>();


        public async static void Initialize()
        {
            await ConnectWssServer("ws://192.168.1.66:8000");

        }

        public static async Task ConnectWssServer(string _ServerIp)
        {
            if (_WssClient != null) _WssClient.Dispose();

            _WssClient = new WatsonWsClient(new Uri(_ServerIp));
            _WssClient.AcceptInvalidCertificates = false;
            _WssClient.ServerConnected += ServerConnected;
            _WssClient.ServerDisconnected += ServerDisconnected;
            _WssClient.MessageReceived += MessageReceived;
            _WssClient.Logger = Logger;
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

        static void ServerConnected(object sender, EventArgs args)
        {
            Console.WriteLine("WsServer connected::::::::::::::");
        }

        static void ServerDisconnected(object sender, EventArgs args)
        {
            Console.WriteLine("WsServer disconnected");
        }

        static void MessageReceived(object sender, MessageReceivedEventArgs args)
        {
            string msg = "(null)";
            if (args.Data != null && args.Data.Count > 0)
                msg = Encoding.UTF8.GetString(args.Data.Array, 0, args.Data.Count);

            Console.WriteLine("from server: " + msg);
        }

        static void Logger(string msg)
        {
            Console.WriteLine(msg);
        }

    }
}
