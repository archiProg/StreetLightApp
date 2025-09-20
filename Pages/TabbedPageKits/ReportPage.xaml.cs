using StreetLightApp.Models;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class ReportPage : ContentPage
{


    public ReportPage()
    {
        InitializeComponent();
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



    // maintenace detail
    private void CheckBoxPowerInput_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        if (e.Value)
        {
            CheckBoxPowerOutput.IsChecked = false;
            CheckBoxBattery.IsChecked = false;
        }
    }

    private void CheckBoxPowerOutput_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        if (e.Value)
        {
            CheckBoxPowerInput.IsChecked = false;
            CheckBoxBattery.IsChecked = false;
        }
    }

    private void CheckBoxBattery_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        if (e.Value)
        {
            CheckBoxPowerInput.IsChecked = false;
            CheckBoxPowerOutput.IsChecked = false;
        }
    }

    private void OnSearchButtonClicked(object sender, EventArgs e)
    {

    }

    private void CheckBoxRepair_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        if (e.Value)
        {
            CheckBoxInspection.IsChecked = false;
        }
    }

    private void CheckBoxInspection_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        if (e.Value)
        {
            CheckBoxRepair.IsChecked = false;
        }
    }

    private void Picker_SelectedIndexChanged(object sender, EventArgs e)
    {
        var picker = (Picker)sender;

        if (picker.SelectedIndex == -1)
            return; 

        string selectedItem = picker.Items[picker.SelectedIndex];

         if (selectedItem == "Report | Maintenace")
        {
            ReportDetail.IsVisible = true;
            MaintenaceDetail.IsVisible = true;
            DeviceDetail.IsVisible = false;
        }
        else if (selectedItem == "Report | Device")
        {
            ReportDetail.IsVisible = true;
            MaintenaceDetail.IsVisible = false;
            DeviceDetail.IsVisible = true;
        }
    }
}