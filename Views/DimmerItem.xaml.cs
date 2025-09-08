using Microsoft.Maui.Controls.Handlers;
using StreetLightApp.Models;

namespace StreetLightApp.Views;

public partial class DimmerItem : ContentView
{
    public event EventHandler<CheckedChangedEventArgs> CheckedChanged;
    private Dimmer _dev;

    public DimmerItem(Dimmer _dim)
    {
        InitializeComponent();
        _dev = _dim;
        LbDeviceName.Text = _dim.device_name;
        DeviceCheckBox.IsVisible = true;
        LbDeviceName.WidthRequest = 75;
        SetStatus(_dim.Status);
        SetDimmer(_dim.Dimvalue);
        SetPercentage(_dim.Percentage);
        SetBattVolt(_dim.BattVolt);
        SetCapacity(_dim.Capacity);
        _dev.StatusHandler += _dev_StatusHandler; ;
        _dev.DimChangeHandler += _dev_DimChangeHandler;
        _dev.PercentageHandler += _dev_PercentageHandler;
        _dev.BattVoltHandler += _dev_BattVoltHandler;
        _dev.CapacityHandler += _dev_CapacityHandler;
    }

    private void SetStatus(int _Status)
    {
        Dispatcher.Dispatch(() =>
        {
            Statustxt.Text = _Status == 1 ? "ON" : "OFF";
            Statustxt.TextColor = _Status == 1 ? Colors.Green : Colors.Red;
        });
    }


    private void SetDimmer(int _Dim)
    {
        Dispatcher.Dispatch(() =>
        {
            DimmerValueTxt.Text = $"{_Dim}%";
        });
    }

    private void SetPercentage(int _Percentage)
    {
        Dispatcher.Dispatch(() =>
        {
            PercentageTxt.Text = $"{_Percentage}%";
        });
    }

    private void SetBattVolt(double _BattVolt)
    {
        Dispatcher.Dispatch(() =>
        {
            BattVoltxt.Text = $"{(_BattVolt / 1000.0).ToString("N2")}V";
        });
    }
    private void SetCapacity(double _Capacity)
    {
        Dispatcher.Dispatch(() =>
        {
            CapacityTxt.Text = $"{(_Capacity / 1000.0).ToString("N2")}Ah";
        });
    }

    private void _dev_PercentageHandler(object? sender, int e)
    {
        SetPercentage(e);
    }

    private void _dev_CapacityHandler(object? sender, double e)
    {
        Console.WriteLine("Capacity Changed: " + e);
    }

    private void _dev_BattVoltHandler(object? sender, double e)
    {
        Console.WriteLine("BattVolt Changed: " + e);
    }


    private void _dev_StatusHandler(object? sender, int e)
    {
        SetStatus(e);
    }

    private void _dev_DimChangeHandler(object? sender, int e)
    {
        SetDimmer(e);
    }


    public void SetChecked(bool isChecked)
    {
        if (_dev.type != "gateway")
        {
            DeviceCheckBox.IsChecked = isChecked;
        }
    }




    private void CheckBoxSelect_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        CheckedChanged?.Invoke(_dev, e);
    }

}