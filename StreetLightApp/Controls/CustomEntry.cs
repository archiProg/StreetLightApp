#if ANDROID
using StreetLightApp.Platforms.Android.Handlers;

#endif


using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Controls
{
    public class CustomEntry : Entry
    {
        public static readonly BindableProperty BorderWidthProperty =
        BindableProperty.Create(nameof(BorderWidth), typeof(int), typeof(CustomEntry), 0);

        public int BorderWidth
        {
            get => (int)GetValue(BorderWidthProperty);
            set => SetValue(BorderWidthProperty, value);
        }
        public static readonly BindableProperty CornerRadiusProperty =
        BindableProperty.Create(nameof(CornerRadius), typeof(int), typeof(CustomEntry), 0);

        public int CornerRadius
        {
            get => (int)GetValue(CornerRadiusProperty);
            set => SetValue(CornerRadiusProperty, value);
        }

        public static readonly BindableProperty BorderColorProperty =
            BindableProperty.Create(nameof(BorderColor), typeof(Color), typeof(CustomEntry), Colors.Transparent);

        public Color BorderColor
        {
            get => (Color)GetValue(BorderColorProperty);
            set => SetValue(BorderColorProperty, value);
        }

        public static readonly BindableProperty BackgroundColorsProperty =
            BindableProperty.Create(nameof(BackgroundColors), typeof(Color), typeof(CustomEntry), Colors.Transparent);

        public Color BackgroundColors
        {
            get => (Color)GetValue(BackgroundColorsProperty);
            set => SetValue(BackgroundColorsProperty, value);
        }

        public static readonly BindableProperty PlaceholderFontFamilyProperty =
        BindableProperty.Create(nameof(PlaceholderFontFamily), typeof(string), typeof(CustomEntry), string.Empty);

        public string PlaceholderFontFamily
        {
            get => (string)GetValue(PlaceholderFontFamilyProperty);
            set => SetValue(PlaceholderFontFamilyProperty, value);
        }

        // Override OnPropertyChanged to handle changes immediately
        protected override void OnPropertyChanged(string propertyName = null)
        {
            base.OnPropertyChanged(propertyName);

            // Trigger the update of UI styles when the properties change
            if (propertyName == nameof(CornerRadius) ||
                propertyName == nameof(BorderColor) ||
                propertyName == nameof(BorderWidth) ||
                propertyName == nameof(BackgroundColors))
            {
#if ANDROID
                // Reapply the custom styles
                (Handler as CustomEntryHandler)?.UpdateStyles(this);
#endif
            }
            if (propertyName == nameof(PlaceholderFontFamily))
            {
#if ANDROID
                // Apply the custom font family to the placeholder text
                (Handler as CustomEntryHandler)?.UpdatePlaceholderFontFamily(this);
#endif
            }
        }
    }
}
