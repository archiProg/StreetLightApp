using Microsoft.Maui.Maps;
using StreetLightApp.Models;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class TestMap : ContentPage
{
    private List<MapPin> _pins;
    public List<MapPin> Pins
    {
        get { return _pins; }
        set { _pins = value; OnPropertyChanged(); }
    }

    public TestMap()
    {
        InitializeComponent();

        BindingContext = this;

        Pins = new List<MapPin>()
        {
            new MapPin(MapPinClicked)
            {
                Id = Guid.NewGuid().ToString(),
                Position = new Location(13.776261550645419, 100.6079035250838),
                IconSrc = "install_12"
            },
            new MapPin(MapPinClicked)
            {
                Id = Guid.NewGuid().ToString(),
                Position = new Location(13.775030483741414, 100.6075162502401),
                IconSrc = "install_12"
            },
            new MapPin(MapPinClicked)
            {
                Id = Guid.NewGuid().ToString(),
                Position = new Location(13.775381139960322, 100.60764461616243),
                IconSrc = "install_12"
            },
            new MapPin(MapPinClicked)
            {
                Id = Guid.NewGuid().ToString(),
                Position = new Location(13.775747690048803, 100.60774375041056),
                IconSrc = "install_12"
            }
        };
        MyMap2.MoveToRegion(MapSpan.FromCenterAndRadius(
               new Location(13.776261550645419, 100.6079035250838),
               Distance.FromMeters(50)
           ));
    }

    private void MapPinClicked(MapPin pin)
    {
        // Handle pin click
    }
}
