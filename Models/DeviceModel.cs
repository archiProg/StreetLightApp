using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{
    public class MyDevice
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


    public class DeviceNode : MyDevice
    {
        public event EventHandler<int> OnlineHandler;
        public int Online { get; set; }


        public DeviceNode(MyDevice _myDevice)
        {
            site_id = _myDevice.site_id;
            contract_id = _myDevice.contract_id;
            contract_number = _myDevice.contract_number;
            gateway_id = _myDevice.gateway_id;
            gateway_name = _myDevice.gateway_name;
            gateway_lat = _myDevice.gateway_lat;
            gateway_long = _myDevice.gateway_long;
            type = _myDevice.type;
            device_id = _myDevice.device_id;
            device_name = _myDevice.device_name;
            device_style = _myDevice.device_style;
            lat = _myDevice.gateway_lat;
            @long = _myDevice.gateway_long;
            group_id = _myDevice.group_id;
            group_name = _myDevice.group_name;
            description = _myDevice.description;
            Online = 0;
        }

        public void SetOnline(int online)
        {
            Online = online;

            OnlineHandler?.Invoke(this, online);

        }
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
