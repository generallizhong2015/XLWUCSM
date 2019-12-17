using System.Collections;
using System.Collections.Generic;
using BLL.Common;
using IBLL;
using IDAL;
using Models;

namespace BLL
{
    class MdlBLL : FounDationBLL, IMdlBLL
    {
        IMdlDAL mdlDAL { set; get; }
        public MDL Select(string p_MDLID, string p_ISSTP)
        {
            return mdlDAL.Select(p_MDLID, p_ISSTP);
        }

        public IList<MDL> Select(Hashtable h_mdl)
        {
            return mdlDAL.Select(h_mdl);
        }

        public void Insert(MDL p_mdl)
        {
            mdlDAL.Insert(p_mdl);
        }

        public void Update(MDL p_mdl)
        {
            mdlDAL.Update(p_mdl);
        }

        public void Delete(MDL p_mdl)
        {
            mdlDAL.Delete(p_mdl);
        }
    }
}