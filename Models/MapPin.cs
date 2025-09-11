using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace StreetLightApp.Models
{
    public class MapPin : INotifyPropertyChanged
    {
        public string Id { get; set; }
        public Location Position { get; set; }
        public string Label { get; set; }
        public string Address { get; set; }

        // Current device state
        private string iconSrc;
        public string IconSrc
        {
            get => iconSrc;
            set
            {
                if (iconSrc != value)
                {
                    iconSrc = value;
                    OnPropertyChanged();
                }
            }
        }

        public string DeviceType { get; set; }
        public int Online { get; set; }
        public int Status { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged([CallerMemberName] string name = null) =>
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));

        public ICommand ClickedCommand { get; set; }

        public MapPin(Action<MapPin> clicked)
        {
            ClickedCommand = new Command(() => clicked(this));
        }
    }
}
