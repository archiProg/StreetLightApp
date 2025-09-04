using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Services
{
    public static class AppPreferences
    {
        static string host = "192.168.1.20";
        public static string Host
        {
            get
            {
                host = Preferences.Get("host", "192.168.1.20");
                return host;
            }
            set
            {
                host = value;
                Preferences.Set("host", host);
            }
        }
        static int port = 1;
        public static int Port
        {
            get
            {
                port = Preferences.Get("port", 8000);
                return port;
            }
            set
            {
                port = value;
                Preferences.Set("port", port);
            }
        }
        static int language = 1;
        public static int Language
        {
            get
            {
                language = Preferences.Get("language", 1);
                return language;
            }
            set
            {
                language = value;
                Preferences.Set("language", language);
            }
        }
        static string email;
        public static string Email
        {
            get
            {
                email = Preferences.Get("email", "null");
                return email;
            }
            set
            {
                email = value;
                Preferences.Set("email", email);
            }
        }
        /*static string username;
        public static string Username
        {
            get
            {
                username = Preferences.Get("username", "null");
                return username;
            }
            set
            {
                username = value;
                Preferences.Set("username", username);
            }
        }*/
        static string password;
        public static string Password
        {
            get
            {
                password = Preferences.Get("password", "null");
                return password;
            }
            set
            {
                password = value;
                Preferences.Set("password", password);
            }
        }
        // For Demo

        /*static int memberTarget = 0;
        public static int MemberTarget
        {
            get
            {
                memberTarget = Preferences.Get("memberTarget", 0);
                return memberTarget;
            }
            set
            {
                memberTarget = value;
                Preferences.Set("memberTarget", memberTarget);
            }
        }
        static int deviceTarget = 0;
        public static int DeviceTarget
        {
            get
            {
                deviceTarget = Preferences.Get("deviceTarget", 0);
                return deviceTarget;
            }
            set
            {
                deviceTarget = value;
                Preferences.Set("deviceTarget", deviceTarget);
            }
        }*/
    }
}
