using System.Collections;
using System.Collections.Generic;
using IBLL.Common;
using Models;

namespace IBLL
{
    public interface IMdlBLL : IFounDationBLL
    {
        /// <summary>
        /// 查询
        /// </summary>			
        ///<param name="p_MDLID"></param>
        /// <returns></returns>
        MDL Select(string p_MDLID, string p_ISSTP);

        /// <summary>
        /// 查询(集合)
        /// </summary>
        /// <param name="h_mdl"></param>
        /// <returns></returns>
        IList<MDL> Select(Hashtable h_mdl);

        /// <summary>
        /// 数据插入
        /// </summary>
        /// <param name="p_mdl"></param>
        void Insert(MDL p_mdl);

        /// <summary>
        /// 数据修改
        /// </summary>
        /// <param name="p_mdl"></param>
        void Update(MDL p_mdl);

        /// <summary>
        /// 数据删除
        /// </summary>
        /// <param name="p_mdl"></param>
        void Delete(MDL p_mdl);
    }
}