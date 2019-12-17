/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:27:42
 * 创建说明：ntcpub实体类
 * 
 * 修改人：
 * 修改时间：
 * 修改说明： 
****************************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace Models
{
    public class NTCPUB
    {
        /// <summary>
        /// NTCPUBNO
        /// </summary>
        public string NTCPUBNO { get; set; }

        /// <summary>
        /// PUBDT
        /// </summary>
        public DateTime PUBDT { get; set; }

        /// <summary>
        /// DISDT
        /// </summary>
        public DateTime DISDT { get; set; }

        /// <summary>
        /// ISVLD
        /// </summary>
        public string ISVLD { get; set; }

        /// <summary>
        /// NTCTXT
        /// </summary>
        public string NTCTXT { get; set; }

        /// <summary>
        /// NTCCUS
        /// </summary>
        public string NTCCUS { get; set; }

        /// <summary>
        /// STT
        /// </summary>
        public int STT { get; set; }

        /// <summary>
        /// MKR
        /// </summary>
        public string MKR { get; set; }

        /// <summary>
        /// MKDTT
        /// </summary>
        public DateTime MKDTT { get; set; }

        #region 扩展属性
        public string MKRNAME { get; set; }
        #endregion
    }
}