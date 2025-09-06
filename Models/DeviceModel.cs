using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{
    public class DeviceNode
    {
        public int site_id { get; set; }
        public int contract_id { get; set; }
        public string contract_number { get; set; }
        public int gateway_id { get; set; }
        public string gateway_name { get; set; }
        public double gateway_lat { get; set; }
        public double gateway_long { get; set; }
        public string type { get; set; }
        public int? device_id { get; set; }
        public string device_name { get; set; }
        public int? device_style { get; set; }
        public double? lat { get; set; }
        public double? @long { get; set; }
        public int? group_id { get; set; }
        public string group_name { get; set; }
        public string description { get; set; } 
        public ObservableCollection<Control> controls { get; set; }
        public List<Config> config { get; set; }
    }

    public class Control
    {
        public int control_id { get; set; }
        public string label { get; set; }
        public double last_value { get; set; }
    }

    public class Config
    {
        public int config_id { get; set; }
        public string type { get; set; }
        public string detail { get; set; }
        public string status { get; set; }
    }
}
