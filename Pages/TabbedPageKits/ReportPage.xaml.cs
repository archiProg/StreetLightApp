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

    private void Button_Clicked(object sender, EventArgs e)
    {

    }

    private void Select_Report_Clicked(object sender, EventArgs e)
    {
        Dispatcher.Dispatch(async () =>
        {
            LogDetail.IsVisible = false;
            AllReportDetail.IsVisible = true;
            await AllReportDetail.FadeTo(0, 10);
            await AllReportDetail.FadeTo(1, 10);
            Select_Report.TextColor = Colors.Black;
            Select_Report.BackgroundColor = Colors.White;
            Select_Log.TextColor = Color.FromArgb("#8B9DB2");
            Select_Log.BackgroundColor = Color.FromArgb("#F1F5F9");
            await Select_Report.FadeTo(0, 200);
            await Select_Report.FadeTo(1, 200);
        });
    }

    private void Select_Log_Clicked(object sender, EventArgs e)
    {
        Dispatcher.Dispatch(async () =>
        {
            LogDetail.IsVisible = true;
            AllReportDetail.IsVisible = false;
            await LogDetail.FadeTo(0, 10);
            await LogDetail.FadeTo(1, 10);
            Select_Report.TextColor =Color.FromArgb("#8B9DB2");
            Select_Report.BackgroundColor = Color.FromArgb("#F1F5F9");
            Select_Log.TextColor = Colors.Black;
            Select_Log.BackgroundColor = Colors.White;
            await Select_Log.FadeTo(0, 200);
            await Select_Log.FadeTo(1, 200);
        });

    }

    // Log detail
}