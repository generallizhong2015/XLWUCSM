using System.Collections;

namespace WUCSM.Helpers
{
    /// <summary>
    /// 数据处理回执类
    /// </summary>
    public class WUCSMResult : Hashtable
    {
        public WUCSMResult()
        {
            this["msg"] = "OK";
            this["url"] = "";
            this["state"] = "";
        }
    }
}