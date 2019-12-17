/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:27:35
 * 创建说明：cus实体类
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
    public class CUS
    {
        /// <summary>
        /// CUSID
        /// </summary>
        public string CUSID { get; set; }

        /// <summary>
        /// CUSNAME
        /// </summary>
        public string CUSNAME { get; set; }

        /// <summary>
        /// LNKR
        /// </summary>
        public string LNKR { get; set; }

        /// <summary>
        /// ADR
        /// </summary>
        public string ADR { get; set; }

        /// <summary>
        /// TEL
        /// </summary>
        public string TEL { get; set; }

        /// <summary>
        /// EMAIL
        /// </summary>
        public string EMAIL { get; set; }

        /// <summary>
        /// DISDATE
        /// </summary>
        public DateTime DISDATE { get; set; }

        /// <summary>
        /// STT
        /// </summary>
        public string STT { get; set; }

        /// <summary>
        /// UPTR
        /// </summary>
        public string UPTR { get; set; }

        /// <summary>
        /// UPTDTT
        /// </summary>
        public DateTime UPTDTT { get; set; }

        /// <summary>
        /// PREFIX
        /// </summary>
        public string PREFIX { get; set; }
    }
}