using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Reflection;
using System.Web.Mvc;
using Models;

namespace WUCSM.Helpers
{
    public class BaseController : Controller
    {
        #region 构造
        public BaseController()
        {

        }
        #endregion

        #region 重写
        protected override void OnException(ExceptionContext filterContext)
        {
            base.OnException(filterContext);

            if (!Request.IsAjaxRequest())
            {
                TempData["EMessage"] = "出错啦，请求的页面错误！";
                Response.Redirect(Url.RouteUrl(new { controller = "Error", action = "Index", area = "WUCSM" }), true);
            }
            else
            {
                WUCSMResult r = new WUCSMResult();
                r["msg"] = "操作失败,系统异常！";
                Response.Write(JSONSerializer.Serialize(r));
                Response.End();
            }
        }
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            filterContext.HttpContext.Session.Timeout = 30;
            base.OnActionExecuting(filterContext);
        }
        #endregion

        #region 公共方法
        #region Url
        /// <summary>
        /// 从路径中解析出QueryString
        /// </summary>
        /// <param name="Url"></param>
        /// <returns></returns>
        public NameValueCollection GetQueryString(string Url)
        {
            NameValueCollection QueryString = new NameValueCollection();
            if (!string.IsNullOrEmpty(Url))
            {
                int idx = Url.IndexOf("?");
                if (idx >= 0) Url = Url.Substring(idx + 1);
                string key = null;
                foreach (string item in Url.Split('='))
                {
                    if (key == null) key = item;
                    else
                    {
                        QueryString.Add(key, Server.UrlDecode(item));
                        key = null;
                    }
                }
            }
            return QueryString;
        }
        #endregion

        #region 获取当前登录用户信息
        /// <summary>
        /// 获取当前登录用户
        /// </summary>
        /// <returns></returns>
        public USERS GetCurUser()
        {
            return Session["CurUser"] as USERS;
        }

        /// <summary>
        /// 获取当前登录客户
        /// </summary>
        /// <returns></returns>
        public CUS GetCurCus()
        {
            return Session["CurCus"] as CUS;
        }

        /// <summary>
        /// 获取当前登录用户权限
        /// </summary>
        /// <returns></returns>
        public IList<USERPWR> GetCurUserPwr()
        {
            return Session["CurUserPwr"] as IList<USERPWR>;
        }
        #endregion

        #region 处理数据(分页、排序)
        /// <summary>
        /// 处理数据(分页、排序)
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="list"></param>
        /// <returns></returns>
        public IList<T> HandleData<T>(IList<T> list)
        {
            //查询条件
            //string key = Request["key"];
            //字段排序
            string sortField = Request["sortField"];
            string sortOrder = Request["sortOrder"];
            if (!string.IsNullOrEmpty(sortField) && !string.IsNullOrEmpty(sortOrder))
            {
                PropertyInfo propertyInfo = typeof(T).GetProperty(sortField);
                if (sortOrder == "asc") list = list.OrderBy(l => propertyInfo.GetValue(l, null)).ToList();
                if (sortOrder == "desc") list = list.OrderByDescending(l => propertyInfo.GetValue(l, null)).ToList();
            }
            //分页
            string pageIndex = Request["pageIndex"];
            string pageSize = Request["pageSize"];
            if (!string.IsNullOrEmpty(pageIndex) && !string.IsNullOrEmpty(pageSize))
                list = list.Skip(Convert.ToInt32(pageIndex) * Convert.ToInt32(pageSize)).Take(Convert.ToInt32(pageSize)).ToList();
            return list;
        }
        #endregion

        #region 前台返回分页，排序Hashtable
        public Hashtable PageData()
        {
            Hashtable pgHt = new Hashtable();
            string sortField = Request["sortField"];
            string sortOrder = Request["sortOrder"];
            int pageIndex = int.Parse(Request["pageIndex"]);
            pageIndex = pageIndex + 1;
            int pageSize = int.Parse(Request["pageSize"]);
            int begin = pageIndex > 1 ? pageSize * (pageIndex - 1) : 0;
            pgHt["BEGIN"] = begin;
            pgHt["PAGESIZE"] = pageSize;
            pgHt["SORTFIELD"] = sortField;
            pgHt["SORTORDER"] = sortOrder;
            return pgHt;
        }
        #endregion

        #region 处理前台返回数据
        /// <summary>
        /// 处理前台返回数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="list"></param>
        /// <param name="Method">自定义处理事件</param>
        /// <returns></returns>
        public string HandleResponseData<T>(IList<T> list, HandleResponseDataHandler Method = null)
        {
            WUCSMResult r = new WUCSMResult();
            r["total"] = list.Count;
            r["data"] = HandleData(list);
            if (Method != null) Method.DynamicInvoke(r);
            return JSONSerializer.Serialize(r);
        }

        public delegate void HandleResponseDataHandler(WUCSMResult r);
        #endregion

        #region 获取客户端IP
        /// <summary>
        /// 获取客户端IP
        /// </summary>
        /// <returns></returns>
        public string GetIP()
        {
            if (Request.ServerVariables["HTTP_VIA"] != null)
                return Request.ServerVariables["HTTP_X_FORWARDED_FOR"].Split(new char[] { ',' })[0];
            else
                return Request.ServerVariables["REMOTE_ADDR"];
        }
        #endregion
        #endregion
    }
}