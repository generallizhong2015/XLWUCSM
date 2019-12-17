using AopAlliance.Intercept;
using System.Transactions;
using System.EnterpriseServices;
using Common.Model;
namespace Transaction
{

    public class TransactionAdvice : IMethodInterceptor
    {
        System.OperatingSystem osInfo = System.Environment.OSVersion;

        #region IMethodInterceptor 成员
        public object Invoke(IMethodInvocation invocation)
        {
            bool bParentTran = false;
            string sTranID = "";// ContextUtil.TransactionId.ToString();
            if (!ContextUtil.IsInTransaction)
            {
                bParentTran = true;
            }
            object returnValue = null;
            object[] o = invocation.Method.GetCustomAttributes(typeof(Spring.Transaction.Interceptor.TransactionAttribute), false);
            Spring.Transaction.Interceptor.TransactionAttribute ta = o[0] as Spring.Transaction.Interceptor.TransactionAttribute;
            int timeout = ta.Timeout;

            if (osInfo.Version.Major == 5 && osInfo.Version.Minor == 0)
            {
                System.Transactions.TransactionOptions to = TransformLevel(ta.IsolationLevel);
                to.Timeout = new System.TimeSpan(1, 0, 0);

                using (System.Transactions.TransactionScope scope = new System.Transactions.TransactionScope(System.Transactions.TransactionScopeOption.Required, to))
                {
                    sTranID = ContextUtil.TransactionId.ToString();
                    returnValue = invocation.Proceed();

                    if (returnValue is OperateReturnInfo)
                    {
                        OperateReturnInfo ori = returnValue as OperateReturnInfo;
                        if ((ori != null && OperateCodeEnum.Success == ori.ReturnCode))
                        {
                            scope.Complete();
                        }
                    }
                    else if (returnValue is bool)  // 增加了事务返回值为bool类型的支持
                    {
                        if ((bool)returnValue)
                        {
                            scope.Complete();
                        }
                    }
                }
            }
            else
            {
                using (TransactionScope scope = new TransactionScope(ta.IsolationLevel, timeout))
                {
                    sTranID = ContextUtil.TransactionId.ToString();
                    returnValue = invocation.Proceed();


                    if (returnValue is OperateReturnInfo)
                    {
                        OperateReturnInfo ori = returnValue as OperateReturnInfo;
                        if ((ori != null && OperateCodeEnum.Success == ori.ReturnCode))
                        {
                            scope.Complete();
                        }
                        else
                        {
                            scope.Abort();
                        }
                    }
                    else if (returnValue is bool) // 增加了事务返回值为bool类型的支持
                    {
                        if ((bool)returnValue)
                        {
                            scope.Complete();
                        }
                        else
                        {
                            scope.Abort();
                        }
                    }
                    else
                    {
                        scope.Abort();
                    }


                    if (bParentTran)
                    {
                        IDataAccess.SessionManager.FreeTransSession(sTranID);
                    }
                }
            }

            return returnValue;
        }

        private TransactionOptions TransformLevel(System.Data.IsolationLevel lil)
        {
            TransactionOptions to = new TransactionOptions();
            switch (lil)
            {
                case System.Data.IsolationLevel.ReadCommitted:
                case System.Data.IsolationLevel.Chaos:
                case System.Data.IsolationLevel.Unspecified:
                case System.Data.IsolationLevel.Snapshot:
                    to.IsolationLevel = IsolationLevel.ReadCommitted;
                    break;
                case System.Data.IsolationLevel.ReadUncommitted:
                    to.IsolationLevel = IsolationLevel.ReadUncommitted;
                    break;
                case System.Data.IsolationLevel.RepeatableRead:
                    to.IsolationLevel = IsolationLevel.RepeatableRead;
                    break;
                case System.Data.IsolationLevel.Serializable:
                    to.IsolationLevel = IsolationLevel.Serializable;
                    break;
                default:
                    to.IsolationLevel = IsolationLevel.ReadCommitted;
                    break;
            }
            return to;
        }
        #endregion
    }
}
