using StreetLightApp.Models;

namespace StreetLightApp.Views;

public partial class DeviceItems : ContentView
{

    public event EventHandler<CheckedChangedEventArgs> CheckedChanged;
    private MyDevice _dev;

    public DeviceItems(MyDevice dev)
    {
        InitializeComponent();
        _dev = dev;

        if (dev.type == "gateway")
        {
            StatusSiteStackLayout.IsVisible = false;
            LbDeviceName.Text = dev.gateway_name;
            GatewayUnCheckBox.IsVisible = true;
            BtnShowDetail.IsVisible = true;
            ImgIconGateway.IsVisible = true;
            LbDeviceName.MaximumWidthRequest = 75;
        }
        else
        {
            LbDeviceName.Text = dev.device_name;
            DeviceCheckBox.IsVisible = true;
            LbDeviceName.WidthRequest = 75;
        }

    }

    private void CheckBoxSelect_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        // Raise the event so parent can handle it
        CheckedChanged?.Invoke(_dev, e);
    }

    public void SetChecked(bool isChecked)
    {
        if (_dev.type != "gateway")
        {
            DeviceCheckBox.IsChecked = isChecked;
        }
    }



    private void BtnShowDetail_Clicked(object sender, EventArgs e)
    {

    }
}