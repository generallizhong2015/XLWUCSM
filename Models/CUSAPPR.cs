using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Models
{
    [Serializable]
    public class CUSAPPR
    {
        /// <summary>
        /// 用户编号
        /// </summary>
        public string USERID { get; set; }
        /// <summary>
        /// 用户名称
        /// </summary>
        public string USERNAME { get; set; }
        /// <summary>
        /// 总数量
        /// </summary>
        public int COUNT { get; set; }
        /// <summary>
        /// 验收数量
        /// </summary>
        public int ACCEPT_COUNT { get; set; }
        /// <summary>
        /// 客户未验收数量
        /// </summary>
        public int NACCEPT_COUNT { get; set; }
        /// <summary>
        /// 未受理数量
        /// </summary>
        public int UNTREATED_COUNT { get; set; }
        /// <summary>
        /// 5星评价数
        /// </summary>
        public int FIVEDGR { get; set; }
        /// <summary>
        /// 4星评价数
        /// </summary>
        public int FOURDGR { get; set; }
        /// <summary>
        /// 3星评价数
        /// </summary>
        public int THREEDGR { get; set; }
        /// <summary>
        /// 2星评价数
        /// </summary>
        public int TWODGR { get; set; }
        /// <summary>
        /// 1星评价数
        /// </summary>
        public int ONEDGR { get; set; }
        /// <summary>
        /// 0星评价数
        /// </summary>
        public int NODGR { get; set; }

        /// <summary>
        /// 开始日期
        /// </summary>
        public string SDT { get; set; }
        /// <summary>
        /// 截至日期
        /// </summary>
        public string EDT { get; set; }

    }
}
