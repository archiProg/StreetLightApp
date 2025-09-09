using Microsoft.Maui.Controls;
using StreetLightApp.Models;
using StreetLightApp.Services;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace StreetLightApp.Pages;

public partial class ManageDevicePage : ContentPage
{
    private List<MyDevice> _SelectDevices;
    Site CurrentSite = null;



    public ManageDevicePage(Site _site, List<MyDevice> selectDevices)
    {
        InitializeComponent();
        Title = _site.site_name;
        CurrentSite = _site;
        _SelectDevices = selectDevices;
        BindingContext = this;

        if (_SelectDevices.Count > 1)
        {
            DetailMultiDevice.IsVisible = true;
            lbSlider.Text = $"50%";
            mySlider.Value = 50;
            statusSwitch.IsToggled = false;
        }
        else
        {
            DetailOneDevice.IsVisible = true;
            if (_SelectDevices[0] is Dimmer dimmer)
            {
                lbSlider.Text = $"{(int)dimmer.Dimvalue}%";
                mySlider.Value = (int)dimmer.Dimvalue;
                statusSwitch.IsToggled = (int)dimmer.Status == 1;
                SetStatus(dimmer.Status);
                SetDimmer(dimmer.Dimvalue);
                SetTemp(dimmer.Temp);
                SetBatteryLevel(dimmer.Percentage);
                SetBatteryIn(dimmer.PowerCurrent);
                SetBatteryOut(dimmer.PowerOutCurrent);
                SetBattVoltOut(dimmer.BattVolt);
                SetBattCapacity(dimmer.Capacity);
                SetBattHealt(dimmer.BattHealth);
                SetCycleCount(dimmer.CycleCount);
                SetCharge(dimmer.Charge);
                dimmer.StatusHandler += Dimmer_StatusHandler;
                dimmer.DimChangeHandler += Dimmer_DimChangeHandler;
                dimmer.TempHandler += Dimmer_TempHandler;
                dimmer.PercentageHandler += Dimmer_PercentageHandler;
                dimmer.PowerCurrentHandler += Dimmer_PowerCurrentHandler;
                dimmer.PowerOutCurrentHandler += Dimmer_PowerOutCurrentHandler;
                dimmer.BattVoltHandler += Dimmer_BattVoltHandler;
                dimmer.CapacityHandler += Dimmer_CapacityHandler;
                dimmer.BattHealthHandler += Dimmer_BattHealthHandler;
                dimmer.CycleCountHandler += Dimmer_CycleCountHandler;
                dimmer.ChargeHandler += Dimmer_ChargeHandler;

            }
        }

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

    private void SetCharge(int charge)
    {
        Dispatcher.Dispatch(() =>
        {
            ShowStatusChargring.IsVisible = charge == 1;
        });
    }

    private void SetStatus(int status)
    {
        Dispatcher.Dispatch(() =>
        {
            statusSwitch.IsToggled = status == 1;
            LbPowerSatatusValue.Text = status == 1 ? "ON" : "OFF";
            LbPowerSatatusValue.TextColor = status == 1 ? Color.FromArgb("#52C68C") : Color.FromArgb("#EF8484");
        });
    }
    private void SetDimmer(int dimvalue)
    {
        Dispatcher.Dispatch(() =>
        {
            lbSlider.Text = $"{dimvalue}%";
            LbBrightnessValue.Text = $"{dimvalue}%";
            mySlider.Value = dimvalue;
        });
    }

    private void SetTemp(double temp)
    {
        Dispatcher.Dispatch(() =>
        {
            LbTemperatureValue.Text = $"{temp}°C";
        });
    }

    private void SetBatteryLevel(int percentage)
    {
        Dispatcher.Dispatch(() =>
        {
            LbBatteryLevelValue.Text = $"{percentage}%";
        });
    }


    private void SetBatteryIn(double powerCurrent)
    {
        Dispatcher.Dispatch(() =>
        {
            LbBatteryInValue.Text = $"{(powerCurrent / 1000).ToString("N2")} mA";
        });
    }

    private void SetBatteryOut(double powerOutCurrent)
    {
        Dispatcher.Dispatch(() =>
        {
            LbBatteryCurrentOutValue.Text = $"{(powerOutCurrent / 1000).ToString("N2")} mA";
        });
    }

    private void SetBattVoltOut(double battVolt)
    {
        Dispatcher.Dispatch(() =>
        {
            LbBatteryVoltOutValue.Text = $"{(battVolt / 1000).ToString("N2")} mA";
        });
    }

    private void SetBattCapacity(double capacity)
    {
        Dispatcher.Dispatch(() =>
        {
            LbCapacityValue.Text = $"{(capacity / 1000).ToString("N2")} Ah";
        });
    }

    private void SetBattHealt(int battHealth)
    {
        Dispatcher.Dispatch(() =>
        {
            LbBatteryHealthValue.Text = $"{battHealth}%";
        });
    }

    private void SetCycleCount(int cycleCount)
    {
        Dispatcher.Dispatch(() =>
        {
            LbCycleValue.Text = $"{cycleCount}";
        });
    }


    private void Dimmer_StatusHandler(object? sender, int e)
    {
        SetStatus(e);
    }

    private void Dimmer_DimChangeHandler(object? sender, int e)
    {
        SetDimmer(e);
    }

    private void Dimmer_TempHandler(object? sender, double e)
    {
        SetTemp(e);
    }


    private void Dimmer_PercentageHandler(object? sender, int e)
    {
        SetBatteryLevel(e);
    }

    private void Dimmer_PowerCurrentHandler(object? sender, double e)
    {
        SetBatteryIn(e);
    }

    private void Dimmer_PowerOutCurrentHandler(object? sender, double e)
    {
        SetBatteryOut(e);
    }
    private void Dimmer_BattVoltHandler(object? sender, double e)
    {
        SetBattVoltOut(e);
    }

    private void Dimmer_CapacityHandler(object? sender, double e)
    {
        SetBattCapacity(e);
    }

    private void Dimmer_BattHealthHandler(object? sender, int e)
    {
        SetBattHealt(e);
    }


    private void Dimmer_CycleCountHandler(object? sender, int e)
    {
        SetCycleCount(e);
    }

    private void Dimmer_ChargeHandler(object? sender, int e)
    {
        SetCharge(e);
    }



    private void statusSwitch_Toggled(object sender, ToggledEventArgs e)
    {
        statusLbl.Text = $"{(e.Value ? "ON" : "OFF")}";
        statusLbl.TextColor = Color.FromArgb($"#{(e.Value ? "52C68C" : "EF8484")}");
        Dispatcher.Dispatch(async () =>
        {
            foreach (var device in _SelectDevices)
            {
                await Provider.SendWsAsync(
                    "3",
                    new
                    {
                        Member = device.gateway_id,
                        Device = device.device_id,
                        Ctrl = 2,
                        V = e.Value ? 1 : 0
                    }
                );
            }
        });
    }

    private void mySlider_DragCompleted(object sender, EventArgs e)
    {
        if (sender is Slider slider)
        {
            Dispatcher.Dispatch(async () =>
            {
                foreach (var device in _SelectDevices)
                {
                    await Provider.SendWsAsync(
                        "3",
                        new
                        {
                            Member = device.gateway_id,
                            Device = device.device_id,
                            Ctrl = 1,
                            V = (int)slider.Value
                        }
                    );
                }
            });
        }
    }

    private void mySlider_HandlerChanged(object sender, ValueChangedEventArgs e)
    {
        if (sender is Slider slider)
        {
            lbSlider.Text = $"{(int)slider.Value}%";
        }
    }

    private void BtnSun_Clicked(object sender, EventArgs e)
    {
        LbNameEnableSw.Text = "Sunday Enable";
        BtnSun.BackgroundColor = Color.FromArgb("#C5E8FF");
        BtnSun.TextColor = Color.FromArgb("#000000");
        BtnMon.BackgroundColor = Colors.Transparent;
        BtnMon.TextColor = Color.FromArgb("#8FA1AD");
        BtnTue.BackgroundColor = Colors.Transparent;
        BtnTue.TextColor = Color.FromArgb("#8FA1AD");
        BtnWed.BackgroundColor = Colors.Transparent;
        BtnWed.TextColor = Color.FromArgb("#8FA1AD");
        BtnThu.BackgroundColor = Colors.Transparent;
        BtnThu.TextColor = Color.FromArgb("#8FA1AD");
        BtnFri.BackgroundColor = Colors.Transparent;
        BtnFri.TextColor = Color.FromArgb("#8FA1AD");
        BtnSat.BackgroundColor = Colors.Transparent;
        BtnSat.TextColor = Color.FromArgb("#8FA1AD");
    }

    private void BtnMon_Clicked(object sender, EventArgs e)
    {
        LbNameEnableSw.Text = "Monday Enable";
        BtnSun.BackgroundColor = Colors.Transparent;
        BtnSun.TextColor = Color.FromArgb("#8FA1AD");
        BtnMon.BackgroundColor = Color.FromArgb("#C5E8FF");
        BtnMon.TextColor = Color.FromArgb("#000000");
        BtnTue.BackgroundColor = Colors.Transparent;
        BtnTue.TextColor = Color.FromArgb("#8FA1AD");
        BtnWed.BackgroundColor = Colors.Transparent;
        BtnWed.TextColor = Color.FromArgb("#8FA1AD");
        BtnThu.BackgroundColor = Colors.Transparent;
        BtnThu.TextColor = Color.FromArgb("#8FA1AD");
        BtnFri.BackgroundColor = Colors.Transparent;
        BtnFri.TextColor = Color.FromArgb("#8FA1AD");
        BtnSat.BackgroundColor = Colors.Transparent;
        BtnSat.TextColor = Color.FromArgb("#8FA1AD");
    }

    private void BtnTue_Clicked(object sender, EventArgs e)
    {
        LbNameEnableSw.Text = "Tueday Enable";
        BtnSun.BackgroundColor = Colors.Transparent;
        BtnSun.TextColor = Color.FromArgb("#8FA1AD");
        BtnMon.BackgroundColor = Colors.Transparent;
        BtnMon.TextColor = Color.FromArgb("#8FA1AD");
        BtnTue.BackgroundColor = Color.FromArgb("#C5E8FF");
        BtnTue.TextColor = Color.FromArgb("#000000");
        BtnWed.BackgroundColor = Colors.Transparent;
        BtnWed.TextColor = Color.FromArgb("#8FA1AD");
        BtnThu.BackgroundColor = Colors.Transparent;
        BtnThu.TextColor = Color.FromArgb("#8FA1AD");
        BtnFri.BackgroundColor = Colors.Transparent;
        BtnFri.TextColor = Color.FromArgb("#8FA1AD");
        BtnSat.BackgroundColor = Colors.Transparent;
        BtnSat.TextColor = Color.FromArgb("#8FA1AD");
    }

    private void BtnWed_Clicked(object sender, EventArgs e)
    {
        LbNameEnableSw.Text = "Wedesday Enable";
        BtnSun.BackgroundColor = Colors.Transparent;
        BtnSun.TextColor = Color.FromArgb("#8FA1AD");
        BtnMon.BackgroundColor = Colors.Transparent;
        BtnMon.TextColor = Color.FromArgb("#8FA1AD");
        BtnTue.BackgroundColor = Colors.Transparent;
        BtnTue.TextColor = Color.FromArgb("#8FA1AD");
        BtnWed.BackgroundColor = Color.FromArgb("#C5E8FF"); ;
        BtnWed.TextColor = Color.FromArgb("#000000");
        BtnThu.BackgroundColor = Colors.Transparent;
        BtnThu.TextColor = Color.FromArgb("#8FA1AD");
        BtnFri.BackgroundColor = Colors.Transparent;
        BtnFri.TextColor = Color.FromArgb("#8FA1AD");
        BtnSat.BackgroundColor = Colors.Transparent;
        BtnSat.TextColor = Color.FromArgb("#8FA1AD");
    }

    private void BtnThu_Clicked(object sender, EventArgs e)
    {
        LbNameEnableSw.Text = "Thurday Enable";
        BtnSun.BackgroundColor = Colors.Transparent;
        BtnSun.TextColor = Color.FromArgb("#8FA1AD");
        BtnMon.BackgroundColor = Colors.Transparent;
        BtnMon.TextColor = Color.FromArgb("#8FA1AD");
        BtnTue.BackgroundColor = Colors.Transparent;
        BtnTue.TextColor = Color.FromArgb("#8FA1AD");
        BtnWed.BackgroundColor = Colors.Transparent;
        BtnWed.TextColor = Color.FromArgb("#8FA1AD");
        BtnThu.BackgroundColor = Color.FromArgb("#C5E8FF");
        BtnThu.TextColor = Color.FromArgb("#000000");
        BtnFri.BackgroundColor = Colors.Transparent;
        BtnFri.TextColor = Color.FromArgb("#8FA1AD");
        BtnSat.BackgroundColor = Colors.Transparent;
        BtnSat.TextColor = Color.FromArgb("#8FA1AD");
    }

    private void BtnFri_Clicked(object sender, EventArgs e)
    {
        LbNameEnableSw.Text = "Friday Enable";
        BtnSun.BackgroundColor = Colors.Transparent;
        BtnSun.TextColor = Color.FromArgb("#8FA1AD");
        BtnMon.BackgroundColor = Colors.Transparent;
        BtnMon.TextColor = Color.FromArgb("#8FA1AD");
        BtnTue.BackgroundColor = Colors.Transparent;
        BtnTue.TextColor = Color.FromArgb("#8FA1AD");
        BtnWed.BackgroundColor = Colors.Transparent;
        BtnWed.TextColor = Color.FromArgb("#8FA1AD");
        BtnThu.BackgroundColor = Colors.Transparent;
        BtnThu.TextColor = Color.FromArgb("#8FA1AD");
        BtnFri.BackgroundColor = Color.FromArgb("#C5E8FF");
        BtnFri.TextColor = Color.FromArgb("#000000");
        BtnSat.BackgroundColor = Colors.Transparent;
        BtnSat.TextColor = Color.FromArgb("#8FA1AD");
    }

    private void BtnSat_Clicked(object sender, EventArgs e)
    {
        LbNameEnableSw.Text = "Saturday Enable";
        BtnSun.BackgroundColor = Colors.Transparent;
        BtnSun.TextColor = Color.FromArgb("#8FA1AD");
        BtnMon.BackgroundColor = Colors.Transparent;
        BtnMon.TextColor = Color.FromArgb("#8FA1AD");
        BtnTue.BackgroundColor = Colors.Transparent;
        BtnTue.TextColor = Color.FromArgb("#8FA1AD");
        BtnWed.BackgroundColor = Colors.Transparent;
        BtnWed.TextColor = Color.FromArgb("#8FA1AD");
        BtnThu.BackgroundColor = Colors.Transparent;
        BtnThu.TextColor = Color.FromArgb("#8FA1AD");
        BtnFri.BackgroundColor = Colors.Transparent;
        BtnFri.TextColor = Color.FromArgb("#8FA1AD");
        BtnSat.BackgroundColor = Color.FromArgb("#C5E8FF");
        BtnSat.TextColor = Color.FromArgb("#000000");
    }

 
}