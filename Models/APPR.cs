/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:27:35
 * 创建说明：appr实体类
 * 
 * 修改人：
 * 修改时间：
 * 修改说明： 
****************************************************************************/
using System;

namespace Models
{
    public class APPR
    {
        public APPR()
        {
            APPRDT = DateTime.Now;
            CHKFLG = "1";
        }
        /// <summary>
        /// 序号
        /// </summary>
        public int APPRID { get; set; }

        /// <summary>
        /// 服务单号
        /// </summary>
        public string ORDNO { get; set; }

        /// <summary>
        /// 评价内容
        /// </summary>
        public string APPRTXT { get; set; }

        /// <summary>
        /// 评价时间
        /// </summary>
        public DateTime APPRDT { get; set; }

        /// <summary>
        /// 满意度
        /// </summary>
        public string DGR { get; set; }

        /// <summary>
        /// 评价状态
        /// </summary>
        public string CHKFLG { get; set; }
    }
}