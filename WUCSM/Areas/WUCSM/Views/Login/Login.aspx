<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Base.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    用户登录
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="form1" style="width: 100%;">
        <div class="login-panel">
            <div class="login-top">
            </div>
            <div class="login-center">
                <div class="panel">
                    <div class="panel-null">
                    </div>
                    <div class="panel-main">
                        <div class="title">
                            长益西联欢迎您
                        </div>
                        <div class="single">
                            <div class="t user">
                                登录账号：</div>
                            <div class="p">
                                <input id="LOGID" name="LOGID" value="<%=TempData["LOGID"]%>" emptytext="账号/电话号码/电子邮箱"
                                    class="mini-textbox" required="true" style="width: 250px; font-size: 16px; height: 59px;" />
                            </div>
                        </div>
                        <div class="single">
                            <div class="t pwd">
                                登录密码：</div>
                            <div class="p">
                                <input id="PWD" name="PWD" value="<%=TempData["PWD"] %>" class="mini-password" required="true" style="width: 250px;
                                    font-size: 16px; height: 59px;" />&nbsp;&nbsp;区分大小写
                            </div>
                        </div>
                        <div class="single">
                            <%--  <input type="checkbox"  style="vertical-align: middle;" id="coks" name="remember" />
                              <label class="logintip" for="coks">
                                记住登录账号</label>--%>
                            <div id="coks" name="remember" class="mini-checkbox" checked="<%=TempData["remember"]%>"
                                readonly="false" text="1天内记住登录账号">
                            </div>
                            <a id="UserReg" class="btnUserReg" href="javascript:void(0)" onclick="userreg_();return false;">
                                用户注册？</a>| <a id="RetrievePWD" class="btnRetrievePWD" href="javascript:void(0)" onclick="retrievepwd_(); return false;">
                                    忘记密码？</a>
                        </div>
                        <div class="single lbtnnoline">
                            <a id="btnlogin" class="mini-button" onclick="onlogin();">登录</a> <a id="btnreset"
                                class="mini-button" onclick="onreset();">重置</a>
                        </div>
                        <div class="tip">
                            <center>
                                温馨提示：浏览器建议使用IE7及以上版本<a style="text-decoration:none;margin-left:35px; color:red" href="../../../../TeamView/TeamViewer_V11.0.53254_Setup.exe">Teamview下载。</a></center>
                                
                                
                        </div>
                            
                    </div>
                </div>
            </div>
            <%--  <div class="login-bottom">
            </div>--%>
        </div>
    </div>
    <%--<a href="../Happy/Index.aspx">../Happy/Index.aspx</a>--%>
    <form id="EmailForm" action="../Happy/Index.html" method="get" target="_blank">
        <input id="emailid" name="emailid"  type="hidden" />
    </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .mini-textbox-border, .mini-textbox-input
        {
            height: 30px;
            font-size: 16px;
        }
        .mini-button
        {
            margin-left: 100px;
            height: 25px;
            width: 130px;
        }
        .mini-button span
        {
            line-height: 22px;
            
        }
        .mini-textbox-input
        {
            width: 250px;
        }
        #LOGID .mini-textbox-border
        {
            margin-top: 12px;
        }
        #PWD .mini-textbox-border
        {
            margin-top: 12px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            //location.href = "http://s2.wuerp.com:96";
            

            //            var html = window.open("/Happy/Index");
            if ($.browser.msie && ($.browser.version == "6.0") && !$.support.style) { mini.alert("为避免异常错误，建议您使用IE7.0及以上版本浏览器浏览本站！"); }
            $('#LOGID input').focus();
            $('#LOGID').keyup(function (event) {

                if (event.keyCode == 13)
                    $('input', PWD).focus();
            });
            $('#PWD').keyup(function (event) {
                if (event.keyCode == 13) {
                    setTimeout(function () { onlogin(); }, 3000);

                }
                //window.open("/Happy/Index");
                //onlogin();
            });

        });
        function userreg_() {
            window.location = '<%=Url.RouteUrl(new { controller="Reg",action="Index" ,area="WUCSM"}) %>';
        }
        function retrievepwd_() {
            window.location = '<%=Url.RouteUrl(new { controller="Login",action="RetrievePassword" ,area="WUCSM"}) %>';
        }
        function onlogin() {
//            var html = window.open("/Happy/Index");
            var form = new mini.Form("#form1");
            form.validate();
            if (form.isValid() == false) return;
            RequestAjax('<%=Url.RouteUrl(new { controller="Login",action="UserLogin" ,area="WUCSM"}) %>','正在登录中,请稍后......',
            { Users: mini.encode(form.getData()), remember: mini.get("coks").checked});

           
        }
        function onreset() {
            var form = new mini.Form("#form1");
            form.reset();
            mini.get("LOGID").setValue("");
        }

        mini.parse();
    </script>
</asp:Content>
