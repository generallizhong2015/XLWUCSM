using System.Collections;
using System.Collections.Generic;
using System.Linq;
using BLL.Common;
using IBLL;
using IDAL;
using Models;
using Spring.Transaction.Interceptor;
using System;

namespace BLL
{
    class SordBLL : FounDationBLL, ISordBLL
    {
        ISordDAL SordDAL { get; set; }
        ISordDtlDAL SordDtlDAL { get; set; }
        ISttCfgDAL SttCfgDAL { get; set; }
        ITaskDealDAL TaskDealDAL { get; set; }
        IApprDAL ApprDAL { get; set; }

        //[Transaction(ReadOnly = true)]
        public SORD Select(string p_ordno)
        {
            //数据权限
            if (GetCurUser().USERTYP == "02")
                return new List<SORD>() { Handle(SordDAL.Select(p_ordno)) }.FirstOrDefault(p => p.SUBMAN == GetCurUser().USERID);
            else
                return Handle(SordDAL.Select(p_ordno));
        }
        //[Transaction(ReadOnly = true)]
        public IList<SORD> Select(Hashtable h_sord)
        {
            return Handle(SordDAL.Select(h_sord));
        }
        public int SelectCount(Hashtable h_sord)
        {
            return SordDAL.SelectCount(h_sord);
        }
        [Transaction(ReadOnly = true)]
        public void Insert(SORD p_sord)
        {
            p_sord.ORDNO = SordDAL.GetCurNo();
            SordDAL.Insert(p_sord);

            //任务记录
            TaskDealDAL.Insert(new TASKDEAL() { NODID = p_sord.STT, ORDNO = p_sord.ORDNO, PRCR = p_sord.SUBMAN, BRF = "提交了派工单！" });
        }
        //[Transaction(ReadOnly = false)]
        public void Update(SORD p_sord)
        {
            SORD l_sord = Select(p_sord.ORDNO);
            //VERSION处理
            ContrastVersion(l_sord, p_sord);

            if (GetCurUser().USERTYP == "01")
            {
                if (String.IsNullOrEmpty(p_sord.PRCMAN)) p_sord.PRCMAN = GetCurUser().USERID;
            }
            else if (l_sord.SUBMAN != GetCurUser().USERID) return;

            SordDAL.Update(p_sord);
            //任务记录
            if (l_sord.STT != p_sord.STT)
            {
                Hashtable h = new Hashtable();
                h["NODTYP"] = "STT";
                IList<STTCFG> STTCFGs = SttCfgDAL.Select(h);
                TaskDealDAL.Insert(new TASKDEAL() { NODID = p_sord.STT, ORDNO = p_sord.ORDNO, PRCR = GetCurUser().USERID, BRF = "处理了派工单！状态由[" + STTCFGs.First(s => s.NODDTSTT == l_sord.STT).NODNAME + "]变为[" + STTCFGs.First(s => s.NODDTSTT == p_sord.STT).NODNAME + "]。" });
            }
            if (l_sord.TracerStt != p_sord.TracerStt)
            {
                string iSTrac = p_sord.TracerStt == 1 ? "跟踪了派工单" : "取消了跟踪!";
                TaskDealDAL.Insert(new TASKDEAL() { NODID = p_sord.STT, ORDNO = p_sord.ORDNO, PRCR = GetCurUser().USERID, BRF = iSTrac });
            }
                
            if (l_sord.RevisitStt != p_sord.RevisitStt)
                TaskDealDAL.Insert(new TASKDEAL() { NODID = p_sord.STT, ORDNO = p_sord.ORDNO, PRCR = GetCurUser().USERID, BRF = "回访了客户。" });
        }
        public void UpdateSord(SORD p_sord)
        {
            
            SORD l_sord = Select(p_sord.ORDNO);
            DateTime subdt = l_sord.SUBDT;
            //VERSION处理
            ContrastVersion(l_sord, p_sord);
            //&& String.IsNullOrEmpty(p_sord.PRCMAN)
            if (GetCurUser().USERTYP == "01")
            {
                //p_sord.PRCMAN = GetCurUser().USERID;
                if (String.IsNullOrEmpty(p_sord.PRCMAN)) p_sord.PRCMAN = GetCurUser().USERID;
            }

            else if (l_sord.SUBMAN != GetCurUser().USERID) 
                return;

            SordDAL.UpdateSord(p_sord);
            //任务记录
            if (l_sord.STT != p_sord.STT)
            {
                Hashtable h = new Hashtable();
                h["NODTYP"] = "STT";
                IList<STTCFG> STTCFGs = SttCfgDAL.Select(h);
                TaskDealDAL.Insert(new TASKDEAL() { NODID = p_sord.STT, ORDNO = p_sord.ORDNO, PRCR = GetCurUser().USERID, BRF = "处理了派工单！状态由[" + STTCFGs.First(s => s.NODDTSTT == l_sord.STT).NODNAME + "]变为[" + STTCFGs.First(s => s.NODDTSTT == p_sord.STT).NODNAME + "]。" });
                    
            }
            //if(l_sord.TracerStt!=p_sord.TracerStt)
            //    TaskDealDAL.Insert(new TASKDEAL() { NODID = p_sord.STT, ORDNO = p_sord.ORDNO, PRCR = p_sord.Tracer, BRF = "跟踪了派工单。" });
            //if(l_sord.RevisitStt!=p_sord.RevisitStt)
            //    TaskDealDAL.Insert(new TASKDEAL() { NODID = p_sord.STT, ORDNO = p_sord.Revisit, PRCR = p_sord.Tracer, BRF = "回访了客户。" });
        }
        //[Transaction(ReadOnly = false)]
        public void Delete(SORD p_sord)
        {
            if (GetCurUser().USERTYP == "02" && p_sord.SUBMAN != GetCurUser().USERID) return;

            Hashtable h = new Hashtable();
            h["ORDNO"] = p_sord.ORDNO;
            p_sord.PRCMAN = GetCurUser().USERID;
            TaskDealDAL.Insert(new TASKDEAL() { NODID = p_sord.STT, ORDNO = p_sord.ORDNO, PRCR = GetCurUser().USERID, BRF = "删除派工单！" });
            SordDAL.Delete(p_sord);
        }


        public IList<TASKDEAL> SelectTaskDeal(Hashtable h_taskdeal)
        {
            return TaskDealDAL.Select(h_taskdeal);
        }

        /// <summary>
        /// 处理数据
        /// </summary>
        /// <param name="SORD"></param>
        /// <returns></returns>
        SORD Handle(SORD SORD)
        {
            if (!string.IsNullOrEmpty(SORD.SUBMANINF))
            {
                string[] AY = SORD.SUBMANINF.Split('|');
                SORD.SUBMAN = AY[0];
                SORD.SUBMANNAME = AY[1];
                SORD.SUBMANMOVTEL = AY[2];
                SORD.SUBMANPIC = AY[3];
            }
            if (!string.IsNullOrEmpty(SORD.LASTREPLYINF))
            {
                string[] AY = SORD.LASTREPLYINF.Split('|');
                SORD.LASTREPLYDT = DateTime.Parse(AY[0]);
                SORD.LASTREPLYMAN = AY[1];
                SORD.LASTREPLYMANNAME = AY[2];
            }
            if (!string.IsNullOrEmpty(SORD.PRCMANINF))
            {
                string[] AY = SORD.PRCMANINF.Split('|');
                SORD.PRCMAN = AY[0];
                SORD.PRCMANNAME = AY[1];
                SORD.PRCMANPIC = AY[2];
            }
            return SORD;
        }

        /// <summary>
        /// 处理数据
        /// </summary>
        /// <param name="SORDs"></param>
        /// <returns></returns>
        IList<SORD> Handle(IList<SORD> SORDs)
        {
            foreach (var SORD in SORDs)
                Handle(SORD);
            return SORDs;
        }


        public IList<TASKDEAL> SelectTrack(string p_ordno)
        {
            Hashtable h = new Hashtable();
            h["ORDNO"] = p_ordno;
            return TaskDealDAL.Select(h);
        }

        public IList<SORDDTL> SelectReply(string p_ordno)
        {
            Hashtable h = new Hashtable();
            h["ORDNO"] = p_ordno;
            return SordDtlDAL.Select(h);
        }

        public IList<APPR> SelectReview(string p_ordno)
        {
            Hashtable h = new Hashtable();
            h["ORDNO"] = p_ordno;
            return ApprDAL.Select(h);
        }
    }
}
