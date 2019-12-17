using System;
using System.Collections.Generic;
using System.Text;
using IBatisNet.DataMapper.TypeHandlers;

namespace IDataAccess
{
    public class NullValueTypeHandlerCallback : ITypeHandlerCallback
    {
        #region ITypeHandlerCallback members

        public object ValueOf(string sValue)
        {
            if (sValue == "")
            {
                return System.DBNull.Value;
            }
            else
            {
                return sValue;
            }
        }

        public object GetResult(IResultGetter getter)
        {
            if (getter.Value == System.DBNull.Value||getter.Value ==" ")
            {
                return "";
            }
            else
            {
                return getter.Value as string;
            }
        }

        public void SetParameter(IParameterSetter setter, object parameter)
        {
            string s = Convert.ToString(parameter);
            if (s == string.Empty)
            {
                setter.Value = "";
            }
            else
            {
                setter.Value = s;
            }
        }

        public object NullValue
        {
            get { return "\0"; }
        }

        #endregion
    }

}
