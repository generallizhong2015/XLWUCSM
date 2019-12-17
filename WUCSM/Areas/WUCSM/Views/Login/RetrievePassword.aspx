<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Base.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    找回密码
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="form1" style="width: 1000px; margin: 0 0 0 180px;">
        <h3 style="color: red">
            填写您注册时的邮箱地址</h3>
        <table cellspacing="0" cellpadding="0" class="hovertable">
            <tbody>
                <tr>
                    <td>
                        邮箱地址：
                        <input id="EMAIL" name="EMAIL" class="mini-textbox" required="true" style="width: 480px;
                            height: 27px;" vtype="email" />
                        <span id="FormEMAIL">填写您注册时的邮箱地址</span>
                    </td>
                </tr>
                <tr>
                    <td>
                        验&nbsp;&nbsp;证&nbsp;码：
                        <input id="ValidateCode" name="ValidateCode" size="6" style="width: 100px" type="text"
                            regparam="true">
                        <img style="width: 80px; height: 25px;" id="img_ValidateCode" language="javascript"
                            class="img_c" title="点击重新获取验证码" onclick="this.src=this.src+'?'" align="absmiddle"
                            src="<%=Url.RouteUrl(new { controller="ValidateCode",action="Index" ,area="WUCSM"}) %>">
                        <span id="C_user_vcode"></span>
                    </td>
                </tr>
            </tbody>
        </table>
        <table class="tip-norole" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td height="50">
                        <a id="btnreg" class="mini-button" onclick="submit();">确认找回</a>
                    </td>
                    <td height="50">
                        <a id="btnreset" class="mini-button" onclick="onreset();">重 置</a>
                    </td>
                    <td height="50">
                        <a id="btnreturn" class="mini-button" onclick="onreturn();">返回登录</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .tip-norole
        {
            width: 700px;
            font-size: 12px;
            border-bottom: 2px dashed #c3c3c3;
        }
        table.hovertable
        {
            font-family: verdana,arial,sans-serif;
            font-size: 11px;
            color: #333333;
            border-width: 1px;
            border-color: #999999;
            border-collapse: collapse;
        }
        table.hovertable th
        {
            background-color: #c3dde0;
            border-width: 1px;
            padding: 6px;
            border-style: solid;
            border-color: #a9c6c9;
        }
        table.hovertable tr
        {
            background-color: #d4e3e5;
        }
        table.hovertable tr.regtr
        {
            background-color: #b3ced1;
        }
        table.hovertable td
        {
            border-width: 1px;
            padding: 6px;
            border-style: solid;
            border-color: #a9c6c9;
        }
        
        
        .mini-textbox-border, .mini-textbox-input
        {
            height: 25px;
            font-size: 16px;
        }
        .mini-button
        {
            margin-left: 80px;
            height: 25px;
            width: 100px;
        }
        .mini-button span
        {
            line-height: 22px;
        }
        .mini-textbox-input
        {
            width: 340px;
            line-height: 25px;
        }
    </style>
    <script type="text/javascript">
        $(document).keyup(function (event) {
            if (event.keyCode == 13)
                submit();
        });
        function submit() {
            var form = new mini.Form("#form1");
            form.validate();
            if (form.isValid() == false) return;
            var ValidateCode = $("#ValidateCode").val();
            if (ValidateCode == null || ValidateCode.length != 6) {
                mini.alert("请正确输入验证码");
                return false;
            }

            $.ajax({
                type: 'post',
                url: '<%=Url.RouteUrl(new { controller="Login",action="EmailRetrievePassword" ,area="WUCSM"}) %>',
                data: { "useremail": mini.get("EMAIL").getValue(), "ValidateCode": ValidateCode },
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.msg != "OK") {
                        mini.alert(res.msg);
                    } else {
                        mini.alert("找回密码提交成功，请在2小时内查看邮箱并及时修改！");
                    }
                    form.reset();
                    img_ValidateCode.src = img_ValidateCode.src + '?';
                    $("#ValidateCode").val("");
                }
            });

        }


        function onreset() {
            var form = new mini.Form("#form1");
            form.reset();
            img_ValidateCode.src = img_ValidateCode.src + '?';
            $("#ValidateCode").val("");
        }

        function onreturn() {
            window.location = '<%=Url.RouteUrl(new { controller="Login",action="Login" ,area="WUCSM"}) %>';
        }

        mini.parse();
    </script>
</asp:Content>
