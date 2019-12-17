using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Script.Serialization;
using System.Text.RegularExpressions;
using System.Collections;
using System.Reflection;
//using Newtonsoft.Json;

namespace WUCSM.Helpers
{
    /// <summary>
    /// JSON序列化和反序列化
    /// </summary>
    public static class JSONSerializer
    {
        static JavaScriptSerializer js = new JavaScriptSerializer();
        /// <summary>
        /// 将对象转换为JSON字符串
        /// </summary>
        /// <param name="obj">要序列化的对象</param>
        /// <returns></returns>
        public static string Serialize(object obj)
        {
            string str = js.Serialize(obj);
            str = Regex.Replace(str, @"\\/Date\((\d+)\)\\/", match =>
            {
                DateTime dt = new DateTime(1970, 1, 1);
                dt = dt.AddMilliseconds(long.Parse(match.Groups[1].Value));
                dt = dt.ToLocalTime();
                return dt.ToString("yyyy-MM-dd HH:mm:ss");
            });
            return str;
        }
        /// <summary>
        /// 序列化对象并将生成的JSON字符串写入制定的System.Text.StringBuilder对象
        /// </summary>
        /// <param name="obj">要序列化的对象</param>
        /// <param name="output">用于写JSON字符串的System.Text.StringBuilder对象</param>
        public static void Serialize(object obj, StringBuilder output)
        {
            js.Serialize(obj, output);
        }
        /// <summary>
        /// 将 JSON 格式字符串转换为指定类型的对象
        /// </summary>
        /// <param name="input">要进行反序列化的JSON字符串</param>
        /// <param name="targetType">所生成对象的类型</param>
        /// <returns></returns>
        public static object Deserialize(string input, Type targetType)
        {
            return js.Deserialize(input, targetType);
        }
        /// <summary>
        /// 将指定的 JSON 字符串转换为 T 类型的对象
        /// </summary>
        /// <typeparam name="T">所生成对象的类型</typeparam>
        /// <param name="input">要进行反序列化的JSON字符串</param>
        /// <returns></returns>
        public static T Deserialize<T>(string input)
        {
            return js.Deserialize<T>(input);
        }
        /// <summary>
        /// 将指定的 JSON 字符串转换为对象
        /// </summary>
        /// <param name="input">要进行反序列化的JSON字符串</param>
        /// <returns></returns>
        public static object DeserializeObject(string input)
        {
            return js.DeserializeObject(input);
        }

        #region 转换表格需要的数据格式

        /// <summary>
        /// 转换表格格式数据
        /// </summary>
        /// <typeparam name="T">类型</typeparam>
        /// <param name="lg">转换的集合</param>
        /// <param name="sortname">排序列</param>
        /// <param name="sortorder">排序方式</param>
        /// <returns></returns>
        public static string ToGridJson<T>(IList<T> lg, string sortname = "", string sortorder = "", int recordcount = 0)
        {
            if (!String.IsNullOrEmpty(sortorder) && !String.IsNullOrEmpty(sortname))
            {
                if (sortorder == "asc") lg = lg.OrderBy(s => GetValue(s, sortname)).ToList();
                if (sortorder == "desc") lg = lg.OrderByDescending(s => GetValue(s, sortname)).ToList();
            }
            FlexigridObject flexigridObject = new FlexigridObject();
            flexigridObject.total = recordcount;
            foreach (var i in lg) flexigridObject.data.Add(GetPropertyList(i));
            return js.Serialize(flexigridObject);
        }

        #region 反射取得字段名称
        private static object GetValue<T>(T model, string field)
        {
            if (field.Split('.').Length == 1)
                return model.GetType().GetProperty(field).GetValue(model, null);
            int index = field.IndexOf('.');
            string f1 = field.Substring(0, index);
            string f2 = field.Substring(index + 1);
            object obj = model.GetType().GetProperty(f1).GetValue(model, null);
            return GetValue(obj, f2);
        }
        #endregion

        #region 反射得到Row
        private static Hashtable GetPropertyList(object obj)
        {
            Hashtable propertyList = new Hashtable();
            Type type = obj.GetType();
            PropertyInfo[] ps = type.GetProperties();
            JavaScriptSerializer js = new JavaScriptSerializer();
            foreach (PropertyInfo property in ps)
            {
                object o = property.GetValue(obj, null);
                if (property.PropertyType.Name == "DateTime")
                {
                    o = DateTime.Parse(o == null ? "" : o.ToString()).ToString("yyyy-MM-dd HH:mm:ss");
                    if (DateTime.Parse(o.ToString()).Date == DateTime.MinValue.Date) o = "";
                }
                propertyList.Add(property.Name, o == null ? "" : o.ToString());
            }
            return propertyList;
        }
        #endregion

        #region 对应JSON数据格式
        class FlexigridObject
        {
            public int total;
            public List<Hashtable> data = new List<Hashtable>();
        }
        #endregion

        #endregion


        #region 转换成树空间需要的数据格式
        /// <summary>
        /// 转换成树空间需要的数据格式
        /// </summary>
        /// <typeparam name="T">类型- 实体中必须带有PRTID</typeparam>
        /// <param name="lg">集合</param>
        /// <param name="ido">树节点赋值字段</param>
        /// <param name="name">树节点显示名称字段</param>
        /// <param name="pid">上级目录字段名称</param>
        /// <returns></returns>

        public static string ToTreeJson<T>(IList<T> lg, string ido, string name, string pid)
        {
            List<treeNode> nodes = new List<treeNode>();
            foreach (var item in lg)
            {
                treeNode ts = new treeNode();
                ts.id = item.GetType().GetProperty(ido).GetValue(item, null).ToString();
                ts.pid = item.GetType().GetProperty(pid).GetValue(item, null) == null ? "" : item.GetType().GetProperty(pid).GetValue(item, null).ToString();
                ts.name = item.GetType().GetProperty(name).GetValue(item, null).ToString();
                ts.expanded = true;
                nodes.Add(ts);
            }
            return js.Serialize(nodes);
        }
        public class treeNode
        {
            public string id { get; set; }
            public string pid { get; set; }
            public string name { get; set; }
            private object _expanded = null;
            public object expanded
            {
                get
                { return _expanded ?? false; }
                set
                { _expanded = value; }
            }
        }
        #endregion
    }
}
