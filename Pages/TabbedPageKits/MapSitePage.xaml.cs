using StreetLightApp.Services;
using StreetLightApp.Views;

namespace StreetLightApp.Pages.TabbedPageKits;

public partial class MapSitePage : ContentPage
{
    public MapSitePage()
    {
        InitializeComponent();
        int colCount = 2;
        int col = 0;

        Grid currentGrid = null;

        foreach (var site in Provider.SiteList)
        {
            if (col == 0)
            {
                currentGrid = new Grid
                {
                    ColumnDefinitions =
            {
                new ColumnDefinition { Width = GridLength.Star },
                new ColumnDefinition { Width = GridLength.Star }
            },
                    Margin = new Thickness(0)
                };

                StackSiteItem.Children.Add(currentGrid);
            }

            var item = new SiteItemMap(site)
            {
                Margin = new Thickness(4),
                HeightRequest = 100
            };

            item.Clicked += async (a, b) =>
            {
                await Navigation.PushAsync(new MapPage(site));
            };

            currentGrid.Children.Add(item);
            Grid.SetColumn(item, col);

            col++;
            if (col >= colCount)
            {
                col = 0;
            }
        }


    }
}
