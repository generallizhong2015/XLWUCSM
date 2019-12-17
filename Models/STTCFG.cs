/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:27:59
 * 创建说明：sttcfg实体类
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
    public class STTCFG
    {
        /// <summary>
        /// NODID
        /// </summary>
        public string NODTYP { get; set; }

        /// <summary>
        /// NODNAME
        /// </summary>
        public string NODNAME { get; set; }

        /// <summary>
        /// NODDTSTT
        /// </summary>
        public string NODDTSTT { get; set; }

        /// <summary>
        /// ISUSE
        /// </summary>
        public string ISUSE { get; set; }
    }
}