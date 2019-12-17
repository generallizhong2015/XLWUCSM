using System.Collections;
using System.Collections.Generic;
using BLL.Common;
using IBLL;
using IDAL;
using Models;

namespace BLL
{
    class SordDtlBLL : FounDationBLL, ISordDtlBLL
    {
        ISordDtlDAL SordDtlDAL { get; set; }

        public SORDDTL Select(string p_ordno, int p_rcdidx)
        {
            return SordDtlDAL.Select(p_ordno, p_rcdidx);
        }

        public IList<SORDDTL> Select(Hashtable h_sorddtl)
        {
            return SordDtlDAL.Select(h_sorddtl);
        }

        public void Insert(SORDDTL p_sorddtl)
        {
            p_sorddtl.RCDIDX = SordDtlDAL.GetCurRcdidx(p_sorddtl.ORDNO);
            SordDtlDAL.Insert(p_sorddtl);
        }

        public void Update(SORDDTL p_sorddtl)
        {
            SordDtlDAL.Update(p_sorddtl);
        }

        public void Delete(SORDDTL p_sorddtl)
        {
            SordDtlDAL.Delete(p_sorddtl);
        }
    }
}
