using System.Web.Mvc;

namespace WUCSM.Areas.WUCSM
{
    public class WUCSMAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "WUCSM";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "WUCSM_default",
                "WUCSM/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
