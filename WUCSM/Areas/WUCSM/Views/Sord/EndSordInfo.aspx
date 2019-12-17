<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>验收派工单</title>
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
    <div id="form1" style="padding: 10px;">
        <div id="newstar" style="margin: 10px 0px 10px 0px; font-weight: bold; font-size: 13px;">
            满意度：
        </div>
        <textarea id="ke" name="content" style="width: 100%; height: 260px;">
        </textarea>
    </div>
    <div style="text-align: center; padding: 10px;">
        <a class="mini-button" onclick="onOk" style="width: 60px; margin-right: 20px;">确定</a>
        <a class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
    </div>
    <script type="text/javascript">
        mini.parse();
        function onOk(e) {
            var editortxt = editor.html();
//            if (!editortxt || editortxt == '') {
//                mini.showTips({ content: "评论不能为空！", state: 'warning', x: 'center', y: 'center', timeout: 3000 });
//                editor.focus();
//                return false;
//            }
            RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="EndSord" ,area="WUCSM"}) %>', '数据提交中...', {
                ordno: '<%=Request["ordno"] %>',
                apprtxt: editortxt,
                dgr: '0' + $('#newstar-score').val()
            }, function () { CloseWindow("ok"); });
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
        function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
        $(function () {
            $('#newstar').raty({
                hintList: ['很不满意', '不满意', '满意', '很满意', '非常满意'],
                start: 5,
                path: '<%=Url.Content("~/Images")%>',
                starOn: 'star-on.png',
                starOff: 'star-off.png'
            });
        });
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
        });
    </script>
</body>
</html>
