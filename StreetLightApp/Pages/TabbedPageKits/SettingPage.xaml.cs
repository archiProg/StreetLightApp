
using StreetLightApp.Services;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class SettingPage : ContentPage
{
	public SettingPage()
	{
		InitializeComponent();
        avatarProfile.Source = $"{Provider.HostImage}{Provider.UserImage}";
        profileNameLbl.Text = Provider.ProfileName;
        profileUsernameLbl.Text = $"@{Provider.Username}";
    }

    private void Button_Clicked(object sender, EventArgs e)
    {

    }

    private async void ButtonLogout_Clicked(object sender, EventArgs e)
    {
        await Provider.LogoutWsAsync();
    }
}