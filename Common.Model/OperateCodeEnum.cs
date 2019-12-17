using System;
using System.Collections.Generic;
using System.Text;

namespace Common.Model
{
    /// <summary>
    /// 操作返回枚举
    /// </summary>
    public enum OperateCodeEnum
    {
        /// <summary>
        /// 操作成功
        /// </summary>
        Success = 9998,
        /// <summary>
        /// {0}失败
        /// </summary>
        Failed = 9999,
        /// <summary>
        /// 未知错误
        /// </summary>
        UnknownError = 10000,
    }
}
