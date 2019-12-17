using System;
using System.Collections.Generic;
using System.Text;
using IBatisNet.Common.Utilities.Objects.Members;

namespace IDataAccess
{
    public class SetAccessorFactory : ISetAccessorFactory
    {
        #region ISetAccessorFactory 成员

        public ISetAccessor CreateSetAccessor(Type targetType, string name)
        {
            return new SetAccessor(targetType, name);
        }

        #endregion
    }
}
