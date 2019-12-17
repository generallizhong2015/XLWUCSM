<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SordTrack</title>
    <script src="<%=Url.Content("~/Scripts/boot.js")%>" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            background: none;
            width: 99%;
            height: 99%;
        }
    </style>
</head>
<body>
    <div>
        <%
            if ((TempData["TASKDEALs"] as IList<Models.TASKDEAL>).Count == 0)
            {
        %>
        <table class="emptyScrCtrl">
            <tbody>
                <tr>
                    <td>
                        <img class="emptyScrImage" alt="" src="<%=Url.Content("~/Images/subtasks-logo.png")%>">
                    </td>
                    <td>
                        <div class="emptyScrTd">
                            <div class="emptyScrHead">
                                跟踪</div>
                            <div class="emptyScrHeadDscr">
                                暂无跟踪</div>
                            <div class="emptyScrDscr">
                                可查看有关此服务事项的进展跟踪。</div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <%
            }
        %>
        <%
            int i = (TempData["TASKDEALs"] as IList<Models.TASKDEAL>).Count;
            foreach (Models.TASKDEAL TASKDEAL in TempData["TASKDEALs"] as IList<Models.TASKDEAL>)
            {
                i--;
        %>
        <div class="linkTrack<%=i==0?" current":"" %>">
            <span style="width: 150px; display: block; float: left;" title="<%=TASKDEAL.PRCDT.ToString("yyyy-MM-dd HH:mm:ss") %>">
                <%=WUCSM.Helpers.DateTimeConvert.DateToString(TASKDEAL.PRCDT)%>
            </span><span>
                <%="["+TASKDEAL.PRCRNAME +"]"+ TASKDEAL.BRF%>
            </span>
        </div>
        <%  
}
        %>
    </div>
</body>
</html>
