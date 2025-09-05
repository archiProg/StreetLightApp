using StreetLightApp.Models;
using System.Collections.ObjectModel;

namespace StreetLightApp.Pages;

public partial class ManageDevicePage : ContentPage
{
    private List<DeviceNode> _selectDevices;
    Site CurrentSite = null;

    public ManageDevicePage(Site _site, List<DeviceNode> selectDevices)
    {
        InitializeComponent();
        Title = _site.site_name;
        CurrentSite = _site;
        _selectDevices = selectDevices;
        BindingContext = this;
    }
 
}