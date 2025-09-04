using Microsoft.Maui.Controls;
using Microsoft.Maui.Controls.Shapes;
using System.Numerics;
using System.Runtime.CompilerServices;

namespace StreetLightApp.Views;

public partial class SmithSlider : ContentView
{
    public class SliderValueChangedEventArgs : EventArgs
    {
        /// <summary>
        /// Number of the old value
        /// min - max
        /// </summary>
        public double OldValue { get; }
        /// <summary>
        /// Number of the new value
        /// min - max
        /// </summary>
        public double NewValue { get; }
        /// <summary>
        /// Order Index of the old value
        /// 0, 1, 2, 3, ...
        /// </summary>
        public int OldIndexValue { get; }
        /// <summary>
        /// Order Index of the new value
        /// 0, 1, 2, 3, ...
        /// </summary>
        public int NewIndexValue { get; }

        public SliderValueChangedEventArgs(double _oldValue = 0, double _newValue = 0, int _oldIndexValue = 0, int _newIndexValue = 0)
        {
            OldValue = _oldValue;
            NewValue = _newValue;
            OldIndexValue = _oldIndexValue;
            NewIndexValue = _newIndexValue;

        }
    }
    public class SliderValueCompleteEventArgs : EventArgs
    {
        /// <summary>
        /// Number of the new value
        /// min - max
        /// </summary>
        public double NewValue { get; }
        /// <summary>
        /// Order Index of the new value
        /// 0, 1, 2, 3, ...
        /// </summary>
        public int NewIndexValue { get; }

        public SliderValueCompleteEventArgs(double _newValue = 0, int _newIndexValue = 0)
        {
            NewValue = _newValue;
            NewIndexValue = _newIndexValue;

        }
    }
    public event EventHandler<SliderValueChangedEventArgs> SliderValueChanged;
    public event EventHandler<SliderValueCompleteEventArgs> SliderValueComplete;

    public static readonly BindableProperty BackColorProperty =
        BindableProperty.Create(
            nameof(BackColor),
            typeof(Brush),
            typeof(SmithSlider),
            Brush.Transparent,
            propertyChanged: OnBackColorChanged);

    public static readonly BindableProperty ForeColorProperty =
        BindableProperty.Create(
            nameof(ForeColor),
            typeof(Brush),
            typeof(SmithSlider),
            Brush.Black,
            propertyChanged: OnForeColorChanged);

    public Brush BackColor
    {
        get => (Brush)GetValue(BackColorProperty);
        set => SetValue(BackColorProperty, value);
    }

    public Brush ForeColor
    {
        get => (Brush)GetValue(ForeColorProperty);
        set => SetValue(ForeColorProperty, value);
    }

    private static void OnBackColorChanged(BindableObject bindable, object oldValue, object newValue)
    {
        var view = (SmithSlider)bindable;
        view.body.Background = (Brush)newValue;  // `body` is your Border in XAML
    }

    private static void OnForeColorChanged(BindableObject bindable, object oldValue, object newValue)
    {
        var view = (SmithSlider)bindable;
        view.fore.Background = (Brush)newValue;  // `fore` is whatever element you want to color
    }

    CornerRadius corner = new CornerRadius(8);
    public CornerRadius Corner
    {
        get
        {
            return corner;

        }
        set
        {
            corner = value;
            fore.StrokeShape = new RoundRectangle
            {
                CornerRadius = value
            };
        }
    }

    SmithOrientation orientation = SmithOrientation.Horizontal;
    public SmithOrientation Orientation
    {
        get
        {
            return orientation;
        }
        set
        {
            orientation = value;
        }
    }

    double minValue = 0;
    public double MinValue
    {
        get
        {
            return minValue;
        }
        set
        {
            minValue = value;
            InitialView();
            SetValue(Value);
        }
    }
    double maxValue = 10;
    public double MaxValue
    {
        get
        {
            return maxValue;
        }
        set
        {
            maxValue = value;
            InitialView();
            SetValue(Value);
        }
    }

    double newvalue = 0;
    public double Value
    {
        get
        {
            return newvalue;
        }
        set
        {

            this.newvalue = value;
            SetValue(value);
        }
    }

    public int StepCount { get; }
    double stepTick = 1;
    public double StepTick
    {
        get
        {
            return stepTick;
        }
        set
        {
            stepTick = value;
            InitialView();
            SetValue(value);
        }
    }
    bool showDebugLabel = true;
    public bool ShowDebugLabel
    {
        get
        {
            return showDebugLabel;
        }
        set
        {
            showDebugLabel = value;
            lbl.IsVisible = value;
            marginBar1.IsVisible = value;
            marginBar2.IsVisible = value;
        }
    }
    Color debugLabelColor = Colors.Black;
    public Color DebugLabelColor
    {
        get
        {
            return debugLabelColor;
        }
        set
        {
            debugLabelColor = value;
            lbl.TextColor = value;
        }
    }
    ImageSource thumbImageSource = "thimb";
    public ImageSource ThumbImageSource
    {
        get
        {
            return thumbImageSource;
        }
        set
        {
            thumbImageSource = value;
            slider.ThumbImageSource = value; ;
        }
    }

    Color thumbColor = Colors.Aqua;
    public Color ThumbColor
    {
        get
        {
            return thumbColor;
        }
        set
        {
            thumbColor = value;
            slider.ThumbColor = value;
        }
    }
    double StepPX = -1;

    double TOL = 1e-9;
    public SmithSlider()
    {
        InitializeComponent();

        Loaded += (s, e) =>
        {
            Dispatcher.Dispatch(() =>
            {
                var w = Width;
                var h = Height;
                //Console.WriteLine($"Loaded - Width:{w}, Height:{h}");
                InitialView();
                SetValue(Value);
            });
        };
        SizeChanged += (s, e) =>
        {
            // Actual rendered size
            var w = Width;
            var h = Height;
            // use w/h here
            //Console.WriteLine($"SizeChanged - Width:{w}, Height:{h}");
            InitialView();
            SetValue(Value);
        };
    }

    protected override void OnPropertyChanged([CallerMemberName] string propertyName = null)
    {
        base.OnPropertyChanged(propertyName);
        //Console.WriteLine($"Width:{Width}, Height:{Height}");
    }
    void InitialView()
    {
        //Width = 0;
        //Height = 0;
        //minValue;
        //maxValue;
        //StepCount
        //StepPX

        //var step = (maxValue - minValue) + 1;//assume max=10, min=0, step = 11(0-10)
        //StepCount = ((maxValue - minValue) / StepTick); //Assume StepTick=0.5,StepCount = 21(0-10) 

        if (StepTick <= 0) throw new ArgumentOutOfRangeException($"{nameof(StepTick)}:Maximim value must greater than than Minimum value.");

        var span = Math.Abs(maxValue - minValue);
        var intervals = Math.Floor(span / StepTick + TOL) + 1;
        StepPX = ((Width - 32) / span); //32 mean margin of slider
        //[DOTNET] SizeChanged - Width:363.42857142857144, Height: 64
        //[DOTNET] InitialView:::minValue = 0, maxValue = 10, span = 10, intervals = 11
        slider.Minimum = minValue;
        slider.Maximum = maxValue;
        //Console.WriteLine($"InitialView:::minValue={minValue}, maxValue={maxValue}, span={span}, intervals={intervals}, StepTick={StepTick}, Slider:{slider.Minimum},{slider.Maximum}");
    }
    void SetValue(double _value)
    {
        //Console.WriteLine($"SetValue:::{_value}");
        if (showDebugLabel)
        {
            lbl.Text = _value.ToString();
        }
        body.WidthRequest = (Width - 32) - (StepPX * (_value - minValue));
        slider.Value = _value;
    }

    bool _updating;
    private void slider_ValueChanged_1(object sender, ValueChangedEventArgs e)
    {
        if (_updating) return;
        int newvalue = Convert.ToInt32(e.NewValue);
        //Console.WriteLine($"slider_ValueChanged:::{newvalue}, {e.OldValue}");
        double oldv = Value;
        if (Math.Abs(slider.Value - newvalue) > TOL)
        {
            _updating = true;
            //Console.WriteLine("Not Equa");
            slider.Value = newvalue;
            Value = newvalue;
            //SetValue(newvalue);
            _updating = false;

        }
        //int currentValue = (int)e.NewValue;
        //SetValue((int)(newvalue + 0.4f));

        //int slideIndex = (int)e.NewValue;
        //slider.Value = slideIndex;
        //SetValue(slideIndex);
        SliderValueChanged?.Invoke(this, new SliderValueChangedEventArgs(oldv, e.NewValue, (int)(oldv - minValue), (int)(e.NewValue - minValue)));
    }

    private void slider_DragCompleted(object sender, EventArgs e)
    {
        //Console.WriteLine($"slider_DragCompleted:::{slider.Value}");
        //Slider_COmplete
        SliderValueComplete?.Invoke(this, new SliderValueCompleteEventArgs(Value, (int)(Value - minValue)));
    }
}
public enum SmithOrientation
{
    //
    // Summary:
    //     StackLayout should be vertically oriented.
    Vertical,
    //
    // Summary:
    //     StackLayout should be horizontally oriented.
    Horizontal
}