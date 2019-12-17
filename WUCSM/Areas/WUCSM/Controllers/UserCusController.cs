using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WUCSM.Helpers;
using IBLL;
using System.Collections;
using Models;

namespace WUCSM.Areas.WUCSM.Controllers
{
    public class UserCusController : BaseController
    {
        IUserCusBLL UserCusBLL { get; set; }
        IUsersBLL UsersBLL { get; set; }
        ICusBLL CusBLL { get; set; }
        Hashtable ht = null;

        [PwrFilter("USERCUS", "open")]
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public string InitTree(string username)
        {
            ht = new Hashtable();
            ht["USERTYP"] = "01";
            ht["STT"] = "1";
            ht["USERNAME"] = username;
            IList<USERS> Users = UsersBLL.Select(ht);
            Users.ToList().AsParallel().ForAll(u => u.PRTID = "01");
            Users.Insert(0, new USERS() { USERID = "01", USERNAME = "客服列表", PRTID = "" });
            return JSONSerializer.ToTreeJson<USERS>(Users, "USERID", "USERNAME", "PRTID");
        }

        public string GetCuses(string USERID, string CUSNAME)
        {
            ht = PageData();
            ht["CUSNAME"] = CUSNAME;
            ht["USERID"] = USERID;
            ht["STT"] = "T";
            IList<CUS> Cuses = CusBLL.Select(ht);
            return JSONSerializer.ToGridJson<CUS>(Cuses, recordcount: CusBLL.Select_RecordCount(ht));
        }

        public string GetUserCuses(string USERID)
        {
            ht = PageData();
            ht["USERID"] = USERID;
            IList<USERCUS> UserCuses = UserCusBLL.Select(ht);
            return JSONSerializer.ToGridJson<USERCUS>(UserCuses, recordcount: UserCusBLL.Select_RecordCount(ht));
        }

        [HttpPost]
        [PwrFilter("USERCUS", "insert")]
        public string SaveSvc()
        {
            IList<CUS> Cuses = GetCusObj();
            string uId = Request.Params["USERID"];
            List<USERCUS> uCus = new List<USERCUS>();
            foreach (CUS Cus in Cuses) uCus.Add(new USERCUS() { CUSID = Cus.CUSID, USERID = uId });
            UserCusBLL.Insert(uCus);
            return "保存成功!";
        }

        [PwrFilter("USERCUS", "delete")]
        public string DelSvc()
        {
            IList<USERCUS> uCus = JSONSerializer.Deserialize<IList<USERCUS>>(Request.Params["data"]);
            UserCusBLL.Delete(uCus);
            return "删除成功!";
        }

        private IList<CUS> GetCusObj()
        {
            return JSONSerializer.Deserialize<List<CUS>>(Request.Params["data"]);
        }

    }
}
