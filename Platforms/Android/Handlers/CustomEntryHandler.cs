#if ANDROID
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Android.Graphics.Drawables;
using Android.Graphics;
using Android.Widget;
using Microsoft.Maui.Handlers;
//using System.Diagnostics;
using Color = Android.Graphics.Color;
using StreetLightApp.Controls;
using Microsoft.Maui.Controls.Platform;

namespace StreetLightApp.Platforms.Android.Handlers
{
    public class CustomEntryHandler : EntryHandler
    {
        public static void Customize()
        {
            EntryHandler.Mapper.AppendToMapping(nameof(CustomEntry), (handler, view) =>
            {
                if (handler.PlatformView is null)
                    return;

                var editText = handler.PlatformView;
                try
                {
                    var customEntry = (CustomEntry)view;

                    // Set the custom font family to the placeholder
                    if (!string.IsNullOrEmpty(customEntry.PlaceholderFontFamily))
                    {
                        editText.SetTypeface(Typeface.Create(customEntry.PlaceholderFontFamily, TypefaceStyle.Normal), TypefaceStyle.Normal);
                    }

                    // Set background color to transparent
                    editText.SetBackgroundColor(Color.Transparent);

                    // Set padding
                    editText.SetPadding(20, 10, 20, 10);

                    // Create a custom border using GradientDrawable
                    GradientDrawable gd = new GradientDrawable();
                    //Console.WriteLine($"SetStroke:{customEntry.BorderColor} = {customEntry.BorderColor.Red},{customEntry.BorderColor.Green},{customEntry.BorderColor.Blue}");
                    var strokeC = Color.Argb((int)customEntry.BorderColor.Alpha * 255, (int)customEntry.BorderColor.Red * 255, (int)customEntry.BorderColor.Green * 255, (int)customEntry.BorderColor.Blue * 255);
                    gd.SetCornerRadius(customEntry.CornerRadius); // Set CornerRadius from CustomEntry
                    gd.SetStroke(5, strokeC); // Set BorderColor from CustomEntry
                                              //gd.SetStroke(customEntry.BorderWidth, Color.ParseColor(customEntry.BorderColor.ToHex())); // Set BorderColor from CustomEntry

                    gd.SetColor(Color.ParseColor(customEntry.BackgroundColors.ToHex())); // Set background color

                    editText.SetBackground(gd);

                    // Set text color to black
                    editText.SetTextColor(Color.Black);
                }
                catch (InvalidCastException ivEx)
                {

                }

            });
        }
        public void UpdateStyles(CustomEntry customEntry)
        {
            if (PlatformView is EditText editText)
            {
                // Set the custom font family to the placeholder
                if (!string.IsNullOrEmpty(customEntry.PlaceholderFontFamily))
                {
                    TypefaceStyle typefaceStyle = TypefaceStyle.Normal;

                    // Check if the custom font is SemiBold or Bold, and use the appropriate style
                    if (customEntry.PlaceholderFontFamily.Contains("Regular"))
                    {
                        typefaceStyle = TypefaceStyle.Normal;
                    }
                    else if (customEntry.PlaceholderFontFamily.Contains("Bold"))
                    {
                        typefaceStyle = TypefaceStyle.Bold;
                    }

                    // Create and set the correct typeface
                    Typeface typeface = Typeface.Create(customEntry.PlaceholderFontFamily, typefaceStyle);
                    editText.SetTypeface(typeface, typefaceStyle);
                }

                GradientDrawable gd = new GradientDrawable();
                //Console.WriteLine($"SetStroke:{customEntry.BorderColor} = {customEntry.BorderColor.Red},{customEntry.BorderColor.Green},{customEntry.BorderColor.Blue}");
                var strokeC = Color.Argb((int)customEntry.BorderColor.Alpha * 255, (int)customEntry.BorderColor.Red * 255, (int)customEntry.BorderColor.Green * 255, (int)customEntry.BorderColor.Blue * 255);
                gd.SetCornerRadius(customEntry.CornerRadius); // Set CornerRadius from CustomEntry
                gd.SetStroke(5, strokeC); // Set BorderColor from CustomEntry
                                          //gd.SetStroke(customEntry.BorderWidth, Color.ParseColor(customEntry.BorderColor.ToHex())); // Set BorderColor from CustomEntry

                gd.SetColor(Color.ParseColor(customEntry.BackgroundColors.ToHex())); // Set background color

                editText.SetBackground(gd);

                // Set text color to black
                editText.SetTextColor(Color.Black);
            }
        }
        // Update the placeholder font family when it changes
        public void UpdatePlaceholderFontFamily(CustomEntry customEntry)
        {
            if (PlatformView is EditText editText)
            {
                if (!string.IsNullOrEmpty(customEntry.PlaceholderFontFamily))
                {
                    TypefaceStyle typefaceStyle = TypefaceStyle.Normal;

                    // Check if the custom font is SemiBold or Bold, and use the appropriate style
                    if (customEntry.PlaceholderFontFamily.Contains("Regular"))
                    {
                        typefaceStyle = TypefaceStyle.Normal;
                    }
                    else if (customEntry.PlaceholderFontFamily.Contains("Bold"))
                    {
                        typefaceStyle = TypefaceStyle.Bold;
                    }

                    // Create and set the correct typeface
                    Typeface typeface = Typeface.Create(customEntry.PlaceholderFontFamily, typefaceStyle);
                    editText.SetTypeface(typeface, typefaceStyle);
                }
            }
        }
    }
}
    #endif