using System.Collections;
using System.Collections.Generic;
using IDAL.Common;
using Models;

namespace IDAL
{
    public interface IApprDAL : IFounDationDAL
    {
        /// <summary>
        /// 查询
        /// </summary>			
        ///<param name="p_apprid"></param>
        /// <returns></returns>
        APPR Select(int p_apprid);

        /// <summary>
        /// 查询(集合)
        /// </summary>
        /// <param name="h_appr"></param>
        /// <returns></returns>
        IList<APPR> Select(Hashtable h_appr);

        /// <summary>
        /// 数据插入
        /// </summary>
        /// <param name="p_appr"></param>
        void Insert(APPR p_appr);

        /// <summary>
        /// 数据修改
        /// </summary>
        /// <param name="p_appr"></param>
        void Update(APPR p_appr);

        /// <summary>
        /// 数据删除
        /// </summary>
        /// <param name="p_appr"></param>
        void Delete(APPR p_appr);
    }
}
