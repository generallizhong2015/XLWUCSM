using System;

namespace WUCSM.Helpers
{
    public class DateTimeConvert
    {
        /// <summary>
        /// 时间转换
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public static string DateToString(DateTime date)
        {
            if (date == DateTime.MinValue) return "";
            TimeSpan ts = DateTime.Now - date;
            if (ts.Days == 0 && ts.Hours == 0 && ts.Minutes >= 0)
                return (ts.Minutes + 1) + "分钟前";
            DateTime today = DateTime.Now.Date;
            if (date.Date == today) return "今天 " + date.ToString("HH:mm:ss");
            else if (date.Date == today.AddDays(-1)) return "昨天 " + date.ToString("HH:mm:ss");
            else if (date.Date == today.AddDays(-2)) return "前天 " + date.ToString("HH:mm:ss");
            else if (date.Date == today.AddDays(1)) return "明天 " + date.ToString("HH:mm:ss");
            else if (date.Date == today.AddDays(2)) return "后天 " + date.ToString("HH:mm:ss");
            return date.ToString("yyyy-MM-dd HH:mm:ss");
        }
    }
}