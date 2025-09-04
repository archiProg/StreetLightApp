using StreetLightApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

        public static List<Site> SiteList = new List<Site>();


        public static void Initialize()
        {
            

        }
    }
}
