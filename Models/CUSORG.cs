/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:27:39
 * 创建说明：cusorg实体类
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
    public class CUSORG
    {
        /// <summary>
        /// CUSID
        /// </summary>
        public string CUSID { get; set; }

        /// <summary>
        /// CUSORGID
        /// </summary>
        public string CUSORGID { get; set; }

        /// <summary>
        /// CUSORGNAME
        /// </summary>
        public string CUSORGNAME { get; set; }

        /// <summary>
        /// LNKR
        /// </summary>
        public string LNKR { get; set; }

        /// <summary>
        /// TEL
        /// </summary>
        public string TEL { get; set; }

        /// <summary>
        /// ADR
        /// </summary>
        public string ADR { get; set; }
        /// <summary>
        /// 09 : MIS, 10:ERP
        /// </summary>
        public string DPT { get; set; }

        /// <summary>
        /// STT
        /// </summary>
        public string STT { get; set; }
    }
}