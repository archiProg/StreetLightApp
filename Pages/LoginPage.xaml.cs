using Newtonsoft.Json;
using StreetLightApp.Models;
using StreetLightApp.Pages.TabbedPageKits;
using StreetLightApp.Services;

namespace StreetLightApp.Pages;

public partial class LoginPage : ContentPage
{
    public LoginPage()
    {
        InitializeComponent();
    }

    private async void Button_Clicked(object sender, EventArgs e)
    {
        var user = usernameTxt.Text;
        var pass = passTxt.Text;

        if (string.IsNullOrEmpty(user))
        {
            await DisplayAlert("Infomation", "Username must be empty.", "Close");
            usernameTxt.Focus();
        }
        else if (string.IsNullOrEmpty(pass))
        {
            await DisplayAlert("Infomation", "Password must be empty.", "Close");
            passTxt.Focus();
        }
        else
        {
            var res = await Login(user, pass);

            if (res.Success == true)
            {
                var page = new NavigationPage(new BaseTabbedPage())
                {
                    BarTextColor = Colors.Black,
                };

                Application.Current.MainPage = new NavigationPage(page);
            }
            else
            {
                await DisplayAlert("Login", $"{res.Message}", "Close");
            }

        }
    }

    private void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {

    }

    private async void googleAccountBtn_Clicked(object sender, EventArgs e)
    {
        await DisplayAlert("Google", "Try to login with google account.", "Close");

    }


    async Task<LoginResult> Login(string _username, string _password)
    {
        var param = new
        {
            email = _username,
            password = _password,
        };

        var response = await RequestApi.PostAsyncApi($"api/loginv2", JsonConvert.SerializeObject(param));
        Console.WriteLine($"Login Response:::::{response.HttpStatusCode}|{response.Message}");
        var res = JsonConvert.DeserializeObject<loginv2>(response.Message);
        if (response.HttpStatusCode == System.Net.HttpStatusCode.OK)
        {//200
            Console.WriteLine($"Success::: {response.HttpStatusCode}");
            AppPreferences.Email = _username;
            AppPreferences.Password = _password;
            Provider.ProfileName = res.user.member_name;
            Provider.Username = res.user.username;
            Provider.UserEmail = res.user.email;
            Provider.UserToken = res.token;
            Provider.UserImage = res.user?.img?.ToString();
            Provider.SiteList = res.user?.sites;
            return new LoginResult
            {
                Success = true,
                Reason = LoginResultReason.Success,
            };
        }
        else if (response.HttpStatusCode == System.Net.HttpStatusCode.Unauthorized)
        {//401
            Console.WriteLine($"Unauthorized::: {response.HttpStatusCode}");
            return new LoginResult
            {
                Success = false,
                Reason = LoginResultReason.UsernameOrPasswordWrong,
                Message = res.message
            };
        }
        else
        {
            Console.WriteLine($"Error::: {response.HttpStatusCode}");
            return new LoginResult
            {
                Success = false,
                Reason = LoginResultReason.Other,
                Message = res.message
            };
        }

    }
}