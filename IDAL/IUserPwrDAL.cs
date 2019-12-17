using System.Collections;
using System.Collections.Generic;
using IDAL.Common;
using Models;

namespace IDAL
{
    public interface IUserPwrDAL : IFounDationDAL
    {
        /// <summary>
        /// 查询
        /// </summary>			
        ///<param name="p_USERID"></param>
        ///<param name="p_MDLID"></param>
        /// <returns></returns>
        USERPWR Select(string p_USERID,string p_MDLID);

        /// <summary>
        /// 查询(集合)
        /// </summary>
        /// <param name="h_userpwr"></param>
        /// <returns></returns>
        IList<USERPWR> Select(Hashtable h_userpwr);

        /// <summary>
        /// 数据插入
        /// </summary>
        /// <param name="p_userpwr"></param>
        void Insert(USERPWR p_userpwr);

        void Insert(IList<USERPWR> p_userpwr);

        /// <summary>
        /// 数据修改
        /// </summary>
        /// <param name="p_userpwr"></param>
        void Update(USERPWR p_userpwr);

        /// <summary>
        /// 数据删除
        /// </summary>
        /// <param name="p_userpwr"></param>
        void Delete(USERPWR p_userpwr);
    }
}