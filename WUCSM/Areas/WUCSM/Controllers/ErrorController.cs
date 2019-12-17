using System.Web.Mvc;
using WUCSM.Helpers;

namespace WUCSM.Areas.WUCSM.Controllers
{
    public class ErrorController : BaseController
    {
        //
        // GET: /WUCSM/Error/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult NoPwr()
        {
            return View();
        }
    }
}
