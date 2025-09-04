using Newtonsoft.Json;
using StreetLightApp.Models;
using StreetLightApp.Pages.TabbedPageKits;
using StreetLightApp.Services;

namespace StreetLightApp.Pages;

public partial class StartUpPage : ContentPage
{
    public StartUpPage()
    {
        InitializeComponent();

        var current = Connectivity.NetworkAccess;
        try
        {

            if (current != NetworkAccess.Internet)
            {
                Dispatcher.Dispatch(async () =>
               {
                   var res = await DisplayActionSheet("Can not access the internet.", "Close", null, "Please go to internet setting");


                   if (res == null)
                   {
                       System.Diagnostics.Process.GetCurrentProcess().Kill();
                   }
                   else if (res == "Close")
                   {
                       System.Diagnostics.Process.GetCurrentProcess().Kill();
                   }
                   else if (res == "Please go to internet setting")
                   {
                       System.Diagnostics.Process.GetCurrentProcess().Kill();

                   }

               });


            }
            else
            {
                var user = AppPreferences.Email;
                var password = AppPreferences.Password;

                if (!string.IsNullOrEmpty(user) && !string.IsNullOrEmpty(password))
                {

                    Dispatcher.Dispatch(async () =>
                    {
                        var res = await Login(AppPreferences.Email, AppPreferences.Password);
                        if (res.HttpStatusCode == System.Net.HttpStatusCode.OK)
                        {
                            Provider.Initialize();

                            var page = new NavigationPage(new BaseTabbedPage())
                            {
                                BarTextColor = Colors.Black,
                            };

                            Application.Current.MainPage = new NavigationPage(page);
                        }
                        else if (res.Reason == LoginResultReason.CannotConnectToServer)
                        {
                            Application.Current.MainPage = new NavigationPage(new MaintenancePage())
                            {
                                //BarBackgroundColor = Colors.Blue,  // Set background color
                                BarTextColor = Color.FromArgb("#182032")       // Set title and back button color
                            };
                        }
                        else if (res.Reason == LoginResultReason.UsernameOrPasswordWrong)
                        {
                            Application.Current.MainPage = new NavigationPage(new LoginPage())
                            {
                                //BarBackgroundColor = Colors.Blue,  // Set background color
                                BarTextColor = Color.FromArgb("#182032")       // Set title and back button color
                            };
                        }
                        else
                        {
                            Application.Current.MainPage = new NavigationPage(new LoginPage())
                            {
                                //BarBackgroundColor = Colors.Blue,  // Set background color
                                BarTextColor = Color.FromArgb("#182032")       // Set title and back button color
                            };
                        }


                    });
                }
                else
                {

                    Dispatcher.Dispatch(async () =>
                    {
                        Application.Current.MainPage = new NavigationPage(new LoginPage())
                        {
                            //BarBackgroundColor = Colors.Blue,  // Set background color
                            BarTextColor = Color.FromArgb("#182032")       // Set title and back button color
                        };
                    });
                }
            }
        }
        catch (Exception e)
        {
            Console.WriteLine("StartUp.InitializeComponent.Connectivity.Error", "" + e);
        }


    }


    async Task<LoginResult> Login(string _username, string _password)
    {
         var parm = new
        {
            email = AppPreferences.Email,
            password = AppPreferences.Password,
        };
        var loginReq = await RequestApi.PostAsyncApi($"api/loginv2", JsonConvert.SerializeObject(parm));

        Console.WriteLine($"StartUp.Login:::{loginReq.HttpStatusCode}|{loginReq.Message}");

        if (loginReq.HttpStatusCode == System.Net.HttpStatusCode.OK)
        {
            var loginres = JsonConvert.DeserializeObject<loginv2>(loginReq.Message);
            
            if (loginres != null)
            {
                //Grab the data
                Provider.ProfileName = loginres.user.member_name;
                Provider.Username = loginres.user.username;
                Provider.UserEmail = loginres.user.email;
                Provider.UserToken = loginres.token;
                Provider.UserImage = loginres.user?.img?.ToString();
                Provider.SiteList = loginres.user?.sites;

                if (Enum.TryParse(loginres.user?.role, out UserRole role))
                {
                    Provider.UserRole = role;
                }
                else
                {
                    Provider.UserRole = UserRole.None; // or handle error
                }

                return new LoginResult
                {
                    Success = true,
                    Reason = LoginResultReason.Success,
                    HttpStatusCode = loginReq.HttpStatusCode,
                };
            }
            else
            {
                return new LoginResult
                {
                    Success = false,
                    Reason = LoginResultReason.Other,
                    HttpStatusCode = loginReq.HttpStatusCode,
                };
            }
        }
        else if (loginReq.HttpStatusCode == System.Net.HttpStatusCode.Unauthorized)
        {//401
            Console.WriteLine($"Unauthorized::: {loginReq.HttpStatusCode}");
            return new LoginResult
            {
                Success = false,
                Reason = LoginResultReason.UsernameOrPasswordWrong,
                Message = loginReq.Message,
                HttpStatusCode = loginReq.HttpStatusCode,
            };
        }
        else
        {
            Console.WriteLine($"Error::: {loginReq.HttpStatusCode}");
            return new LoginResult
            {
                Success = false,
                Reason = LoginResultReason.Other,
                Message = loginReq.Message,
                HttpStatusCode = loginReq.HttpStatusCode,
            };
        }
    }
}