using System;

namespace Common.Model
{
    /// <summary>
    /// 操作返回
    /// </summary>
    [Serializable]
    public class OperateReturnInfo
    {
        OperateCodeEnum returnCode;
        object returnInfo;
        string adviceInfo;
        string failedcode;
        /// <summary>
        /// 构造函数
        /// </summary>
        public OperateReturnInfo()
        {

        }
        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="returnCode">OperateCodeEnum类型</param>
        public OperateReturnInfo(OperateCodeEnum returnCode)
        {
            this.returnCode = returnCode;
        }
        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="returnCode">OperateCodeEnum类型</param>
        /// <param name="returnInfo">强制返回值</param>
        public OperateReturnInfo(OperateCodeEnum returnCode, object returnInfo)
            : this(returnCode)
        {
            this.returnInfo = returnInfo;
        }
        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="returnCode">OperateCodeEnum类型</param>
        /// <param name="returnInfo">强制返回值</param>
        /// <param name="failedcode">操作失败内部码</param>
        public OperateReturnInfo(OperateCodeEnum returnCode, object returnInfo, string failedcode)
            : this(returnCode, returnInfo)
        {
            this.failedcode = failedcode;
        }
        /// <summary>
        /// 返回的值类型
        /// </summary>
        public OperateCodeEnum ReturnCode
        {
            get { return returnCode; }
            set { returnCode = value; }
        }

        /// <summary>
        /// 返回的可选信息
        /// </summary>
        public object ReturnInfo
        {
            get
            {
                if (returnInfo == null) { return string.Empty; }
                else { return returnInfo; }
            }
            set { returnInfo = value; }
        }

        /// <summary>
        /// 建议信息
        /// </summary>
        public string AdviceInfo
        {
            get { return adviceInfo; }
            set { adviceInfo = value; }
        }

        /// <summary>
        /// 操作失败内部码
        /// </summary>
        public string FailedCode
        {
            get { return failedcode; }
            set { failedcode = value; }
        }
    }
}
