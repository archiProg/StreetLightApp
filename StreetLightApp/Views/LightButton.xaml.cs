 
namespace StreetLightApp.Views;

public partial class LightButton : ContentView
{
    public event EventHandler Clicked;
    bool _hasAppeared = false;

    bool status = false;
    public bool Status
    {
        get { return status; }
        set
        {
            status = value;
            SetStatus(value);
        }
    }
    int brightness = 0;
    public int Brightness
    {
        get { return brightness; }
        set
        {
            brightness = value;
            SetBrightness(value);
        }
    }
    int battery = 0;
    public int Battery
    {
        get { return battery; }
        set
        {
            battery = value;
            SetBattery(value);
        }
    }
    string title = "Light";
    public string Title
    {
        get { return title; }
        set
        {
            title = value;
            titleLbl.Text = value;
        }
    }
    public LightButton()
    {
        InitializeComponent();
        InitIcon();

    }

    private void InitIcon()
    {
 
    }

    public void SetBrightness(int _brightness)
    {
        brightLbl.Text = $"{_brightness}%";
    }
    public void SetBattery(int _batt)
    {
        battLbl.Text = $"{_batt}%";
    }
    public void SetStatus(bool _status)
    {
        if (_status)
        {
            statusLbl.Text = "ON";
            statusLbl.TextColor = Colors.Green;
        }
        else
        {
            statusLbl.Text = "OFF";
            statusLbl.TextColor = Colors.Red;
        }
    }

    private void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
        Clicked?.Invoke(this, e);
    }
}