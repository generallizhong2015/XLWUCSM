using System.Runtime.InteropServices;

namespace Transaction
{
    [Guid("17CF72D0-BAC5-11d1-B1BF-00C04FC2F3EF")]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface ITipTransaction
    {
        void Push([In, MarshalAs(UnmanagedType.LPStr)] string pszRemoteTmUrl,
            [In, Out, MarshalAs(UnmanagedType.LPStr)] ref string ppszRemoteTxUrl);

        void GetTransactionUrl([In, Out, MarshalAs(UnmanagedType.LPStr)] 
			ref string ppszLocalTxUrl);
    }
}
