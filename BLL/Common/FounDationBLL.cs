using System.Web;
using Models;
using System.Reflection;
using System;
using IBLL.Common;

namespace BLL.Common
{
    public class FounDationBLL : IFounDationBLL
    {
        /// <summary>
        /// 对比VERSION(新对象VERSION自动+1)
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="OldObject">旧对象</param>
        /// <param name="NewObject">新对象</param>
        public void ContrastVersion<T>(T OldObject, T NewObject)
        {
            bool IsSame = false;
            PropertyInfo OldObject_PropertyInfo = OldObject.GetType().GetProperty("VERSION");
            PropertyInfo NewObject_PropertyInfo = NewObject.GetType().GetProperty("VERSION");
            if (OldObject_PropertyInfo != null && NewObject_PropertyInfo != null)
            {
                object Old_Version = OldObject_PropertyInfo.GetValue(OldObject, null);
                object New_Version = NewObject_PropertyInfo.GetValue(NewObject, null);
                if (Old_Version.Equals(New_Version))
                {
                    IsSame = true;
                    NewObject_PropertyInfo.SetValue(NewObject, Convert.ToInt32(New_Version) + 1, null);
                }
            }
            if (!IsSame) throw new Exception("数据已被其他用户修改，请重新载入数据再试！");
        }

        /// <summary>
        /// 获取当前登录用户
        /// </summary>
        /// <returns></returns>
        public USERS GetCurUser()
        {
            if (HttpContext.Current.Session == null) return null;
            return HttpContext.Current.Session["CurUser"] as USERS;
        }

        /// <summary>
        /// 获取当前登录客户
        /// </summary>
        /// <returns></returns>
        public CUS GetCurCus()
        {
            if (HttpContext.Current.Session == null) return null;
            return HttpContext.Current.Session["CurCus"] as CUS;
        }
    }
}
