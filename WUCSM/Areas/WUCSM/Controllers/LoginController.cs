using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WUCSM.Helpers;
using IBLL;
using Models;
using System.Web.Routing;
using System.Collections;
using System.Linq;

namespace WUCSM.Areas.WUCSM.Controllers
{
    /// <summary>
    /// 登录
    /// </summary>
    public class LoginController : BaseController
    {
        //
        // GET: /WUCSM/Login/
        IUsersBLL UsersBLL { get; set; }
        ICusBLL CusBLL { get; set; }
        IUserPwrBLL UserPwrBLL { get; set; }
        IMdlBLL MdlBLL { get; set; }

        public ActionResult Login()
        {
            if (GetCurUser() != null)
                return new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Sord", action = "Index" }));

            TempData["remember"] = "false";
            if (Request.Cookies["Info"] != null)
            {
                string userId = Convert.ToString(Request.Cookies["Info"].Values["userid"]);
                string password = Convert.ToString(Request.Cookies["Info"].Values["password"]);
                TempData["LOGID"] = HttpUtility.UrlDecode(userId);
                TempData["PWD"] = HttpUtility.UrlDecode(password);
                TempData["remember"] = "true";

            }

            return View();
        }


        
        public ActionResult GG()
        {
            return View();
        }

        /// <summary>
        /// 退出登录
        /// </summary>
        /// <returns></returns>
        public ActionResult OutLogin()
        {
            Session.RemoveAll();
            return new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Login", action = "Login" }));
        }
        public string UserLogin()
        {
            WUCSMResult r = new WUCSMResult();
            string Users = Request.Params["Users"];
            string remember = Request.Params["remember"];
            string useridvalue = string.Empty;
            if (String.IsNullOrEmpty(Users))
            {
                r["msg"] = "参数错误!";
                return JSONSerializer.Serialize(r);
            }



            USERS users = JSONSerializer.Deserialize<USERS>(Users);

            USERS wUsers = null;
            USERS wUsers_LOGID = UsersBLL.Select("", users.LOGID.Trim(), "", "", "", "");
            USERS wUsers_MOVTEL = UsersBLL.Select("", "", "", "", users.LOGID, "");
            USERS wUsers_EMAIL = UsersBLL.Select("", "", "", "", "", users.LOGID);
            if (wUsers_LOGID == null && wUsers_MOVTEL == null && wUsers_EMAIL == null)
            {
                r["msg"] = "登录账号不存在！请检查或联系管理员";
            }
            else
            {

                if (wUsers_LOGID != null)
                {
                    wUsers = wUsers_LOGID;
                    useridvalue = wUsers_LOGID.LOGID;
                }
                else if (wUsers_MOVTEL != null)
                {
                    wUsers = wUsers_MOVTEL;
                    useridvalue = wUsers_MOVTEL.MOVTEL;
                }
                else if (wUsers_EMAIL != null)
                {
                    wUsers = wUsers_EMAIL;
                    useridvalue = wUsers_EMAIL.EMAIL;
                }
              
            }
            if (wUsers != null)
            {
                if (wUsers.PWD != users.PWD) r["msg"] = "密码不正确!";
                else if (wUsers.STT != "1") r["msg"] = "该登录账号未授权或已停用，请联系管理员!";
                else
                {
                    if (wUsers.USERTYP == "02")
                    {
                        CUS wcus = CusBLL.Select(wUsers.CUSID);
                        Session["CurCus"] = wcus;
                    }
                    Session["CurUser"] = wUsers;
                    var a = new KeyValuePair<string, string>("", "");
                    Hashtable h = new Hashtable();
                    h["USERID"] = wUsers.USERID;
                    IList<USERPWR> USERPWRs = UserPwrBLL.Select(h);
                    Session["CurUserPwr"] = USERPWRs;
                    Session["CurMdl"] =
                        MdlBLL.Select(new Hashtable())
                            .Where(m => m.ISSTP == "F" && USERPWRs.Count(u => u.MDLID == m.MDLID && u.PWRID == "open") > 0)
                            .OrderBy(m => m.SEQNO)
                            .ToList();
                    NameValueCollection ReferrerQueryString = Request.UrlReferrer == null
                        ? new NameValueCollection()
                        : GetQueryString(Request.UrlReferrer.Query);
                    if (string.IsNullOrEmpty(ReferrerQueryString["FromUrl"]))
                        r["url"] = Url.RouteUrl(new { controller = "Sord", action = "Index", area = "WUCSM" });
                    else r["url"] = ReferrerQueryString["FromUrl"];
                    r["userid"] = GetCurUser().USERID;

                    HttpCookie cookie = new HttpCookie("Info"); //定义cookie对象以及名为Info的项
                    if (remember == "true")
                    {

                        DateTime dt = DateTime.Now; //定义时间对象
                        TimeSpan ts = new TimeSpan(1, 0, 0, 0); //cookie有效作用时间1天
                        cookie.Expires = dt.Add(ts); //添加作用时间
                        cookie.Values.Add("userid", HttpUtility.UrlEncode(useridvalue)); //增加属性
                        cookie.Values.Add("password", wUsers.PWD);
                        cookie.Values.Add("remember", "true");
                        Response.AppendCookie(cookie); //确定写入cookie中 
                    }
                    else
                    {
                        DateTime dt = DateTime.Now; //定义时间对象
                        TimeSpan ts = new TimeSpan(-1, 0, 0, 0);
                        cookie.Expires = dt.Add(ts); //添加作用时间
                        Response.AppendCookie(cookie); //确定写入cookie中 
                    }

                }
            }
            return JSONSerializer.Serialize(r);
        }


        public ActionResult RetrievePassword()
        {
            return View();
        }

        /// <summary>
        /// 提交到邮箱找回密码
        /// </summary>
        /// <returns></returns>
        public string EmailRetrievePassword(string useremail, string ValidateCode)
        {
            WUCSMResult r = new WUCSMResult();
            MD5 md5 = new MD5();
            if (String.IsNullOrEmpty(useremail))
            {
                r["msg"] = "参数错误!";
                return JSONSerializer.Serialize(r);
            }
            if (Session["CheckCode"] != null && ValidateCode.ToLower() != Session["CheckCode"].ToString().ToLower())
            {
                r["msg"] = "验证码错误!";
                return JSONSerializer.Serialize(r);
            }

            Hashtable h = new Hashtable();
            h["EMAIL"] = useremail;
            IList<USERS> users = UsersBLL.Select(h);
            if (users.Count == 0)
            {
                r["msg"] = "邮箱地址错误,请重新输入!";
                return JSONSerializer.Serialize(r);
            }
            string Code = md5.EnCode(users.ToList()[0].LOGID + "," + DateTime.Now.ToLongTimeString());
            string PwdUrl = Request.Url.AbsoluteUri.Replace(Request.Url.AbsolutePath, "") + "/Login/CodeRetrievePassword?Code=" + Url.Encode(Code);
            string PwdStr = "请点击链接找回密码：<br/><a href=\"" + PwdUrl + "\">点击找回密码</a><br>如果上述文字点击无效，请把下面网页地址复制到浏览器地址栏中打开：<br/><a href=\"" + PwdUrl + "\">" + PwdUrl + "</a><br/>如果您没有申请密码找回，请忽略此邮件。";
            r["msg"] = new SendMailHelper().Send("jamprfee@sina.com", "西联软件技术有限公司", useremail, "西联客户服务系统密码找回", PwdStr, "jamprfee", "fx120414", "smtp.sina.com", "");
            //记录找回码
            if (r["msg"].ToString() == "OK")
            {
                users.ToList()[0].FNDPWDVLD = Code;
                UsersBLL.Update(users.ToList()[0]);
            }
            return JSONSerializer.Serialize(r);
        }

        public ActionResult CodeRetrievePassword(string Code)
        {
            WUCSMResult r = new WUCSMResult();
            MD5 md5 = new MD5();
            string[] Codes = md5.EeCode(Code).Split(',');
            USERS wUsers = UsersBLL.Select("", Codes[0], "", "", "", "");
            if (DateTime.Parse(Codes[1]).AddHours(2) < DateTime.Now || wUsers == null || wUsers.FNDPWDVLD != Code)
            {
                Response.Write("<script>alert('链接已失效!');</script>");
            }
            return View();
        }
        public string PwrSvc(string Code, string NewPwr)
        {
            WUCSMResult r = new WUCSMResult();
            MD5 md5 = new MD5();
            string[] Codes = md5.EeCode(Code).Split(',');
            USERS wUsers = UsersBLL.Select("", Codes[0], "", "", "", "");
            if (DateTime.Parse(Codes[1]).AddHours(2) < DateTime.Now || wUsers == null || wUsers.FNDPWDVLD != Code)
            {
                r["msg"] = "操作无效!";
                return JSONSerializer.Serialize(r);
            }
            wUsers.PWD = NewPwr;
            wUsers.FNDPWDVLD = null;
            UsersBLL.Update(wUsers);
            r["url"] = Url.RouteUrl(new { controller = "Login", action = "Login", area = "WUCSM" });
            return JSONSerializer.Serialize(r);
        }
    }
}
