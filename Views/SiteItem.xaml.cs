namespace StreetLightApp.Views;

public partial class SiteItem : ContentView
{
	public event EventHandler Clicked;
	ImageSource img = "home_64.png";
    public ImageSource Img
	{
		get
		{
			return img;
		}
		set
		{
			img = value;
			siteimg.Source = value;
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
    public SiteItem()
	{
		InitializeComponent();
	}

    private void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
		Clicked?.Invoke(this, EventArgs.Empty);
    }
}