using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace WUCSM.Helpers
{
    public class ErrorLog
    {
        /// <summary>
        /// 记录错误日志
        /// </summary>
        /// <param name="funName">执行方法名</param>
        /// <param name="errMsg">错误信息</param>
        public static void WriteErrLog(string funName, string errMsg)
        {

            string errorTxt = "";//日志内容
            //日志存储路径
            string fileDirectory = HttpContext.Current.Server.MapPath("/App_Data/ErrLog/");
            //日志文件名
            string logName = DateTime.Now.ToString("yyyyMMdd") + ".txt";
            //日志存储
            string fileName = fileDirectory + logName;
            try
            {
                if (!Directory.Exists(fileDirectory))
                {
                    Directory.CreateDirectory(fileDirectory);
                }
                if (!File.Exists(fileName))
                {

                    StreamWriter sw;
                    sw = File.CreateText(fileName);
                    sw.Close();

                }
                errorTxt = Convert.ToString(Convert.ToDateTime(DateTime.Now).ToString("yyyy-MM-dd HH:mm:ss")) + "  方法名：" + funName + "， 错误信息：" + errMsg + Environment.NewLine;
                File.AppendAllText(fileName, errorTxt);

            }
            catch
            {
                //
            }

        }// end
    }
}