using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{
    public class MaintenanceModel
    {
        public int id { get; set; }
        public int gateway_id { get; set; }
        public int device_id { get; set; }
        public DateTime maintenance_date { get; set; }
        public string maintenance_type { get; set; }
        public string description { get; set; }
        public int? technician_id { get; set; }
        public string status { get; set; }
        public DateTime created_at { get; set; }
        public DateTime updated_at { get; set; }
        public int site_id { get; set; }
        public string device_name { get; set; }
    }
}
