using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StreetLightApp.Models
{
    public class PreferenceModel
    {
        public enum LanguageName
        {
            EN = 1,//Default
            TH = 2,
        }
        public enum ThemeAppearance
        {
            Default = 0,//Auto
            Light = 1,
            Dark = 2,
        }
    }
}
