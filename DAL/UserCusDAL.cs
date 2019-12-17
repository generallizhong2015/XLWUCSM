using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL.Common;
using IDAL;
using System.Collections;
using Models;

namespace DAL
{
    class UserCusDAL : FounDationDAL, IUserCusDAL
    {
        public Models.USERCUS Select(string p_userid, string p_cusid, string p_cusorgid)
        {
            Hashtable h_usercus = new Hashtable();
            h_usercus["USERID"] = p_userid;
            h_usercus["CUSID"] = p_cusid;
            h_usercus["CUSORGID"] = p_cusorgid;
            return QueryForObject<USERCUS>("USERCUS_MAP.USERCUS_SELECT", h_usercus);
        }

        public IList<Models.USERCUS> Select(System.Collections.Hashtable h_usercus)
        {
            return QueryForList<USERCUS>("USERCUS_MAP.USERCUS_SELECT", h_usercus);
        }

        public void Insert(Models.USERCUS p_usercus)
        {
            ExecuteSQL("USERCUS_MAP.USERCUS_INSERT", p_usercus);
        }

        public void Update(Models.USERCUS p_usercus)
        {
            ExecuteSQL("USERCUS_MAP.USERCUS_UPDATE", p_usercus);
        }

        public void Delete(Models.USERCUS p_usercus)
        {
            ExecuteSQL("USERCUS_MAP.USERCUS_DELETE", p_usercus);
        }

        public int Select_RecordCount(Hashtable h_usercus)
        {
            return int.Parse(QueryForObject("USERCUS_MAP.USERCUS_SELECT_RECORDCOUNT", h_usercus).ToString());
        }
    }
}
