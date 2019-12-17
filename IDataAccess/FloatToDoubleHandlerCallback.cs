using System;
using System.Collections.Generic;
using System.Text;
using IBatisNet.DataMapper.TypeHandlers;

namespace IDataAccess
{
    public class FloatToDoubleHandlerCallback : ITypeHandlerCallback
    {
        #region ITypeHandlerCallback 成员

        public object GetResult(IResultGetter getter)
        {
            // 用于将从数据库读取的值转换成.NET中的值  
            // 再用显示转换将decimal转换成double
            if (getter.Value == System.DBNull.Value || getter.Value == " ")
            {
                return 0d;
            }//cq加，如果是NULL的情况，比如说left join商品档案的时候，商品已经没有了，所以商品的包装率left出来就是NULL

            decimal v1 = Convert.ToDecimal(getter.Value);
            double v2 = (double)v1;
            return v2;
        }

        public object NullValue
        {
            get
            {
                return 0.00;
            }
        }

        public void SetParameter(IParameterSetter setter, object parameter)
        {
            //将.NET中的double型转换成decimal
            decimal v1 = Convert.ToDecimal(parameter);
            setter.Value = v1;
        }

        public object ValueOf(string s)
        {
            return s;
        }

        #endregion
    }
}
