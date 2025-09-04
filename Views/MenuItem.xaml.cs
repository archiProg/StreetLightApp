namespace StreetLightApp.Views;

public partial class MenuItem : ContentView
{
    public event EventHandler Clicked;
    BadgeType badgeType = BadgeType.None;
    public BadgeType BadgeType
    {
        get
        {
            return badgeType;
        }
        set
        {
            badgeType = value;
            SetBadgeType(value, badgeNumber);
        }
    }
    int badgeNumber = 0;
    public int BadgeNumber
    {
        get
        {
            return badgeNumber;
        }
        set
        {
            badgeNumber = value;
            SetBadgeType(BadgeType.Number, value);
        }
    }
    string title = "Title";
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

    string description = "Description";
    public string Description
    {
        get
        {
            return description;
        }
        set
        {
            description = value;
            descriptionLbl.Text = value;
        }
    }
    public MenuItem()
    {
        InitializeComponent();
    }

    void SetBadgeType(BadgeType _badgeType, int _count = 0)
    {
        switch (_badgeType)
        {
            case BadgeType.None:
                badgeNumberPanel.IsVisible = false;
                badgeDot.IsVisible = false;
                break;
            case BadgeType.Number:
                badgeNumberPanel.IsVisible = true;
                badgeLbl.Text = $"{(_count > 99 ? "99+" : _count.ToString())}";
                badgeDot.IsVisible = false;
                break;
            case BadgeType.Dot:
                badgeNumberPanel.IsVisible = false;
                badgeDot.IsVisible = true;
                break;
        }
    }

    private void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
        Clicked?.Invoke(this, EventArgs.Empty);
    }
}

public enum BadgeType
{
    None,
    Number,
    Dot
}