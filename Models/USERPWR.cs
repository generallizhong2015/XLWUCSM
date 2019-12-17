/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:28:03
 * 创建说明：userpwr实体类
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
    public class USERPWR
    {
        /// <summary>
        /// USERID
        /// </summary>
        public string USERID { get; set; }

        /// <summary>
        /// MDLID
        /// </summary>
        public string MDLID { get; set; }

        /// <summary>
        /// PWRID
        /// </summary>
        public string PWRID { get; set; }
    }
}