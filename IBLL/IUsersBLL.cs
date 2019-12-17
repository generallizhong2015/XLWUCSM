using System.Collections;
using System.Collections.Generic;
using IBLL.Common;
using Models;

namespace IBLL
{
    public interface IUsersBLL : IFounDationBLL
    {
        /// <summary>
        /// 查询
        /// </summary>			
        ///<param name="p_USERID"></param>
        /// <returns></returns>
        USERS Select(string p_USERID, string p_LOGID, string p_USERTYP, string p_CUSID, string p_MOVTEL, string p_EMAIL);

        /// <summary>
        /// 查询(集合)
        /// </summary>
        /// <param name="h_users"></param>
        /// <returns></returns>
        IList<USERS> Select(Hashtable h_users);

        IList<USERS> SelectLike(Hashtable h_users);

        /// <summary>
        /// 数据插入
        /// </summary>
        /// <param name="p_users"></param>
        void Insert(USERS p_users);

        /// <summary>
        /// 数据修改
        /// </summary>
        /// <param name="p_users"></param>
        void Update(USERS p_users);

        /// <summary>
        /// 数据删除
        /// </summary>
        /// <param name="p_users"></param>
        void Delete(USERS p_users);


        void Insert(IList<USERS> p_users);
        //USERS SelectByLogID(string p_LOGID);

        //USERS SelectByCusID(string p_CUSID);

        string SetUserid();

        void SetUserPwr(string usertyp, string userid, string issys);
    }
}