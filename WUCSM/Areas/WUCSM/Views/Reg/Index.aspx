<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Base.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    用户注册
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="form1" style="width: 1000px; margin: 0 0 0 180px;">
        <h3 style="color: red">
            长益西联公司感谢您参与新资料注册，为了我们更好的为您服务，及时了解您的状况，请认真填写以下各项</h3>
        <table cellspacing="0" cellpadding="0" class="hovertable">
            <tbody>
                <tr onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'1');" onclick="DoMouseOn(this,'1');">
                    <td>
                        <font color="red">*</font>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：
                        <input id="SEX" class="mini-combobox" style="width: 50px;" valuefield="id" name="SEX"
                            data="[{ 'id': 'M', 'text': '男' },{ 'id': 'F', 'text': '女' }]" required="true"
                            textfield="text" value="M">
                    </td>
                </tr>
                <tr class="regtr" onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'2');"
                    onclick="DoMouseOn(this,'2');">
                    <td>
                        <font color="red">*</font>邀&nbsp;&nbsp;请&nbsp;码：
                        <input id="CUSIDANDCUSORGID" name="CUSIDANDCUSORGID" class="mini-textbox" maxlength="16"
                            required="true" style="width: 400px; height: 27px;" vtype="int" />
                        <span id="FormCUSID">>=8位的数字,系统邀请码</span>
                    </td>
                </tr>
                <tr onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'1');" onclick="DoMouseOn(this,'1');">
                    <td>
                        <font color="red">*</font>登录帐号：
                        <input id="LOGID" name="LOGID" class="mini-textbox" required="true" style="width: 400px;
                            height: 27px;" vtype="rangeLength:2,20" onchange="Check_LOGID();" />
                        <span id="FormLOGID">2-20个字符，可以是字母、数字或中文</span>
                    </td>
                </tr>
                <tr class="regtr" onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'2');"
                    onclick="DoMouseOn(this,'2');">
                    <td>
                        <font color="red">*</font>帐号密码：
                        <input id="PWD" name="PWD" class="mini-password" required="true" style="width: 400px;
                            height: 27px;" min="6" maxlength="16" vtype="rangeLength:6,16" />
                        <span id="FormPWD">6-16个字符，区分大小写</span>
                    </td>
                </tr>
                <tr onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'1');" onclick="DoMouseOn(this,'1');">
                    <td>
                        <font color="red">*</font>确认密码：
                        <input id="PWDre" name="PWDre" class="mini-password" required="true" style="width: 400px;
                            height: 27px;" min="6" maxlength="16" vtype="rangeLength:6,16" />
                        <span id="FormPWDre">请再次填写密码</span>
                    </td>
                </tr>
                <tr class="regtr" onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'2');"
                    onclick="DoMouseOn(this,'2');">
                    <td>
                        <font color="red">*</font>用户姓名：
                        <input id="USERNAME" name="USERNAME" class="mini-textbox" required="true" style="width: 400px;
                            height: 27px;" maxlength="8" onvalidation="onChineseValidation" />
                        <span id="FormUSERNAME">您的真实姓名</span>
                    </td>
                </tr>
                <tr onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'1');" onclick="DoMouseOn(this,'1');">
                    <td>
                        <font color="red">*</font>联系电话：
                        <input id="MOVTEL" name="MOVTEL" class="mini-textbox" required="true" style="width: 400px;
                            height: 27px;" maxlength="15" vtype="rangeLength:6,15" />
                        <span id="FormMOVTEL">座机或手机</span>
                    </td>
                </tr>
                <tr class="regtr" onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'2');"
                    onclick="DoMouseOn(this,'2');">
                    <td>
                        <font color="red">*</font>联系地址：
                        <input id="ADR" name="ADR" class="mini-textbox" required="true" style="width: 400px;
                            height: 27px;" maxlength="100" vtype="rangeLength:1,100" />
                        <span id="FormADR">您常用的联系地址</span>
                    </td>
                </tr>
                <tr onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'1');" onclick="DoMouseOn(this,'1');">
                    <td class="regtd">
                        <font color="red">*</font>邮箱地址：
                        <input id="EMAIL" name="EMAIL" class="mini-textbox" required="true" style="width: 400px;
                            height: 27px;" vtype="email" />
                        <span id="FormEMAIL">填写后可用于找回密码</span>
                    </td>
                </tr>
                <tr class="regtr" onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'2');"
                    onclick="DoMouseOn(this,'2');">
                    <td>
                        <font color="red">*</font>QQ号码 ：
                        <input id="QQ" name="QQ" class="mini-textbox" maxlength="10" required="true" style="width: 400px;
                            height: 27px;" vtype="int" />
                        <span id="FormQQ">您常用的QQ号码</span>
                    </td>
                </tr>
                <tr onmouseover="DoMouseOver(this);" onmouseout="DoMouseOut(this,'1');" onclick="DoMouseOn(this,'1');">
                    <td>
                        <font color="red">*</font>验&nbsp;&nbsp;证&nbsp;码：
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
                        <a id="btnreg" class="mini-button" onclick="submit();">提交注册</a>
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
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;成都长益西联 总部地址：成都市高新区益州大道中段722号复地复城国际T4-30
        邮编：610041 电话：028-62997288
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
        var g_obj = null;
        var g_row = null;
        var selectcolor = '#f0903c';
        /** 鼠标飘入改变行样式 **/
        function DoMouseOver(obj) {
            //            if (obj.style.background != selectcolor && obj.style.background != 'rgb(240, 144, 60)' && obj.style.background.indexOf('rgb(240, 144, 60)') < 0) {
            //                obj.style.background = '#9cbd00';
            //            }
        }

        /** 鼠标移出改变行样式 **/
        function DoMouseOut(obj, bg) {
            if (obj.style.background != selectcolor && obj.style.background != 'rgb(240, 144, 60)' && obj.style.background.indexOf('rgb(240, 144, 60)') < 0) {
                if (bg == "1") {
                    obj.style.background = '#d4e3e5';
                }
                if (bg == "2") {
                    obj.style.background = '#b3ced1';
                }
            }
        }

        function DoMouseOn(obj, bg) {
            //            obj.style.background = selectcolor;

            //            if ((g_obj != null) && (g_obj != obj)) {
            //                if (g_row == "1") {
            //                    g_obj.style.background = '#d4e3e5';
            //                }
            //                if (g_row == "2") {
            //                    g_obj.style.background = '#b3ced1';
            //                }
            //            }
            //            g_obj = obj;
            //            g_row = bg;

        }


        var flag = false;

        function onChineseValidation(e) {
            if (e.isValid) {
                if (isChinese(e.value) == false) {
                    e.errorText = "必须输入中文";
                    e.isValid = false;
                }
            }
        }

        /* 是否汉字 */
        function isChinese(v) {
            var re = new RegExp("^[\u4e00-\u9fa5]+$");
            if (re.test(v)) return true;
            return false;
        }

        $(document).keyup(function (event) {
            if (event.keyCode == 13)
                submit();
        });

        function submit() {
            var form = new mini.Form("#form1");
            form.validate();
            if (form.isValid() == false) return;

            if ($("#ValidateCode").val() == null || $("#ValidateCode").val().length != 6) {
                mini.alert("请正确输入验证码");
                return false;
            }
            Check_LOGID();
            var PWD = mini.get("PWD").getValue();
            var PWDre = mini.get("PWDre").getValue();
            if (PWD != PWDre) {
                mini.alert("两次输入的密码不一致");
                mini.get("PWD").setValue("");
                mini.get("PWDre").setValue("");
                img_ValidateCode.src = img_ValidateCode.src + '?';
                $("#ValidateCode").val("");
                return false;
            }
            if (flag) {
                RequestAjax('<%=Url.RouteUrl(new { controller="Reg",action="Reg" ,area="WUCSM"}) %>', '正在注册,请稍后......', { reg: mini.encode(form.getData()) }, function () {
                    regsuccess();
                });
            }
        }

        function regsuccess() {
//            mini.alert("用户注册成功,请等待管理员审核并授权后方可登陆");
            mini.alert("用户注册成功!");
            var form = new mini.Form("#form1");
            form.reset();
            img_ValidateCode.src = img_ValidateCode.src + '?';
            $("#ValidateCode").val("");
        }


        function Check_LOGID() {
            var CUSIDANDCUSORGID = mini.get("CUSIDANDCUSORGID").getValue();
            var LOGID = mini.get("LOGID").getValue();
            var MOVTEL = mini.get("MOVTEL").getValue();
            var EMAIL = mini.get("EMAIL").getValue();
            var ValidateCode = $("#ValidateCode").val();
            $.ajax({
                type: 'post',
                url: '<%=Url.RouteUrl(new { controller="Reg",action="CheckLOGID" ,area="WUCSM"}) %>',
                data: { "CUSIDANDCUSORGID": CUSIDANDCUSORGID, "LOGID": LOGID, "MOVTEL": MOVTEL, "EMAIL": EMAIL, "ValidateCode": ValidateCode },
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.msg != "OK") {
                        mini.alert(res.msg);
                        img_ValidateCode.src = img_ValidateCode.src + '?';
                        $("#ValidateCode").val("");
                        if (res.state == "-1")
                            mini.get("CUSIDANDCUSORGID").setValue("");
                        if (res.state == "-2")
                            mini.get("LOGID").setValue("");
                        if (res.state == "-3")
                            mini.get("MOVTEL").setValue("");
                        if (res.state == "-4")
                            mini.get("EMAIL").setValue("");
                        flag = false;

                    } else {
                        flag = true;
                    }
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
