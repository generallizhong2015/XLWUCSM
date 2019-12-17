using System;
using System.Collections.Generic;
using System.Text;
using IBatisNet.Common.Utilities.Objects.Members;
using System.Reflection;
using IBatisNet.Common.Utilities.Objects;

namespace IDataAccess
{
    public class GetAccessor : IGetAccessor
    {
        private PropertyInfo _propertyInfo = null;
        private string _propertyName = string.Empty;
        private Type _targetType = null;
        public GetAccessor(Type targetType, string propertyName)
        {
            try
            {
                ReflectionInfo reflectionCache = ReflectionInfo.GetInstance(targetType);
                _propertyInfo = (PropertyInfo)reflectionCache.GetGetter(propertyName);
                _targetType = targetType;
                _propertyName = propertyName;
            }
            catch
            {


            }

        }
        
        #region IAccessor 成员
        public Type MemberType
        {
            get { return _propertyInfo.PropertyType; }
        }
        public string Name
        {
            get { return _propertyInfo.Name; }

        }
        #endregion

        #region IGet 成员
        public object Get(object target)
        {
            if (!_propertyInfo.CanRead)
            {
                throw new NotSupportedException(string.Format("Property \"{0}\" on type {1} doesn't have a get method.", this._propertyName, this._targetType));
            }

            try
            {
                object ret = _propertyInfo.GetValue(target, null);
                if (_propertyInfo.PropertyType == typeof(string))
                {
                    string r = ret as string;
                    if (r == string.Empty)
                    {
                        r = " ";
                        ret = r;
                    }
                }

                if (_propertyInfo.PropertyType == typeof(bool))
                {
                    bool r = Convert.ToBoolean(ret);
                    ret = r ? 1 : 0;
                }

                return ret;
            }
            catch
            { throw new Exception("转换失败:" + _propertyInfo.Name); }
        }
        #endregion
    }
}
