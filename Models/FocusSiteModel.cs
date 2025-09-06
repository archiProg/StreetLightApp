using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{
    public class FocusGatewayModel
    {
        public int gateway_id { get; set; }
        public string GatewayName { get; set; }
        public int Status { get; set; }
        public int contract_id { get; set; }
        public string contract_number { get; set; }
        public double gateway_lat { get; set; }
        public double gateway_long { get; set; }

        public List<Dictionary<int, int>> DEVICE_TYPE = new();
        public List<Dimmer> Dimmers = new();
    }

}
