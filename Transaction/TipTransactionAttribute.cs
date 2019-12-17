using System;
using System.Collections.Generic;
using System.Text;
using System.EnterpriseServices;

namespace Transaction
{
    /// <summary>
    /// Tip事务标志
    /// </summary>
    [Serializable]
    public class TipTransactionAttribute:Attribute
    {
        /// <summary>
        /// 构造函数(等同于[TipTransaction(true)])
        /// </summary>
        public TipTransactionAttribute():this(true,TransactionIsolationLevel.ReadCommitted,3600)
        {
            
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="isTransStart"></param>
        public TipTransactionAttribute(bool isTransStart)
            : this(isTransStart, TransactionIsolationLevel.ReadCommitted, 3600)
        {

        }
        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="isTransStart">Tip事务是否从此开始</param>
        /// <param name="isolationLevel">事务隔离级别</param>
        /// <param name="transactionTimeout">超时时间</param>
        public TipTransactionAttribute(bool isTransStart, TransactionIsolationLevel isolationLevel, int transactionTimeout)
        {
            IsTransStart = isTransStart;
            IsolationLevel = isolationLevel;
            TransactionTimeout = transactionTimeout;
        }

        /// <summary>
        /// Tip事务是否从此开始
        /// </summary>
        public bool IsTransStart
        { get; set; }

        /// <summary>
        /// 事务隔离级别
        /// </summary>
        public TransactionIsolationLevel IsolationLevel { get; set; }

        /// <summary>
        /// 事务超时时间
        /// </summary>
        public int TransactionTimeout { get; set; }
    }
}
