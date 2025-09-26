using Microsoft.Maui.Controls;
using Newtonsoft.Json;
using StreetLightApp.Models;
using StreetLightApp.Services;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace StreetLightApp.Pages;

public partial class ManageDevicePage : ContentPage
{
    private List<MyDevice> _SelectDevices;
    Site CurrentSite = null;

    String StatusConfig = "inactive";
    List<ScheduleDetail> OriginalConfigDevices = new()
{
    new ScheduleDetail { id = 1, day_of_week = "Sun", off_time = "", on_time = "" },
    new ScheduleDetail { id = 2, day_of_week = "Mon", off_time = "", on_time = "" },
    new ScheduleDetail { id = 3, day_of_week = "Tue", off_time = "", on_time = "" },
    new ScheduleDetail { id = 4, day_of_week = "Wed", off_time = "", on_time = "" },
    new ScheduleDetail { id = 5, day_of_week = "Thu", off_time = "", on_time = "" },
    new ScheduleDetail { id = 6, day_of_week = "Fri", off_time = "", on_time = "" },
    new ScheduleDetail { id = 7, day_of_week = "Sat", off_time = "", on_time = "" }
};

    List<ScheduleDetail> ConfigDevices = new()
{
    new ScheduleDetail { id = 1, day_of_week = "Sun", off_time = "", on_time = "" },
    new ScheduleDetail { id = 2, day_of_week = "Mon", off_time = "", on_time = "" },
    new ScheduleDetail { id = 3, day_of_week = "Tue", off_time = "", on_time = "" },
    new ScheduleDetail { id = 4, day_of_week = "Wed", off_time = "", on_time = "" },
    new ScheduleDetail { id = 5, day_of_week = "Thu", off_time = "", on_time = "" },
    new ScheduleDetail { id = 6, day_of_week = "Fri", off_time = "", on_time = "" },
    new ScheduleDetail { id = 7, day_of_week = "Sat", off_time = "", on_time = "" }
};


    int IndexDaySelect = 0;
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
            foreach (var config in ConfigDevices)
            {

                config.off_time = new TimeSpan(0, 0, 0).ToString(@"hh\:mm");
                config.on_time = new TimeSpan(0, 0, 0).ToString(@"hh\:mm");

            }
        }
        else
        {
            DetailOneDevice.IsVisible = true;

            if (_SelectDevices[0] is Dimmer dimmer)
            {
                var _ConfigDevices = JsonConvert.DeserializeObject<List<ScheduleDetail>>(dimmer.config[0].detail);
                StatusConfig = dimmer.config[0].status;
                SetStatusConfig(StatusConfig);
                int count = 0;
                foreach (var config in _ConfigDevices)
                {
                    if (OriginalConfigDevices[count].id == config.id)
                    {
                        OriginalConfigDevices[count].on_time = string.IsNullOrWhiteSpace(config.on_time)
                            ? new TimeSpan(0, 0, 0).ToString(@"hh\:mm")
                            : config.on_time;
                        OriginalConfigDevices[count].off_time = string.IsNullOrWhiteSpace(config.off_time)
                            ? new TimeSpan(0, 0, 0).ToString(@"hh\:mm")
                            : config.off_time;
                        ConfigDevices[count].on_time = string.IsNullOrWhiteSpace(config.on_time)
                            ? new TimeSpan(0, 0, 0).ToString(@"hh\:mm")
                            : config.on_time;
                        ConfigDevices[count].off_time = string.IsNullOrWhiteSpace(config.off_time)
                            ? new TimeSpan(0, 0, 0).ToString(@"hh\:mm")
                            : config.off_time;
                        if (count == 0)
                        {
                            if (TimeSpan.TryParse(OriginalConfigDevices[3].on_time, out var onTime))
                            {
                                TimePickerOn.Time = onTime;
                            }
                            if (TimeSpan.TryParse(OriginalConfigDevices[3].off_time, out var offTime))
                            {
                                TimePickerOff.Time = offTime;
                            }
                        }
                    }

                    count++;
                    Console.WriteLine($"config:::::::{config.id} | {config.day_of_week} | {config.off_time} | {config.on_time}");
                }

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
            statusSwitch.Toggled -= statusSwitch_Toggled;

            statusSwitch.IsToggled = status == 1;
            LbPowerSatatusValue.Text = status == 1 ? "ON" : "OFF";
            LbPowerSatatusValue.TextColor = status == 1 ? Color.FromArgb("#52C68C") : Color.FromArgb("#EF8484");
            statusLbl.Text = status == 1 ? "ON" : "OFF";
            statusLbl.TextColor = status == 1 ? Color.FromArgb("#52C68C") : Color.FromArgb("#EF8484");

            statusSwitch.Toggled += statusSwitch_Toggled;
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
            await IndicatorSenddata(true);
            foreach (var device in _SelectDevices)
            {
                if (device.type != "gateway")
                {
                    var focusDevice = device as Dimmer;
                    if (focusDevice != null)
                    {
                        if (e.Value)
                        {

                            if (focusDevice.Dimvalue == 0)
                            {
                                await Provider.SendWsAsync(
                                    "3",
                                    new
                                    {
                                        Member = focusDevice.gateway_id,
                                        Device = focusDevice.device_id,
                                        Ctrl = 1,
                                        V = 100
                                    }
                                );
                            }
                            else
                            {

                                await Provider.SendWsAsync(
                                    "3",
                                    new
                                    {
                                        Member = focusDevice.gateway_id,
                                        Device = focusDevice.device_id,
                                        Ctrl = 1,
                                        V = focusDevice.Dimvalue
                                    }
                                );
                            }
                        }
                        await Provider.SendWsAsync(
                            "3",
                            new
                            {
                                Member = focusDevice.gateway_id,
                                Device = focusDevice.device_id,
                                Ctrl = 2,
                                V = e.Value ? 1 : 0
                            }
                        );

                    }
                }
            }
            await IndicatorSenddata(false);
        });
    }

    async Task IndicatorSenddata(bool running)
    {
        Dispatcher.Dispatch(() =>
        {
            indicatorSenddata.IsVisible = running;
            mySlider.IsEnabled = !running;
            statusSwitch.IsEnabled = !running;
        });

        await Task.Delay(100);
    }


    private void mySlider_DragCompleted(object sender, EventArgs e)
    {


        if (sender is Slider slider)
        {
            Dispatcher.Dispatch(async () =>
            {
                await IndicatorSenddata(true);
                if ((int)slider.Value == 0)
                {
                    statusSwitch.Toggled -= statusSwitch_Toggled;
                    statusSwitch.IsToggled = false;
                    statusSwitch.Toggled += statusSwitch_Toggled;
                }
                else
                {
                    statusSwitch.Toggled -= statusSwitch_Toggled;
                    statusSwitch.IsToggled = true;
                    statusSwitch.Toggled += statusSwitch_Toggled;
                }
                LbPowerSatatusValue.Text = statusSwitch.IsToggled ? "ON" : "OFF";
                LbPowerSatatusValue.TextColor = statusSwitch.IsToggled ? Color.FromArgb("#52C68C") : Color.FromArgb("#EF8484");
                statusLbl.Text = statusSwitch.IsToggled ? "ON" : "OFF";
                statusLbl.TextColor = statusSwitch.IsToggled ? Color.FromArgb("#52C68C") : Color.FromArgb("#EF8484");
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
                await IndicatorSenddata(false);
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
        //LbNameEnableSw.Text = "Sunday Enable";
        IndexDaySelect = 0;
        if (TimeSpan.TryParse(OriginalConfigDevices[0].off_time, out var offTime))
        {
            TimePickerOff.Time = offTime;
        }
        else
        {
            TimePickerOff.Time = new TimeSpan(0, 0, 0);
        }
        if (TimeSpan.TryParse(OriginalConfigDevices[0].on_time, out var onTime))
        {
            TimePickerOn.Time = onTime;
        }
        else
        {
            TimePickerOn.Time = new TimeSpan(0, 0, 0);
        }
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
        //LbNameEnableSw.Text = "Monday Enable";
        IndexDaySelect = 1;
        if (TimeSpan.TryParse(OriginalConfigDevices[1].off_time, out var offTime))
        {
            TimePickerOff.Time = offTime;
        }
        else
        {
            TimePickerOff.Time = new TimeSpan(0, 0, 0);
        }
        if (TimeSpan.TryParse(OriginalConfigDevices[1].on_time, out var onTime))
        {
            TimePickerOn.Time = onTime;
        }
        else
        {
            TimePickerOn.Time = new TimeSpan(0, 0, 0);
        }
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
        //LbNameEnableSw.Text = "Tueday Enable";
        IndexDaySelect = 2;
        if (TimeSpan.TryParse(OriginalConfigDevices[2].off_time, out var offTime))
        {
            TimePickerOff.Time = offTime;
        }
        else
        {
            TimePickerOff.Time = new TimeSpan(0, 0, 0);
        }
        if (TimeSpan.TryParse(OriginalConfigDevices[2].on_time, out var onTime))
        {
            TimePickerOn.Time = onTime;
        }
        else
        {
            TimePickerOn.Time = new TimeSpan(0, 0, 0);
        }
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
        //LbNameEnableSw.Text = "Wedesday Enable";
        IndexDaySelect = 3;
        if (TimeSpan.TryParse(OriginalConfigDevices[3].off_time, out var offTime))
        {
            TimePickerOff.Time = offTime;
        }
        else
        {
            TimePickerOff.Time = new TimeSpan(0, 0, 0);
        }
        if (TimeSpan.TryParse(OriginalConfigDevices[3].on_time, out var onTime))
        {
            TimePickerOn.Time = onTime;
        }
        else
        {
            TimePickerOn.Time = new TimeSpan(0, 0, 0);
        }
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
        //LbNameEnableSw.Text = "Thurday Enable";
        IndexDaySelect = 4;
        if (TimeSpan.TryParse(OriginalConfigDevices[4].off_time, out var offTime))
        {
            TimePickerOff.Time = offTime;
        }
        else
        {
            TimePickerOff.Time = new TimeSpan(0, 0, 0);
        }
        if (TimeSpan.TryParse(OriginalConfigDevices[4].on_time, out var onTime))
        {
            TimePickerOn.Time = onTime;
        }
        else
        {
            TimePickerOn.Time = new TimeSpan(0, 0, 0);
        }
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
        //LbNameEnableSw.Text = "Friday Enable";
        IndexDaySelect = 5;
        if (TimeSpan.TryParse(OriginalConfigDevices[5].off_time, out var offTime))
        {
            TimePickerOff.Time = offTime;
        }
        else
        {
            TimePickerOff.Time = new TimeSpan(0, 0, 0);
        }
        if (TimeSpan.TryParse(OriginalConfigDevices[5].on_time, out var onTime))
        {
            TimePickerOn.Time = onTime;
        }
        else
        {
            TimePickerOn.Time = new TimeSpan(0, 0, 0);
        }
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
        //LbNameEnableSw.Text = "Saturday Enable";
        IndexDaySelect = 6;
        if (TimeSpan.TryParse(OriginalConfigDevices[6].off_time, out var offTime))
        {
            TimePickerOff.Time = offTime;
        }
        else
        {
            TimePickerOff.Time = new TimeSpan(0, 0, 0);
        }
        if (TimeSpan.TryParse(OriginalConfigDevices[6].on_time, out var onTime))
        {
            TimePickerOn.Time = onTime;
        }
        else
        {
            TimePickerOn.Time = new TimeSpan(0, 0, 0);
        }
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
    private async void ButtonIfonmation_Clicked(object sender, EventArgs e)
    {
        string ListSelected = "";
        int count = 0;
        foreach (var device in _SelectDevices)
        {
            Console.WriteLine(device.device_name);
            ListSelected += device.device_name;
            if (count != _SelectDevices.Count - 1)
                ListSelected += ", ";
            count++;
        }
        DisplayAlert("Selected Devices", ListSelected, "Close");
    }

    private void SetStatusConfig(string status)
    {
        Dispatcher.Dispatch(() =>
        {
            statusSwitch.Toggled -= SwStatusCongig_Toggled;

            if (status == "active")
            {
                SwStatusCongig.IsToggled = true;
            }
            else
            {
                SwStatusCongig.IsToggled = false;
            }

            statusSwitch.Toggled += SwStatusCongig_Toggled;
        });
    }

    private bool CheckCompareConfigs()
    {
        for (int i = 0; i < OriginalConfigDevices.Count; i++)
        {
            if (SwStatusCongig.IsToggled != (StatusConfig == "active"))
            {
                return true;
            }
            if (OriginalConfigDevices[i].on_time != ConfigDevices[i].on_time || OriginalConfigDevices[i].off_time != ConfigDevices[i].off_time)
            {
                return true;

            }
        }
        return false;

    }


    private void SwStatusCongig_Toggled(object sender, ToggledEventArgs e)
    {
        var compair = CheckCompareConfigs();
        if (compair)
        {
            BtnSaveConfig.IsEnabled = true;
            BtnSaveConfig.BackgroundColor = Color.FromArgb("#316BF7");
            BtnSaveConfig.Opacity = 1;
        }
        else
        {
            BtnSaveConfig.IsEnabled = false;
            BtnSaveConfig.BackgroundColor = Colors.DarkGray;
            BtnSaveConfig.TextColor = Colors.White;
            BtnSaveConfig.Opacity = 0.5;
        }
    }

    private void TimePickerOff_TimeSelected(object sender, TimeChangedEventArgs e)
    {
        TimeSpan newTime = e.NewTime;

        string newTimeString = newTime.ToString(@"hh\:mm");

        ConfigDevices[IndexDaySelect].off_time = newTimeString;

        var compair = CheckCompareConfigs();
        if (compair)
        {
            BtnSaveConfig.IsEnabled = true;
            BtnSaveConfig.BackgroundColor = Color.FromArgb("#316BF7");
            BtnSaveConfig.Opacity = 1;
        }
        else
        {
            BtnSaveConfig.IsEnabled = false;
            BtnSaveConfig.BackgroundColor = Colors.DarkGray;
            BtnSaveConfig.TextColor = Colors.White;
            BtnSaveConfig.Opacity = 0.5;
        }
    }

    private void TimePickerOn_TimeSelected(object sender, TimeChangedEventArgs e)
    {
        TimeSpan newTime = e.NewTime;

        string newTimeString = newTime.ToString(@"hh\:mm");

        ConfigDevices[IndexDaySelect].on_time = newTimeString;

        var compair = CheckCompareConfigs();
        if (compair)
        {
            BtnSaveConfig.IsEnabled = true;
            BtnSaveConfig.BackgroundColor = Color.FromArgb("#316BF7");
            BtnSaveConfig.Opacity = 1;
        }
        else
        {
            BtnSaveConfig.IsEnabled = false;
            BtnSaveConfig.BackgroundColor = Colors.DarkGray;
            BtnSaveConfig.TextColor = Colors.White;
            BtnSaveConfig.Opacity = 0.5;
        }
    }

    private async Task PostScheduleAsync()
    {
        try
        {
            List<ScheduleConfig> _dataConfig = new();

            foreach (var device in _SelectDevices)
            {
                var scheduleConfig = new ScheduleConfig
                {
                    gateway_id = device.gateway_id,
                    device_id = (int)device.device_id,
                    type = "schedule",
                    detail = ConfigDevices
                };
                _dataConfig.Add(scheduleConfig);
            }


            var request = new ScheduleRequest
            {
                dataConfig = _dataConfig
            };

            string json = JsonConvert.SerializeObject(request);

            Console.WriteLine($"DEBUG JSON:\n{json}");

            string endpoint = $"api/save-schedule/{CurrentSite.site_id}";

            var response = await RequestApi.PostAsyncApiJWT2(endpoint, json);

            if (response != null && response.HttpStatusCode == System.Net.HttpStatusCode.OK)
            {
                OriginalConfigDevices = ConfigDevices;
                if (_SelectDevices != null && Provider.MapSites != null && CurrentSite != null)
                {
                    foreach (var device in _SelectDevices)
                    {
                        if (!Provider.MapSites.ContainsKey(CurrentSite.site_id))
                            continue;

                        var siteDevices = Provider.MapSites[CurrentSite.site_id];
                        var deviceConfig = siteDevices.FirstOrDefault(x => x.device_id == device.device_id && x.gateway_id == device.gateway_id && device.type != "gateway");

                        if (deviceConfig != null && deviceConfig.config != null && deviceConfig.config.Count > 0)
                        {
                            deviceConfig.config[0].detail = JsonConvert.SerializeObject(ConfigDevices)?.ToString();
                        }
                        else {
                            Console.WriteLine("lastConfig != null && lastConfig.config != null && lastConfig.config.Count > 0");
                            Console.WriteLine($"lastConfig.config.Count{deviceConfig.config.Count}");
                            Console.WriteLine($"lastConfig.config != null {deviceConfig.config != null}");
                            Console.WriteLine($"lastConfig != null {deviceConfig != null}");
                        }
                    }
                }
                await DisplayAlert("Success", "Schedule posted successfully!", "OK");
            }
            else
            {
                await DisplayAlert("Error", response?.Message ?? "Unknown error", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Exception", ex.Message, "OK");
        }
    }

    private async void BtnSaveConfig_Clicked(object sender, EventArgs e)
    {
        await IndicatorSenddata(true);
        await PostScheduleAsync();

        OriginalConfigDevices = ConfigDevices
           .Select(d => new ScheduleDetail { id = d.id, day_of_week = d.day_of_week, off_time = d.off_time, on_time = d.on_time })
           .ToList();

        BtnSaveConfig.IsEnabled = false;
        BtnSaveConfig.BackgroundColor = Colors.DarkGray;
        BtnSaveConfig.Opacity = 0.5;

        await IndicatorSenddata(false);
    }
}