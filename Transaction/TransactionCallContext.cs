using System;
using System.Runtime.Remoting.Messaging;

namespace Transaction
{
	[Serializable]
	public class TransactionCallContext : 
		ILogicalThreadAffinative 
	{
		private string tipUrl = null;
		private TransactionCallContext()
		{}

		private TransactionCallContext(string tipUrl)
		{
			this.tipUrl = tipUrl;
		}

		public string TipUrl
		{
			get {return tipUrl;}
		}

		public static TransactionCallContext FromTipUrl(string tipUrl)
		{
			TransactionCallContext ctx = new TransactionCallContext(tipUrl);
			return ctx;
		}
	}


}
