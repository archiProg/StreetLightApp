using StreetLightApp.Models;
using System.Collections.ObjectModel;

namespace StreetLightApp.Controls
{
    public class MapEx : Microsoft.Maui.Controls.Maps.Map
    {
        public ObservableCollection<MapPin> CustomPins
        {
            get { return (ObservableCollection<MapPin>)GetValue(CustomPinsProperty); }
            set { SetValue(CustomPinsProperty, value); }
        }

        public static readonly BindableProperty CustomPinsProperty = BindableProperty.Create(
            nameof(CustomPins),
            typeof(ObservableCollection<MapPin>),
            typeof(MapEx),
            new ObservableCollection<MapPin>()); // default value
    }
}
