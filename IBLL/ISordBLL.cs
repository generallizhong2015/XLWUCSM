using System.Collections;
using System.Collections.Generic;
using IBLL.Common;
using Models;

namespace IBLL
{
    public interface ISordBLL : IFounDationBLL
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

        /// <summary>
        /// 查询任务记录(集合)
        /// </summary>
        /// <param name="h_taskdeal"></param>
        /// <returns></returns>
        IList<TASKDEAL> SelectTaskDeal(Hashtable h_taskdeal);

        /// <summary>
        /// 查询任务记录(集合)
        /// </summary>
        /// <param name="p_ordno"></param>
        /// <returns></returns>
        IList<TASKDEAL> SelectTrack(string p_ordno);

        /// <summary>
        /// 查询任务回复(集合)
        /// </summary>
        /// <param name="p_ordno"></param>
        /// <returns></returns>
        IList<SORDDTL> SelectReply(string p_ordno);

        /// <summary>
        /// 查询任务评论(集合)
        /// </summary>
        /// <param name="p_ordno"></param>
        /// <returns></returns>
        IList<APPR> SelectReview(string p_ordno);
    }
}
