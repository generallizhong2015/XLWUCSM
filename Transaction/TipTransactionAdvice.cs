using System;
using System.Collections.Generic;
using System.Text;
using AopAlliance.Intercept;
using System.EnterpriseServices;
using System.Runtime.Remoting.Messaging;
using System.IO;
using Common.Model;

namespace Transaction
{
    public class TipTransactionAdvice : IMethodInterceptor
    {
        #region IMethodInterceptor 成员

        public object Invoke(IMethodInvocation invocation)
        {
            object returnValue = null;
            object[] o = invocation.Method.GetCustomAttributes(typeof(TipTransactionAttribute), false);
            TipTransactionAttribute tta = null;
            for (int i = 0; i < o.Length; i++)
            {
                if (o[i] is TipTransactionAttribute)
                {
                    tta = o[i] as TipTransactionAttribute;
                    break;
                }
            }
            try
            {



                if (tta.IsTransStart) //开始事务
                {

                    using (TipTransactionScope scope = new TipTransactionScope(TransactionOption.Required, tta.IsolationLevel, 3600))
                    {
                        string url = null;

                        ITipTransaction trxn = (ITipTransaction)ContextUtil.Transaction;
                        trxn.GetTransactionUrl(ref url);

                        CallContext.SetData("DTCTxID", TransactionCallContext.FromTipUrl(url));

                        returnValue = invocation.Proceed();
                        OperateReturnInfo ori = returnValue as OperateReturnInfo;
                        if ((ori != null && OperateCodeEnum.Success == ori.ReturnCode))
                        {
                            scope.SetComplete();
                        }
                        CallContext.FreeNamedDataSlot("DTCTxID");
                    }
                    return returnValue;
                }
                else //传递事务
                {

                    TransactionCallContext ctx = (TransactionCallContext)CallContext.GetData("DTCTxID");
                    ServiceConfig config = new ServiceConfig();

                    if (ctx != null)
                    {
                        // Console.WriteLine(ctx.TipUrl);
                        config.TipUrl = ctx.TipUrl;
                        config.Transaction = TransactionOption.Required;
                    }
                    else
                    {
                        config.Transaction = TransactionOption.RequiresNew; //如果不存在tip事务，则启用新事务
                    }

                    config.IsolationLevel = tta.IsolationLevel;
                    config.TransactionTimeout = tta.TransactionTimeout;
                    using (TipTransactionScope scope = new TipTransactionScope(config))
                    {
                        returnValue = invocation.Proceed();
                        OperateReturnInfo ori = returnValue as OperateReturnInfo;
                        if ((ori != null && OperateCodeEnum.Success == ori.ReturnCode))
                        {
                            scope.SetComplete();
                        }
                        CallContext.FreeNamedDataSlot("DTCTxID");
                    }

                    return returnValue;
                }
            }
            catch (Exception e)
            {
                using (StreamWriter sw = new StreamWriter("tiperror.txt", false, Encoding.Default))
                {
                    sw.WriteLine(e.Message);
                    sw.WriteLine(e.Source);
                    sw.WriteLine(e.StackTrace);
                }

                throw;
            }

        }

        #endregion
    }
}
