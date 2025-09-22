namespace StreetLightApp.Pages.TabbedPageKits;

public partial class BaseTabbedPage : TabbedPage
{
    bool IsiOS => DeviceInfo.Platform == DevicePlatform.iOS;
    bool IsAndroid => DeviceInfo.Platform == DevicePlatform.Android;
    public BaseTabbedPage()
    {
        InitializeComponent();
        for (int i = 0; i < this.Children.Count; i++)
        {
            Console.WriteLine($"Tab[{i}]: {this.Children[i].GetType().Name}, Title: {this.Children[i].Title}");
        }


#if ANDROID
        //DisplayAlert("Login","Login result","Close");
        Microsoft.Maui.Controls.PlatformConfiguration.AndroidSpecific.TabbedPage.SetToolbarPlacement(this, Microsoft.Maui.Controls.PlatformConfiguration.AndroidSpecific.ToolbarPlacement.Bottom);
#endif
    }

    private void TabbedPage_CurrentPageChanged(object sender, EventArgs e)
    {
        var tab = sender as TabbedPage;
        Console.WriteLine($"CurrentPageChanged:::{tab.CurrentPage}");
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

    private void ReportPage_NavigatedTo(object sender, NavigatedToEventArgs e)
    {
        var p = sender as ContentPage;
        p.IconImageSource = $"calendarview_64.png";
    }

    private void ReportPage_NavigatedFrom(object sender, NavigatedFromEventArgs e)
    {
        var p = sender as ContentPage;
        p.IconImageSource = $"calendarview_64.png";
    }

    private void LogPage_NavigatedTo(object sender, NavigatedToEventArgs e)
    {
        var p = sender as ContentPage;
        Console.WriteLine("LogPage_NavigatedTo");
        p.IconImageSource = $"log_icon.png";
    }

    private void LogPage_NavigatedFrom(object sender, NavigatedFromEventArgs e)
    {
        var p = sender as ContentPage;
        Console.WriteLine("LogPage_NavigatedFrom");

        p.IconImageSource = $"log_icon.png";
    }

    private void SettingPage_NavigatedTo(object sender, NavigatedToEventArgs e)
    {
        var p = sender as ContentPage;
        p.IconImageSource = $"setting_64.png";
    }

    private void SettingPage_NavigatedFrom(object sender, NavigatedFromEventArgs e)
    {
        var p = sender as ContentPage;
        p.IconImageSource = $"setting_64.png";
    }
}