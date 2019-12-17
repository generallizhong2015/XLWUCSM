<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/BaseMdl.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    我的资料
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h4>
            我的资料</h4>
        <div id="tabs1" class="mini-tabs" activeindex="0" style="width: 100%; height: 500px;"
            plain="false">
            <div title="基本资料" iconcls="icon-user">
                <h4>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;基本信息</h4>
                <div id="form1">
                    <input class="mini-hidden" id="USERID" name="USERID" />
                    <input class="mini-hidden" id="CUSID" name="CUSID" />
                    <input class="mini-hidden" id="CUSORGID" name="CUSORGID" />
                    <input class="mini-hidden" id="ITEL" name="ITEL" />
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 100px; text-align: center">
                                <span style="color: Red">*</span>登录账号：
                            </td>
                            <td>
                                <input id="LOGID" name="LOGID" class="mini-textbox" enabled="false" value="123" style="width: 250px" />
                            </td>
                            <td style="width: 60px;">
                                &nbsp;
                            </td>
                            <td style="width: 100px; text-align: center">
                                <span style="color: Red">*</span>用户姓名：
                            </td>
                            <td>
                                <input id="USERNAME" name="USERNAME" class="mini-textbox" required="true" style="width: 250px" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: center">
                                <span style="color: Red">*</span>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：
                            </td>
                            <td>
                                <input id="SEX" name="SEX" class="mini-combobox" data="SEXs" shownullitem="true"
                                    emptytext="--请选择--" multiselect="false" nullitemtext="--请选择--" required="true"
                                    allowinput="true" shownullitem="true" style="width: 250px" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td style="width: 100px; text-align: center">
                                <span style="color: Red">*</span>身份证号：
                            </td>
                            <td>
                                <input id="IDNO" name="IDNO" class="mini-textbox" required="true" style="width: 250px"
                                    value="0" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: center">
                                <span style="color: Red">*</span>联系电话：
                            </td>
                            <td>
                                <input id="MOVTEL" name="MOVTEL" class="mini-textbox" style="width: 250px" required="true" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td style="width: 100px; text-align: center">
                                &nbsp;座机号码：
                            </td>
                            <td>
                                <input id="OTEL" name="OTEL" class="mini-textbox" style="width: 250px" />
                                <%-- <input id="ITEL" name="ITEL" class="mini-textbox" style="width: 0px" />--%>
                            </td>
                            <td rowspan="5" style="vertical-align: middle; text-align: center; width: 200px">
                                <img id="PIC" name="PIC" src="<%=Url.Content("~/Attachments/uimage/tx.gif")%>" style="width: 140px;
                                    height: 160px;" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: center">
                                &nbsp;Q&nbsp;Q&nbsp;号码：
                            </td>
                            <td>
                                <input id="QQ" name="QQ" class="mini-textbox" vtype="int" style="width: 250px" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td style="width: 100px; text-align: center">
                                &nbsp;电子邮件：
                            </td>
                            <td>
                                <input id="EMAIL" name="EMAIL" class="mini-textbox" vtype="email" style="width: 250px" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: center">
                                所在部门：
                            </td>
                            <td>
                                <input id="DPT" name="DPT" class="mini-combobox" style="width: 250px;" textfield="NODNAME"
                                    emptytext="----请选择----" multiselect="false" nullitemtext="----请选择----" valuefield="DPT"
                                    shownullitem="true" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td style="width: 100px; text-align: center">
                                职务职称：
                            </td>
                            <td>
                                <input id="PSTN" name="PSTN" class="mini-combobox" style="width: 250px;" textfield="text"
                                    emptytext="--请选择------" multiselect="false" nullitemtext="----请选择----" valuefield="id"
                                    shownullitem="true" data="PSTNs" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: center">
                                联系地址：
                            </td>
                            <td colspan="4">
                                <input id="ADR" name="ADR" class="mini-textbox" style="width: 98%" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: center">
                                用户状态：
                            </td>
                            <td>
                                <input id="STT" name="STT" class="mini-combobox" style="width: 250px;" textfield="text"
                                    valuefield="id" enabled="false" shownullitem="true" data="STTs" value="1" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td style="width: 100px; text-align: center">
                                账户角色：
                            </td>
                            <td>
                                <input id="ISSYS" name="ISSYS" class="mini-combobox" style="width: 250px;" textfield="text"
                                    valuefield="id" enabled="false" shownullitem="true" data="ISSYSs" value="F" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: center">
                                所属客户：
                            </td>
                            <td colspan="2">
                                <input id="CUSNAME" name="CUSNAME" class="mini-textbox" enabled="false" style="width: 98%" />
                            </td>
                            <td colspan="2">
                                <input id="CUSORGNAME" name="CUSORGNAME" class="mini-textbox" enabled="false" style="width: 98%" />
                            </td>
                            <td style="text-align: center">
                                <input id="fileupload1" class="mini-fileupload" name="Fdata" limittype="*.jpg;*.png;*.gif;*.bmp"
                                    flashurl="/Scripts/swfupload/swfupload.swf" uploadurl='<%=Url.RouteUrl(new { controller="UserInf",action="UpLoad" ,area="WUCSM"}) %>'
                                    onuploadsuccess="onUploadSuccess" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right; padding-top: 5px; padding-right: 3px;" colspan="5">
                                <a class="mini-button" iconcls="icon-save" plain="false" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle(new string[] { "USERINF", "update", "USERINEL", "update" }) %>
                                    onclick="SaveSvc()">保存</a> <a class="mini-button" iconcls="icon-cancel" plain="false"
                                        <%=new WUCSM.Helpers.HtmlPwrFilter().Handle(new string[] { "USERINF", "update", "USERINEL", "update" }) %>
                                        onclick="Cancel()">取消</a>
                            </td>
                            <td style="text-align: left; padding-top: 5px; padding-right: 3px; padding-left: 30px">
                                <a class="mini-button" iconcls="icon-upload" plain="false" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle(new string[] { "USERINF", "upload", "USERINEL", "upload" }) %>
                                    onclick="startUpload()">上传</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div title="口令修改" iconcls="icon-unlock">
                <div id="form2">
                    <h4>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;口令修改</h4>
                    <table style="margin: 20px;">
                        <tr>
                            <td style="width: 100px; text-align: center">
                                <span style="color: Red">*</span>&nbsp;&nbsp;原始口令：
                            </td>
                            <td>
                                <input name="OLDPWR" errormode="none" style="width: 150px" onvalidation="onPwdValidation"
                                    class="mini-password" required="true" vtype="minLength:6" minlengtherrortext="密码不能少于6个字符" />
                            </td>
                            <td id="OLDPWR_error" class="errorText">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: center">
                                <span style="color: Red">*</span>设置新口令：
                            </td>
                            <td>
                                <input name="NEWPWR" errormode="none" style="width: 150px" onvalidation="onPwdValidation"
                                    class="mini-password" required="true" vtype="minLength:6" minlengtherrortext="新密码不能少于6个字符" />
                            </td>
                            <td id="NEWPWR_error" class="errorText">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: center">
                                <span style="color: Red">*</span>重复新口令：
                            </td>
                            <td>
                                <input name="CFMNEWPWR" errormode="none" style="width: 150px" onvalidation="onPwdValidation"
                                    class="mini-password" required="true" vtype="minLength:6" minlengtherrortext="确认密码不能少于6个字符" />
                            </td>
                            <td id="CFMNEWPWR_error" class="errorText">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right; padding-top: 5px; padding-right: 3px;" colspan="2">
                                <a class="mini-button" iconcls="icon-save" plain="false" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle(new string[] { "USERINF", "update", "USERINEL", "update" }) %>
                                    onclick="PwrSvc()">保存</a> <a class="mini-button" iconcls="icon-cancel" plain="false"
                                        <%=new WUCSM.Helpers.HtmlPwrFilter().Handle(new string[] { "USERINF", "update", "USERINEL", "update" }) %>
                                        onclick="PwrCanel()">取消</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <input id="uInf" type="hidden" value='<%= ViewData["USERINF"]%>' />
    </div>
    <script type="text/javascript">
        mini.parse();
        mini.get("DPT").load(mini.decode('<%=ViewData["DPT"] %>'));
        var frm = new mini.Form("#form1");
        var data = mini.decode($("#uInf")[0].value);
        frm.setData(data);
        $("#PIC").attr("src", data["PIC"]);
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="<%=Url.Content("~/Scripts/swfupload/swfupload.js")%>"></script>
    <script src="../../../../Scripts/miniui/UserSelectWindow.js" type="text/javascript"></script>
    <script src="../../../../Scripts/miniui/miniui.js" type="text/javascript"></script>
    <script src="../../../../Scripts/miniui/jquery.tmpl.js" type="text/javascript"></script>
    <script src="<%=Url.Content("~/Scripts/boot.js")%>" type="text/javascript"></script>
    <script type="text/javascript">
        
        var SEXs = [{ 'id': 'M', 'text': '男' }, { 'id': 'F', 'text': '女'}];
        var STTs = [{ 'id': '0', 'text': '停用' }, { 'id': '1', 'text': '正常' }, { 'id': '2', 'text': '未授权'}];
        var ISSYSs = [{ 'id': 'T', 'text': '超级用户' }, { 'id': 'F', 'text': '普通用户'}];
        var PSTNs = [{ 'id': '01', 'text': '职员' }, { 'id': '02', 'text': '经理' }, { 'id': '03', 'text': '总监' }, { 'id': '04', 'text': '其他'}];
//        var DPTs=<%=TempData["DPT"] %>;
//        var DPTs = [{ 'id': '01', 'text': '信息部' }, { 'id': '02', 'text': '维护部' }, { 'id': '03', 'text': '其他部门'}];
//        var DPTs=mini.decode('<%=TempData["DPT"] %>>')

        function SaveSvc() {
            var frm = new mini.Form("#form1");
            frm.validate();
            if (frm.isValid() == false || frm.isChanged() == true) return;
            var o = frm.getData(true, false);
            var json = mini.encode(o);
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="UserInf",action="SaveSvc" ,area="WUCSM"}) %>',
                data: { data: json },
                success: function (text) {
                    if (text == "保存成功!") {
                        notify("保存成功！");
                        frm.setChanged(true);
                        $("#uInf")[0].value = json;
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
        }
        function Cancel() {
            var frm = new mini.Form("#form1");
            var data = mini.decode($("#uInf")[0].value);
            frm.setData(data);
        }

        function PwrSvc() {
            var frm2 = new mini.Form("#form2");
            frm2.validate();
            if (frm2.isValid() == false || frm2.isChanged() == true) return;
            var o = frm2.getData(true, false);
            if (o["OLDPWR"] == o["NEWPWR"]) { mini.alert("新密码和原始密码一致!"); return; }
            if (o["NEWPWR"] != o["CFMNEWPWR"]) { mini.alert("确认密码和新密码不一致!"); return; }
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="UserInf",action="PwrSvc" ,area="WUCSM"}) %>',
                data: { OLDPWR: o["OLDPWR"], NEWPWR: o["NEWPWR"] },
                success: function (text) {
                    frm2.reset();
                    notify(text);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    frm2.reset();
                }
            });
        }

        function PwrCanel() { var frm2 = new mini.Form("#form2"); frm2.reset(); }
        function updateError(e) { var id = e.sender.name + "_error"; var el = document.getElementById(id); if (el) { el.innerHTML = e.errorText; } }
        function onUserNameValidation(e) { updateError(e); }
        function onPwdValidation(e) { updateError(e); }
        function startUpload() { var fileupload = mini.get("fileupload1"); fileupload.startUpload(); }
        function onUploadSuccess(e) { $("#PIC").attr("src", e.serverData); }
        function notify(text) { mini.showMessageBox({ showModal: true, width: 200, title: "提示信息", iconCls: "mini-messagebox-warning", message: text, timeout: 1200, x: 'right', y: 'bottom' }); }
    </script>
    <style type="text/css">
        tr
        {
            height: 28px;
        }
        .errorText
        {
            color: red;
            font-size: 11px;
        }
    </style>
</asp:Content>
