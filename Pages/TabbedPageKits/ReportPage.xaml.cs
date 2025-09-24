using Microsoft.Maui.HotReload;
using StreetLightApp.Models;
using StreetLightApp.Pages.Log;
using StreetLightApp.Services;
using StreetLightApp.Views;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class ReportPage : ContentPage
{


    public ReportPage()
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

    private void MapPinClicked(MapPin pin)
    {
        // Handle pin click
    }

    private void DeviceSearchTxt_Focused(object sender, FocusEventArgs e)
    {

    }

    private void DeviceSearchTxt_Unfocused(object sender, FocusEventArgs e)
    {

    }

    private void SitePick_SelectedIndexChanged(object sender, EventArgs e)
    {

    }



 

 

 

 

    // Log detail
}