using StreetLightApp.Models;

namespace StreetLightApp.Pages.Log;

public partial class LogDetailSitePage : ContentPage
{
    public LogDetailSitePage(List<LogModelData> _log, String _selectedStartDate, String _selectedEndDate, String _type, String _deviceName, String _gatewayName)
    {
        InitializeComponent();
        deviceName.Text = _deviceName;
        gatewayName.Text = $"Gateway: {_gatewayName}";
        TypeName.Text = $"Type: {_type}";
        TimeSearch.Text = $"{_selectedStartDate} to {_selectedEndDate}";
        LogListView.ItemsSource = _log;

        Console.WriteLine($"device name ::::::{_deviceName}");
        Console.WriteLine($"_selectedStartDate ::::::{_selectedStartDate}");
        Console.WriteLine($"_selectedEndDate ::::::{_selectedEndDate}");
        Console.WriteLine($"_type ::::::{_type}");
        Console.WriteLine(_log.Count);
    }
}