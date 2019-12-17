using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBLL.Common;
using Models;
using System.Collections;

namespace IBLL
{
    public interface IUserCusBLL : IFounDationBLL
    {
        USERCUS Select(string p_userid, string p_cusid, string p_cusorgid);
        IList<USERCUS> Select(Hashtable h_usercus);
        int Select_RecordCount(Hashtable h_usercus);
        void Insert(IList<USERCUS> UserCuses);
        void Delete(IList<USERCUS> UserCuses);
    }
}
