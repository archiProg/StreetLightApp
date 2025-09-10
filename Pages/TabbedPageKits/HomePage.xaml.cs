using StreetLightApp.Popups;
using StreetLightApp.Services;
using Mopups.Services;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class HomePage : ContentPage
{
	public HomePage()
	{
		InitializeComponent();
        //NavigationPage.SetHasNavigationBar(this, false);

        if (!string.IsNullOrEmpty(Provider.UserImage))
        {
            avatarProfile.Source = $"{Provider.HostImage}{Provider.UserImage}";
        }
        else
        {
            //Use First letter of username as avatar.
        }
        profileNameLbl.Text = Provider.ProfileName;
        profileUsernameLbl.Text = $"@{Provider.Username}";
        MapMenuItem.Clicked += MapMenuItem_Clicked;
    }

    private void MapMenuItem_Clicked(object? sender, EventArgs e)
    {

        Dispatcher.Dispatch(async () =>
        {
            await Navigation.PushAsync(new MapSitePage());
        });
    }

    private async void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
        var popup = new DimmerPopup();
        await MopupService.Instance.PushAsync(popup);
        var res = await popup.PopupDismissedTask;
        Console.WriteLine($"Popup:::Res:::{res}"); 
        //NavigationPage.SetHasNavigationBar(this, false);
    }
    protected override  bool OnBackButtonPressed()
    {
        if(MopupService.Instance.PopupStack.Count > 0)
        {
            Dispatcher.Dispatch(async() =>
            {
                await MopupService.Instance.PopAllAsync();
            });
            Console.WriteLine("Pop All Stack:::::::");
            return true;
        }
        else
        {
            Console.WriteLine("Normal Back:::::::");
            return false;
        }

            //return base.OnBackButtonPressed();
    }
    protected override void OnAppearing()
    {
        base.OnAppearing();
        //NavigationPage.SetHasNavigationBar(this, false);
    }

    private void MenuItem_Clicked(object sender, EventArgs e)
    {
        DisplayAlert("Menu Item Clicked", "You clicked a menu item!", "OK");
    }
}