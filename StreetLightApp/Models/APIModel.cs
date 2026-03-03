using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{

    public class loginv2
    {
        public string message { get; set; }
        public string token { get; set; }
        public User user { get; set; }
    }

    public class LoginResult
    {
        public bool Success { get; set; } = false;
        public string Message { get; set; }
        public LoginResultReason Reason { get; set; }
        public System.Net.HttpStatusCode HttpStatusCode { get; set; }
    }

    public enum LoginResultReason
    {
        Success = 1,
        UsernameOrPasswordWrong = 2,
        CannotConnectToServer = 3,
        Other = 99
    }


    public class ApiResponse
    {
        public string Message { get; set; }
        public System.Net.HttpStatusCode HttpStatusCode { get; set; }
    }
}
