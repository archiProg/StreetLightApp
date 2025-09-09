using Microsoft.Maui.Controls;
using StreetLightApp.Models;
using StreetLightApp.Services;
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
            lbSlider.Text = $"50%";
            mySlider.Value = 50;
            statusSwitch.IsToggled = false;
        }
        else {

            if (_SelectDevices[0] is Dimmer dimmer)
            {
                lbSlider.Text = $"{(int)dimmer.Dimvalue}%";
                mySlider.Value = (int)dimmer.Dimvalue;
                statusSwitch.IsToggled = (int)dimmer.Status == 1;
                dimmer.StatusHandler += Dimmer_StatusHandler;
                dimmer.DimChangeHandler += Dimmer_DimChangeHandler;
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

    private void Dimmer_StatusHandler(object? sender, int e)
    {
        Dispatcher.Dispatch(() => {
            statusSwitch.IsToggled = e == 1;
        });
    }

    private void Dimmer_DimChangeHandler(object? sender, int e)
    {
        Dispatcher.Dispatch(() => {
            if (_SelectDevices.Count == 1)
            {

                lbSlider.Text = $"{e}%";
                mySlider.Value = e;
            }
        });
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
            Dispatcher.Dispatch(async () => {
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
}