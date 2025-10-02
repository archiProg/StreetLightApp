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
        DevicesItem.Clicked += DevicesItem_Clicked;
        ReportsItem.Clicked += ReportsItem_Clicked;

        Provider.InitDashboardHandle += (sender, dashboard) =>
       {
           Dispatcher.Dispatch(() =>
           {
               LbCoutLampOnline.Text = dashboard.onlineDevice.ToString();
               LbCoutLampOffline.Text = dashboard.offlineDevice.ToString();
               LbTotalDevice1.Text = $"of {dashboard.totalDevice.ToString()}";
               LbTotalDevice2.Text = $"of {dashboard.totalDevice.ToString()}";
               LbCoutGatewayOffline.Text = dashboard.offlineGateway.ToString();
               LbCoutGatewayOnline.Text = dashboard.onlineGateway.ToString();
               LbTotalGateway1.Text = $"of {dashboard.totalGateway.ToString()}";
               LbTotalGateway2.Text = $"of {dashboard.totalGateway.ToString()}";
           });
       };
 
        // Set initial values
        LbCoutLampOnline.Text = Provider.DataDashboard.onlineDevice.ToString();
        LbCoutLampOffline.Text = Provider.DataDashboard.offlineDevice.ToString();
        LbTotalDevice1.Text = $"of {Provider.DataDashboard.totalDevice.ToString()}";
        LbTotalDevice2.Text = $"of {Provider.DataDashboard.totalDevice.ToString()}";
        LbCoutGatewayOffline.Text = Provider.DataDashboard.offlineGateway.ToString();
        LbCoutGatewayOnline.Text = Provider.DataDashboard.onlineGateway.ToString();
        LbTotalGateway1.Text = $"of {Provider.DataDashboard.totalGateway.ToString()}";
        LbTotalGateway2.Text = $"of {Provider.DataDashboard.totalGateway.ToString()}";
    }

    private void MapMenuItem_Clicked(object? sender, EventArgs e)
    {

        Dispatcher.Dispatch(async () =>
        {
            //await Navigation.PushAsync(new TestMap());
            await Navigation.PushAsync(new MapSitePage());
        });
    }
    private void DevicesItem_Clicked(object? sender, EventArgs e)
    {

        if (Parent is TabbedPage tabbedPage)
        {
             var devicePage = tabbedPage.Children
                .FirstOrDefault(p => p is DevicePage);

            if (devicePage != null)
            {
                tabbedPage.CurrentPage = devicePage; // switch tab
            }
        }
    }
    private void ReportsItem_Clicked(object? sender, EventArgs e)
    {

        if (Parent is TabbedPage tabbedPage)
        {
            var reportPage = tabbedPage.Children
               .FirstOrDefault(p => p is ReportPage);

            if (reportPage != null)
            {
                tabbedPage.CurrentPage = reportPage; // switch tab
            }
        }
    }

    private async void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
        var popup = new DimmerPopup();
        await MopupService.Instance.PushAsync(popup);
        var res = await popup.PopupDismissedTask;
        Console.WriteLine($"Popup:::Res:::{res}");
        //NavigationPage.SetHasNavigationBar(this, false);
    }
    protected override bool OnBackButtonPressed()
    {
        if (MopupService.Instance.PopupStack.Count > 0)
        {
            Dispatcher.Dispatch(async () =>
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