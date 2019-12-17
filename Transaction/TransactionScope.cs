using System;
using System.EnterpriseServices;

namespace Transaction
{
    public enum TransactionScopeOption
    {
        Suppress = TransactionOption.NotSupported,
        Required = TransactionOption.Required,
        RequiresNew = TransactionOption.RequiresNew
    }


    /// <summary>
    /// 事务类
    /// </summary>
    public class TransactionScope : IDisposable
    {
        bool m_Consistent = false;

        public void Complete()
        {
            if (m_Consistent == false)
            {
                m_Consistent = true;
                ContextUtil.MyTransactionVote = TransactionVote.Commit;
            }
            else
            {
                throw new InvalidOperationException("不能调用超过两次");
            }
        }

        public void Abort()
        {
            if (m_Consistent == false)
            {
                m_Consistent = true;
                ContextUtil.MyTransactionVote = TransactionVote.Abort;
            }
            else
            {
                throw new InvalidOperationException("不能调用超过两次");
            }
        }

        public TransactionScope(System.Data.IsolationLevel isolationLevel, int timeout)
            : this(TransactionScopeOption.Required, isolationLevel, timeout)
        {
        }


        public TransactionScope(TransactionScopeOption scopeOption, System.Data.IsolationLevel isolationLevel, int timeout)
        {
            ServiceConfig config = new ServiceConfig();
            config.Transaction = (TransactionOption)scopeOption;
            config.IsolationLevel = TransformLevel(isolationLevel);
            if (timeout < 0)
                timeout = 0;
            config.TransactionTimeout = timeout;
            ServiceDomain.Enter(config);
            ContextUtil.MyTransactionVote = TransactionVote.Abort;
        }

        public void Dispose()
        {
            if (m_Consistent == false && ContextUtil.IsInTransaction)
            {
                ContextUtil.MyTransactionVote = TransactionVote.Abort;
            }
            ServiceDomain.Leave();
            m_Consistent = false;
        }

        private TransactionIsolationLevel TransformLevel(System.Data.IsolationLevel lil)
        {
            switch (lil)
            {
                case System.Data.IsolationLevel.ReadCommitted:
                case System.Data.IsolationLevel.Chaos:
                case System.Data.IsolationLevel.Unspecified:
                case System.Data.IsolationLevel.Snapshot:
                    return TransactionIsolationLevel.ReadCommitted;
                case System.Data.IsolationLevel.ReadUncommitted:
                    return TransactionIsolationLevel.ReadUncommitted;
                case System.Data.IsolationLevel.RepeatableRead:
                    return TransactionIsolationLevel.RepeatableRead;
                case System.Data.IsolationLevel.Serializable:
                    return TransactionIsolationLevel.Serializable;
                default:
                    return TransactionIsolationLevel.ReadCommitted;
            }
        }
    }
}
