using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Collections;
using IBLL;
using Models;
using WUCSM.Helpers;
using System.Globalization;
using System.Data.OleDb;
using System.Data;
using System.IO;

namespace WUCSM.Areas.WUCSM.Controllers
{
    public class CusController : BaseController
    {
        ICusBLL CusBLL { get; set; }
        ICusOrgBLL CusOrgBLL { get; set; }
        IUsersBLL UsersBLL { get; set; }
        Hashtable ht = new Hashtable();
        string sMeg = "";

        [PwrFilter("CUS", "open")]
        public ActionResult Index()
        {
            return View();
        }

        #region 取得客户列表
        [HttpPost]
        public string GetCuses()
        {
            ht = PageData();
            ht["STT"] = Request.Params["STT"];
            ht["LNKR"] = Request.Params["LNKR"];
            ht["TEL"] = Request.Params["TEL"];
            ht["DISDATE"] = Request.Params["DISDATE"];
            ht["CUSNAME"] = Request.Params["CUSNAME"];
            IList<CUS> Cuses = CusBLL.Select(ht);
            return JSONSerializer.ToGridJson<CUS>(Cuses, recordcount: CusBLL.Select_RecordCount(ht));
        }
        #endregion

        #region 取得单条数据
        public string GetCus(string CUSID)
        {
            return JSONSerializer.Serialize(CusBLL.Select(CUSID)); ;
        }
        #endregion

        [PwrFilter("CUS", "update")]
        #region 保存客户资料
        public string SaveSvc()
        {
            CUS Cus = GetBackCus();
            if (Cus.CUSID == "默认")
            {
                Cus.CUSID = CusBLL.GetMaxCusId(Cus.PREFIX.ToUpper().Trim());
                Cus.UPTR = GetCurUser().USERID;
                if (CusBLL.Select(Cus.CUSID) != null) throw new Exception("客户号："+Cus.CUSID+"已被占用!");
                CusBLL.Insert(Cus);
            }
            else if (Cus.CUSID != "默认" && (!String.IsNullOrEmpty(Cus.CUSID)))
            {
                CusBLL.Update(Cus);
            }
            return JSONSerializer.Serialize(Cus);
        }
        #endregion

        #region 启用停用客户
        public string CusAdj(string CUSID)
        {
            CUS Cus = CusBLL.Select(CUSID);
            Cus.STT = Cus.STT == "T" ? "F" : "T";
            CusBLL.Update(Cus);
            return JSONSerializer.Serialize(Cus);
        }
        #endregion

        #region 取得前台传回对象
        private CUS GetBackCus()
        {
            return JSONSerializer.Deserialize<CUS>(Request.Params["data"]);
        }

        private CUSORG GetBackCusOrg()
        {
            return JSONSerializer.Deserialize<CUSORG>(Request.Params["data"]);
        }
        #endregion

        #region 取得客户门店
        public string GetCusOrgs(string CUSID)
        {
            ht.Add("CUSID", CUSID);
            IList<CUSORG> CUSORGs = new List<CUSORG>();
            if (!String.IsNullOrEmpty(CUSID)) CUSORGs = CusOrgBLL.Select(ht);
            return JSONSerializer.ToGridJson<CUSORG>(CUSORGs);
        }
        #endregion

        #region 取得门店资料
        public string GetCusOrg(string CUSID, string CUSORGID)
        {
            CUSORG CusOrg = new CUSORG();
            if ((!String.IsNullOrEmpty(CUSID)) && (!String.IsNullOrEmpty(CUSORGID)))
                CusOrg = CusOrgBLL.Select(CUSID, CUSORGID);
            return JSONSerializer.Serialize(CusOrg);
        }
        #endregion

        [PwrFilter("CUS", "update")]
        #region 保存门店资料
        public string SaveCusOrg()
        {
            CUSORG CusOrg = GetBackCusOrg();
            if (!String.IsNullOrEmpty(CusOrg.CUSID) && CusOrg.CUSORGID == "默认" && CusOrg.CUSID != "默认")
            {
                CusOrg.CUSORGID = CusOrgBLL.GetMaxCusOrgId(CusOrg.CUSID);
                CusOrgBLL.Insert(CusOrg);
            }
            else if (CusOrg.CUSORGID != "默认" && (!String.IsNullOrEmpty(CusOrg.CUSID)))
            {
                CusOrgBLL.Update(CusOrg);
            }
            return JSONSerializer.Serialize(CusOrg);
        }
        #endregion

        #region 启用停用门店
        public string CusOrgAdj(string CUSID, string CUSORGID)
        {
            CUSORG CusOrg = CusOrgBLL.Select(CUSID, CUSORGID);
            CusOrg.STT = CusOrg.STT == "T" ? "F" : "T";
            CusOrgBLL.Update(CusOrg);
            return JSONSerializer.Serialize(CusOrg);
        }
        #endregion

        #region 导入资料
        public string UpLoad()
        {
            string tempFile = Request.PhysicalApplicationPath;
            HttpPostedFileBase uploadFile = Request.Files["Fdata"];
            if (uploadFile.ContentLength > 0)
            {
                string ofileName = uploadFile.FileName;
                string fileExt = ofileName.Substring(ofileName.LastIndexOf("."));
                string nfileName = DateTime.Now.ToString("yyyyMMddHHmmss_ffff", DateTimeFormatInfo.InvariantInfo) + fileExt;
                string path = string.Format("{0}{1}{2}", tempFile, "\\Attachments\\uimage\\", nfileName);
                uploadFile.SaveAs(path);
                readExcel(path);
            }
            return sMeg;
        }

        private void readExcel(string fileName)
        {
            string source = "Provider=Microsoft.Ace.OLEDB.12.0;Data Source='" + fileName + "';Extended Properties='Excel 12.0;HDR=yes;IMEX=1'";
            OleDbConnection conn = new OleDbConnection(source);
            string CMaxNo = "";
            string UMaxNo = "";
            try
            {
                conn.Open();
                string select = "SELECT * FROM [Sheet1$]";
                OleDbDataAdapter readCommand = new OleDbDataAdapter(select, conn);
                DataSet readData = new DataSet("Data");
                readCommand.Fill(readData);
                DataTable dt = readData.Tables[0];
                if (dt.Rows.Count == 0) { sMeg = "Excel文件没有行,请确认后再上传!"; return; }
                IList<CUS> Cuses = new List<CUS>();
                IList<USERS> Useres = new List<USERS>();
                foreach (DataRow dr in dt.Rows)
                {
                    CUS Cus = new CUS();
                    USERS User = new USERS();
                    foreach (DataColumn dc in dr.Table.Columns)//循环取得表的列
                    {
                        switch (dc.ColumnName.Trim())
                        {
                            case "客户名称": Cus.CUSNAME = dr[dc].ToString(); break;
                            case "联系人": Cus.LNKR = dr[dc].ToString(); break;
                            case "联系地址": Cus.ADR = dr[dc].ToString(); break;
                            case "联系电话": Cus.TEL = dr[dc].ToString(); break;
                            case "邮箱": Cus.EMAIL = dr[dc].ToString(); break;
                            case "服务截止日": Cus.DISDATE = DateTime.Now.Date; if (dr[dc] != null && dr[dc].ToString() != "") DateTime.Parse(dr[dc].ToString()); break;
                            case "登录号": User.LOGID = dr[dc].ToString(); break;
                            case "密码": User.PWD = dr[dc].ToString(); break;
                            default: break;
                        }
                    }
                    //客户资料
                    if (String.IsNullOrEmpty(CMaxNo)) CMaxNo = CusBLL.GetMaxCusId(Cus.PREFIX);
                    else CMaxNo = ((int.Parse(CMaxNo)) + 1).ToString().PadLeft(8, '0');
                    Cus.CUSID = CMaxNo;
                    Cus.UPTDTT = DateTime.Now;
                    Cus.UPTR = GetCurUser().CUSID;
                    Cus.STT = "T";
                    Cus.UPTR = GetCurUser().USERID;
                    Cuses.Add(Cus);
                    //用户资料
                    if (String.IsNullOrEmpty(UMaxNo)) UMaxNo = CusBLL.GetMaxCusId(Cus.PREFIX);
                    else UMaxNo = ((int.Parse(UMaxNo)) + 1).ToString().PadLeft(8, '0');
                    User.USERID = UMaxNo;
                    User.USERNAME = User.LOGID;
                    User.SEX = "M";
                    User.IDNO = "0";
                    User.OTEL = Cus.TEL;
                    User.ADR = Cus.ADR;
                    User.CUSID = Cus.CUSID;
                    User.ISSYS = "T";
                    User.USERTYP = "02";
                    User.STT = "1";
                    Useres.Add(User);
                }
                CusBLL.Insert(Cuses);
                UsersBLL.Insert(Useres);
            }
            catch (Exception ex)
            {
                if (String.IsNullOrEmpty(sMeg)) sMeg = ex.Message;
            }
            finally
            {
                conn.Close();
            }
        }
        #endregion
    }
}
