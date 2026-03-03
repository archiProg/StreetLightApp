using StreetLightApp.Models;

namespace StreetLightApp.Pages.Log;

public partial class ReportMaintenacePage : ContentPage
{
    List<MaintenanceModel> Report_maintenace;
    public ReportMaintenacePage(List<MaintenanceModel> _report_maintenace)
    {
        InitializeComponent();
        Report_maintenace = _report_maintenace;
        DataReair.ItemsSource = Report_maintenace.Where(x => x.maintenance_type == "Repair").ToList();
        DataInspection.ItemsSource = Report_maintenace.Where(x => x.maintenance_type == "Inspection").ToList();
        RadioButtonRepair.IsChecked = true;


    }

    private async void RadioRepair_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        RadioButtonInspection.CheckedChanged -= RadioInspection_CheckedChanged;
        RadioButtonInspection.IsChecked = false;
        RadioButtonInspection.CheckedChanged += RadioInspection_CheckedChanged;
        DataReair.IsVisible = true;
        DataInspection.IsVisible = false;
        await DataReair.FadeTo(0, 10);
        await DataReair.FadeTo(1, 10);
    }

    private async void RadioInspection_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        RadioButtonRepair.CheckedChanged -= RadioRepair_CheckedChanged;
        RadioButtonRepair.IsChecked = false;
        RadioButtonRepair.CheckedChanged += RadioRepair_CheckedChanged;
        DataReair.IsVisible = false;
        DataInspection.IsVisible = true;
        await DataInspection.FadeTo(0, 10);
        await DataInspection.FadeTo(1, 10);
    }
}