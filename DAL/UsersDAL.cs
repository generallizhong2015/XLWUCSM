using System;
using System.Collections;
using System.Collections.Generic;
using DAL.Common;
using IDAL;
using Models;

namespace DAL
{
    class UsersDAL : FounDationDAL, IUsersDAL
    {
        public USERS Select(string p_USERID, string p_LOGID, string p_USERTYP, string p_CUSID, string p_MOVTEL, string p_EMAIL)
        {
            Hashtable h_users = new Hashtable();
            h_users["USERID"] = p_USERID;
            h_users["LOGID"] = p_LOGID;
            h_users["USERTYP"] = p_USERTYP;
            h_users["CUSID"] = p_CUSID;
            h_users["MOVTEL"] = p_MOVTEL;
            h_users["EMAIL"] = p_EMAIL;
            return QueryForObject<USERS>("users_map.users_select", h_users);
        }

        public IList<USERS> Select(Hashtable h_users)
        {
            return QueryForList<USERS>("users_map.users_select", h_users);
        }
        public IList<USERS> SelectLike(Hashtable h_users)
        {
            return QueryForList<USERS>("users_map.users_selectlike", h_users);
        }

        public void Insert(USERS p_users)
        {
            ExecuteSQL("users_map.users_insert", p_users);
        }

        public void Update(USERS p_users)
        {
            ExecuteSQL("users_map.users_update", p_users);
        }

        public void Delete(USERS p_users)
        {
            ExecuteSQL("users_map.users_delete", p_users);
        }

        //public USERS SelectByLogID(string p_LOGID)
        //{
        //    Hashtable h_users = new Hashtable();
        //    h_users["LOGID"] = p_LOGID;
        //    return QueryForObject<USERS>("users_map.usersbylogid_select", h_users);
        //}

        //public USERS SelectByCusID(string p_CUSID)
        //{
        //    Hashtable h_users = new Hashtable();
        //    h_users["CUSID"] = p_CUSID;
        //    return QueryForObject<USERS>("users_map.usersbycusid_select", h_users);
        //}

        public string SelectMaxUserid()
        {
            object obj = QueryForObject("users_map.getmaxid", null);
            if (obj == null) return "";
            else return obj.ToString();
        }
    }
}