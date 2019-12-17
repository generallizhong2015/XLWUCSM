using System.Collections;
using System.Collections.Generic;
using BLL.Common;
using IBLL;
using IDAL;
using Models;
using System;

namespace BLL
{
    class CusBLL : FounDationBLL, ICusBLL
    {
        ICusDAL CusDAL { set; get; }
        public CUS Select(string p_cusid)
        {
            return CusDAL.Select(p_cusid);
        }

        public IList<CUS> Select(Hashtable h_cus)
        {
            return CusDAL.Select(h_cus);
        }

        public void Insert(CUS p_cus)
        {
            CusDAL.Insert(p_cus);
        }

        public void Insert(IList<CUS> p_cuslist)
        {
            foreach (CUS Cus in p_cuslist)
            {
                CusDAL.Insert(Cus);
            }
        }

        public void Update(CUS p_cus)
        {
            CusDAL.Update(p_cus);
        }

        public void Delete(CUS p_cus)
        {
            CusDAL.Delete(p_cus);
        }

        public string GetMaxCusId(string prefix)
        {
            if (prefix.Length == 8) return prefix;
            int iCurId = 0;
            string CurCusId = "";
            string MaxID = "";

            if (string.IsNullOrEmpty(prefix))
            {
                MaxID = CusDAL.GetMaxCusId();
                if (String.IsNullOrEmpty(MaxID)) iCurId = 0;
                else iCurId = int.Parse(MaxID);
                CurCusId = (++iCurId).ToString().PadLeft(8, '0');
                return CurCusId;
            }
            else
            {
                MaxID = CusDAL.GetMaxCusIdByPrefix(prefix);
                if (String.IsNullOrEmpty(MaxID)) iCurId = 0;
                else
                {
                    int pos = 0;
                    string tmp = MaxID.Remove(0, prefix.Length);
                    for (int i = 0; i < tmp.Length; i++)
                    {
                        int tmpCode = (int)tmp[i];
                        if ((tmpCode >= 65 && tmpCode <= 90) || (tmpCode >= 97 && tmpCode <= 122))
                        {
                            pos = i;
                        }
                    }
                    if (pos == tmp.Length) iCurId = 1;
                    else iCurId = int.Parse(tmp.Substring(pos + 1));
                }
                CurCusId = prefix + (++iCurId).ToString().PadLeft(8 - prefix.Length, '0');
                return CurCusId;
            }
        }

        public int Select_RecordCount(Hashtable h_cus)
        {
            return CusDAL.Select_RecordCount(h_cus);
        }
    }
}
