
namespace Common.Model.Helpers
{
    /// <summary>
    /// 联动计算辅助类
    /// </summary>
    public static class CalHelper
    {
        #region 计算数量
        /// <summary>
        /// 计算数量
        /// </summary>
        /// <param name="m_PKGQTY">件数</param>
        /// <param name="m_CNVRTO">换算率</param>
        /// <returns>数量</returns>
        public static float CalQTY(float m_PKGQTY, float m_CNVRTO)
        {
            return m_PKGQTY * m_CNVRTO;
        }
        #endregion

        #region 计算件数
        /// <summary>
        /// 计算件数
        /// </summary>
        /// <param name="m_QTY">数量</param>
        /// <param name="m_CNVRTO">换算率</param>
        /// <returns>件数</returns>
        public static float CalPKGQTY(float m_QTY, float m_CNVRTO)
        {
            return m_QTY / m_CNVRTO;
        }
        #endregion

        #region 计算金额
        /// <summary>
        /// 计算金额
        /// </summary>
        /// <param name="m_QTY">数量</param>
        /// <param name="m_PRC">价格</param>
        /// <returns>金额</returns>
        public static float CalAMT(float m_QTY, float m_PRC)
        {
            return m_QTY * m_PRC;
        }
        #endregion
    }
}
