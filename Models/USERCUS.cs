using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Models
{
    public class USERCUS
    {
        public int UCID { get; set; }
        public string USERID { get; set; }
        public string CUSID { get; set; }
        public string CUSORGID { get; set; }

        #region 扩展属性用于前台展示
        public string USERNAME { get; set; }
        public string CUSNAME { get; set; }
        public string CUSORGNAME { get; set; }
        public string LNKR { get; set; }
        public string TEL { get; set; }
        /// <summary>
        /// 09 : MIS, 10:ERP
        /// </summary>
        public string DPT { get; set; }
        #endregion
    }
}
