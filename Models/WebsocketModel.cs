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

    public class UpdateStatusGatewayParam
    {
        [JsonPropertyName("MemberID")]
        public int MemberID { get; set; }

        [JsonPropertyName("Status")]
        public int Status { get; set; }
    }


    public class UpdateStatusAllGatewayParam
    {
        [JsonPropertyName("Success")]
        public bool Success { get; set; }

        [JsonPropertyName("Message")]
        public string Message { get; set; }

        // Keep string keys for Member
        [JsonPropertyName("Member")]
        public Dictionary<string, MemberGateway> Member { get; set; }
    }

    public class MemberGateway
    {
        [JsonPropertyName("Status")]
        public int Status { get; set; }

        [JsonPropertyName("Img")]
        public string Img { get; set; }

        [JsonPropertyName("Name")]
        public string Name { get; set; }

        [JsonPropertyName("DeviceType")]
        public int DeviceType { get; set; }
    }

    public enum CmdType
    {
        LOGIN = 2,
        UpdateStatusGateWay = 9, 
        UpdateDevices = 31,
        UpdateStatusAllGateway = 34
    }
}
