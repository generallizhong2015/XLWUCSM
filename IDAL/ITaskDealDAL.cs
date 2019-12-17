using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IDAL.Common;
using Models;
using System.Collections;

namespace IDAL
{
    public interface ITaskDealDAL : IFounDationDAL
    {
        TASKDEAL Select(string p_dealid, string p_ordno);
        IList<TASKDEAL> Select(Hashtable h_taskdeal);
        void Insert(TASKDEAL p_taskdeal);
        void Update(TASKDEAL p_taskdeal);
        void Delete(TASKDEAL p_taskdeal);
    }
}
