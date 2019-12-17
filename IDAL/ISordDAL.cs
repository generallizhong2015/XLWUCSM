using System.Collections;
using System.Collections.Generic;
using IDAL.Common;
using Models;

namespace IDAL
{
    public interface ISordDAL : IFounDationDAL
    {
        /// <summary>
        /// 查询
        /// </summary>			
        ///<param name="p_ordno"></param>
        /// <returns></returns>
        SORD Select(string p_ordno);

        /// <summary>
        /// 查询(集合)
        /// </summary>
        /// <param name="h_sord"></param>
        /// <returns></returns>
        IList<SORD> Select(Hashtable h_sord);

        /// <summary>
        /// 查询总条数
        /// </summary>
        /// <param name="h_sord"></param>
        /// <returns></returns>
        int SelectCount(Hashtable h_sord);

        /// <summary>
        /// 获取新单据号
        /// </summary>
        /// <returns></returns>
        string GetCurNo();

        /// <summary>
        /// 数据插入
        /// </summary>
        /// <param name="p_sord"></param>
        void Insert(SORD p_sord);

        /// <summary>
        /// 数据修改
        /// </summary>
        /// <param name="p_sord"></param>
        void Update(SORD p_sord);
        /// <summary>
        /// 数据修改
        /// </summary>
        /// <param name="p_sord"></param>
        void UpdateSord(SORD p_sord);
        /// <summary>
        /// 数据删除
        /// </summary>
        /// <param name="p_sord"></param>
        void Delete(SORD p_sord);
    }
}
