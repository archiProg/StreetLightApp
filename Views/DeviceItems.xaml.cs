using StreetLightApp.Models;

namespace StreetLightApp.Views;

public partial class DeviceItems : ContentView
{

    public event EventHandler<CheckedChangedEventArgs> CheckedChanged;

    public DeviceItems(DeviceNode dev)
	{
		InitializeComponent();
		
		LbDeviceName.Text = dev.device_name;

    }

    private void CheckBoxSelect_CheckedChanged(object sender, CheckedChangedEventArgs e)
    {
        // Raise the event so parent can handle it
        CheckedChanged?.Invoke(this, e);
    }
}