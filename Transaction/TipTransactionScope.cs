using System;
using System.EnterpriseServices;

namespace Transaction
{
	/// <summary>
	/// 事务范围类
	/// </summary>
	public class TipTransactionScope : IDisposable
	{
		/// <summary>
		/// 标记事务是否成功
		/// </summary>
		private bool succeded;

		/// <summary>
		/// 
		/// </summary>
		public TipTransactionScope() : this(TransactionOption.RequiresNew, TransactionIsolationLevel.Serializable, 3600)
		{
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="transactionOption">事务选项</param>
		public TipTransactionScope(TransactionOption transactionOption) :
            this(transactionOption, TransactionIsolationLevel.Serializable, 3600)
		{
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="transactionOption">事务选项</param>
		/// <param name="isolationLevel">隔离级别</param>
		/// <param name="timeoutSeconds">超时时间</param>
		public TipTransactionScope(TransactionOption transactionOption, 
			TransactionIsolationLevel isolationLevel, int timeoutSeconds)
		{
			ServiceConfig cfg = new ServiceConfig();
			cfg.Transaction = transactionOption;
			cfg.IsolationLevel = isolationLevel;
			cfg.TransactionTimeout = timeoutSeconds;
            
			ServiceDomain.Enter(cfg);
		}
		
		/// <summary>
		/// 自行设置事务配置
		/// </summary>
		/// <param name="cfg">事务配置</param>
		public TipTransactionScope(ServiceConfig cfg)
		{
			ServiceDomain.Enter(cfg);
		}

		/// <summary>
		/// 设置为事务已成功
		/// </summary>
		public void SetComplete()
		{
			succeded = true;
		}

        /// <summary>
        /// 设置为事务已回滚
        /// </summary>
        public void SetAbort()
        {
            succeded = false;
        }

		/// <summary>
		/// 如果没有设置为成功，那么回滚事务，否则提交事务
		/// </summary>
		public void Dispose()
		{
			if (succeded)
			{
				ContextUtil.SetComplete();
			} 
			else
			{
				ContextUtil.SetAbort();
			}
			ServiceDomain.Leave();
		}
	}
}
