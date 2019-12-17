using System;

namespace Common.Model
{
    /// <summary>
    /// ��������
    /// </summary>
    [Serializable]
    public class OperateReturnInfo
    {
        OperateCodeEnum returnCode;
        object returnInfo;
        string adviceInfo;
        string failedcode;
        /// <summary>
        /// ���캯��
        /// </summary>
        public OperateReturnInfo()
        {

        }
        /// <summary>
        /// ���캯��
        /// </summary>
        /// <param name="returnCode">OperateCodeEnum����</param>
        public OperateReturnInfo(OperateCodeEnum returnCode)
        {
            this.returnCode = returnCode;
        }
        /// <summary>
        /// ���캯��
        /// </summary>
        /// <param name="returnCode">OperateCodeEnum����</param>
        /// <param name="returnInfo">ǿ�Ʒ���ֵ</param>
        public OperateReturnInfo(OperateCodeEnum returnCode, object returnInfo)
            : this(returnCode)
        {
            this.returnInfo = returnInfo;
        }
        /// <summary>
        /// ���캯��
        /// </summary>
        /// <param name="returnCode">OperateCodeEnum����</param>
        /// <param name="returnInfo">ǿ�Ʒ���ֵ</param>
        /// <param name="failedcode">����ʧ���ڲ���</param>
        public OperateReturnInfo(OperateCodeEnum returnCode, object returnInfo, string failedcode)
            : this(returnCode, returnInfo)
        {
            this.failedcode = failedcode;
        }
        /// <summary>
        /// ���ص�ֵ����
        /// </summary>
        public OperateCodeEnum ReturnCode
        {
            get { return returnCode; }
            set { returnCode = value; }
        }

        /// <summary>
        /// ���صĿ�ѡ��Ϣ
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
        /// ������Ϣ
        /// </summary>
        public string AdviceInfo
        {
            get { return adviceInfo; }
            set { adviceInfo = value; }
        }

        /// <summary>
        /// ����ʧ���ڲ���
        /// </summary>
        public string FailedCode
        {
            get { return failedcode; }
            set { failedcode = value; }
        }
    }
}
