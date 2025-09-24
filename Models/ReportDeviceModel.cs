using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{
 
    public class RootReportDevice
    {
        public string message { get; set; }
        public List<ReportDeviceModel> data { get; set; }
    }

    public class ReportDeviceModel
    {
        public string period { get; set; }
        public double avgInput { get; set; }
        public double avgOutput { get; set; }
        public double avgBattery { get; set; }

    }

}
