using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WUCSM.Areas.WUCSM.Controllers
{
    public class HappyController : Controller
    {
        //
        // GET: /WUCSM/Happy/

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult NewsYeas()
        {
            return View();
        }
        public ActionResult UptMis()
        {
            return View();
        }
    }
}
