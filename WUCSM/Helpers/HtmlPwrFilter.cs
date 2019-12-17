using System.Collections.Generic;
using System.Linq;
using System.Web;
using Models;

namespace WUCSM.Helpers
{
    public class HtmlPwrFilter
    {
        public string Handle(string mdlid, string pwrid)
        {
            if (HttpContext.Current.Session != null && (HttpContext.Current.Session["CurUserPwr"] as IList<USERPWR>).Count(u => u.MDLID == mdlid && u.PWRID == pwrid) > 0)
                return "enabled=\"true\"";
            return "enabled=\"false\"";
        }

        public string Handle(string[] mdlpwr)
        {
            List<USERPWR> mdlpwrs = new List<USERPWR>();

            for (int i = 0; i < mdlpwr.Length; i++)
                if (i % 2 == 1)
                    mdlpwrs.Add(new USERPWR() { MDLID = mdlpwr[i - 1], PWRID = mdlpwr[i] });

            if (HttpContext.Current.Session != null && (HttpContext.Current.Session["CurUserPwr"] as IList<USERPWR>).Intersect(mdlpwrs, new MyEquality()).Count() > 0)
                return "enabled=\"true\"";
            return "enabled=\"false\"";
        }
    }
}