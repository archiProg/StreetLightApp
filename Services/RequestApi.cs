using Newtonsoft.Json;
using RestSharp;
using StreetLightApp.Models;
using System.Net;
using System.Text;

namespace StreetLightApp.Services
{
    public class RequestApi
    {
        private static readonly HttpClient _httpClient = new();

        static long ExpireAt = 0;


        public static async Task<ApiResponse> PostAsyncApi(string endpoint, string jsonData, Dictionary<string, string> headers = null)
        {
            ApiResponse apiResponse = new ApiResponse();

            try
            {
                if (string.IsNullOrEmpty(Provider.APIHost))
                {
                    apiResponse.HttpStatusCode = HttpStatusCode.InternalServerError;
                    apiResponse.Message = "Exception: Base URL is not set.";
                    return apiResponse;
                }

                var url = $"{Provider.APIHost}/{endpoint}";

                using var request = new HttpRequestMessage(HttpMethod.Post, url)
                {
                    Content = new StringContent(jsonData, Encoding.UTF8, "application/json")
                };

                if (headers != null)
                {
                    foreach (var item in headers)
                    {
                        request.Headers.TryAddWithoutValidation(item.Key, item.Value);
                    }
                }

                var response = await _httpClient.SendAsync(request);
                var responseContent = await response.Content.ReadAsStringAsync();

                apiResponse.HttpStatusCode = response.StatusCode;
                apiResponse.Message = responseContent;
                return apiResponse;
            }
            catch (Exception ex)
            {
                apiResponse.HttpStatusCode = HttpStatusCode.InternalServerError;
                apiResponse.Message = $"Exception: {ex.Message}";
                return apiResponse;
            }
        }



        public static async Task<ApiResponse> PostAsyncApiJWT2(string _endpoint, string _body, Dictionary<string, string> _header = null)
        {
            long now = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
            try
            {
                if (now > ExpireAt || string.IsNullOrEmpty(Provider.UserToken))
                {
                    var body = new
                    {
                        email = AppPreferences.Email,
                        password = AppPreferences.Password,
                    };
                    var loginReq = await PostAsyncApi($"{Provider.APIHost}/api/loginv2", JsonConvert.SerializeObject(body));
                    if (loginReq.HttpStatusCode == System.Net.HttpStatusCode.OK)
                    {
                        var loginres = JsonConvert.DeserializeObject<loginv2>(loginReq?.Message?.ToString());
                        Provider.ProfileName = loginres.user.member_name;
                        Provider.Username = loginres.user.username;
                        Provider.UserEmail = loginres.user.email;
                        Provider.UserToken = loginres.token;
                        Provider.UserImage = loginres.user?.img?.ToString();
                        Provider.SiteList = loginres.user?.sites;
                        int secondsInOneDay = 60 * 60 * 24; // 1 day
                        int expireOffset = secondsInOneDay - 10;  // 1 day minus 10 sec
                        ExpireAt = (int)(DateTimeOffset.UtcNow.ToUnixTimeSeconds() + expireOffset);
                        Console.WriteLine($"ExpireAt:::{ExpireAt}");
                        if (Enum.TryParse(loginres.user?.role, out UserRole role))
                        {
                            Provider.UserRole = role;
                        }
                        else
                        {
                            Provider.UserRole = UserRole.None;
                        }

                    }
                }
                if (_header != null)
                {
                    if (!_header.ContainsKey("Authorization"))
                    {
                        _header.Add("Authorization", $"Bearer {Provider.UserToken}");
                    }
                }
                else
                {
                    _header = new Dictionary<string, string>();
                    _header.Add("Authorization", $"Bearer {Provider.UserToken}");
                }
                var res = await PostAsyncApi(_endpoint, _body, _header);
                return new ApiResponse
                {
                    HttpStatusCode = res.HttpStatusCode,
                    Message = res.Message
                };
            }
            catch (Exception ex)
            {
                //Console.WriteLine($"POST Request Exception: {ex.Message}");
                return new ApiResponse
                {
                    Message = $"Exception: {ex.Message}",
                    HttpStatusCode = System.Net.HttpStatusCode.InternalServerError
                };
            }
        }


        public static async Task<ApiResponse> PostAsyncApi2(string _endpoint, string _param, Dictionary<string, string> _header = null)
        {
            try
            {
                var options = new RestClientOptions()
                {
                    //MaxTimeout = -1,
                };
                var client = new RestClient(options);
                var request = new RestRequest($"{_endpoint}", Method.Post);
                request.AddHeader("Content-Type", "application/json");
                if (_header != null)
                {
                    foreach (var item in _header)
                    {
                        request.AddHeader(item.Key, item.Value);
                    }
                }

                request.AddStringBody(_param, DataFormat.Json);
                RestResponse response = await client.ExecuteAsync(request);
                Console.WriteLine($"Login:::Response:::{response.Content}");

                return new ApiResponse
                {
                    Message = response?.Content?.ToString(),
                    HttpStatusCode = response.StatusCode,
                };
            }

            catch (Exception ex)
            {
                //Console.WriteLine($"POST Request Exception: {ex.Message}");
                return new ApiResponse
                {
                    Message = $"Exception: {ex.Message}",
                    HttpStatusCode = System.Net.HttpStatusCode.InternalServerError
                };
            }
        }


        public static async Task<ApiResponse> GetAPI(string _endpoint, Dictionary<string, string> _header = null)
        {
            try
            {
                var options = new RestClientOptions()
                {
                    //MaxTimeout = -1,
                };
                var client = new RestClient(options);
                var request = new RestRequest($"{_endpoint}", Method.Get);

                if (_header != null)
                {
                    foreach (var kv in _header)
                    {
                        request.AddHeader(kv.Key, kv.Value);
                    }
                }

                RestResponse response = await client.ExecuteAsync(request);
                Console.WriteLine(response.Content);

                return new ApiResponse
                {
                    Message = response?.Content?.ToString(),
                    HttpStatusCode = response.StatusCode,
                };
            }

            catch (Exception ex)
            {
                //Console.WriteLine($"POST Request Exception: {ex.Message}");
                return new ApiResponse
                {
                    Message = $"Exception: {ex.Message}",
                    HttpStatusCode = System.Net.HttpStatusCode.InternalServerError
                };
            }
        }

        public static async Task<ApiResponse> GetAPIJWT(string _endpoint, Dictionary<string, string> _header = null)
        {
            try
            {
                Console.WriteLine($"GetJWT:::{_endpoint}");
                long now = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
                if (now > ExpireAt || string.IsNullOrEmpty(Provider.UserToken))
                {
                    var body = new
                    {
                        email = AppPreferences.Email,
                        password = AppPreferences.Password,
                    };
                    var loginReq = await PostAsyncApi($"{Provider.APIHost}/api/loginv2", JsonConvert.SerializeObject(body));
                    if (loginReq.HttpStatusCode == System.Net.HttpStatusCode.OK)
                    {
                        var loginres = JsonConvert.DeserializeObject<loginv2>(loginReq?.Message?.ToString());
                        Provider.ProfileName = loginres.user.member_name;
                        Provider.Username = loginres.user.username;
                        Provider.UserEmail = loginres.user.email;
                        Provider.UserToken = loginres.token;
                        Provider.UserImage = loginres.user?.img?.ToString();
                        Provider.SiteList = loginres.user?.sites;
                        int secondsInOneDay = 60 * 60 * 24; // 1 day
                        int expireOffset = secondsInOneDay - 10;  // 1 day minus 10 sec
                        ExpireAt = (int)(DateTimeOffset.UtcNow.ToUnixTimeSeconds() + expireOffset);
                        //ExpireAt = (long)DateTimeOffset.UtcNow.ToUnixTimeSeconds() + (60 * 60 * 24); // 1 day
                        Console.WriteLine($"ExpireAt:::{ExpireAt}");
                        if (Enum.TryParse(loginres.user?.role, out UserRole role))
                        {
                            Provider.UserRole = role;
                        }
                        else
                        {
                            Provider.UserRole = UserRole.None;
                        }

                    }
                }
                if (_header != null)
                {
                    if (!_header.ContainsKey("Authorization"))
                    {
                        _header.Add("Authorization", $"Bearer {Provider.UserToken}");
                    }
                }
                else
                {
                    _header = new Dictionary<string, string>();
                    _header.Add("Authorization", $"Bearer {Provider.UserToken}");
                }
                var res = await GetAPI(_endpoint, _header);
                return new ApiResponse
                {
                    HttpStatusCode = res.HttpStatusCode,
                    Message = res.Message
                };
            }
            catch (Exception ex)
            {
                //Console.WriteLine($"POST Request Exception: {ex.Message}");
                return new ApiResponse
                {
                    Message = $"Exception: {ex.Message}",
                    HttpStatusCode = System.Net.HttpStatusCode.InternalServerError
                };
            }

        }
    }

}



