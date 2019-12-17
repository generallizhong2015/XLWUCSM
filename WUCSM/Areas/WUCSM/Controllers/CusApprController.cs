using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WUCSM.Helpers;
using System.Collections;
using Common.Model.Helpers;
using IBLL;
using Models;

namespace WUCSM.Areas.WUCSM.Controllers
{
    public class CusApprController : BaseController
    {
        Hashtable ht = new Hashtable();
        ICusApprBLL CusApprBLL { get; set; }
        ISordBLL SordBLL { get; set; }

        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 获取满意度调查
        /// </summary>
        /// <returns></returns>
        public string GetCusAppr()
        {
            ht = PageData();
            if (!String.IsNullOrEmpty(Request.Params["USERIDS"]))
            {
                ht["USERIDS"] = string.Join(",", Request.Params["USERIDS"].Split(',').Select(u => "'" + u + "'"));
            }
            if ((!String.IsNullOrEmpty(Request.Params["SDT"])) && (!(String.IsNullOrEmpty(Request.Params["EDT"]))))
            {
                ht["SDT"] = Request.Params["SDT"];
                ht["EDT"] = Request.Params["EDT"];
            }
            else
            {
                DateTime now = DateTime.Now;
                DateTime Sdt = new DateTime(now.Year, now.Month, 1);
                DateTime Edt = Sdt.AddMonths(1).AddDays(-1);
                ht["SDT"] = Sdt;
                ht["EDT"] = Edt;
            }
            IList<CUSAPPR> CusAppr = CusApprBLL.GetCusAppr(ht);
            return JSONSerializer.ToGridJson<CUSAPPR>(CusAppr);
        }

        /// <summary>
        /// 获取单据明细
        /// </summary>
        /// <returns></returns>
        public string GetCusApprOrd()
        {
            ht = PageData();
            ht["SDT"] = Request.Params["SDT"];
            ht["EDT"] = Request.Params["EDT"];
            ht["V_USERID"] = Request.Params["USERID"];
            string dgr = "";
            switch (Request.Params["FIELD"])
            {
                case "FIVEDGR": dgr = "05"; ht["DGR"] = dgr; break;
                case "FOURDGR": dgr = "04"; ht["DGR"] = dgr; break;
                case "THREEDGR": dgr = "03"; ht["DGR"] = dgr; break;
                case "TWODGR": dgr = "02"; ht["DGR"] = dgr; break;
                case "ONEDGR": dgr = "01"; ht["DGR"] = dgr; break;
                case "NODGR": dgr = "00"; ht["NDGR"] = dgr; break;
                case "UNTREATED_COUNT": ht["V_STT"] = "0"; break;
            }
            WUCSMResult r = new WUCSMResult();

            r["total"] = SordBLL.SelectCount(ht);
            r["data"] = SordBLL.Select(ht);
            return JSONSerializer.Serialize(r);
        }
    }
}