<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Base.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    口令修改
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="form1" style="width: 1000px; margin: 0 0 0 180px;">
        <h3 style="color: red">
            您正在修改账户口令，请牢记！</h3>
        <table cellspacing="0" cellpadding="0" class="hovertable">
            <tbody>
                <tr>
                    <td style="width: 100px; text-align: center">
                        <span style="color: Red">*</span>设置新口令：
                    </td>
                    <td>
                        <input name="NEWPWR" errormode="none" style="width: 350px" onvalidation="onPwdValidation"
                            class="mini-password" required="true" min="6" maxlength="16" vtype="rangeLength:6,16" />
                    </td>
                    <td id="NEWPWR_error" class="errorText">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; text-align: center">
                        <span style="color: Red">*</span>重复新口令：
                    </td>
                    <td>
                        <input name="CFMNEWPWR" errormode="none" style="width: 350px" onvalidation="onPwdValidation"
                            class="mini-password" required="true" min="6" maxlength="16" vtype="rangeLength:6,16" />
                    </td>
                    <td id="CFMNEWPWR_error" class="errorText">
                    </td>
                </tr>
            </tbody>
        </table>
        <table  cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td style="padding-top: 5px; padding-right: 3px;" colspan="2">
                        <a class="mini-button" iconcls="icon-save" plain="false" onclick="PwrSvc()">保存</a>
                        <a class="mini-button" iconcls="icon-cancel" plain="false" onclick="PwrCanel()">重置</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .errorText
        {
            color: red;
            font-size: 11px;
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
            margin-left: 120px;
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
                PwrSvc();
        });
        function onPwdValidation(e) { updateError(e); }
        function updateError(e) {
            var id = e.sender.name + "_error"; var el = document.getElementById(id); if (el) { el.innerHTML = e.errorText; }
        }
        function PwrSvc() {
            var form = new mini.Form("#form1");
            form.validate();
            if (form.isValid() == false || form.isChanged() == true) return;
            var o = form.getData(true, false);
            if (o["NEWPWR"] != o["CFMNEWPWR"]) { mini.alert("确认密码和新密码不一致!"); return; }
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="Login",action="PwrSvc" ,area="WUCSM"}) %>',
                data: { Code: "<%=Request.QueryString["Code"] %>", NewPwr: o["NEWPWR"] },
                success: function (res) {
                     if (res.msg != "OK") {
                        mini.alert(res.msg);
                        form.reset();
                        img_ValidateCode.src = img_ValidateCode.src + '?';
                        $("#ValidateCode").val("");
                    } else {
                        mini.alert("新口令设置成功！");
//                       window.location = res.url;
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    form.reset();
                }
            });
        }

        function notify(text) {
            mini.showMessageBox({
                showModal: true, width: 200, title: "提示信息", iconCls: "mini-messagebox-warning", message: text, timeout: 1200, x: 'right', y: 'bottom'
            });
        }


        function PwrCanel() {
            var form = new mini.Form("#form1");
            form.reset();
        }
        mini.parse();
    </script>
</asp:Content>
