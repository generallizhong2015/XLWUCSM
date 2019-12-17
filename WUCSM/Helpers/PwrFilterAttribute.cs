using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Models;

namespace WUCSM.Helpers
{
    /// <summary>
    /// 权限过滤器
    /// </summary>
    public class PwrFilterAttribute : FilterAttribute, IActionFilter
    {
        #region 构造
        List<USERPWR> mdlpwr = new List<USERPWR>();
        public PwrFilterAttribute()
        {

        }
        /// <summary>
        /// 单个权限
        /// </summary>
        /// <param name="mdlid">模块编号</param>
        /// <param name="pwrid">权限编号</param>
        public PwrFilterAttribute(string mdlid, string pwrid)
        {
            this.mdlpwr.Add(new USERPWR() { MDLID = mdlid, PWRID = pwrid });
        }
        /// <summary>
        /// 多个权限(满足一个即可)
        /// </summary>
        /// <param name="mdlpwr"></param>
        public PwrFilterAttribute(string[] mdlpwr)
        {
            for (int i = 0; i < mdlpwr.Length; i++)
                if (i % 2 == 1)
                    this.mdlpwr.Add(new USERPWR() { MDLID = mdlpwr[i - 1], PWRID = mdlpwr[i] });
        }
        #endregion

        #region 重写
        public void OnActionExecuted(ActionExecutedContext filterContext)
        {

        }

        public void OnActionExecuting(ActionExecutingContext filterContext)
        {
            UrlHelper url = new UrlHelper(filterContext.RequestContext);
            HttpRequestBase Request = filterContext.HttpContext.Request;
            HttpResponseBase Response = filterContext.HttpContext.Response;

            //过滤登录
            if (filterContext.HttpContext.Session["CurUser"] == null)
            {
                if (Request.IsAjaxRequest())
                {
                    WUCSMResult r = new WUCSMResult();
                    r["msg"] = "操作失败,用户未登录或登录已超时，请重新登录！";
                    filterContext.Result = new ContentResult() { Content = JSONSerializer.Serialize(r), ContentEncoding = Response.ContentEncoding, ContentType = Response.ContentType };
                    return;
                }
                string currentURL = url.Encode(url.RouteUrl(filterContext.RequestContext.RouteData.Values) + (Request.QueryString.Count > 0 ? "?" + Request.QueryString.ToString() : ""));
                filterContext.Result = new RedirectResult(url.RouteUrl(new RouteValueDictionary(new { controller = "Login", action = "Login" })) + "?FromUrl=" + currentURL);
                return;
            }
            //过滤权限
            if (mdlpwr.Count > 0)
            {
                IList<USERPWR> USERPWRs = filterContext.HttpContext.Session["CurUserPwr"] as IList<USERPWR>;
                if (mdlpwr.Intersect(USERPWRs, new MyEquality()).Count() == 0)
                {
                    if (Request.IsAjaxRequest())
                    {
                        WUCSMResult r = new WUCSMResult();
                        r["msg"] = "操作失败,用户没有权限进行此操作！";
                        filterContext.Result = new ContentResult() { Content = JSONSerializer.Serialize(r) };
                        return;
                    }
                    filterContext.Result = new RedirectResult(url.RouteUrl(new RouteValueDictionary(new { controller = "Error", action = "NoPwr" })));
                    return;
                }
            }
        }
        #endregion
    }
    public class MyEquality : IEqualityComparer<USERPWR>
    {
        public bool Equals(USERPWR A, USERPWR B)
        {
            return A.MDLID == B.MDLID && A.PWRID == B.PWRID;
        }
        public int GetHashCode(USERPWR obj)
        {
            return obj.MDLID.GetHashCode() * obj.PWRID.GetHashCode();
        }
    }
}