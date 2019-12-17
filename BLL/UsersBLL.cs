using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using BLL.Common;
using IBLL;
using IDAL;
using Models;

namespace BLL
{
    class UsersBLL : FounDationBLL, IUsersBLL
    {
        IUsersDAL usersDAL { set; get; }
        IMdlDAL mdlDAL { set; get; }
        IUserPwrDAL UserPwrDAL { get; set; }
        public USERS Select(string p_USERID, string p_LOGID, string p_USERTYP, string p_CUSID, string p_MOVTEL, string p_EMAIL)
        {
            return usersDAL.Select(p_USERID, p_LOGID, p_USERTYP, p_CUSID,  p_MOVTEL,  p_EMAIL);
        }

        public IList<USERS> Select(Hashtable h_users)
        {
            return usersDAL.Select(h_users);
        }

        public IList<USERS> SelectLike(Hashtable h_users)
        {
            return usersDAL.SelectLike(h_users);
        }

        public void Insert(USERS p_users)
        {
            usersDAL.Insert(p_users);
            SetUserPwr(p_users.USERTYP,p_users.USERID,p_users.ISSYS);
        }


        public void Insert(IList<USERS> p_users)
        {
            foreach (USERS User in p_users)
            {
                usersDAL.Insert(User);
            }
        }

        public void Update(USERS p_users)
        {
            usersDAL.Update(p_users);
        }

        public void Delete(USERS p_users)
        {
            usersDAL.Delete(p_users);
        }


        //public USERS SelectByLogID(string p_LOGID)
        //{
        //    return usersDAL.SelectByLogID(p_LOGID);
        //}

        //public USERS SelectByCusID(string p_CUSID)
        //{
        //    return usersDAL.SelectByCusID(p_CUSID);
        //}
        /// <summary>
        /// 产生用户编号
        /// </summary>
        /// <returns></returns>
        public string SetUserid()
        {
            string MaxID = usersDAL.SelectMaxUserid();
            int iCurId = 0;
            if (String.IsNullOrEmpty(MaxID)) iCurId = 0;
            else iCurId = int.Parse(MaxID);
            string CurCusId = (++iCurId).ToString().PadLeft(8, '0');
            return CurCusId;
        }

        /// <summary>
        /// 设置权限
        /// </summary>
        /// <param name="userid">用户类型（01客服  02客户）</param>
        /// <param name="userid">用户ID</param>
        /// <param name="issys">是否是管理员（T是，F否）</param>
        public void SetUserPwr(string usertyp,string userid, string issys)
        {
            string strmdlid = string.Empty;
            string strpwrid = string.Empty;

            string mdlid = string.Empty;
            string pwrid = string.Empty;


            Hashtable ht = new Hashtable();
            ht["MDLTYP"] = usertyp == "01" ? "01" : "02";
            IList<MDL> mdl = mdlDAL.Select(ht);
            if (!string.IsNullOrEmpty(userid))
            {
                Hashtable h = new Hashtable();
                h["USERID"] = userid;
                IList<USERPWR> userpwr = UserPwrDAL.Select(h);
                userpwr.ToList().ForEach(u => UserPwrDAL.Delete(u));
                userpwr.Clear();

                foreach (var mdlitem in mdl)
                {
                    strmdlid = mdlitem.MDLID;
                    strpwrid = mdlitem.FUNGRP;
                    string[] str_pwrid = strpwrid.Split(',');
                    for (var i = 0; i < str_pwrid.Length; i++)
                    {
                        mdlid = strmdlid;
                        pwrid = str_pwrid[i];

                        if (usertyp=="01"||issys == "T") //超级管理员
                        {
                            USERPWR up = new USERPWR();
                            up.USERID = userid;
                            up.MDLID = mdlid;
                            up.PWRID = pwrid;
                            userpwr.Add(up);
                        }
                        else if (mdlid != "USERGRP")
                        {
                            USERPWR up = new USERPWR();
                            up.USERID = userid;
                            up.MDLID = mdlid;
                            up.PWRID = pwrid;
                            userpwr.Add(up);
                        }
                    }


                }

                UserPwrDAL.Insert(userpwr);

            }
        }

    }
}