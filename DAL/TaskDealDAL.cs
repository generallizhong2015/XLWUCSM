using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IDAL;
using DAL.Common;
using System.Collections;
using Models;

namespace DAL
{
    class TaskDealDAL : FounDationDAL, ITaskDealDAL
    {

        public Models.TASKDEAL Select(string p_dealid, string p_ordno)
        {
            Hashtable h_taskdeal = new Hashtable();
            h_taskdeal["DEALID"] = p_dealid;
            h_taskdeal["ORDNO"] = p_ordno;
            return QueryForObject<TASKDEAL>("TASKDEAL_MAP.TASKDEAL_SELECT", h_taskdeal);
        }

        public IList<Models.TASKDEAL> Select(System.Collections.Hashtable h_taskdeal)
        {
            return QueryForList<TASKDEAL>("TASKDEAL_MAP.TASKDEAL_SELECT", h_taskdeal);
        }

        public void Insert(Models.TASKDEAL p_taskdeal)
        {
            ExecuteSQL("TASKDEAL_MAP.TASKDEAL_INSERT", p_taskdeal);
        }

        public void Update(Models.TASKDEAL p_taskdeal)
        {
            ExecuteSQL("TASKDEAL_MAP.TASKDEAL_UPDATE", p_taskdeal);
        }

        public void Delete(Models.TASKDEAL p_taskdeal)
        {
            ExecuteSQL("TASKDEAL_MAP.TASKDEAL_DELETE", p_taskdeal);
        }
    }
}
