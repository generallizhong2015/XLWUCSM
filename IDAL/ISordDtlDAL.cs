using System.Collections;
using System.Collections.Generic;
using IDAL.Common;
using Models;

namespace IDAL
{
    public interface ISordDtlDAL : IFounDationDAL
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
        /// 获取新序号
        /// </summary>
        /// <param name="p_ordno"></param>
        /// <returns></returns>
        int GetCurRcdidx(string p_ordno);

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
