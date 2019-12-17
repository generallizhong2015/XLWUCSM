using System;
using System.Collections.Generic;
using System.Text;
using IBatisNet.Common.Utilities.Objects.Members;
using System.Reflection;
using IBatisNet.Common.Utilities.Objects;

namespace IDataAccess
{
    public class SetAccessor : ISetAccessor
    {
        private PropertyInfo _propertyInfo = null;
        private string _propertyName = string.Empty;
        private Type _targetType = null;

        public SetAccessor(Type targetType, string propertyName)
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

        #region ISet 成员
        public void Set(object target, object value)
        {

            if (!_propertyInfo.CanWrite)
            {
                throw new NotSupportedException(string.Format("Property \"{0}\" on type {1} doesn't have a set method.", this._propertyName, this._targetType));
            }

            try
            {
                if (_propertyInfo.PropertyType == typeof(string))
                {
                    if (value != null)
                    {
                        string v = value.ToString();
                        v = v.Trim();
                        value = v;
                    }
                    else
                    {
                        value = string.Empty;
                    }
                }

                if (_propertyInfo.PropertyType == typeof(bool))
                {
                    int i = Convert.ToInt32(value);
                    value = i == 0 ? false : true;
                }

                if (_propertyInfo.PropertyType == typeof(double))
                {
                    double d = Convert.ToDouble(value);
                    value = d;
                }
                this._propertyInfo.SetValue(target, value, null);
            }
            catch
            { throw new Exception("转换失败:" + _propertyInfo.Name); }
        }
        #endregion
    }
}
