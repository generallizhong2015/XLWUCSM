using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WUCSM.Helpers;
using Models;
using IBLL;
using System.Collections;
using System.Web.Routing;

namespace WUCSM.Areas.WUCSM.Controllers
{
    /// <summary>
    /// 通知发布
    /// </summary>
    public class NtcPubController : BaseController
    {
        INtcPubBLL NtcPubBLL { get; set; }
        ICusBLL CusBLL { get; set; }
        Hashtable ht = new Hashtable();
        
        public ActionResult Index()
        {
            if (GetCurUser().USERTYP == "02") return new RedirectToRouteResult(new RouteValueDictionary(new { controller = "NtcPbuExternal", action = "Index" }));
            else return new RedirectToRouteResult(new RouteValueDictionary(new { controller = "NtcPub", action = "NtcPubInternal" }));
        }

        [PwrFilter("NTCPUB", "open")]
        public ActionResult NtcPubInternal()
        {
            return View();
        }

        #region 取得通知公告单
        [HttpPost]
        public string GetNtcPubs()
        {

            ht = PageData();
            ht["STT"] = Request.Params["STT"];
            ht["ISVLD"] = Request.Params["ISVLD"];
            ht["SPUBDT"] = Request.Params["SPUBDT"];
            ht["NTCTXT"] = Request.Params["NTCTXT"];
            IList<NTCPUB> NtcPubs = NtcPubBLL.Select(ht);
            return JSONSerializer.ToGridJson<NTCPUB>(NtcPubs, recordcount: NtcPubBLL.Select_RecordCount(ht));
        }
        #endregion

        #region 取得单条数据
        public string GetNtcPub(string PUBNO)
        {
            return JSONSerializer.Serialize(NtcPubBLL.Select(PUBNO));
        }
        #endregion

        [PwrFilter("NTCPUB", "update")]
        #region 保存通知公告
        public string SaveSvc()
        {
            NTCPUB NtcPub = GetNtcPub().First();
            if (NtcPub.NTCPUBNO == "默认")
            {
                NtcPub.MKR = GetCurUser().USERID;
                NtcPub.MKDTT = DateTime.Now;
                NtcPub.NTCPUBNO = NtcPubBLL.GetMaxPubNo();
                NtcPubBLL.Insert(NtcPub);
            }
            else if (NtcPub.NTCPUBNO != "默认" && (!String.IsNullOrEmpty(NtcPub.NTCPUBNO)))
            {
                NtcPubBLL.Update(NtcPub);
            }
            return "保存成功!";
        }
        #endregion

        [PwrFilter("NTCPUB", "delete")]
        #region 删除通知公告
        public string DelSvc(string NTCPUBNO)
        {
            String[] NtcPubNo = NTCPUBNO.Split(',');
            IList<NTCPUB> NTCPUBs = new List<NTCPUB>();
            for (int i = 0; i < NtcPubNo.Length; i++)
            {
                NTCPUBs.Add(new NTCPUB() { NTCPUBNO = NtcPubNo[i] });
            }
            NtcPubBLL.Delete(NTCPUBs);
            return "删除成功!";
        }
        #endregion

        [PwrFilter("NTCPUB", "release")]
        #region 发布通知公告
        public string PubSvc()
        {
            IList<NTCPUB> NTCPUBs = GetNtcPub();
            NtcPubBLL.PubSvc(NTCPUBs);
            return "发布成功!";
        }
        #endregion

        [PwrFilter("NTCPUB", "invalid")]
        #region 作废通知公告
        public string RspSvc()
        {
            IList<NTCPUB> NTCPUBs = GetNtcPub();
            NtcPubBLL.RspSvc(NTCPUBs);
            return "作废成功!";
        }
        #endregion

        #region 取得前台传回对象
        private IList<NTCPUB> GetNtcPub()
        {
            string NtcPubStr = Request.Params["data"];
            return JSONSerializer.Deserialize<List<NTCPUB>>(NtcPubStr);
        }
        #endregion

        # region 取得可通知客户
        public string GetCus()
        {
            ht = PageData();
            ht["STT"] = "T";
            ht["CUSNAME"] = Request.Params["CUSNAME"];
            IList<CUS> Cuses = CusBLL.Select(ht);
            return JSONSerializer.ToGridJson<CUS>(Cuses, recordcount: CusBLL.Select_RecordCount(ht));
        }
        #endregion

    }
}
