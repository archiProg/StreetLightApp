using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{
    public class Member
    {
        public int id { get; set; }
        public string member_name { get; set; }
        public string email { get; set; }
        public int enabled { get; set; }
        public string role { get; set; }
    }

    public class MemberApiResponse
    {
        public int id { get; set; }
        public string name { get; set; }
        public List<Member> members { get; set; }
    }

 
}
