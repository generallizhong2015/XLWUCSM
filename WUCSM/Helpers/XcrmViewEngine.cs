using System.Collections.Generic;
using System.Web.Mvc;

namespace WUCSM.Helpers
{
    public class XcrmViewEngine : WebFormViewEngine
    {
        public XcrmViewEngine()
        {
            var formmats = new List<string>();
            formmats.Add("~/Areas/WUCSM/Views/{1}/{0}.aspx");
            base.ViewLocationFormats = formmats.ToArray();
            base.PartialViewLocationFormats = formmats.ToArray();
        }
    }
}