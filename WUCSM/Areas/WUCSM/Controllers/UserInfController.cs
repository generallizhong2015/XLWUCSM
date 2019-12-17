using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WUCSM.Helpers;
using Models;
using IBLL;
using System.Collections;
using System.Web.UI;
using System.Globalization;

namespace WUCSM.Areas.WUCSM.Controllers
{
    public class UserInfController : BaseController
    {
        ISttCfgBLL SttCfgBLL { get; set; }
        ICusBLL CusBLL { get; set; }
        IUsersBLL UsersBLL { get; set; }

        [PwrFilter(new string[] { "USERINF", "open", "USERINEL", "open" })]
        public ActionResult Index()
        {
            Hashtable h = new Hashtable();
            h["NODTYP"] = "DPT";

            ViewData["DPT"] = JSONSerializer.Serialize(SttCfgBLL.Select(h).OrderBy(s => s.NODDTSTT));
            
            USERS u = GetCurUser();
            ViewData["USERINF"] = JSONSerializer.Serialize(u);
            return View();
        }

        [PwrFilter(new string[] { "USERINF", "update", "USERINEL", "update" })]
        public string SaveSvc(string data)
        {
            USERS u1 = JSONSerializer.Deserialize<USERS>(data);
            USERS u2 = UsersBLL.Select(u1.USERID, "", "", "", "", "");
            u1.CUSID = u2.CUSID;
            u1.CHKVU = u2.CHKVU;
            u1.CUSORGID = u2.CUSORGID;
            u1.FNDPWDVLD = u2.FNDPWDVLD;
            u1.PIC = u2.PIC;
            u1.PWD = u2.PWD;
            u1.USERTYP = u2.USERTYP;
            UsersBLL.Update(u1);
            Session["CurUser"] = u1;
            return "保存成功!";
        }

        [PwrFilter(new string[] { "USERINF", "upload", "USERINEL", "upload" })]
        public string UpLoad()
        {
            string tempFile = Request.PhysicalApplicationPath;
            HttpPostedFileBase uploadFile = Request.Files["Fdata"];
            if (uploadFile.ContentLength > 0)
            {
                string ofileName = uploadFile.FileName;
                string fileExt = ofileName.Substring(ofileName.LastIndexOf("."));
                string nfileName = DateTime.Now.ToString("yyyyMMddHHmmss_ffff", DateTimeFormatInfo.InvariantInfo) + fileExt;
                uploadFile.SaveAs(string.Format("{0}{1}{2}", tempFile, "\\Attachments\\uimage\\", nfileName));
                USERS u = GetCurUser();
                u.CUSORGID = "";
                u.PIC = string.Format("{0}{1}", "\\Attachments\\uimage\\", nfileName);
                UsersBLL.Update(u);
                return u.PIC;
            }
            return "";
        }

        [PwrFilter(new string[] { "USERINF", "update", "USERINEL", "update" })]
        public string PwrSvc()
        {
            string sMeg = "";
            string oldPwr = Request.Params["OLDPWR"];
            string newPwr = Request.Params["NEWPWR"];
            USERS u = GetCurUser();
            if (oldPwr != u.PWD) sMeg = "原始密码输入错误!";
            else
            {
                u.PWD = newPwr;
                UsersBLL.Update(u);
                sMeg = "修改成功!";
                Session["CurUser"] = u;
            }
            return sMeg;
        }
    }
}
