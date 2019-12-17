/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:27:40
 * 创建说明：mdl实体类
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
    public class MDL
    {
        /// <summary>
        /// MDLID
        /// </summary>
        public string MDLID { get; set; }

        /// <summary>
        /// MDLNAME
        /// </summary>
        public string MDLNAME { get; set; }

        /// <summary>
        /// PRTID
        /// </summary>
        public string PRTID { get; set; }

        /// <summary>
        /// LVL
        /// </summary>
        public int LVL { get; set; }

        /// <summary>
        /// MDLTYP
        /// </summary>
        public string MDLTYP { get; set; }

        /// <summary>
        /// SEQNO
        /// </summary>
        public int SEQNO { get; set; }

        /// <summary>
        /// ISSTP
        /// </summary>
        public string ISSTP { get; set; }

        /// <summary>
        /// MDLVER
        /// </summary>
        public string MDLVER { get; set; }

        /// <summary>
        /// FUNGRP
        /// </summary>
        public string FUNGRP { get; set; }

        /// <summary>
        /// BRF
        /// </summary>
        public string BRF { get; set; }
    }
}