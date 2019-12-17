<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SordReply</title>
    <script src="<%=Url.Content("~/Scripts/boot.js")%>" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            background: none;
        }
    </style>
    <script type="text/javascript">
        function onOk() {
            var editortxt = editor.html();
            if (!editortxt || editortxt == '') {
                mini.showTips({ content: "回复不能为空！", state: 'warning', x: 'center', y: 'center', timeout: 3000 });
                editor.focus();
                return false;
            }
            RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="InsertReply" ,area="WUCSM"}) %>', '数据提交中...', { ordno: '<%=Request["ordno"] %>', subtxt: editortxt }, function () {
                if ('<%=Request["type"] %>' == '1')
                    CloseWindow('ok');
                else
                    window.location.reload();
            });
        }
        function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
        function onCancel() {
            if ('<%=Request["type"] %>' == '1')
                CloseWindow('cancel');
            else
                $(divke).hide();
        }
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
</head>
<body>
    <div>
        <%
            if (Request["type"] != "1" && (TempData["SORDDTLs"] as IList<Models.SORDDTL>).Count == 0)
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
                                回复</div>
                            <div class="emptyScrHeadDscr">
                                暂无回复</div>
                            <div class="emptyScrDscr">
                                给服务事项留言，以：跟进服务事项进展；澄清一些问题；讨论服务事项相关文档；知会其他人员有关此服务事项的进展。</div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <%
            }
        %>
        <%
            if (Request["type"] != "1")
                foreach (Models.SORDDTL SORDDTL in TempData["SORDDTLs"] as IList<Models.SORDDTL>)
                {
        %>
        <div class="replyitem">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="width: 40px;">
                        <img class="userMiniPhoto" alt="" src="<%=Url.Content(string.IsNullOrEmpty(SORDDTL.SUBMANPIC)?"~/Images/user.png":"~"+SORDDTL.SUBMANPIC)%>" />
                    </td>
                    <td>
                        <a class="linkHeader">
                            <%=SORDDTL.SUBMANNAME%></a> <span class="textSmallDescribe" title="<%=SORDDTL.SUBDT.ToString("yyyy-MM-dd HH:mm:ss") %>">
                                <%=WUCSM.Helpers.DateTimeConvert.DateToString(SORDDTL.SUBDT) %></span>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <%=SORDDTL.SUBTXT %>
                    </td>
                </tr>
            </table>
        </div>
        <%
            }
        %>
        <%--<a class="mini-button " plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle(new string[] { "SORD", "reply", "SORDEL", "reply" }) %>
            iconcls="icon-add" style="margin: 5px;" onclick="onClick">发表回复</a>--%>
        <div id="divke" style="<%=Request["type"]=="1"?"": "display: none;" %> width: 99%;">
            <textarea id="ke" name="content" style="width: 100%; height: 400px;">
            </textarea>
            <div style="text-align: center; padding: 3px;">
                <a class="mini-button" onclick="onOk" style="width: 60px; margin-right: 20px;">确定</a>
                <a class="mini-button" onclick="onCancel" style="width: 60px;">关闭</a>
            </div>
        </div>
    </div>
</body>
</html>
