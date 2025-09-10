using StreetLightApp.Models;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class ReportPage : ContentPage
{
    private List<MapPin> _pins;
    public List<MapPin> Pins
    {
        get { return _pins; }
        set { _pins = value; OnPropertyChanged(); }
    }

    public ReportPage()
    {
        InitializeComponent();

        BindingContext = this;

        Pins = new List<MapPin>()
        {
            new MapPin(MapPinClicked)
            {
                Id = Guid.NewGuid().ToString(),
                Position = new Location(51.731551, -0.156230),
                IconSrc = "install_12"
            },
            new MapPin(MapPinClicked)
            {
                Id = Guid.NewGuid().ToString(),
                Position = new Location(51.762951, -0.182317),
                IconSrc = "install_12"
            },
            new MapPin(MapPinClicked)
            {
                Id = Guid.NewGuid().ToString(),
                Position = new Location(51.754034, -0.074997),
                IconSrc = "install_12"
            },
            new MapPin(MapPinClicked)
            {
                Id = Guid.NewGuid().ToString(),
                Position = new Location(51.704029, -0.135474),
                IconSrc = "install_12"
            }
        };
    }

    private void MapPinClicked(MapPin pin)
    {
        // Handle pin click
    }
}