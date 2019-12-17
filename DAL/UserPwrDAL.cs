using System.Collections;
using System.Collections.Generic;
using System.Linq;
using DAL.Common;
using IDAL;
using Models;

namespace DAL
{
    class UserPwrDAL : FounDationDAL, IUserPwrDAL
    {    
        public USERPWR Select(string p_USERID,string p_MDLID)
        {
            Hashtable h_userpwr = new Hashtable();
            h_userpwr["USERID"] = p_USERID;
            h_userpwr["MDLID"] = p_MDLID;
            return QueryForObject<USERPWR>("userpwr_map.userpwr_select", h_userpwr);
        }

        public IList<USERPWR> Select(Hashtable h_userpwr)
        {
            return QueryForList<USERPWR>("userpwr_map.userpwr_select", h_userpwr);
        }

        public void Insert(USERPWR p_userpwr)
        {
            ExecuteSQL("userpwr_map.userpwr_insert", p_userpwr);
        }

        public void Insert(IList<USERPWR> p_userpwr)
        {
            p_userpwr.ToList().ForEach(s => ExecuteSQL("userpwr_map.userpwr_insert", s));
        }

        public void Update(USERPWR p_userpwr)
        {
            ExecuteSQL("userpwr_map.userpwr_update", p_userpwr);
        }

        public void Delete(USERPWR p_userpwr)
        {
            ExecuteSQL("userpwr_map.userpwr_delete", p_userpwr);
        }
    }
}