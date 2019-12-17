using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Spring.Objects.Factory;
using IBatisNet.Common.Logging;
using IBatisNet.DataMapper;
using IBatisNet.DataMapper.Configuration;
using IBatisNet.Common.Utilities;
using System.Xml;
using IBatisNet.Common;
using System.Configuration;

namespace IDataAccess
{
    public class SqlMapClient : IInitializingObject
    {
        private String _sqlMapConfig;

        private ISqlMapper _mapper;
        private static readonly ILog log = LogManager.GetLogger(typeof(SqlMapClient));

        public string SqlMapConfig
        {
            get { return _sqlMapConfig; }
            set { _sqlMapConfig = value; }
        }


        public ISqlMapper mapper
        {
            get
            {
                return _mapper;
            }
        }

        public void AfterPropertiesSet()
        {
            DomSqlMapBuilder builder = new DomSqlMapBuilder();
            if (_sqlMapConfig.IndexOf("embedded:") != -1)
            {
                string[] location =
                    _sqlMapConfig.Split(new string[] { "embedded:" }, StringSplitOptions.RemoveEmptyEntries);
                log.Debug("Resource:" + location[0]);
                XmlDocument sqlMapConfig = Resources.GetEmbeddedResourceAsXmlDocument(location[0]);
                _mapper = builder.Configure(sqlMapConfig);
                _mapper.DataSource = new CentralizedDataSource(_mapper.DataSource);
            }
            else
            {
                if (SqlMapConfig == @"Config\ibatisconfig\SqlMapMySql.config")
                {
                    builder.SetAccessorFactory = new SetAccessorFactory();
                    builder.GetAccessorFactory = new GetAccessorFactory();
                }

                _mapper = builder.Configure(SqlMapConfig);
                _mapper.DataSource.ConnectionString = _mapper.DataSource.ConnectionString;
            }
        }
    }

    /// <summary>
    /// Wraps the datasource so that the *.config connectionString values may be used.
    /// </summary>
    public class CentralizedDataSource : IDataSource
    {
        public const string CONNECTIONSTRINGKEY = "default";
        private IDataSource _innerDataSource = null;

        public CentralizedDataSource(IDataSource innerDataSource)
        {
            _innerDataSource = innerDataSource;
        }

        public string Name
        {
            get { return _innerDataSource.Name; }
            set { _innerDataSource.Name = value; }
        }

        public string ConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings[CONNECTIONSTRINGKEY].ConnectionString; }
            set { }
        }

        public IDbProvider DbProvider
        {
            get { return _innerDataSource.DbProvider; }
            set { _innerDataSource.DbProvider = value; }
        }
    }
}
