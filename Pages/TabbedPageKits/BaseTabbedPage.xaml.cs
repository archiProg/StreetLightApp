namespace StreetLightApp.Pages.TabbedPageKits;

public partial class BaseTabbedPage : TabbedPage
{
    bool IsiOS => DeviceInfo.Platform == DevicePlatform.iOS;
    bool IsAndroid => DeviceInfo.Platform == DevicePlatform.Android;
    public BaseTabbedPage()
    {
        InitializeComponent();


#if ANDROID
        //DisplayAlert("Login","Login result","Close");
        Microsoft.Maui.Controls.PlatformConfiguration.AndroidSpecific.TabbedPage.SetToolbarPlacement(this, Microsoft.Maui.Controls.PlatformConfiguration.AndroidSpecific.ToolbarPlacement.Bottom);
#endif
    }

    private void TabbedPage_CurrentPageChanged(object sender, EventArgs e)
    {
        var tab = sender as TabbedPage;
        Console.WriteLine($"CurrentPageChanged:::{tab.CurrentPage}");
        /*if (tab?.CurrentPage is HomePage)
        {
            homePage.IconImageSource = "home_64.png";
        }
        else
        {
            homePage.IconImageSource = "home_64_noactive.png";
        }*/
    }

    private void TabbedPage_PagesChanged(object sender, System.Collections.Specialized.NotifyCollectionChangedEventArgs e)
    {
        Console.WriteLine($"PagesChanged:::{e.NewStartingIndex}");
    }

    private void homePage_NavigatedTo(object sender, NavigatedToEventArgs e)
    {
        var p = sender as ContentPage;
        p.IconImageSource = $"home_64.png";
    }

    private void HomePage_NavigatedFrom(object sender, NavigatedFromEventArgs e)
    {
        var p = sender as ContentPage;
        p.IconImageSource = $"home_64_noactive.png";
    }

    private void DevicePage_NavigatedTo(object sender, NavigatedToEventArgs e)
    {
        var p = sender as ContentPage;
        p.IconImageSource = $"list_48_active.png";
    }

    private void DevicePage_NavigatedFrom(object sender, NavigatedFromEventArgs e)
    {
        var p = sender as ContentPage;
        p.IconImageSource = $"list_48_noactive.png";
    }

}