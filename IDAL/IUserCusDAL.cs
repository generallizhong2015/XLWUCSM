using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IDAL.Common;
using Models;
using System.Collections;

namespace IDAL
{
    public interface IUserCusDAL : IFounDationDAL
    {
        USERCUS Select(string p_userid, string p_cusid, string p_cusorgid);
        IList<USERCUS> Select(Hashtable h_usercus);
        int Select_RecordCount(Hashtable h_usercus);
        void Insert(USERCUS p_usercus);
        void Update(USERCUS p_usercus);
        void Delete(USERCUS p_usercus);
    }
}
