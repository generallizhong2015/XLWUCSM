using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBLL;
using BLL.Common;
using IDAL;

namespace BLL
{
    class UserCusBLL : FounDationBLL, IUserCusBLL
    {
        IUserCusDAL UserCusDAL { get; set; }

        public Models.USERCUS Select(string p_userid, string p_cusid, string p_cusorgid)
        {
            return UserCusDAL.Select(p_cusid, p_cusid, p_cusorgid);
        }

        public IList<Models.USERCUS> Select(System.Collections.Hashtable h_usercus)
        {
            return UserCusDAL.Select(h_usercus);
        }

        public void Insert(IList<Models.USERCUS> UserCuses)
        {
            foreach (Models.USERCUS uc in UserCuses)
            {
                UserCusDAL.Insert(uc);
            }
        }

        public void Delete(IList<Models.USERCUS> UserCuses)
        {
            foreach (Models.USERCUS uc in UserCuses)
            {
                UserCusDAL.Delete(uc);
            }
        }

        public int Select_RecordCount(System.Collections.Hashtable h_usercus)
        {
            return UserCusDAL.Select_RecordCount(h_usercus);
        }
    }
}
