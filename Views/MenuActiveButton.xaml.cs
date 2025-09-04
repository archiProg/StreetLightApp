namespace StreetLightApp.Views;

public partial class MenuActiveButton : ContentView
{
    public event EventHandler Clicked;
    bool active = false;
    public bool Active
    {
        get
        {
            return active;
        }
        set
        {
            active = value;
            iconImage.Source = value ? ActiveIcon : Icon;
        }
    }
    string title = "Button";
    public string Title
    {
        get
        {
            return title;
        }
        set
        {
            title = value;
            titleLbl.Text = value;
        }
    }

    ImageSource icon = "home_64_noactive";
    public ImageSource Icon
    {
        get
        {
            return icon;
        }
        set
        {
            icon = value;
            iconImage.Source = value;
        }
    }
    ImageSource activeicon = "home_64";
    public ImageSource ActiveIcon
    {
        get
        {
            return activeicon;
        }
        set
        {
            activeicon = value;
            if (Active)
            {
                iconImage.Source = value;
            }
        }
    }

    public MenuActiveButton()
    {
        InitializeComponent();
    }

    private void Button_Clicked(object sender, EventArgs e)
    {
        Clicked?.Invoke(this, e);
    }
}