using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{
    public class WsMessage<T>
    {
        [JsonPropertyName("cmd")]
        public int Cmd { get; set; }

        [JsonPropertyName("param")]
        public T Param { get; set; }
    }

    public class UpdateStatusDataParam
    {
        [JsonPropertyName("Ctrl")]
        public int Ctrl { get; set; }

        [JsonPropertyName("Device")]
        public int Device { get; set; }

        [JsonPropertyName("Member")]
        public int Member { get; set; }

        [JsonPropertyName("V")]
        public int V { get; set; }

    }

    public enum CmdType
    {
        LOGIN = 2,
        UpdateDevices = 31
    }
}
