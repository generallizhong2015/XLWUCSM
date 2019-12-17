<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SordReview</title>
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
            if ((TempData["APPRs"] as IList<Models.APPR>).Count == 0)
            {
        %>
        <table class="emptyScrCtrl">
            <tbody>
                <tr>
                    <td>
                        <img class="emptyScrImage" alt="" src="<%=Url.Content("~/Images/massages-logo.png")%>">
                    </td>
                    <td>
                        <div class="emptyScrTd">
                            <div class="emptyScrHead">
                                评论</div>
                            <div class="emptyScrHeadDscr">
                                暂无评论</div>
                            <div class="emptyScrDscr">
                                给服务事项评论，以：改善服务质量；给予建议批评。</div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <%if ((bool)TempData["CanReview"])
          {
        %>
        <a class="mini-button " iconcls="icon-add" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("SORDEL","review") %>
            style="margin: 5px; <%=(Session["CurUser"] as Models.USERS).USERTYP == "02"?"": "display:none;"%>"
            onclick="onClick">发表评论</a>
        <%
            }
        %>
        <%
            }
        %>
        <div id="divke" style="display: none; width: 100%;">
            <div id="newstar" style="font-weight: bold; font-size: 13px;">
                满意度：
            </div>
            <textarea id="ke" name="content" style="width: 100%; height: 250px;">
            </textarea>
            <div style="text-align: center; padding: 8px;">
                <a class="mini-button" onclick="onOk" style="width: 60px; margin-right: 20px;">确定</a>
                <a class="mini-button" onclick="onCancel" style="width: 60px;">关闭</a>
            </div>
        </div>
        <%
            foreach (Models.APPR APPR in TempData["APPRs"] as IList<Models.APPR>)
            {
        %>
        <div class="replyitem">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="width: 40px;">
                        <img class="userMiniPhoto" alt="" src="<%=Url.Content(string.IsNullOrEmpty((TempData["SORD"] as Models.SORD).SUBMANPIC)?"~/Images/user.png":"~"+(TempData["SORD"] as Models.SORD).SUBMANPIC)%>" />
                    </td>
                    <td>
                        <a class="linkHeader">
                            <%=(TempData["SORD"] as Models.SORD).SUBMANNAME%></a> <span class="textSmallDescribe"
                                title="<%=APPR.APPRDT.ToString("yyyy-MM-dd HH:mm:ss") %>">
                                <%=WUCSM.Helpers.DateTimeConvert.DateToString(APPR.APPRDT)%></span> &nbsp;&nbsp;&nbsp;&nbsp;<span
                                    id="star<%=APPR.APPRID %>"> </span>
                        <script type="text/javascript">
                            $(function () {
                                $('#star<%=APPR.APPRID %>').raty({
                                    hintList: ['很不满意', '不满意', '满意', '很满意', '非常满意'],
                                    readOnly: true,
                                    start: parseInt('<%=APPR.DGR %>'),
                                    path: '<%=Url.Content("~/Images")%>',
                                    starOn: 'star-on.png',
                                    starOff: 'star-off.png'
                                });
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td style="<%=(Session["CurUser"] as Models.USERS).USERTYP == "02"?"": "display:none;"%>">
                        <%=APPR.APPRTXT%>
                    </td>
                </tr>
            </table>
        </div>
        <%
            }
        %>
        <script type="text/javascript">
            $(function () {
                $('#newstar').raty({
                    hintList: ['很不满意', '不满意', '满意', '很满意', '非常满意'],
                    start: 5,
                    path: '<%=Url.Content("~/Images")%>',
                    starOn: 'star-on.png',
                    starOff: 'star-off.png'
                });
            });

            function onOk() {
                var editortxt = editor.html();
                if (!editortxt || editortxt == '') {
                    mini.showTips({ content: "评论不能为空！", state: 'warning', x: 'center', y: 'center', timeout: 3000 });
                    editor.focus();
                    return false;
                }
                RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="InsertReview" ,area="WUCSM"}) %>', '数据提交中...', { ordno: '<%=Request["ordno"] %>', apprtxt: editortxt, dgr: '0' + $('#newstar-score').val() }, function () { window.location.reload(); });
            }
            function onCancel() { $(divke).hide(); }
            mini.parse();
            var editorId = "ke";
            var editor = null;
            KindEditor.ready(function (K) {
                editor = K.create('#' + editorId, {
                    resizeType: 1,
                    uploadJson: '<%=Url.RouteUrl(new { controller="Upload",action="UploadFile" ,area="WUCSM"}) %>',
                    fileManagerJson: '<%=Url.RouteUrl(new { controller="Upload",action="UploadDirectory" ,area="WUCSM"})%>',
                    allowPreviewEmoticons: false,
                    allowImageUpload: true,
                    allowFileManager: true
                });
                prettyPrint();
            });
            function onClick() {
                $(divke).show();
                editor.html('').focus();
                $(document).scrollTop($(document.body).height() + 300);
            }
        </script>
    </div>
</body>
</html>
