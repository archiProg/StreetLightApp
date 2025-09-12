using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;


namespace StreetLightApp.Models
{
    public class Dimmer : MyDevice
    {
        public int Online { get; set; }
        public int Dimvalue { get; set; }
        public int Status { get; set; }
        public string img_power_on_Icon { get; set; } = "";
        public string img_power_off_Icon { get; set; } = "";
        public int Percentage { get; internal set; }
        public double Temp { get; internal set; }
        public int Charge { get; internal set; }
        public double PowerVolt { get; internal set; }
        public double PowerCurrent { get; internal set; }
        public double PowerOutVolt { get; internal set; }
        public double PowerOutCurrent { get; internal set; }
        public double BattVolt { get; internal set; }
        public double Capacity { get; internal set; }
        public int BattHealth { get; internal set; }
        public int CycleCount { get; internal set; }

        public event EventHandler<int> DimChangeHandler;
        public event EventHandler<int> OnlineHandler;
        public event EventHandler<int> StatusHandler;

        public event EventHandler<int> PercentageHandler;
        public event EventHandler<double> TempHandler;
        public event EventHandler<int> ChargeHandler;
        public event EventHandler<double> PowerVoltHandler;
        public event EventHandler<double> PowerCurrentHandler;
        public event EventHandler<double> PowerOutVoltHandler;
        public event EventHandler<double> PowerOutCurrentHandler;
        public event EventHandler<double> BattVoltHandler;
        public event EventHandler<double> CapacityHandler;
        public event EventHandler<int> BattHealthHandler;
        public event EventHandler<int> CycleCountHandler;

        public List<ImageSource> ImageSourcesList = new List<ImageSource>();
        public void OnStatusHandler()
        {
            try
            {
                //Console.WriteLine("EventHandler Air[Status]");
                OnStatus(Status);
            }
            catch (Exception ex)
            {
                OnStatus(Status);
            }
        }
        protected virtual void OnStatus(int status)
        {
            StatusHandler?.Invoke(this, status);
        }
        public void SetStatus(int status)
        {
            Status = status;
             OnStatusHandler();
        }

        public void OnDimChangeHandler()
        {
            try
            {
                OnDimChange(Dimvalue);
            }
            catch (Exception ex)
            {
                OnDimChange(Dimvalue);
            }
        }
        protected virtual void OnDimChange(int dim)
        {
            DimChangeHandler?.Invoke(this, dim);
        }

        public void OnOnlineHandler()
        {
            try
            {
                OnOnline(Online);
            }
            catch (Exception ex)
            {
                OnOnline(Online);
            }
        }
        protected virtual void OnOnline(int status)
        {
            OnlineHandler?.Invoke(this, status);
        }
        public void SetOnline(int online)
        {
            Online = online;

            OnOnlineHandler();
        }

        public Dimmer(MyDevice _myDevice)
        {
            site_id = _myDevice.site_id;
            contract_id = _myDevice.contract_id;
            contract_number = _myDevice.contract_number;
            gateway_id = _myDevice.gateway_id;
            gateway_name = _myDevice.gateway_name;
            gateway_lat = _myDevice.gateway_lat;
            gateway_long = _myDevice.gateway_long;
            type = _myDevice.type;
            device_id = _myDevice.device_id;
            device_name = _myDevice.device_name;
            device_style = _myDevice.device_style;
            lat = _myDevice.lat;
            @long = _myDevice.@long;
            group_id = _myDevice.group_id;
            group_name = _myDevice.group_name;
            description = _myDevice.description;
        }

        public List<Config> config { get; set; }

        public void SetName(string name)
        {
            device_name = name;

        }
        public void SetDim(int dim)
        {
            Dimvalue = dim;
            OnDimChangeHandler();
        }

        internal void SetPercentage(int last_value)
        {
            Percentage = last_value;
            PercentageHandler?.Invoke(this, last_value);
        }

        internal void SetTemp(double last_value)
        {
            Temp = last_value;
            TempHandler?.Invoke(this, (int)last_value);
        }

        internal void SetCharge(int last_value)
        {
            Charge = last_value;
            ChargeHandler?.Invoke(this, last_value);
        }

        internal void SetPowerVolt(double last_value)
        {
            PowerVolt = last_value;
            PowerVoltHandler?.Invoke(this, (int)last_value);
        }

        internal void SetPowerCurrent(double last_value)
        {
            PowerCurrent = last_value;
            PowerCurrentHandler?.Invoke(this, (int)last_value);
        }

        internal void SetPowerOutVolt(double last_value)
        {
            PowerOutVolt = last_value;
            PowerOutVoltHandler?.Invoke(this, (int)last_value);
        }

        internal void SetPowerOutCurrent(double last_value)
        {
            PowerOutCurrent = last_value;
            PowerOutCurrentHandler?.Invoke(this, (int)last_value);
        }

        internal void SetBattVolt(double last_value)
        {
            BattVolt = last_value;
            BattVoltHandler?.Invoke(this, (int)last_value);
        }

        internal void SetCapacity(double last_value)
        {
            Capacity = last_value;
            CapacityHandler?.Invoke(this, (int)last_value);
        }

        internal void SetBattHealth(int last_value)
        {
            BattHealth = last_value;
            BattHealthHandler?.Invoke(this, last_value);
        }

        internal void SetCycleCount(int last_value)
        {
            CycleCount = last_value;
            CycleCountHandler?.Invoke(this, last_value);
        }
    }
}
