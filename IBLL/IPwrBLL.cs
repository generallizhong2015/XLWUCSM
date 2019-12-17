using System.Collections;
using System.Collections.Generic;
using IBLL.Common;
using Models;

namespace IBLL
{
    public interface IPwrBLL : IFounDationBLL
    {
        /// <summary>
        /// 查询
        /// </summary>			
        ///<param name="p_PWRID"></param>
        /// <returns></returns>
        PWR Select(string p_PWRID);

        /// <summary>
        /// 查询(集合)
        /// </summary>
        /// <param name="h_pwr"></param>
        /// <returns></returns>
        IList<PWR> Select(Hashtable h_pwr);

        /// <summary>
        /// 数据插入
        /// </summary>
        /// <param name="p_pwr"></param>
        void Insert(PWR p_pwr);

        /// <summary>
        /// 数据修改
        /// </summary>
        /// <param name="p_pwr"></param>
        void Update(PWR p_pwr);

        /// <summary>
        /// 数据删除
        /// </summary>
        /// <param name="p_pwr"></param>
        void Delete(PWR p_pwr);
    }
}