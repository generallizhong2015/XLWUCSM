using System.Collections;
using System.Collections.Generic;
using System.Linq;
using BLL.Common;
using IBLL;
using IDAL;
using Models;

namespace BLL
{
    class UserPwrBLL : FounDationBLL, IUserPwrBLL
    {
        IUserPwrDAL userpwrDAL { set; get; }
        public USERPWR Select(string p_USERID,string p_MDLID)
        {
            return userpwrDAL.Select(p_USERID,p_MDLID);
        }

        public IList<USERPWR> Select(Hashtable h_userpwr)
        {
            return userpwrDAL.Select(h_userpwr);
        }

        public void Insert(USERPWR p_userpwr)
        {
            userpwrDAL.Insert(p_userpwr);
        }
        public void Insert(IList<USERPWR> p_userpwr)
        {
            p_userpwr.ToList().ForEach(s => userpwrDAL.Insert(s));
        }

        public void Update(USERPWR p_userpwr)
        {
            userpwrDAL.Update(p_userpwr);
        }

        public void Delete(USERPWR p_userpwr)
        {
            userpwrDAL.Delete(p_userpwr);
        }
    }
}