using Mopups.Pages;
using Mopups.Services;
using System.Threading.Tasks;

namespace StreetLightApp.Popups;

public partial class DimmerPopup : PopupPage
{
    TaskCompletionSource<string> _taskCompletionSource;
    public Task<string> PopupDismissedTask => _taskCompletionSource.Task; 
    public string ReturnValue { get; set; }
    public DimmerPopup()
	{
		InitializeComponent();

    }
    protected override void OnAppearing()
    {
        base.OnAppearing();
        _taskCompletionSource = new TaskCompletionSource<string>();
        Dispatcher.Dispatch(async() =>
        {
            await Task.Delay(16);
            await closeBtn.RotateTo(135, 1000, Easing.CubicInOut);
        });
        
    }
    
    protected override async void OnDisappearing()
    {
        base.OnDisappearing();
        _taskCompletionSource.SetResult(ReturnValue);
    }

    private async void Button_Clicked(object sender, EventArgs e)
    {
        ReturnValue = "Dialog Cancel";
        await closeBtn.RotateTo(0, 200, Easing.CubicInOut);
        await MopupService.Instance.PopAsync();//.PopAllAsync();
    }

    private async void Button_Clicked_1(object sender, EventArgs e)
    {
        ReturnValue = "Dialog Submit";
        await closeBtn.RotateTo(0, 150, Easing.CubicInOut);
        await MopupService.Instance.PopAsync();//.PopAllAsync();
    }
    private void SmithSlider_SliderValueChanged(object sender, Views.SmithSlider.SliderValueChangedEventArgs e)
    {
        Console.WriteLine($"SliderValueChanged:::{e.OldValue}, {e.NewValue}, {e.OldIndexValue}, {e.NewIndexValue}");
        Dispatcher.Dispatch(() =>
        {
            brightnessLbl.Text = e.NewValue.ToString("N0");
        });
        
    }

    private void SmithSlider_SliderValueComplete(object sender, Views.SmithSlider.SliderValueCompleteEventArgs e)
    {
        Console.WriteLine($"SliderValueComplete:::{e.NewValue}, {e.NewIndexValue}");
    }

    private async void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
        ReturnValue = "Dialog Cancel";
        await closeBtn.RotateTo(-45, 210, Easing.CubicInOut);
        await MopupService.Instance.PopAsync();//.PopAllAsync();
    }

    private async void PopupPage_BackgroundClicked(object sender, EventArgs e)
    {
        ReturnValue = "Dialog Cancel";
        //await closeBtn.RotateTo(-45, 210, Easing.CubicInOut);
    }
}