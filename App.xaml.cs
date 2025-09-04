using StreetLightApp.Pages;

namespace StreetLightApp
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();
        }

        protected override Window CreateWindow(IActivationState? activationState)
        {
            DeviceDisplay.KeepScreenOn = true;
            return new Window(new NavigationPage(new StartUpPage())
            {
                BarTextColor = Color.FromArgb("#182032")
            });
        }
    }
}