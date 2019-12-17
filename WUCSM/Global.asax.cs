using System.Web.Mvc;
using System.Web.Routing;
using WUCSM.Helpers;

namespace WUCSM
{
    // 注意: 有关启用 IIS6 或 IIS7 经典模式的说明，
    // 请访问 http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Default", // 路由名称
                "{controller}/{action}/{id}", // 带有参数的 URL
                new { controller = "Login", action = "Login", id = UrlParameter.Optional } // 参数默认值
            );
        }

        protected void Application_Start()
        {
            //重新指定View的规则 
            ViewEngines.Engines.Clear();
            ViewEngines.Engines.Add(new WUCSM.Helpers.XcrmViewEngine());
            //设置Spring控制器工厂
            ControllerBuilder.Current.SetControllerFactory(typeof(SpringControllerFactory));

            AreaRegistration.RegisterAllAreas();
            RegisterRoutes(RouteTable.Routes);
        }
    }
}