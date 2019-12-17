using System;
using System.Collections.Generic;
using System.Text;
using System.EnterpriseServices;
using IBatisNet.DataMapper;
using IBatisNet.DataMapper.Configuration.Statements;
using IBatisNet.DataMapper.MappedStatements;
using IBatisNet.DataMapper.Scope;
using IBatisNet.DataMapper.Commands;
using System.Collections;
using System.Runtime.Remoting.Messaging;
namespace IDataAccess
{
    public class SessionManager
    {
        private static Hashtable pri_hashSession = new Hashtable();
        public static IBatisNet.DataMapper.ISqlMapSession getSession(ISqlMapper mapper)
        {
            ISqlMapSession theSession = null;
            if (ContextUtil.IsInTransaction)
            {
                if (pri_hashSession.Contains(ContextUtil.TransactionId.ToString()))
                {
                    theSession = (ISqlMapSession)pri_hashSession[ContextUtil.TransactionId.ToString()];
                }
                else
                {
                    theSession = mapper.LocalSession;
                    if (mapper.LocalSession != null)
                    {
                        mapper.CloseConnection();
                    }
                    theSession = mapper.OpenConnection();
                    pri_hashSession.Add(ContextUtil.TransactionId.ToString(), theSession);
                }
            }
            else
            {
                theSession = mapper.LocalSession;
                if (mapper.LocalSession == null)
                {
                    theSession = mapper.OpenConnection();
                }
                CallContext.SetData("SESSIONMAP", mapper);
            }
            return theSession;
        }
        public static void FreeSession()
        {
            object objsession = CallContext.GetData("SESSIONMAP");
            if (objsession != null)
            {
                try
                {
                    ISqlMapper mapfree = objsession as ISqlMapper;
                    if (mapfree != null && mapfree.LocalSession != null)
                    {
                        mapfree.CloseConnection();
                    }
                }
                catch { }
                finally
                {
                    CallContext.SetData("SESSIONMAP", null);
                }
            }
        }
        public static void FreeSession(ISqlMapper mapper)
        {
            if (!ContextUtil.IsInTransaction)
            {
                try
                {
                    if (mapper.LocalSession != null)
                    {
                        mapper.CloseConnection();
                    }
                }
                catch
                {
                }
            }
        }
        public static void FreeTransSession(string sTransID)
        {

            try
            {
                ISqlMapSession session = (ISqlMapSession)pri_hashSession[sTransID];
                if (session != null)
                {
                    pri_hashSession.Remove(sTransID);
                    if (session.SqlMapper.LocalSession != null)
                    {
                        session.SqlMapper.CloseConnection();
                    }
                }
            }
            catch
            {
            }

        }
    }
}

