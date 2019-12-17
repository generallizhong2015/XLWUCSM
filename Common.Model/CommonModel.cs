
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Common.Model
{
    /// <summary>
    /// 公用实体类
    /// </summary>
    public class CommonModel
    {
        #region zTree Model
        /// <summary>
        /// zTree Model（请勿改变大小写，原因是与插件需要的属性相匹配）
        /// </summary>
        public class zTreeModel
        {
            /// <summary>
            /// 节点Id
            /// </summary>
            public string id { get; set; }

            /// <summary>
            /// 父节点Id
            /// </summary>
            public string pId { get; set; }

            /// <summary>
            /// 节点名称
            /// </summary>
            public string name { get; set; }

            /// <summary>
            /// 节点图标
            /// </summary>
            public string icon { get; set; }

            /// <summary>
            /// 节点链接
            /// </summary>
            public string src { get; set; }

            /// <summary>
            /// 是否展开节点
            /// </summary>
            public bool open { get; set; }

            /// <summary>
            /// 是否禁用单选或复选框
            /// </summary>
            public bool chkDisabled { get; set; }

            /// <summary>
            /// 是否选择勾选框
            /// </summary>
            public bool @checked { get; set; }

            /// <summary>
            /// 是否包含子节点
            /// </summary>
            public bool haveSon { get; set; }
        }

       #endregion
    }
}
