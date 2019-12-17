using System;
using System.Collections;
using System.Collections.Generic;
using IBatisNet.DataMapper;
using IBatisNet.DataMapper.MappedStatements;
using System.Data;
using IBatisNet.DataMapper.Scope;
using System.Reflection;
using IBatisNet.DataMapper.Configuration.Statements;
using IBatisNet.Common;
using System.Data.SqlClient;
using System.Text;
using System.Data.Common;
using System.Runtime.Remoting.Messaging;
using System.Xml;
using System.Text.RegularExpressions;
using System.IO;

namespace IDataAccess
{
    public abstract class SqlMapClientTemplate
    {
        #region ����
        private ISqlMapper mapper;
        private SqlMapClient _sqlMapClient;
        public SqlMapClient SqlMapClient
        {
            get { return _sqlMapClient; }
            set
            {
                _sqlMapClient = value;
                mapper = _sqlMapClient.mapper;
            }
        }
        private bool isOwnedSession = false;
        public bool IsOwnedSessoin
        {
            set
            {
                isOwnedSession = value;
                CallContext.SetData("SESSIONOWN", isOwnedSession);
                if (isOwnedSession == false)
                {
                    SessionManager.FreeSession(mapper);
                    CallContext.SetData("SESSIONOWN", null);
                }
            }
            get
            {
                object obj = CallContext.GetData("SESSIONOWN");
                if (obj == null)
                {
                    isOwnedSession = false;
                }
                else
                {
                    isOwnedSession = (bool)obj;
                }
                return isOwnedSession;
            }
        }
        #endregion

        /// <summary>
        /// ����sqlд�ļ���
        /// </summary>
        static object lockObj = new object();
        /// <summary>
        /// ����sql����ļ�
        /// </summary>
        string SqlFileName = "TraceSQL.txt";

        #region ��ִ�з���

        protected object Insert(String query, Object parameters)
        {
            SessionManager.getSession(mapper);
            object obj = mapper.Insert(query, parameters);//sunky
            if (this.IsOwnedSessoin == false)
            {
                SessionManager.FreeSession(mapper);
            }
            return obj;//
        }

        protected int Update(String query, object parameters)
        {
            SessionManager.getSession(mapper);
            int iobj = mapper.Update(query, parameters);//sunky
            if (this.IsOwnedSessoin == false)
            {
                SessionManager.FreeSession(mapper);
            }
            return iobj;//
        }

        protected int Delete(String query, object parameters)
        {
            SessionManager.getSession(mapper);
            int iobj = mapper.Delete(query, parameters);//sunky
            if (this.IsOwnedSessoin == false)
            {
                SessionManager.FreeSession(mapper);
            }
            return iobj;
        }

        #region QueryForObject

        protected object QueryForObject(string statementName, object parameterObject)
        {
            SessionManager.getSession(mapper);
            string aa = GetStatementSQL(statementName, parameterObject);
            object obj = mapper.QueryForObject(statementName, parameterObject);
            if (this.IsOwnedSessoin == false)
            {
                SessionManager.FreeSession(mapper);
            }
            return obj;
        }

        protected T QueryForObject<T>(string statementName, object parameterObject)
        {
            SessionManager.getSession(mapper);
            T tobj = mapper.QueryForObject<T>(statementName, parameterObject);
            if (this.IsOwnedSessoin == false)
            {
                SessionManager.FreeSession(mapper);
            }
            return tobj;
        }

        #endregion

        protected IDictionary QueryForDictionary(string statementName, object parameterObject, string keyProperty)
        {
            SessionManager.getSession(mapper);
            IDictionary idic = mapper.QueryForDictionary(statementName, parameterObject, keyProperty);
            if (this.IsOwnedSessoin == false)
            {
                SessionManager.FreeSession(mapper);
            }
            return idic;
        }

        #region QueryForList

        protected IList QueryForList(string statementName, object parameterObject)
        {
            SessionManager.getSession(mapper);
            IList list = mapper.QueryForList(statementName, parameterObject);
            if (this.IsOwnedSessoin == false)
            {
                SessionManager.FreeSession(mapper);
            }
            return list;
        }

        protected IList<T> QueryForList<T>(string statementName, object parameterObject)
        {
            SessionManager.getSession(mapper);
            string aa = GetStatementSQL(statementName, parameterObject);
            IList<T> listobj = mapper.QueryForList<T>(statementName, parameterObject);
            if (this.IsOwnedSessoin == false)
            {
                SessionManager.FreeSession(mapper);
            }
            return listobj;
        }

        #endregion

        #region QueryForDataTable

        protected DataTable QueryForDataTable(string statementName, object paramObject)
        {

            DataTable dataTable = new DataTable();

            ISqlMapSession session = SessionManager.getSession(mapper);
            try
            {
                IDbCommand cmd = GetDbCommand(statementName, paramObject, session);
                cmd.CommandTimeout = 0;


                dataTable = new DataTable(statementName);
                using (cmd)
                {

                    // 20130522 �����м�����sql �����
                    lock (lockObj)
                    {
                        if (File.Exists(SqlFileName))
                        {
                            File.AppendAllText(SqlFileName, cmd.CommandText + Environment.NewLine + Environment.NewLine + Environment.NewLine);
                        }
                    }


                    dataTable.Load(cmd.ExecuteReader());
                }
            }
            finally
            {
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }

            dataTable.RemotingFormat = SerializationFormat.Binary;
            return dataTable;
        }

        protected DataTable QueryForDataTableForGP(string statementName, object paramObject)
        {

            DataTable dataTable = new DataTable(statementName);

            ISqlMapSession session = SessionManager.getSession(mapper);
            try
            {
                IDbCommand cmd = GetDbCommand(statementName, paramObject, session);
                cmd.CommandTimeout = 0;
                using (cmd)
                {

                    lock (lockObj)
                    {
                        if (File.Exists(SqlFileName))
                        {
                            File.AppendAllText(SqlFileName, cmd.CommandText + Environment.NewLine + Environment.NewLine + Environment.NewLine);
                        }
                    }


                    dataTable.Load(cmd.ExecuteReader());
                }
            }
            finally
            {
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }

            dataTable.RemotingFormat = SerializationFormat.Binary;
            return dataTable;
        }

        protected DataTable QueryForDataTable(string sSql)
        {
            DataTable dataTable = new DataTable("myDt");
            IDbCommand cmd = GetDbCommand(CommandType.Text);
            cmd.CommandText = sSql;
            cmd.CommandTimeout = 0;

            try
            {
                using (cmd)
                {

                    // 20130406 ����GP�м�����sql �����
                    lock (lockObj)
                    {
                        if (File.Exists(SqlFileName))
                        {
                            File.AppendAllText(SqlFileName, cmd.CommandText + Environment.NewLine + Environment.NewLine + Environment.NewLine);
                        }
                    }

                    dataTable.Load(cmd.ExecuteReader());
                }
            }
            finally
            {
                if (cmd.Connection.State == ConnectionState.Open)
                {
                    cmd.Connection.Close();
                }
            }

            dataTable.RemotingFormat = SerializationFormat.Binary;
            return dataTable;
        }

        /// <summary>
        /// ֻ������һ�β�ѯ�����ӽ������ر�
        /// </summary>
        protected DataTable QueryForDataTable(string sSql, string connectionstr)
        {
            DataTable dataTable = new DataTable();
            IDbCommand cmd = GetDbCommand();
            cmd.CommandTimeout = 0;
            IDbConnection conn = cmd.Connection;
            string sInitConstr = conn.ConnectionString;
            try
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                conn.ConnectionString = connectionstr;
                conn.Open();
                cmd.CommandText = sSql.ToString();
                dataTable.Load(cmd.ExecuteReader());

                return dataTable;
            }
            catch (Exception ex)
            { throw ex; }
            finally
            {
                conn.ConnectionString = sInitConstr;
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }
        }

        /// <summary>
        /// �洢����(Oracle��)
        /// </summary>
        protected DataTable QueryDatatableForOracleStoredProcedure(string statementName, object paramObject)
        {
            DataTable dataTable;
            if (mapper.LocalSession == null)
            {
                SessionManager.getSession(mapper);
            }

            ISqlMapSession session = mapper.LocalSession;
            IDbCommand cmd = GetDbCommand(statementName, paramObject);
            cmd.CommandTimeout = 0;
            try
            {
                IMappedStatement statement = mapper.GetMappedStatement(statementName);
                dataTable = new DataTable(statementName);
                RequestScope request = statement.Statement.Sql.GetRequestScope(statement, paramObject, session);
                statement.PreparedCommand.Create(request, session, statement.Statement, paramObject);
                request.IDbCommand.CommandTimeout = 0;
                using (request.IDbCommand)
                {
                    string OriginSql = request.IDbCommand.CommandText;
                    if (OriginSql.IndexOf("PROCEDURE", StringComparison.CurrentCultureIgnoreCase) != -1)
                    {

                        #region �µĲ�ѯ����(����)

                        #region step one ��ȡ�洢������
                        string spName = getOracleStoredProcedureName(OriginSql);
                        #endregion

                        #region �����ȡ�洢������
                        int length = spName.Length;
                        string randomSpName = spName;
                        string randName = GetCode(30 - length);
                        randomSpName += randName;
                        OriginSql = OriginSql.Replace(spName, randomSpName);
                        spName = randomSpName;

                        request.IDbCommand.CommandText = OriginSql.Replace('\r', ' ');//.Replace('\n', ' ');
                        #endregion


                        #region step two,ִ�д洢����,�����ݷ���cursor,���ڵ�����ȡ
                        request.IDbCommand.ExecuteNonQuery();
                        #endregion

                        #region step three ���ز�ѯ���,ע�������p_cur
                        Hashtable param = new Hashtable();
                        param.Add("p_cur", null);
                        IDbCommand cmdstore = GetDbCommand("Common.DetailQuery.virtualstoreprocedure", param);
                        cmdstore.CommandText = spName;
                        dataTable.Load(cmdstore.ExecuteReader());
                        #endregion

                        #region ɾ���洢����
                        request.IDbCommand.CommandText = "drop procedure " + spName;
                        request.IDbCommand.ExecuteNonQuery();
                        #endregion

                        #endregion


                    }
                    else //����oracleDML���
                    {

                        lock (lockObj)
                        {
                            if (File.Exists(SqlFileName))
                            {
                                File.AppendAllText(SqlFileName, cmd.CommandText + Environment.NewLine + Environment.NewLine + Environment.NewLine);
                            }
                        }


                        dataTable.Load(request.IDbCommand.ExecuteReader());
                    }
                }
            }
            finally
            {
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }

            //���ڿո�����
            TrimDataTable(dataTable);

            dataTable.RemotingFormat = SerializationFormat.Binary;
            return dataTable;
        }

        #endregion

        protected DataView QueryForDataView(string statementName, object paramObject)
        {
            return QueryForDataTable(statementName, paramObject).DefaultView;
        }

        #region ִ��SQL

        protected int ExecuteCustomSQL(string sql, Array paras)
        {
            ISqlMapSession session = SessionManager.getSession(mapper);

            IDbCommand cmd = GetDbCommand(CommandType.Text);
            cmd.CommandText = sql;
            cmd.CommandTimeout = 0;
            try
            {
                if (paras != null && paras.Length > 0)
                {
                    foreach (var item in paras)
                    {
                        cmd.Parameters.Add(item);
                    }
                }
                using (cmd)
                {
                    return cmd.ExecuteNonQuery();
                }
            }
            finally
            {
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }
        }

        protected int ExecuteSQL(string statementName, object paramObject)
        {
            return ExecuteSQL(statementName, paramObject, 0);
        }

        protected int ExecuteSQL(string statementName, object paramObject, int timeout)
        {
            ISqlMapSession session = SessionManager.getSession(mapper);
            try
            {
                IDbCommand cmd = GetDbCommand(statementName, paramObject, session);
                cmd.CommandText = cmd.CommandText.Replace('\r', ' ').Replace('\n', ' ');
                cmd.CommandTimeout = timeout;

                lock (lockObj)
                {
                    if (File.Exists(SqlFileName))
                    {
                        File.AppendAllText(SqlFileName, cmd.CommandText + Environment.NewLine + Environment.NewLine + Environment.NewLine);
                    }
                }

                return cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }
        }

        /// <summary>
        /// �����ݲ�xml�����ļ�ִ�и�SQL
        /// </summary>
        /// <param name="xmlPath">���磺"Maps\AppDetails_OPL.BatisMap.xml"</param>
        protected int ExecuteSQLFromFile(string xmlPath, string statement, IDictionary<string, string> paramObject)
        {
            ISqlMapSession session = SessionManager.getSession(mapper);
            try
            {
                IDbCommand cmd = GetDbCommand();
                string sql = GetContent(System.Environment.CurrentDirectory + "\\" + xmlPath, statement);
                if (string.IsNullOrEmpty(sql.Trim()))
                {
                    throw new Exception("ExecuteSQLFromFileδ�ܶ�ȡSQL��"
                        + Environment.NewLine + System.Environment.CurrentDirectory + "\\" + xmlPath
                        + Environment.NewLine + statement);
                }

                if (paramObject != null)
                {
                    foreach (KeyValuePair<string, string> item in paramObject)
                    {
                        sql = sql.Replace("$" + item.Key + "$", item.Value);
                    }
                }

                cmd.CommandText = sql;
                cmd.CommandTimeout = 0;

                // 20130522 �����м�����sql �����
                lock (lockObj)
                {
                    if (File.Exists(SqlFileName))
                    {
                        File.AppendAllText(SqlFileName, cmd.CommandText + Environment.NewLine + Environment.NewLine + Environment.NewLine);
                    }
                }

                return cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }
        }

        /// <summary>
        /// ִ������sql  (ÿ��500��)
        /// </summary>
        protected int ExecuteBatchSQL(IList<string> sqlList)
        {
            IDbCommand cmd = GetDbCommand();
            cmd.CommandTimeout = 0;

            int efRowCount = 0; //Ӱ������

            try
            {
                int COUNT = 500;
                int page = sqlList.Count % COUNT > 0 ? (sqlList.Count / COUNT) + 1 : sqlList.Count / COUNT;

                StringBuilder sql = null;

                for (int j = 1; j <= page; j++)
                {
                    sql = new StringBuilder();

                    sql.AppendLine(" begin ");

                    for (int i = (j - 1) * COUNT; i < j * COUNT && i < sqlList.Count; i++)
                    {
                        string _sql = sqlList[i] + ";";

                        sql.AppendLine(_sql);
                    }

                    sql.AppendLine(" end; ");

                    cmd.CommandText = sql.ToString();

                    // 20130522 �����м�����sql �����
                    lock (lockObj)
                    {
                        if (File.Exists(SqlFileName))
                        {
                            File.AppendAllText(SqlFileName, cmd.CommandText + Environment.NewLine + Environment.NewLine + Environment.NewLine);
                        }
                    }

                    efRowCount += cmd.ExecuteNonQuery();
                }

                return efRowCount;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }
        }

        /// <summary>
        /// ִ������sql  (ÿ��ִ���������ݲ�����ֵ)
        /// </summary>
        protected void ExecuteBatchSQL(IList<string> sqlList, int cnt)
        {
            IDbCommand cmd = GetDbCommand();
            cmd.CommandTimeout = 0;

            try
            {
                int COUNT = cnt;
                int page = sqlList.Count % COUNT > 0 ? (sqlList.Count / COUNT) + 1 : sqlList.Count / COUNT;

                StringBuilder sql = null;

                for (int j = 1; j <= page; j++)
                {
                    sql = new StringBuilder();

                    sql.AppendLine(" begin ");

                    for (int i = (j - 1) * COUNT; i < j * COUNT && i < sqlList.Count; i++)
                    {
                        string _sql = sqlList[i] + ";";

                        sql.AppendLine(_sql);
                    }

                    sql.AppendLine(" end; ");

                    cmd.CommandText = sql.ToString();

                    // 20130522 �����м�����sql �����
                    lock (lockObj)
                    {
                        if (File.Exists(SqlFileName))
                        {
                            File.AppendAllText(SqlFileName, cmd.CommandText + Environment.NewLine + Environment.NewLine + Environment.NewLine);
                        }
                    }

                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            { throw ex; }
            finally
            {
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }
        }
        #endregion

        protected object ExecuteScalar(string statementName, object paramObject)
        {

            if (!this.IsOwnedSessoin && mapper.LocalSession == null)
            {
                SessionManager.getSession(mapper);
            }
            ISqlMapSession session = mapper.LocalSession;

            IDbCommand cmd = GetDbCommand(statementName, paramObject);
            cmd.CommandTimeout = 0;
            object o = null;
            try
            {
                o = cmd.ExecuteScalar();
            }
            catch (Exception ex)
            { throw ex; }
            finally
            {
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }
            return o;
        }
        #endregion

        /// <summary>
        /// ��ȡ�������
        /// </summary>
        /// <param name="tableName">����</param>
        /// <returns>�������ϣ����� [GoodsCode,GoodsName,SalePrice] </returns>
        protected string GetTableColumns(string tableName)
        {
            IDbCommand cmd = GetDbCommand();
            cmd.CommandTimeout = 0;
            DataTable dataTable = new DataTable();

            try
            {
                cmd.CommandText = "select * from " + tableName + " where 1=2";
                dataTable.Load(cmd.ExecuteReader());
                string str = "";
                foreach (DataColumn dc in dataTable.Columns)
                {
                    str += dc.ColumnName + ",";
                }
                return str.TrimEnd(',');
            }
            finally
            {
                if (this.IsOwnedSessoin == false)
                {
                    SessionManager.FreeSession(mapper);
                }
            }
        }

        #region GetDbCommand

        protected IDbCommand GetDbCommand()
        {

            ISqlMapSession session = SessionManager.getSession(mapper);
            if (session.Connection.State == ConnectionState.Closed)
            {
                session.Connection.Open();
            }
            return session.CreateCommand(CommandType.Text);
        }

        protected IDbCommand GetDbCommand(CommandType commandType)
        {
            ISqlMapSession session = SessionManager.getSession(mapper);
            if (session.Connection.State == ConnectionState.Closed)
            {
                session.Connection.Open();
            }
            return session.CreateCommand(commandType);
        }


        private IDbCommand GetDbCommand(string statementName, object paramObject)
        {
            return GetDbCommand(statementName, paramObject, null);
        }

        private IDbCommand GetDbCommand(string statementName, object paramObject, ISqlMapSession session)
        {
            IStatement statement = mapper.GetMappedStatement(statementName).Statement;

            IMappedStatement mapStatement = mapper.GetMappedStatement(statementName);
            session = SessionManager.getSession(mapper);
            RequestScope request = statement.Sql.GetRequestScope(mapStatement, paramObject, session);

            mapStatement.PreparedCommand.Create(request, session, statement, paramObject);

            return request.IDbCommand;
        }

        #endregion

        #region ����

        public string GetDBType
        {
            get
            {
                return mapper.DataSource.DbProvider.Name;
            }
        }

        /// <summary>
        /// �����ȡ�洢������
        /// </summary>
        protected string GetCode(int num)
        {
            string a = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < num; i++)
            {
                sb.Append(a[new Random(Guid.NewGuid().GetHashCode()).Next(0, a.Length - 1)]);
            }
            return sb.ToString();
        }

        /// <summary>
        /// ��ȡ�洢������[Oracle��]
        /// Example:_spnamep_0103_10_spname
        /// </summary>
        /// <param name="sql"></param>
        /// <returns>p_0103_10</returns>
        private string getOracleStoredProcedureName(string sql)
        {
            int FirstIndex = sql.IndexOf("_spname", StringComparison.CurrentCultureIgnoreCase);
            int LastIndex = sql.LastIndexOf("_spname", StringComparison.CurrentCultureIgnoreCase);
            return sql.Substring(FirstIndex + 7, LastIndex - FirstIndex - 7);
        }

        void TrimDataTable(DataTable dt)
        {
            IList needTrimColumn = new ArrayList();

            foreach (DataColumn dc in dt.Columns)
            {
                if (dc.DataType == typeof(string))
                {
                    dc.ReadOnly = false;
                    needTrimColumn.Add(dc);
                }
            }

            if (needTrimColumn.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    foreach (DataColumn dc in needTrimColumn)
                    {
                        if (dr[dc] == null)
                            dr[dc] = "";
                        else
                            dr[dc] = dr[dc].ToString().Trim();
                    }
                }
            }
        }

        protected string QueryForConStr()
        {

            ISqlMapSession session = new SqlMapSession(mapper);
            if (mapper.LocalSession != null)
            {
                session = mapper.LocalSession;
            }
            else
            {
                session = mapper.OpenConnection();
            }
            return session.DataSource.ConnectionString;


        }

        protected IDbConnection QueryForConnection()
        {
            ISqlMapSession session = new SqlMapSession(mapper);
            if (mapper.LocalSession != null)
            {
                session = mapper.LocalSession;
            }
            else
            {
                session = mapper.OpenConnection();
            }
            return session.Connection;

        }

        protected ISqlMapSession QueryForSession()
        {
            ISqlMapSession session = new SqlMapSession(mapper);
            if (mapper.LocalSession != null)
            {
                session = mapper.LocalSession;
            }
            else
            {
                session = mapper.OpenConnection();
            }
            return session;
        }

        static string GetContent(string xmlPath, string statement)
        {
            string s = string.Empty;
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.Load(xmlPath);

            XmlNode sqlMapNode = xmldoc.ChildNodes[1];

            XmlNode statementsNode = null;
            foreach (XmlNode nl in sqlMapNode.ChildNodes)
            {
                if (nl.Name == "statements") statementsNode = nl;
            }

            if (statementsNode == null) return string.Empty;

            foreach (XmlNode nl in statementsNode.ChildNodes)
            {
                if (nl.Attributes != null)
                {
                    if (sqlMapNode.Attributes["namespace"].Value + "." + nl.Attributes["id"].Value == statement)
                    {
                        if (!nl.InnerXml.Contains("<include"))
                        {
                            s = nl.InnerText;
                        }
                        else
                        {
                            //��Ҫ�滻InnerXml �е�include
                            XmlDocument childXml = new XmlDocument();
                            XmlNode declaration = childXml.CreateXmlDeclaration("1.0", "gb2312", null);
                            childXml.AppendChild(declaration);//ͷ����

                            XmlElement xeRoot = childXml.CreateElement("statement");
                            xeRoot.InnerXml = nl.InnerXml; //���ݷŵ��½���xml
                            childXml.AppendChild(xeRoot);//���ڵ�

                            XmlNode sqlNode = childXml.ChildNodes[1];

                            foreach (XmlNode cnode in sqlNode.ChildNodes)
                            {
                                if (cnode.Name == "include")
                                {   //ȡInclude����
                                    s += GetContent(xmlPath, sqlMapNode.Attributes["namespace"].Value + "." + cnode.Attributes["refid"].Value) + Environment.NewLine;
                                }
                                else
                                {
                                    s += cnode.InnerText + Environment.NewLine;
                                }
                            }
                        }
                        break;
                    }
                }
            }
            return s;
        }

        public string GetStatementSQL(string statementName, object paramObject)
        {
            //paramObject = ChangeEmptyToKG(paramObject);
            IStatement statement = mapper.GetMappedStatement(statementName).Statement;
            IMappedStatement mapStatement = mapper.GetMappedStatement(statementName);

            ISqlMapSession session = SessionManager.getSession(mapper);
            RequestScope request = statement.Sql.GetRequestScope(mapStatement, paramObject, session);
            mapStatement.PreparedCommand.Create(request, session, statement, paramObject);
            return request.IDbCommand.CommandText;
        }

        #endregion
    }
}
