using StreetLightApp.Models;
using System.Collections.ObjectModel;

namespace StreetLightApp.Pages;

public partial class ManageDevicePage : ContentPage
{
    private List<MyDevice> _selectDevices;
    Site CurrentSite = null;

    public ManageDevicePage(Site _site, List<MyDevice> selectDevices)
    {
        InitializeComponent();
        Title = _site.site_name;
        CurrentSite = _site;
        _selectDevices = selectDevices;
        BindingContext = this;
    }
 
}