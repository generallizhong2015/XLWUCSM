using System;
using System.Collections.Generic;
using System.Text;
using IBatisNet.DataMapper.TypeHandlers;

namespace IDataAccess
{
    public class BoolToStringHandlerCallback : ITypeHandlerCallback
    {
        #region ITypeHandlerCallback 成员

        public object GetResult(IResultGetter getter)
        {
            // 用于将从数据库读取的值转换成.NET中的值  
            // 再用显示转换将int转换成double
            if (getter.Value == DBNull.Value)
            {
                return false;
            }
            else
            {
                return !(Convert.ToString(getter.Value) == "F");
            }
        }

        public object NullValue
        {
            get
            {
                return false;
            }
        }

        public void SetParameter(IParameterSetter setter, object parameter)
        {
            //将.NET中的bool型转换成String
            bool v1 = Convert.ToBoolean(parameter);
            string v2 = v1 ? "T" : "F";
            setter.Value = v2;
        }

        public object ValueOf(string s)
        {
            return s;
        }

        #endregion
    }
}
