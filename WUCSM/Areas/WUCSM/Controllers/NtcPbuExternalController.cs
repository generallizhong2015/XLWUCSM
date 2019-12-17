using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WUCSM.Helpers;
using System.Collections;
using IBLL;
using Models;

namespace WUCSM.Areas.WUCSM.Controllers
{
    public class NtcPbuExternalController : BaseController
    {
        INtcPubBLL NtcPubBLL { get; set; }
        Hashtable ht = new Hashtable();

        [PwrFilter("NTCPUBEL", "open")]
        public ActionResult Index()
        {
            return View();
        }

        #region 取得通知公告单
        [HttpPost]
        public string GetNtcPubs()
        {
            ht = PageData();
            ht["STT"] = "90";
            ht["ISVLD"] = "T";
            ht["CUSID"] = GetCurCus().CUSID;
            ht["SPUBDT"] = DateTime.Now.Date;
            ht["NTCTXT"] = Request.Params["NTCTXT"];
            IList<NTCPUB> NtcPubs = NtcPubBLL.Select(ht);
            return JSONSerializer.ToGridJson<NTCPUB>(NtcPubs, recordcount: NtcPubBLL.Select_RecordCount(ht));
        }
        #endregion

        #region 取得单条数据
        public string GetNtcPub(string PUBNO)
        {
            return JSONSerializer.Serialize(NtcPubBLL.Select(PUBNO)); ;
        }
        #endregion
    }
}
