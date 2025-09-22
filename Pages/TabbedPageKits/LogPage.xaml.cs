using StreetLightApp.Pages.Log;
using StreetLightApp.Services;
using StreetLightApp.Views;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class LogPage : ContentPage
{
    public LogPage()
    {
        InitializeComponent();
        if (Provider.SiteList.Count > 0)
        {
            foreach (var site in Provider.SiteList)
            {
                var siteBtn = new SiteItem
                {
                    Title = site.site_name,
                    Description = site.site_label,
                    Img = "log_site_icon.png"
                };
                siteBtn.Clicked += async (a, b) =>
                {
                    await Navigation.PushAsync(new LogSitePage(site));
                };
                sitePanel.Children.Add(siteBtn);
            }
        }
    }
}