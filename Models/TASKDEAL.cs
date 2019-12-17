/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:28:02
 * 创建说明：taskdeal实体类
 * 
 * 修改人：
 * 修改时间：
 * 修改说明： 
****************************************************************************/
using System;

namespace Models
{
    public class TASKDEAL
    {
        public TASKDEAL()
        {
            PRCDT = DateTime.Now;
        }
        /// <summary>
        /// DEALID
        /// </summary>
        public int DEALID { get; set; }

        /// <summary>
        /// ORDNO
        /// </summary>
        public string ORDNO { get; set; }

        /// <summary>
        /// NODID
        /// </summary>
        public string NODID { get; set; }

        /// <summary>
        /// PRCDT
        /// </summary>
        public DateTime PRCDT { get; set; }

        /// <summary>
        /// PRCR
        /// </summary>
        public string PRCR { get; set; }

        /// <summary>
        /// PRCRNAME
        /// </summary>
        public string PRCRNAME { get; set; }

        /// <summary>
        /// BRF
        /// </summary>
        public string BRF { get; set; }
    }
}