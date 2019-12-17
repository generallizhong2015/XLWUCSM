/****************************************************************************
 * 创建人：   蒋鹏飞
 * 创建时间：2014年08月14日 17:27:45
 * 创建说明：sord实体类
 * 
 * 修改人：
 * 修改时间：
 * 修改说明： 
****************************************************************************/
using System;

namespace Models
{
    public class SORD
    {
        public SORD()
        {
            SUBDT = DateTime.Now;
            ECTIME = 2;
            STT = "0";
            VERSION = 1;
            ISDELETE = 0;
            PRCDT = DateTime.Now;
            ACCDT = DateTime.Now;
            LASTREPLYDT = DateTime.MinValue;
        }

        /// <summary>
        /// 服务单号
        /// </summary>
        public string ORDNO { get; set; }

        /// <summary>
        /// 提交时间
        /// </summary>
        public DateTime SUBDT { get; set; }

        /// <summary>
        /// 提交客户
        /// </summary>
        public string SUBCUS { get; set; }

        /// <summary>
        /// 提交客户名称
        /// </summary>
        public string SUBCUSNAME { get; set; }

          /// <summary>
        /// 提交客户电话
        /// </summary>
        public string SUBCUSTEL { get; set; }

        /// <summary>
        /// 提交人员信息
        /// </summary>
        public string SUBMANINF { get; set; }

        /// <summary>
        /// 提交人员
        /// </summary>
        public string SUBMAN { get; set; }

        /// <summary>
        /// 提交人员名称
        /// </summary>
        public string SUBMANNAME { get; set; }

        /// <summary>
        /// 提交人员联系电话
        /// </summary>
        public string SUBMANMOVTEL { get; set; }

        /// <summary>
        /// 提交人员图片
        /// </summary>
        public string SUBMANPIC { get; set; }

        /// <summary>
        /// 服务正文
        /// </summary>
        public string SUBTXT { get; set; }

        /// <summary>
        /// 处理人信息
        /// </summary>
        public string PRCMANINF { get; set; }

        /// <summary>
        /// 处理人
        /// </summary>
        public string PRCMAN { get; set; }

        /// <summary>
        /// 处理人名称
        /// </summary>
        public string PRCMANNAME { get; set; }

        /// <summary>
        /// 开始处理时间
        /// </summary>
        public DateTime PRCDT { get; set; }
        
        /// <summary>
        /// 处理人图片
        /// </summary>
        public string PRCMANPIC { get; set; }
        /// <summary>
        ///报错截图
        /// </summary>
        public string USRIMG { get; set; }

        /// <summary>
        /// 处理结果及方法
        /// </summary>
        public string PRCMTHRSTL { get; set; }

        /// <summary>
        /// 预计时间
        /// </summary>
        public double ECTIME { get; set; }

        /// <summary>
        /// 服务类型
        /// </summary>
        public string SERTYP { get; set; }

        /// <summary>
        /// 服务类型名称
        /// </summary>
        public string SERTYPNAME { get; set; }

        /// <summary>
        /// IP地址
        /// </summary>
        public string IPADR { get; set; }

        /// <summary>
        /// 状态 
        /// 0:服务申请中  30:服务处理中   50:用户验收中  90:用户已验收  -1:作废
        /// </summary>
        public string STT { get; set; }

        /// <summary>
        /// 状态名称
        /// </summary>
        public string STTNAME { get; set; }

        /// <summary>
        /// 版本号
        /// </summary>
        public int VERSION { get; set; }

        /// <summary>
        /// 删除标识
        /// </summary>
        public int ISDELETE { get; set; }
        /// <summary>
        /// 验收时间
        /// </summary>
        public DateTime ACCDT { get; set; }

        /// <summary>
        /// 最后回复信息
        /// </summary>
        public string LASTREPLYINF { get; set; }

        /// <summary>
        /// 最后回复人
        /// </summary>
        public string LASTREPLYMAN { get; set; }

        /// <summary>
        /// 最后回复人名称
        /// </summary>
        public string LASTREPLYMANNAME { get; set; }

        /// <summary>
        /// 最后回复时间
        /// </summary>
        public DateTime LASTREPLYDT { get; set; }
        /// <summary>
        /// 远程类型
        /// T：Teamview  P：pcanywhere
        /// </summary>
        public string SERSYS { get; set; }
        /// <summary>
        /// 远程账号
        /// </summary>
        public string USRNUM { get; set; }
        /// <summary>
        /// 远程密码
        /// </summary>
        public string USRPASS { get; set; }
        /// <summary>
        /// 故障描述
        /// </summary>
        public string FAULT { get; set; }
        /// <summary>
        /// 跟踪人
        /// </summary>
        public string Tracer { get; set; }
        /// <summary>
        /// 回访人
        /// </summary>
        public string Revisit { get; set; }
        /// <summary>
        /// 是否跟踪 0: 否  1:是
        /// </summary>
        public int TracerStt { get; set; }
        /// <summary>
        /// 是否回访  0: 否  1:是
        /// </summary>
        public int RevisitStt { get; set; }
        /// <summary>
        /// 回访内容
        /// </summary>
        public string RevisitTxt { get; set; }
        /// <summary>
        /// s是否超级管理员
        /// </summary>
        //public string ISSYS { get; set; }
    }
}