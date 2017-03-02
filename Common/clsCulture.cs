using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading;

namespace webApp.Common
{
    public class clsCulture : System.Globalization.CultureInfo
    {
        public clsCulture() : base(Thread.CurrentThread.CurrentCulture.Name)
        {
            this.NumberFormat.PercentSymbol = string.Empty;
        }
    }
}