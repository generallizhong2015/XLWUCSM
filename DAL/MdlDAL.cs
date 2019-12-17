using System.Collections;
using System.Collections.Generic;
using DAL.Common;
using IDAL;
using Models;

namespace DAL
{
    class MdlDAL : FounDationDAL, IMdlDAL
    {
        public MDL Select(string p_MDLID, string p_ISSTP)
        {
            Hashtable h_mdl = new Hashtable();
            h_mdl["MDLID"] = p_MDLID;
            h_mdl["ISSTP"] = p_ISSTP;
            return QueryForObject<MDL>("mdl_map.mdl_select", h_mdl);
        }

        public IList<MDL> Select(Hashtable h_mdl)
        {
            return QueryForList<MDL>("mdl_map.mdl_select", h_mdl);
        }

        public void Insert(MDL p_mdl)
        {
            ExecuteSQL("mdl_map.mdl_insert", p_mdl);
        }

        public void Update(MDL p_mdl)
        {
            ExecuteSQL("mdl_map.mdl_update", p_mdl);
        }

        public void Delete(MDL p_mdl)
        {
            ExecuteSQL("mdl_map.mdl_delete", p_mdl);
        }
    }
}