using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Routing;
using IBLL;
using Models;
using WUCSM.Helpers;
using System.Globalization;
using System.Web;

namespace WUCSM.Areas.WUCSM.Controllers
{
    /// <summary>
    /// 服务工单
    /// </summary>
    public class SordController : BaseController
    {
        #region 注入对象
        ISttCfgBLL SttCfgBLL { get; set; }
        ISordBLL SordBLL { get; set; }
        ISordDtlBLL SordDtlBLL { get; set; }
        IApprBLL ApprBLL { get; set; }
        INtcPubBLL NtcPubBLL { get; set; }
        IUsersBLL UsersBLL { get; set; }
        IUserCusBLL UserCusBLL { get; set; }

        #endregion

        
        string faults = "";
        #region 界面
        /// <summary>
        /// 服务工单主入口
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
             
            if (GetCurUser().USERTYP == "01")
                return new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Sord", action = "Internal" }));
            else
                return new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Sord", action = "External" }));
        }

        /// <summary>
        /// 内部服务工单入口
        /// </summary>
        /// <returns></returns>
        [PwrFilter("SORD", "open")]
        public ActionResult Internal()
        {
            Hashtable h = new Hashtable();
            h["ISUSE"] = "T";
            h["NODTYP"] = "STT";
            IList<STTCFG> STTs = SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT).ToList();
            //IList<STTCFG> stt = SttCfgBLL.Select(h).Where(x => x.NODDTSTT != "90").OrderBy(s=>s.NODDTSTT).ToList();
            STTs.Insert(0, new STTCFG() { NODDTSTT = "-90", NODNAME = "用户未验收" });
            TempData["STTs"] = JSONSerializer.Serialize(STTs);

            h["NODTYP"] = "SERTYP";
            TempData["SERTYPs"] = JSONSerializer.Serialize(SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT));
            h["STT"] = "1";
            h["USERTYP"] = "01";
            IList<Models.USERS> uList = UsersBLL.Select(h);
            var aa = (from i in uList select new { i.USERID, i.USERNAME }).ToList();
            //List<object> d = new List<object>();
            //foreach (var item in aa)
            //{
            //    d.Add(new { NAME=item.USERID,});
            //}
            TempData["USERs"] = JSONSerializer.Serialize(aa);
            TempData["Tracer"] = JSONSerializer.Serialize(aa);
            TempData["Revisit"] = JSONSerializer.Serialize(aa);
            TempData["Fault"] = faults;
            return View();
        }
        /// <summary>
        /// 外部服务工单入口
        /// </summary>
        /// <returns></returns>
        [PwrFilter("SORDEL", "open")]
        public ActionResult External()
        {
            CUS Cus = GetCurCus();
            string Tips = "";
            Hashtable h = new Hashtable();
            h["ISUSE"] = "T";
            h["NODTYP"] = "STT";
            IList<STTCFG> STTs = SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT).ToList();
            STTs.Insert(0, new STTCFG() { NODDTSTT = "-90", NODNAME = "用户未验收" });
            TempData["STTs"] = STTs;
            h["NODTYP"] = "SERTYP";
            if ((Cus.DISDATE - DateTime.Now).Days <= 0) Tips = "温馨提示：您的服务合同已于" + Cus.DISDATE.ToLongDateString() + "到期，请及时联系长益西联软件公司！";
            else if ((Cus.DISDATE - DateTime.Now).Days <= 30) Tips = "温馨提示：您的服务合同将于" + (DateTime.Now - Cus.DISDATE).Days + "天后到期，请及时联系长益西联软件公司！";
            TempData["SERTYPs"] = SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT).ToList();
            TempData["NTCPUBs"] = NtcPubBLL.GetSrollNtcPub(Cus.CUSID);
            TempData["TIPs"] = Tips;
            TempData["IsUse"] = Cus.STT;
            //判断是mis 还是erp
            IList<USERS> users = new List<USERS>();
            h.Clear();
            h["CUSID"] = Cus.CUSID;
            IList<USERCUS> usercus = UserCusBLL.Select(h);
            string isMis=string.Empty;
            //TempData["IsMis"]
            if (usercus != null && usercus.Count > 0)
            {
                foreach (var item in usercus)
                {
                    h.Clear();
                    h["USERID"] = item.USERID;
                    users = UsersBLL.Select(h);
                }
            }
            if (users.Count > 0)
            {
                foreach (var item in users)
                {
                    if (item.DPT != null)
                    {
                        isMis = item.DPT;
                    }
                }
            }
            TempData["IsMis"] = isMis;
            return View();
        }
        [PwrFilter("ORDEROPER", "open")]
        public ActionResult OrderOper()
        {
            Hashtable h = new Hashtable();
            h["ISUSE"] = "T";
            h["NODTYP"] = "STT";
            IList<STTCFG> STTs = SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT).ToList();
            //IList<STTCFG> stt = SttCfgBLL.Select(h).Where(x => x.NODDTSTT != "90").OrderBy(s=>s.NODDTSTT).ToList();
            STTs.Insert(0, new STTCFG() { NODDTSTT = "-90", NODNAME = "用户未验收" });
            STTs.Insert(1, new STTCFG() { NODDTSTT = "-1", NODNAME = "作废" });
            TempData["STTs"] = JSONSerializer.Serialize(STTs);

            h["NODTYP"] = "SERTYP";
            TempData["SERTYPs"] = JSONSerializer.Serialize(SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT));
            h["STT"] = "1";
            h["USERTYP"] = "01";
            IList<Models.USERS> uList = UsersBLL.Select(h);
            var aa = (from i in uList select new { i.USERID, i.USERNAME }).ToList();
            //List<object> d = new List<object>();
            //foreach (var item in aa)
            //{
            //    d.Add(new { NAME=item.USERID,});
            //}
            TempData["USERs"] = JSONSerializer.Serialize(aa);
            return View();
        }

        /// <summary>
        /// 判断客户留言时间
        /// </summary>
        /// <returns></returns>
        public string NewSordMsg()
        {
            CUS Cus = GetCurCus();
            string Tips = "";
            IList<USERS> users = new List<USERS>();
            Hashtable ht = new Hashtable();
            ht["CUSID"] = Cus.CUSID;
            IList<USERCUS> usercus = UserCusBLL.Select(ht);
            if (usercus.Count > 0)
            {
                foreach (var item in usercus)
                {
                    ht.Clear();
                    ht["USERID"] = item.USERID;
                    users= UsersBLL.Select(ht);
                }
            }
            if (users.Count > 0)
            {
                foreach (var item in users)
                {   
                    if (item.DPT == "10")//mis
                    {
                        Tips = "由于现在是非工作时间段，如果您有影响销售等紧急问题需要处理，请您在网站留言后并尽快通过值班电话与我们取得联系：18081006306。";
                    }
                    else if (item.DPT == "09")//erp
                    {
                        Tips = "由于现在是非工作时间段，如果您有影响销售等紧急问题需要处理，请您在网站留言后并尽快通过值班电话与我们取得联系：18081006706。";
                    }
                }
            }
            return Tips;
        }


        /// <summary>
        /// 判断客户留言时间
        /// </summary>
        /// <returns></returns>
        public string NewSordCall()
        {

            string Tips = "";
            try
            {
                CUS Cus = GetCurCus();
                IList<USERS> users = new List<USERS>();
                Hashtable ht = new Hashtable();
                ht["CUSID"] = Cus.CUSID;
                IList<USERCUS> usercus = UserCusBLL.Select(ht);
                if (usercus.Count > 0)
                {
                    foreach (var item in usercus)
                    {
                        ht.Clear();
                        ht["USERID"] = item.USERID;
                        users = UsersBLL.Select(ht);
                    }
                }
                if (users.Count > 0)
                {
                    foreach (var item in users)
                    {
                        if (item.DPT == "10")
                        {
                            Tips = "尊敬的客户，您好！留言10分钟未响应，请您联系：028-62997277";
                        }
                        else if (item.DPT == "09")
                        {
                            Tips = "尊敬的客户，您好！留言10分钟未响应，请您联系：028-62997278";
                        }
                        else if (item.DPT != "10" || item.DPT != "09")
                        {
                            Tips = "尊敬的客户,你好!感谢你选择西联软件";
                        }
                    }
                }
            }
            catch (Exception e)
            {
                return Tips = "系统繁忙，稍后再试!";
                throw;
            }
            
            return Tips;
        }

        /// <summary>
        /// 申请派工单
        /// </summary>
        /// <returns></returns>
        [PwrFilter("SORDEL", "insert")]
        public ActionResult NewSord()
        {
            TempData["IP"] = GetIP();
            Hashtable h = new Hashtable();
            h["ISUSE"] = "T";
            h["NODTYP"] = "SERTYP";
            TempData["CUS"] = GetCurCus();
            TempData["USER"] = GetCurUser();
            TempData["SERTYPs"] = JSONSerializer.Serialize(SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT));
            return View();
        }
        /// <summary>
        /// 受理派工单
        /// </summary>
        /// <returns></returns>
        [PwrFilter("SORD", "startsd")]
        public ActionResult StartSordInfo(string ordno)
        {

            //得到当前登录信息
            string usrName = GetCurUser().USERNAME;
            TempData["UsrName"] = usrName;

            Hashtable h = new Hashtable();
            h["STT"] = "1";
            h["USERTYP"] = "01";
            IList<Models.USERS> uList = UsersBLL.Select(h);
            var aa = (from i in uList select new { i.USERID, i.USERNAME }).ToList();
            TempData["USERs"] = JSONSerializer.Serialize(aa);
            TempData["SORD"] = SordBLL.Select(ordno);
            var flower = 11;
            TempData["Fault"] = flower;
            return View();
        }
        /// <summary>
        /// 验收派工单
        /// </summary>
        /// <param name="ordno"></param>
        /// <returns></returns>
        [PwrFilter("SORDEL", "endsd")]
        public ActionResult EndSordInfo(string ordno)
        {
            return View();
        }
        /// <summary>
        /// 编辑派工单
        /// </summary>
        /// <returns></returns>
        [PwrFilter(new string[] { "SORD", "update", "SORDEL", "update" })]
        public ActionResult UpdateSordInfo(string ordno,string isSys)
        {
            Hashtable h = new Hashtable();
            h["ISUSE"] = "T";
            h["NODTYP"] = "STT";
            TempData["isSys"] = isSys;
            TempData["STTs"] = JSONSerializer.Serialize(SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT));

            h["NODTYP"] = "SERTYP";
            TempData["SERTYPs"] = JSONSerializer.Serialize(SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT));
            SORD sord=SordBLL.Select(ordno);
            TempData["SORD"] = sord;
            string red=string.Empty;
            if (GetCurUser().USERID != sord.Revisit)
                 red= "disabled";
            TempData["Redonery"] = red;
            return View();
        }
        /// <summary>
        /// 派工单详情
        /// </summary>
        /// <param name="ordno"></param>
        /// <returns></returns>
        [PwrFilter(new string[] { "SORD", "open", "SORDEL", "open" })]
        public ActionResult SordInfo(string ordno)
        {
            SORD SORD = SordBLL.Select(ordno);

            Hashtable h = new Hashtable();
            h["NODTYP"] = "STT";
            h["ISUSE"] = "T";
            STTCFG STTCFG = SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT).FirstOrDefault(s => int.Parse(s.NODDTSTT) > int.Parse(SORD.STT));
            if (STTCFG != null) TempData["NEXTSTTCFG"] = STTCFG;

            TempData["SORD"] = SORD;
            return View();
        }
        /// <summary>
        /// 工单回复
        /// </summary>
        [PwrFilter(new string[] { "SORD", "open", "SORDEL", "open" })]
        public ActionResult SordReply(string ordno, string type)
        {
            if (type != "1")
            {
                Hashtable h = new Hashtable();
                h["ORDNO"] = ordno;
                TempData["SORDDTLs"] = SordDtlBLL.Select(h);
            }
            return View();
        }
        /// <summary>
        /// 工单评论
        /// </summary>
        [PwrFilter(new string[] { "SORD", "open", "SORDEL", "open" })]
        public ActionResult SordReview(string ordno)
        {
                Hashtable h = new Hashtable();
                h["ORDNO"] = ordno;
                TempData["APPRs"] = ApprBLL.Select(h);
                TempData["Getuser"] = GetCurUser().USERTYP == "01";
                SORD SORD = SordBLL.Select(ordno);
                TempData["SORD"] = SORD;
                TempData["CanReview"] = SORD.STT == "90";
            
            return View();
        }
        /// <summary>
        /// 工单跟踪
        /// </summary>
        [PwrFilter(new string[] { "SORD", "open", "SORDEL", "open" })]
        public ActionResult SordTrack(string ordno)
        {
            Hashtable h = new Hashtable();
            h["ORDNO"] = ordno;
            TempData["TASKDEALs"] = SordBLL.SelectTaskDeal(h).OrderBy(t => t.PRCDT).ToList();
            return View();
        }
        #endregion

        #region 获取派工单
        [PwrFilter(new string[] { "SORD", "open", "SORDEL", "open" })]
        [HttpPost]
        public string GetSord()
        {
            
            //string ORDNO, string STT, string SDT, string EDT, string SERTYP, string SUBCUS, string USERIDS
            string ORDNO=Request["ORDNO"];
            string STT = Request["STT"];
            string SDT = Request["SDT"];
            string EDT = Request["EDT"];
            string SERTYP = Request["SERTYP"];
            string SUBCUS = Request["SUBCUS"];
            string USERIDS = Request["USERIDS"];   
            string Tracer = Request["Tracer"];
            string Revisit = Request["Revisit"];
            DateTime? sSDT = null;
            DateTime? sEDT = null;
            if ((!string.IsNullOrEmpty(SDT)) && (!string.IsNullOrEmpty(EDT)))
            {
                sSDT = DateTime.Parse(SDT);
                sEDT = DateTime.Parse(EDT);
            }
            Hashtable h = PageData();
            if (STT == "-90")
                h["NOTSTT"] = "90";
            else
                h["STT"] = STT;

            if (STT == "")
                h["STT"] = null;
            h["SDT"] = sSDT;
            h["EDT"] = sEDT;
            h["ORDNO"] = ORDNO;
            h["PRCMAN"] = SERTYP;
            h["SUBCUS"] = SUBCUS;
            h["ISDELETE"] = 0;
            h["Tracer"] = Tracer;
            h["Revisit"] = Revisit;
            if (!string.IsNullOrEmpty(USERIDS))
                h["USERIDS"] = string.Join(",", USERIDS.Split(',').Select(u => "'" + u + "'"));



            WUCSMResult r = new WUCSMResult();
            r["total"] = SordBLL.SelectCount(h);
            r["data"] = HandleSelectSord(SordBLL.Select(h));
            return JSONSerializer.Serialize(r);
        }
        #endregion

        #region 获取派工单(外部)
        [PwrFilter(new string[] { "SORD", "open", "SORDEL", "open" })]
        public string GetMySord(string subdt, string sordstt, string sertyp)
        {
            Hashtable h = PageData();
            //subdt
            int subdtdays = 0;
            if (int.TryParse(subdt, out subdtdays))
            {
                h["SDT"] = DateTime.Now.AddDays(-subdtdays);
                h["EDT"] = DateTime.Now;
            }
            //sordstt
            if (sordstt == "-90")
                h["NOTSTT"] = "90";
            else if (sordstt != "default")
                h["STT"] = sordstt;
            //sertyp
            if (sertyp != "default") h["SERTYP"] = sertyp;
            h["SUBMAN"] = GetCurUser().USERID;
            h["ISDELETE"] = 0;

            WUCSMResult r = new WUCSMResult();
            r["total"] = SordBLL.SelectCount(h);
            r["data"] = HandleSelectSord(SordBLL.Select(h));
            return JSONSerializer.Serialize(r);
        }
        object HandleSelectSord(SORD s, IList<STTCFG> STTCFGs)
        {
            DateTime today = DateTime.Now.Date;
            STTCFG NEXTSTTCFG = STTCFGs.FirstOrDefault(sc => int.Parse(sc.NODDTSTT) > int.Parse(s.STT));
            IList<TASKDEAL> C_SORDTRACKs = SordBLL.SelectTrack(s.ORDNO);
            return new
            {
                ORDNO = s.ORDNO,
                SUBDT = s.SUBDT,
                ISTODAY = s.SUBDT.Date == today,
                SUBDTXT = DateTimeConvert.DateToString(s.SUBDT),
                SUBCUS = s.SUBCUS,
                SUBCUSNAME = s.SUBCUSNAME,
                SUBMANINF = s.SUBMANINF,
                SUBMAN = s.SUBMAN,
                SUBMANNAME = s.SUBMANNAME,
                SUBMANMOVTEL = s.SUBMANMOVTEL,
                SUBMANPIC = s.SUBMANPIC,
                SUBTXT = s.SUBTXT,
                USRIMG = s.USRIMG,
                SERSYS=s.SERSYS,
                USRNUM=s.USRNUM,
                USRPASS=s.USRPASS,
                PRCMAN = s.PRCMAN,
                ISSYS = GetCurUser().ISSYS,
                PRCDT = DateTimeConvert.DateToString(s.PRCDT),
                PRCMANNAME = s.PRCMANNAME,
                PRCMANPIC = s.PRCMANPIC,
                PRCMTHRSTL = s.PRCMTHRSTL ?? "",
                ECTIME = s.ECTIME,
                ECDT = s.PRCDT.AddHours(s.ECTIME),
                ECDTXT = DateTimeConvert.DateToString(s.PRCDT.AddHours(s.ECTIME)),
                SERTYP = s.SERTYP,
                SERTYPNAME = s.SERTYPNAME,
                IPADR = s.IPADR,
                STT = s.STT,
                TracerStt=s.TracerStt,
                Tracer=s.Tracer,
                RevisitStt=s.RevisitStt,
                Revisit=s.Revisit,
                RevisitTxt=s.RevisitTxt,
                STTNAME = s.STTNAME,
                NEXTSTT = NEXTSTTCFG == null ? "" : NEXTSTTCFG.NODDTSTT,
                NEXTSTTNAME = NEXTSTTCFG == null ? "" : NEXTSTTCFG.NODNAME,
                VERSION = s.VERSION,
                LASTREPLYINF = s.LASTREPLYINF,
                LASTREPLYMAN = s.LASTREPLYMAN ?? "",
                LASTREPLYMANNAME = s.LASTREPLYMANNAME ?? "",
                LASTREPLYDT = s.LASTREPLYDT,
                LASTREPLYISTODAY = s.LASTREPLYDT.Date == today,
                LASTREPLYDTXT = DateTimeConvert.DateToString(s.LASTREPLYDT),
                SORDPROCESs = STTCFGs.Select(stt => new
                {
                    STT = stt.NODDTSTT,
                    STTNAME = stt.NODNAME,
                    ISHANDLE = double.Parse(s.STT) >= double.Parse(stt.NODDTSTT),
                    HANDLEDT = C_SORDTRACKs.LastOrDefault(c_s => c_s.NODID == stt.NODDTSTT) != null ? C_SORDTRACKs.LastOrDefault(c_s => c_s.NODID == stt.NODDTSTT).PRCDT : DateTime.MinValue,
                    HANDLEDTXT = C_SORDTRACKs.LastOrDefault(c_s => c_s.NODID == stt.NODDTSTT) != null ? DateTimeConvert.DateToString(C_SORDTRACKs.LastOrDefault(c_s => c_s.NODID == stt.NODDTSTT).PRCDT) : ""
                }),
                SORDTRACKs = C_SORDTRACKs.Select(track => new
                {
                    PRCDT = track.PRCDT,
                    PRCDTXT = DateTimeConvert.DateToString(track.PRCDT),
                    PRCR = track.PRCR,
                    PRCRNAME = track.PRCRNAME,
                    BRF = track.BRF
                }),
                SORDREVIEWs = SordBLL.SelectReview(s.ORDNO).Select(review => new
                {
                    APPRID = review.APPRID,
                    APPRTXT = review.APPRTXT,
                    APPRDT = review.APPRDT,
                    APPRDTXT = DateTimeConvert.DateToString(review.APPRDT),
                    DGR = review.DGR,
                    APPRNAME = s.SUBMANNAME,
                    APPRPIC = s.SUBMANPIC
                }),
                SORDREPLYs = SordBLL.SelectReply(s.ORDNO).Select(reply => new
                {
                    SUBDT = reply.SUBDT,
                    SUBMAN = reply.SUBMAN,
                    SUBMANNAME = reply.SUBMANNAME,
                    SUBMANPIC = reply.SUBMANPIC,
                    SUBTXT = reply.SUBTXT,
                    ISTODAY = reply.SUBDT.Date == today,
                    ISME = reply.SUBMAN == GetCurUser().USERID,
                    SUBDTXT = DateTimeConvert.DateToString(reply.SUBDT),
                })
            };
        }
        object HandleSelectSord(IList<SORD> SORDs)
        {
            Hashtable h = new Hashtable();
            h["NODTYP"] = "STT";
            h["ISUSE"] = "T";
            IList<STTCFG> STTCFGs = SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT).ToList();
            return SORDs.Select(s => HandleSelectSord(s, STTCFGs));
        }
        #endregion

        #region 添加派工单
        [PwrFilter("SORDEL", "insert")]
        public string InsertSord(string sord)
        {
            SORD SORD = JSONSerializer.Deserialize<SORD>(sord);
            SORD.SUBMAN = GetCurUser().USERID;
            SORD.SUBCUS = GetCurCus().CUSID;

            //更新联系电话
            USERS USER = UsersBLL.Select(GetCurUser().USERID, null, null, null, null, null);
            USER.MOVTEL = SORD.SUBMANMOVTEL;
            UsersBLL.Update(USER);
            Session["CurUser"] = USER;

            SordBLL.Insert(SORD);
            return JSONSerializer.Serialize(new WUCSMResult());
        }
        #endregion

        #region 修改派工单
        [PwrFilter(new string[] { "SORD", "update", "SORDEL", "update" })]
        public string UpdateSord(string sord)
        {
            SORD SOrd = JSONSerializer.Deserialize<SORD>(sord);
            WUCSMResult r = new WUCSMResult();
            if (GetCurUser().USERTYP == "01" && SOrd.STT == "90")
            {
                r["msg"] = "派工单[" + SOrd.ORDNO + "]需等待客户进行验收！";
            }
            else
            {
                //SordBLL.Update(SOrd);
                SordBLL.UpdateSord(SOrd);
            }
            return JSONSerializer.Serialize(r);
        }
        #endregion

        #region 跳转至下一个状态
        [PwrFilter("SORD", "movenstt")]
        public string MoveNextStt(string ordno, string stt, string fault)
        {
            WUCSMResult r = new WUCSMResult();
            SORD SORD = SordBLL.Select(ordno);
            SORD.FAULT = fault;
            if (SORD.STT == "90")
                r["msg"] = "派工单[" + SORD.ORDNO + "]已经结束，不能再进行状态跳转！";
            if (SORD.STT == "50")
                r["msg"] = "派工单[" + SORD.ORDNO + "]需等待客户进行验收！";
            else
            {
                SORD.STT = stt;
                SordBLL.Update(SORD);
            }
            return JSONSerializer.Serialize(r);
        }
        #endregion

        #region 受理派工单
        [PwrFilter("SORD", "startsd")]
        public string StartSord(string ordno, string users, string sdt, double ectime)
        {
            WUCSMResult r = new WUCSMResult();
            SORD SORD = SordBLL.Select(ordno);
            if (SORD.STT != "0")
                r["msg"] = "派工单[" + SORD.ORDNO + "]已被受理，操作失败！";
            else
            {
                SORD.STT = "30";
                SORD.PRCDT = DateTime.Parse(sdt);
                //SORD.PRCDT = Convert.ToDateTime(sdt);
                SORD.PRCMAN = users;
                SORD.ECTIME = ectime;
                SORD.ACCDT = DateTime.Now;
                SordBLL.Update(SORD);
                r["mes"] = "受理成功！";
            }
            return JSONSerializer.Serialize(r);
        }
        #endregion
        /// <summary>
        /// 获取客户经理名字
        /// </summary>
        /// <returns></returns>
        public string GetName()
        {
            //客户经理编号
            string usrId = Request.Params["UserID"];
            if (string.IsNullOrWhiteSpace(usrId))
                return "匿名";
            Hashtable h = new Hashtable();
            h["STT"] = "1";
            h["USERTYP"] = "01";
            IList<Models.USERS> uList = UsersBLL.Select(h);
            USERS obj = uList.FirstOrDefault(s => s.USERID == usrId);
            string name = string.Empty;
            if (obj != null)
                name = obj.USERNAME;
            return name;
        }

        #region 添加跟踪派工单人员
        [PwrFilter("SORD", "startsd")]
        public string TracerSord()
        {
            string ordno = Request.Params["ordno"];//订单号
            string TracerStt = string.IsNullOrWhiteSpace(Request.Params["TracerStt"])?"0":Request.Params["TracerStt"];//跟踪状态
            string name = Request.Params["Name"];//切换是否跟踪
            int isTracer = Convert.ToInt32(TracerStt);
            int tmpStt = isTracer == 0 ? 1 : 0;

            //得到当前登录信息
            string usrID = GetCurUser().USERID;
            Hashtable h = new Hashtable();
            h["STT"] = "1";
            h["USERTYP"] = "01";
            IList<Models.USERS> uList = UsersBLL.Select(h);
            WUCSMResult r = new WUCSMResult();
            SORD SORD = SordBLL.Select(ordno);
            if (string.IsNullOrWhiteSpace(SORD.PRCMAN))
            {
                r["msg"] = "派工单[" + SORD.ORDNO + "]还未被受理,请先督促！";
                return JSONSerializer.Serialize(r);
            }
            else if (SORD.TracerStt != 0 && name=="跟踪")
            {
                r["msg"] = "派工单[" + SORD.ORDNO + "]已被跟踪，操作失败！";
                return JSONSerializer.Serialize(r);
            }
            else
            {
                if (string.IsNullOrWhiteSpace(SORD.Tracer))//不存在则赋值，存在表示取消跟踪，则清空
                {
                    SORD.Tracer = usrID;
                }
                else {
                    SORD.Tracer = "";
                }
                SORD.TracerStt = tmpStt;
                SORD.ACCDT = DateTime.Now;
                SordBLL.Update(SORD);
                r["mes"] = "跟踪成功！";
            }
            return JSONSerializer.Serialize(r);
        }
        #endregion
        #region 添加回访派工单人员
        [PwrFilter("SORD", "startsd")]
        public string RevisitSord()
        {
            string ordno = Request.Params["ordno"];//订单号
            string Fault = Request.Params["Fault"];//回访内容
            //得到当前登录信息
            string usrID = GetCurUser().USERID;
            Hashtable h = new Hashtable();
            h["STT"] = "1";
            h["USERTYP"] = "01";
            IList<Models.USERS> uList = UsersBLL.Select(h);
            WUCSMResult r = new WUCSMResult();
            SORD SORD = SordBLL.Select(ordno);
            if (SORD.RevisitStt != 0)
                r["msg"] = "派工单[" + SORD.ORDNO + "]已被回访，操作失败！";
            else
            {
                SORD.Revisit = usrID;
                SORD.RevisitTxt = Fault;
                SORD.RevisitStt = 1;
                SORD.ACCDT = DateTime.Now;
                SordBLL.Update(SORD);
                r["mes"] = "回访成功！";
            }
            return JSONSerializer.Serialize(r);
        }
        #endregion


        #region 验收派工单
        [ValidateInput(false)]
        [PwrFilter("SORDEL", "endsd")]
        public string EndSord(string ordno, string apprtxt, string dgr)
        {
            WUCSMResult r = new WUCSMResult();
            SORD SORD = SordBLL.Select(ordno);
            if (SORD.STT != "50")
                r["msg"] = "派工单[" + SORD.ORDNO + "]还不能进行验收！";
            else
            {
                SORD.STT = "90";
                SordBLL.Update(SORD);
                ApprBLL.Insert(new APPR() { ORDNO = ordno, APPRTXT = apprtxt, DGR = dgr});
            }
            return JSONSerializer.Serialize(r);
        }
        #endregion

        #region 删除派工单
        [PwrFilter(new string[] { "SORD", "delete", "SORDEL", "delete" })]
        public string DeleteSord(string ordno)
        {

            WUCSMResult r = new WUCSMResult();
            SORD SORD = SordBLL.Select(ordno);
            if (SORD.STT != "0")
                r["msg"] = "派工单[" + SORD.ORDNO + "]已受理，不能删除！";
            else
                SordBLL.Delete(SordBLL.Select(ordno));
            return JSONSerializer.Serialize(r);
        }
        #endregion

        #region 作废派工单
        [PwrFilter(new string[] { "SORD", "update"})]
        public string EditSordStt(string ordno)
        {

            WUCSMResult r = new WUCSMResult();
            //获取当前作废的派工单信息
            SORD SORD = SordBLL.Select(ordno);
            if(SORD==null)
                r["msg"] = "派工单[" + SORD.ORDNO + "]未找到，无法作废！";
            //SORD SORD = SordBLL.Select(ordno);
            
            SORD.STT = "-1";//修改当前状态  -1 位作废状态
            
            SordBLL.Update(SORD);
            return JSONSerializer.Serialize(r);
        }
        #endregion

        #region 发表回复
        [ValidateInput(false)]
        [PwrFilter(new string[] { "SORD", "reply", "SORDEL", "reply" })]
        public string InsertReply(string ordno, string subtxt)
        {
            SordDtlBLL.Insert(new SORDDTL() { ORDNO = ordno, SUBMAN = GetCurUser().USERID, SUBTYP = GetCurUser().USERTYP, SUBTXT = subtxt });
            return JSONSerializer.Serialize(new WUCSMResult());
        }
        #endregion

        #region 发表评论
        [ValidateInput(false)]
        [PwrFilter("SORDEL", "review")]
        public string InsertReview(string ordno, string apprtxt, string dgr)
        {
            ApprBLL.Insert(new APPR() { ORDNO = ordno, APPRTXT = apprtxt, DGR = dgr });
            return JSONSerializer.Serialize(new WUCSMResult());
        }
        #endregion
   
    }
}
