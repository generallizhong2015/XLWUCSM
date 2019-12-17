using System.Collections;
using IBLL;
using WUCSM.Helpers;

namespace WUCSM.Areas.WUCSM.Controllers
{
    public class FastQueryController : BaseController
    {
        ICusBLL CusBLL { get; set; }
        IUsersBLL UsersBLL { get; set; }

        /// <summary>
        /// 快速检索客户
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public string QryCus(string key)
        {
            Hashtable h = new Hashtable();
            h["CUSNAME"] = key;
            return HandleResponseData(CusBLL.Select(h));
        }

        /// <summary>
        /// 快速检索系统用户
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public string QryAdminUser(string key)
        {
            Hashtable h = new Hashtable();
            h["USERNAME"] = key;
            h["USERTYP"] = "01";
            return HandleResponseData(UsersBLL.Select(h));
        }
    }
}
