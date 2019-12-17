/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:27:54
 * 创建说明：sorddtl实体类
 * 
 * 修改人：
 * 修改时间：
 * 修改说明： 
****************************************************************************/
using System;

namespace Models
{
    public class SORDDTL
    {
        public SORDDTL()
        {
            RCDIDX = 1;
            SUBDT = DateTime.Now;
        }
        /// <summary>
        /// 服务单号
        /// </summary>
        public string ORDNO { get; set; }

        /// <summary>
        /// 回复序号
        /// </summary>
        public int RCDIDX { get; set; }

        /// <summary>
        /// 回复时间
        /// </summary>
        public DateTime SUBDT { get; set; }

        /// <summary>
        /// 回复类型
        /// </summary>
        public string SUBTYP { get; set; }

        /// <summary>
        /// 回复人
        /// </summary>
        public string SUBMAN { get; set; }

        /// <summary>
        /// 回复人名称
        /// </summary>
        public string SUBMANNAME { get; set; }

        /// <summary>
        /// 回复人图片
        /// </summary>
        public string SUBMANPIC { get; set; }

        /// <summary>
        /// 回复正文
        /// </summary>
        public string SUBTXT { get; set; }
    }
}