/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:28:06
 * 创建说明：users实体类
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
    public class USERS
    {

        /// <summary>
        /// USERID
        /// </summary>
        public string USERID { get; set; }

        /// <summary>
        /// USERNAME
        /// </summary>
        public string USERNAME { get; set; }

        /// <summary>
        /// LOGID
        /// </summary>
        public string LOGID { get; set; }

        /// <summary>
        /// CUSID
        /// </summary>
        public string CUSID { get; set; }

        /// <summary>
        /// CUSORGID
        /// </summary>
        public string CUSORGID { get; set; }

        /// <summary>
        /// SEX
        /// </summary>
        public string SEX { get; set; }

        /// <summary>
        /// DPT
        /// </summary>
        public string DPT { get; set; }

        /// <summary>
        /// PSTN
        /// </summary>
        public string PSTN { get; set; }

        /// <summary>
        /// IDNO
        /// </summary>
        public string IDNO { get; set; }

        /// <summary>
        /// ADR
        /// </summary>
        public string ADR { get; set; }

        /// <summary>
        /// OTEL
        /// </summary>
        public string OTEL { get; set; }

        /// <summary>
        /// ITEL
        /// </summary>
        public string ITEL { get; set; }

        /// <summary>
        /// MOVTEL
        /// </summary>
        public string MOVTEL { get; set; }

        /// <summary>
        /// EMAIL
        /// </summary>
        public string EMAIL { get; set; }

        /// <summary>
        /// QQ
        /// </summary>
        public string QQ { get; set; }

        /// <summary>
        /// PWD
        /// </summary>
        public string PWD { get; set; }

        /// <summary>
        /// CHKVU
        /// </summary>
        public string CHKVU { get; set; }

        /// <summary>
        /// USERTYP
        /// </summary>
        public string USERTYP { get; set; }

        /// <summary>
        /// STT
        /// </summary>
        public string STT { get; set; }

        /// <summary>
        /// FNDPWDVLD
        /// </summary>
        public string FNDPWDVLD { get; set; }

        /// <summary>
        /// PIC
        /// </summary>
        public string PIC { get; set; }

        /// <summary>
        /// ISSYS
        /// </summary>
        public string ISSYS { get; set; }


        #region 扩展属性PRTID
        /// <summary>
        /// PRTID 方便树形结构展示
        /// </summary>
        public string PRTID { get; set; }

        public string CUSNAME { get; set; }

        public string CUSORGNAME { get; set; }

        #endregion
    }
}