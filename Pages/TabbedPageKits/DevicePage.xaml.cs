using StreetLightApp.Services;
using StreetLightApp.Views;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class DevicePage : ContentPage
{
    public DevicePage()
    {
        InitializeComponent();
        //sitePanel
        if (Provider.SiteList.Count > 0)
        {
            foreach (var site in Provider.SiteList)
            {
                var siteBtn = new SiteItem
                {
                    Title = site.site_name,
                    Description = site.site_label,
                    Img = "female_avatar.png"
                };
                siteBtn.Clicked += async(a, b) =>
                {
                    await Navigation.PushAsync(new DeviceSitePage(site));
                };
                sitePanel.Children.Add(siteBtn);
            }
        }
    }
    protected override void OnAppearing()
    {
        base.OnAppearing();
        Provider.SiteDevices.Clear();

    }
}