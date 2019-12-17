using System;
using System.Collections.Generic;
using System.Text;
using IBatisNet.Common.Utilities.Objects.Members;

namespace IDataAccess
{
    public class GetAccessorFactory : IGetAccessorFactory
    {
        #region IGetAccessorFactory 成员

        public IGetAccessor CreateGetAccessor(Type targetType, string name)
        {
            return new GetAccessor(targetType, name);

        }

        #endregion
    }
}
