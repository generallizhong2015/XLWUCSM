using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WUCSM.Helpers;
using IBLL;
using Models;
using System.Data;
using System.Text;

namespace WUCSM.Areas.WUCSM.Controllers
{
  
    /// <summary>
    /// 注册
    /// </summary>
    public class RegController : BaseController
    {
        public static string CUSID = string.Empty;
        public static string CUSORGID = string.Empty;
        //
        // GET: /WUCSM/Reg/
        IUsersBLL UsersBLL { get; set; }
        ICusBLL CusBLL { get; set; }
        ICusOrgBLL CusorgBLL { get; set; }
        

        public ActionResult Index()
        {
            return View();
        }
        public string CheckLOGID(string CUSIDANDCUSORGID, string LOGID, string MOVTEL, string EMAIL, string ValidateCode)
        {
            WUCSMResult r = new WUCSMResult();
            if (Session["CheckCode"] != null && ValidateCode.ToLower() != Session["CheckCode"].ToString().ToLower())
            {
                r["msg"] = "验证码错误!";
                return JSONSerializer.Serialize(r);
            }
            if (CUSIDANDCUSORGID.Length < 8)
            {
                r["msg"] = "邀请码长度错误，请联系管理员!";
                r["state"] = "-1";
                return JSONSerializer.Serialize(r);
            }
            string b_CUSID = CUSIDANDCUSORGID.Substring(0, 8);
            string a_CUSORGID = CUSIDANDCUSORGID.Substring(8, CUSIDANDCUSORGID.Length - 8);
            CUS wcus = CusBLL.Select(b_CUSID);
            CUSORG wcusorg = CusorgBLL.Select(b_CUSID, a_CUSORGID);
            //if (wcus == null || wcusorg == null)
            if (wcus == null)
            {
                r["msg"] = "邀请码错误，请联系管理员!";
                r["state"] = "-1";
                return JSONSerializer.Serialize(r);
            }
            if (String.IsNullOrEmpty(LOGID))
            {
                r["msg"] = "登录账号参数错误!";
                return JSONSerializer.Serialize(r);
            }

            USERS wUsers_LOGID = UsersBLL.Select("", LOGID, "", "", "", "");
            USERS wUsers_MOVTEL = UsersBLL.Select("", "", "", "", MOVTEL, "");
            USERS wUsers_EMAIL = UsersBLL.Select("", "", "", "", "", EMAIL);

            if (wUsers_LOGID != null)
            {
                r["msg"] = "登录账号已被注册,请重新填写!";
                r["state"] = "-2";
            }
            else if (wUsers_MOVTEL != null)
            {
                r["msg"] = "联系电话已被注册,请重新填写!";
                r["state"] = "-3";
            }
            else if (wUsers_EMAIL != null)
            {
                r["msg"] = "电子邮箱已被注册,请重新填写!";
                r["state"] = "-4";
            }
            CUSID = b_CUSID;
            CUSORGID = a_CUSORGID;
            return JSONSerializer.Serialize(r);
        }


        public string Reg()
        {
            WUCSMResult r = new WUCSMResult();
            string Reg = Request.Params["Reg"];
            if (String.IsNullOrEmpty(Reg))
            {
                r["msg"] = "参数错误!";
                return JSONSerializer.Serialize(r);
            }

            USERS users = JSONSerializer.Deserialize<USERS>(Reg);
            USERS users_cus = UsersBLL.Select("", "", "02", CUSID, "", "");
            string userid = UsersBLL.SetUserid();
            users.USERID = userid;
            users.LOGID = users.LOGID.Trim();
            users.CUSID = CUSID;
            users.CUSORGID = CUSORGID;
            users.USERTYP = "02";
            users.STT = "1";
            if (users_cus == null)
            {
                users.ISSYS = "T";
            }
            else
            {
                users.ISSYS = "F";
            }
           
            UsersBLL.Insert(users);
            //r["url"] = Url.RouteUrl(new { controller = "Login", action = "Login", area = "WUCSM" });

            //给权限
            //UsersBLL.SetUserPwr(users.USERTYP, userid, users.ISSYS);
            return JSONSerializer.Serialize(r);
        }
      

    }
}
