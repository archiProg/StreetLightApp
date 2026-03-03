using StreetLightApp.Models;

namespace StreetLightApp.Views;

public partial class SiteItemMap : ContentView
{
    public event EventHandler Clicked;
    public SiteItemMap(Site _site)
    {
        InitializeComponent();
        SiteName.Text = _site.site_name;
        SiteLabelName.Text = _site.site_label;
    }

    private void OnBorderTapped(object sender, TappedEventArgs e)
    {
        Clicked?.Invoke(this, e);
    }
}