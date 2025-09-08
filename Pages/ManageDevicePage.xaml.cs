using Microsoft.Maui.Controls;
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

        string tit = "";
            foreach (var device in selectDevices)
        {
            if (tit.Length > 0)
                tit += ", ";
            tit += device.device_name;
        }
        titleLbl.Text = $"{tit}";
        itemCountLbl.Text = $"{selectDevices.Count} Items";
    }

    private void statusSwitch_Toggled(object sender, ToggledEventArgs e)
    {
        statusLbl.Text = $"{(e.Value ? "ON" : "OFF")}";
        statusLbl.TextColor = Color.FromArgb($"#{(e.Value ? "52C68C" : "EF8484")}");
    }
}