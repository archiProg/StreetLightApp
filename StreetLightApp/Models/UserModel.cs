using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{
    public enum UserRole
    {
        Admin,
        Owner,
        Customer,
        None,
    }

    public class User
    {
        public int id { get; set; }
        public string username { get; set; }
        public string member_name { get; set; }
        public string email { get; set; }
        public object img { get; set; }
        public string role { get; set; }
        public List<Site> sites { get; set; }
    }
}
