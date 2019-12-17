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
using System.Globalization;
using Common.Model;


namespace WUCSM.Areas.WUCSM.Controllers
{
    /// <summary>
    /// 成员管理
    /// </summary>
    public class UserGrpController : BaseController
    {
        //
        // GET: /WUCSM/UserGrp/

        IUsersBLL UsersBLL { get; set; }
        ICusBLL CusBLL { get; set; }
        ICusOrgBLL CusorgBLL { get; set; }
        IPwrBLL PwrBLL { get; set; }
        IMdlBLL MdlBLL { get; set; }
        IUserPwrBLL UserPwrBLL { get; set; }

        Hashtable ht = new Hashtable();
        public static string logid = string.Empty;
         [PwrFilter("USERGRP", "open")]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult UserPwr()
        {
            return View();
        }

        #region 获取用户资料
        public string GetUsers(string LOGID, string USERNAME, string STT, string SEX)
        {
            USERS u = GetCurUser();

            ht["LOGID"] = LOGID;
            ht["USERNAME"] = USERNAME;
            ht["CUSID"] = u.CUSID;
            ht["USERTYP"] = "02";
            ht["STT"] = STT;
            ht["SEX"] = SEX;
            return HandleResponseData(UsersBLL.SelectLike(ht));

        }
        #endregion

        #region 保存用户资料
        [PwrFilter("USERGRP", "update")]
        public string SaveSvc(string data)
        {
            WUCSMResult r = new WUCSMResult();
            USERS u1 = JSONSerializer.Deserialize<USERS>(data);
            if (u1.USERID == "")
            {
                USERS wUsers = UsersBLL.Select("", u1.LOGID, "", "", "", "");
                if (wUsers != null)
                {
                    r["msg"] = "登录账号已存在,请重新填写!";
                    return JSONSerializer.Serialize(r);
                }
                USERS u = GetCurUser();
                u1.CUSID = u.CUSID;
                u1.CUSORGID = u.CUSORGID;
                u1.USERID = UsersBLL.SetUserid();
                u1.PWD = "123456";
                UsersBLL.Insert(u1);
            }
            else
            {

                USERS u2 = UsersBLL.Select("", u1.LOGID, "", "", "", "");
                u1.CUSID = u2.CUSID;
                u1.LOGID = u2.LOGID;
                u1.CHKVU = u2.CHKVU;
                u1.CUSORGID = u2.CUSORGID;
                u1.FNDPWDVLD = u2.FNDPWDVLD;
                u1.PIC = u2.PIC;
                u1.PWD = u2.PWD;
                UsersBLL.Update(u1);
            }

            return JSONSerializer.Serialize(r);
        }
        #endregion

        #region 删除用户资料
        [PwrFilter("USERGRP", "delete")]
        public string DeleteUsers()
        {
            string deleted = Request.Params["deleted"];
            WUCSMResult r = new WUCSMResult();
            List<USERS> users = JSONSerializer.Deserialize<List<USERS>>(deleted);
            users.ToList().ForEach(u => UsersBLL.Delete(u));
            return JSONSerializer.Serialize(r);

        }
        #endregion

        #region 用户停用
        [PwrFilter("USERGRP", "userno")] 
        public string USERno()
        {
            string allusers = Request.Params["allusers"];
            WUCSMResult r = new WUCSMResult();
            List<USERS> users = JSONSerializer.Deserialize<List<USERS>>(allusers);
            users.ToList().ForEach(u => u.STT = "0");
            users.ToList().ForEach(u => UsersBLL.Update(u));
            return JSONSerializer.Serialize(r);

        }
        #endregion

        #region 用户激活
        [PwrFilter("USERGRP", "setuser")]
        public string SetUSER()
        {
            string allusers = Request.Params["allusers"];
            string stt = Request.Params["stt"];
            WUCSMResult r = new WUCSMResult();
            List<USERS> users = JSONSerializer.Deserialize<List<USERS>>(allusers);
            users.ToList().ForEach(u => u.STT = (stt == null ? "1" : stt));
            users.ToList().ForEach(u => UsersBLL.Update(u));
            return JSONSerializer.Serialize(r);

        }
        #endregion

        #region 重置密码
        [PwrFilter("USERGRP", "setpwd")]
        public string SetPWD()
        {
            string allusers = Request.Params["allusers"];
            WUCSMResult r = new WUCSMResult();
            List<USERS> users = JSONSerializer.Deserialize<List<USERS>>(allusers);

            users.ToList().ForEach(u => u.PWD = "123456");
            users.ToList().ForEach(u => UsersBLL.Update(u));
            return JSONSerializer.Serialize(r);

        }
        #endregion

        #region 取得单条数据
        public string GetUsersbyLogID(string LOGID)
        {
            logid = LOGID;
            USERS u = UsersBLL.Select("", LOGID, "", "", "", "");
            ViewData["USERINF"] = JSONSerializer.Serialize(u);
            return JSONSerializer.Serialize(u);
        }
        #endregion

        #region 上传
        [PwrFilter("USERGRP", "upload")]
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
                USERS u = UsersBLL.Select("", logid, "", "", "", "");
                u.CUSORGID = "";
                u.PIC = string.Format("{0}{1}", "\\Attachments\\uimage\\", nfileName);
                UsersBLL.Update(u);
                return u.PIC;
            }
            return "";
        }
        #endregion

        #region 获取权限树
        public ActionResult GetModuleListzTree(string userid, string usertyp)
        {
            if (usertyp == "02")
            {
                ht["MDLTYP"] = "02";
            }
            else
            {
                ht["MDLTYP"] = "01";
            }
            ht["ISSTP"] = "F";
            //获取系统可用模块  
            IOrderedEnumerable<MDL> SysModules = MdlBLL.Select(ht).OrderBy(s => s.SEQNO);

            var thisTreeList = SysModules.Select(sysZTree => new CommonModel.zTreeModel
            {

                id = sysZTree.MDLID,
                pId = string.IsNullOrEmpty(sysZTree.PRTID) ? "0" : sysZTree.PRTID,
                name = sysZTree.MDLNAME,
                @checked = ModIsChecked(userid, sysZTree.MDLID)//设置模块菜单是否勾选
            }).ToList();

            foreach (var item in SysModules)
            {
                string functall = item.FUNGRP;

                string strmodid = item.MDLID;
                string strwindowname = item.MDLNAME;

                if (!string.IsNullOrEmpty(functall))
                {
                    foreach (var itemSmall in functall.Split(','))
                    {
                        var smallTreeModel = new CommonModel.zTreeModel
                        {
                            id = strmodid + "|" + itemSmall,
                            pId = strmodid,
                            name = PwrBLL.Select(itemSmall).PWRNAME,
                            @checked = PurIsChecked(userid, strmodid, itemSmall)
                        };
                        thisTreeList.Add(smallTreeModel);
                    }
                }
            }

            var modelMain = new CommonModel.zTreeModel
            {
                id = "0",
                pId = "0",
                name = "【西联软件】客户服务事项管理系统",
                open = true,
                icon = "/Scripts/zTree/css/zTreeStyle/zTreeIcon/ztree-home.png",
                @checked = IsChecked(userid),
                haveSon = thisTreeList.Count > 0
            };
            thisTreeList.Add(modelMain);
            return Json(thisTreeList);
        }
        #endregion

        #region 判断权限树根节点，菜单节点，按钮节点是否被选中
        protected bool IsChecked(string userid)
        {
            bool isChecked = false;
            Hashtable ht = new Hashtable();
            ht["USERID"] = userid;
            IList<USERPWR> up = UserPwrBLL.Select(ht);
            if (up.Count > 0)
            {
                isChecked = true;
            }

            return isChecked;
        }

        protected bool ModIsChecked(string userid, string strmodid)
        {
            bool isChecked = false;
            Hashtable ht = new Hashtable();
            ht["USERID"] = userid;
            ht["MDLID"] = strmodid;
            IList<USERPWR> up = UserPwrBLL.Select(ht);
            if (up.Count > 0)
            {
                isChecked = true;
            }

            return isChecked;
        }

        protected bool PurIsChecked(string userid, string strmodid, string pwrid)
        {
            bool isChecked = false;
            Hashtable ht = new Hashtable();
            ht["USERID"] = userid;
            ht["MDLID"] = strmodid;
            ht["PWRID"] = pwrid;
            IList<USERPWR> up = UserPwrBLL.Select(ht);
            if (up.Count > 0)
            {
                isChecked = true;
            }

            return isChecked;
        }

        #endregion

        #region 保存权限
        //[PwrFilter("USERGRP", "savepwr")]
        public string SaveSvcTree()
        {
            WUCSMResult r = new WUCSMResult();
            String userid = Request.Params["userid"];
            String diytreeid = Request.Params["diytreeid"];

            Hashtable ht = new Hashtable();
            if (!string.IsNullOrEmpty(userid))
            {
                ht["USERID"] = userid;
                IList<USERPWR> userpwr = UserPwrBLL.Select(ht);
                userpwr.ToList().ForEach(u => UserPwrBLL.Delete(u));

                userpwr.Clear();
                if (!string.IsNullOrEmpty(diytreeid))
                {
                    string[] str_mdlidandpwrid = diytreeid.Split(',');
                    string mdlid = string.Empty;
                    string pwrid = string.Empty;

                    for (var i = 0; i < str_mdlidandpwrid.Length; i++)
                    {
                        string[] mdlidandpwrid = str_mdlidandpwrid[i].Split('|');
                        mdlid = mdlidandpwrid[0];
                        pwrid = mdlidandpwrid[1];

                        USERPWR up = new USERPWR();
                        up.USERID = userid;
                        up.MDLID = mdlid;
                        up.PWRID = pwrid;
                        userpwr.Add(up);
                    }

                    UserPwrBLL.Insert(userpwr);

                }

            }
            else
            {
                r["msg"] = "参数错误!";
                return JSONSerializer.Serialize(r);
            }
            return JSONSerializer.Serialize(r);

        }
        #endregion
    }
}
