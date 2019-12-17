using AopAlliance.Intercept;
using System.Transactions;
using System;
using System.EnterpriseServices;
using System.IO;
using System.Collections;
using System.Runtime.Remoting.Messaging;
namespace Transaction
{
    public class SessionAdvice : IMethodInterceptor
    {
        public object Invoke(IMethodInvocation invocation)
        {
            object returnValue = null;
            object obj = CallContext.GetData("SESSIONOWN");
            bool bFree = false;
            if (obj == null)
            {
                CallContext.SetData("SESSIONOWN", true);
                bFree = true;
            }

            try
            {

                returnValue = invocation.Proceed();                
            }
            finally
            {
                if (bFree)
                {
                    CallContext.SetData("SESSIONOWN", null);
                    IDataAccess.SessionManager.FreeSession();
                }
            }
            return returnValue;
        }
    }
}
