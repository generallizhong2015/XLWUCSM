using System;
using System.EnterpriseServices;

namespace Transaction
{
	/// <summary>
	/// ����Χ��
	/// </summary>
	public class TipTransactionScope : IDisposable
	{
		/// <summary>
		/// ��������Ƿ�ɹ�
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
		/// <param name="transactionOption">����ѡ��</param>
		public TipTransactionScope(TransactionOption transactionOption) :
            this(transactionOption, TransactionIsolationLevel.Serializable, 3600)
		{
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="transactionOption">����ѡ��</param>
		/// <param name="isolationLevel">���뼶��</param>
		/// <param name="timeoutSeconds">��ʱʱ��</param>
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
		/// ����������������
		/// </summary>
		/// <param name="cfg">��������</param>
		public TipTransactionScope(ServiceConfig cfg)
		{
			ServiceDomain.Enter(cfg);
		}

		/// <summary>
		/// ����Ϊ�����ѳɹ�
		/// </summary>
		public void SetComplete()
		{
			succeded = true;
		}

        /// <summary>
        /// ����Ϊ�����ѻع�
        /// </summary>
        public void SetAbort()
        {
            succeded = false;
        }

		/// <summary>
		/// ���û������Ϊ�ɹ�����ô�ع����񣬷����ύ����
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
