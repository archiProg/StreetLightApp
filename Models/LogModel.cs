using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{
 
    public class LogModelData
    {
        public string log_type { get; set; }
        public int gateway_id { get; set; }
        public object device_id { get; set; }
        public int control_id { get; set; }
        public int last_value { get; set; }
        public int? member_id { get; set; }
        public string member_name { get; set; }
        public DateTime created_at { get; set; }
    }

    public class LogModel
    {
        public string message { get; set; }
        public List<LogModelData> data { get; set; }
    }
}
