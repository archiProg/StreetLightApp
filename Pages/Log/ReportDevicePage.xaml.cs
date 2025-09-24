using LiveChartsCore;
using LiveChartsCore.SkiaSharpView;
using LiveChartsCore.SkiaSharpView.Painting;
using SkiaSharp;
using StreetLightApp.Models;
using System.ComponentModel;
namespace StreetLightApp.Pages.Log;

public partial class ReportDevicePage : ContentPage, INotifyPropertyChanged
{
    public event PropertyChangedEventHandler PropertyChanged;

    private ISeries[] _series;
    public ISeries[] Series
    {
        get => _series;
        set
        {
            _series = value;
            OnPropertyChanged(nameof(Series));
        }
    }

    private Axis[] _xAxes;
    public Axis[] XAxes
    {
        get => _xAxes;
        set
        {
            _xAxes = value;
            OnPropertyChanged(nameof(XAxes));
        }
    }

    private Axis[] _yAxes;
    public Axis[] YAxes
    {
        get => _yAxes;
        set
        {
            _yAxes = value;
            OnPropertyChanged(nameof(YAxes));
        }
    }

    protected void OnPropertyChanged(string propertyName) =>
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));

    List<ReportDeviceModel> ReportDevices = new();

    public ReportDevicePage(List<ReportDeviceModel> _reportDevices, string deviceName, string gatewayName)
    {
        InitializeComponent();
        ReportDevices = _reportDevices;
        CheckBoxPowerInput.IsChecked = true;
    }

    private void CheckBoxPowerInput_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        if (e.Value)
        {
            CheckBoxPowerOutput.IsChecked = false;
            CheckBoxBattery.IsChecked = false;
            int pointWidth = 10;

            foreach (var device in ReportDevices)
            {
                if (device.avgInput == null)
                    device.avgInput = 0;
            }

            Chart.WidthRequest = Math.Max(
               DeviceDisplay.MainDisplayInfo.Width / DeviceDisplay.MainDisplayInfo.Density,
               ReportDevices.Count * pointWidth
           );



            var watt = ReportDevices.Select(d => (double)d.avgInput).ToArray();
            var labels = ReportDevices.Select(d => d.period).ToArray();


            Series = new ISeries[]
            {
            new LineSeries<double>
            {
                Values = watt,
                Fill = null,
                GeometrySize = 6,
                Stroke = new SolidColorPaint(SKColors.Blue) { StrokeThickness = 2 }
            }
            };

            XAxes = new[]
            {
            new Axis
            {
                Labels = labels,
                LabelsRotation = 45,
                Name = "Time",
                TextSize = 12,
                 MinStep = 1,
                UnitWidth = 1,
                LabelsPaint = new SolidColorPaint(SKColors.Black),
                SeparatorsPaint = new SolidColorPaint(SKColors.LightGray) { StrokeThickness = 1 }
            }
        };

            YAxes = new[]
            {
            new Axis
            {
                Name = "Input (W)",
                TextSize = 12,
                LabelsPaint = new SolidColorPaint(SKColors.Black),
                SeparatorsPaint = new SolidColorPaint(SKColors.LightGray) { StrokeThickness = 1 }
            }
        };

            BindingContext = this;
        }
    }

    private void CheckBoxPowerOutput_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        if (e.Value)
        {
            CheckBoxPowerInput.IsChecked = false;
            CheckBoxBattery.IsChecked = false;
            int pointWidth = 10;

            // Ensure battery objects exist
            foreach (var device in ReportDevices)
            {
                if (device.avgOutput == null)
                    device.avgOutput = 0;
            }

            Chart.WidthRequest = Math.Max(
               DeviceDisplay.MainDisplayInfo.Width / DeviceDisplay.MainDisplayInfo.Density,
               ReportDevices.Count * pointWidth
           );



            var watt = ReportDevices.Select(d => (double)d.avgOutput).ToArray();
            var labels = ReportDevices.Select(d => d.period).ToArray();

            Series = new ISeries[]
            {
            new LineSeries<double>
            {
                Values = watt,
                Fill = null,
                GeometrySize = 6,
                Stroke = new SolidColorPaint(SKColors.Red) { StrokeThickness = 2 }
            }
            };

            XAxes = new[]
            {
            new Axis
            {
                Labels = labels,
                LabelsRotation = 45,
                Name = "Time",
                TextSize = 12,
                 MinStep = 1,
                UnitWidth = 1,
                LabelsPaint = new SolidColorPaint(SKColors.Black),
                SeparatorsPaint = new SolidColorPaint(SKColors.LightGray) { StrokeThickness = 1 }
            }
        };

            YAxes = new[]
            {
            new Axis
            {
                Name = "Output (W)",
                TextSize = 12,
                LabelsPaint = new SolidColorPaint(SKColors.Black),
                SeparatorsPaint = new SolidColorPaint(SKColors.LightGray) { StrokeThickness = 1 }
            }
        };

            BindingContext = this;
        }

    }

    private void CheckBoxBattery_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        if (!e.Value) return;

        // Uncheck others
        CheckBoxPowerInput.IsChecked = false;
        CheckBoxPowerOutput.IsChecked = false;

        // Ensure battery objects exist
        foreach (var device in ReportDevices)
        {
            if (device.avgBattery == null)
                device.avgBattery = 0;
        }


        int pointWidth = 10;
        Chart.WidthRequest = Math.Max(
            DeviceDisplay.MainDisplayInfo.Width / DeviceDisplay.MainDisplayInfo.Density,
            ReportDevices.Count * pointWidth
        );

        var batteryLevels = ReportDevices.Select(d => (double)d.avgBattery).ToArray();
        var labels = ReportDevices.Select(d => d.period).ToArray();

        Series = new ISeries[]
        {
            new LineSeries<double>
            {
                Values = batteryLevels,
                Fill = null,
                GeometrySize = 6,
                Stroke = new SolidColorPaint(SKColors.Green) { StrokeThickness = 2 }
            }
        };

        XAxes = new[]
        {
            new Axis
            {
                Labels = labels,
                LabelsRotation = 45,
                Name = "Time",
                TextSize = 12,
                MinStep = 1,
                UnitWidth = 1,
                LabelsPaint = new SolidColorPaint(SKColors.Black),
                SeparatorsPaint = new SolidColorPaint(SKColors.LightGray) { StrokeThickness = 1 }
            }
        };

        YAxes = new[]
        {
            new Axis
            {
                Name = "Battery (%)",
                TextSize = 12,
                LabelsPaint = new SolidColorPaint(SKColors.Black),
                SeparatorsPaint = new SolidColorPaint(SKColors.LightGray) { StrokeThickness = 1 }
            }
        };


    }
}