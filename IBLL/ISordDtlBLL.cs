using System.Collections;
using System.Collections.Generic;
using IBLL.Common;
using Models;

namespace IBLL
{
    public interface ISordDtlBLL : IFounDationBLL
    {
        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="p_ordno"></param>
        /// <param name="p_rcdidx"></param>
        /// <returns></returns>
        SORDDTL Select(string p_ordno, int p_rcdidx);

        /// <summary>
        /// 查询(集合)
        /// </summary>
        /// <param name="h_sorddtl"></param>
        /// <returns></returns>
        IList<SORDDTL> Select(Hashtable h_sorddtl);

        /// <summary>
        /// 数据插入
        /// </summary>
        /// <param name="p_sorddtl"></param>
        void Insert(SORDDTL p_sorddtl);

        /// <summary>
        /// 数据修改
        /// </summary>
        /// <param name="p_sorddtl"></param>
        void Update(SORDDTL p_sorddtl);

        /// <summary>
        /// 数据删除
        /// </summary>
        /// <param name="p_sorddtl"></param>
        void Delete(SORDDTL p_sorddtl);
    }
}
