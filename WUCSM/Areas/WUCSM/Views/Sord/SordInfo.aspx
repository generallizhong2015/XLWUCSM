<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/BaseMdl.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    派工单-<%=Request["ordno"] %>
    详情
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="p1" class="mini-panel" title="派工单-<%=Request["ordno"] %>" showtoolbar="true"
        style="width: 100%;">
        <!--toolbar-->
        <div property="toolbar" style="padding: 5px;">
            <a class="mini-button" id="btnupdate" plain="true" iconcls="icon-edit" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle(new string[] { "SORD", "update", "SORDEL", "update" }) %>
                onclick="UpdateSord">编辑</a> <a id="btndelete" class="mini-button" plain="true" iconcls="icon-remove"
                    onclick="DeleteSord" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle(new string[] { "SORD", "delete", "SORDEL", "delete" }) %>>
                    删除</a> <a id="btnmovenstt" class="mini-button" plain="true" iconcls="icon-downgrade"
                        onclick="MoveNextStt" style="<%=(Session["CurUser"] as Models.USERS).USERTYP == "01"?"": "display:none;"%>"
                        <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("SORD","movenstt") %>>
                        <%=TempData.Keys.Contains("NEXTSTTCFG") ? "跳转到[<span style=\"color:Green;\">" + (TempData["NEXTSTTCFG"] as Models.STTCFG).NODNAME + "</span>]" : "不可跳转"%></a>
            <a id="btnendsd" class="mini-button" style="<%=(Session["CurUser"] as Models.USERS).USERTYP == "02"?"": "display:none;"%>"
                plain="true" iconcls="icon-ok" onclick="EndSord('<%=Request["ordno"] %>');" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("SORDEL","endsd") %>>
                验收</a>
        </div>
        <table border="0" cellpadding="1" cellspacing="2">
            <tr>
                <td class="cmlable">
                    处&nbsp;理&nbsp;人&nbsp;：
                </td>
                <td colspan="3">
                    <%
                        if (string.IsNullOrEmpty((TempData["SORD"] as Models.SORD).PRCMANNAME))
                        {
                    %>
                    暂无人受理
                    <%
                        }
                        else
                        {
                    %>
                    <img class="userMiniPhoto" style="width: 80px; height: 80px;" alt="" src="<%=Url.Content(string.IsNullOrEmpty((TempData["SORD"] as Models.SORD).PRCMANPIC)?"~/Images/user.png":"~"+(TempData["SORD"] as Models.SORD).PRCMANPIC)%>" />
                    <%=(TempData["SORD"] as Models.SORD).PRCMANNAME%>
                    <%
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td class="cmlable">
                    提交客户：
                </td>
                <td>
                    <%=(TempData["SORD"] as Models.SORD).SUBCUSNAME%>
                </td>
                <td class="cmlable">
                    提交人：
                </td>
                <td>
                    <%=(TempData["SORD"] as Models.SORD).SUBMANNAME%>
                </td>
                <td class="cmlable">
                    提交时间：
                </td>
                <td class="cmdate" title="<%=(TempData["SORD"] as Models.SORD).SUBDT.ToString("yyyy-MM-dd HH:mm:ss") %>">
                    <%=WUCSM.Helpers.DateTimeConvert.DateToString((TempData["SORD"] as Models.SORD).SUBDT)%>
                </td>
                <td class="cmlable">
                    状态：
                </td>
                <td class="sstt<%=(TempData["SORD"] as Models.SORD).STT%>">
                    <%=(TempData["SORD"] as Models.SORD).STTNAME%>
                </td>
            </tr>
            <tr>
                <td style="width: 60px;" class="cmlable">
                    正文描述：
                </td>
                <td style="width: 500px" colspan="5">
                    <%=(TempData["SORD"] as Models.SORD).SUBTXT%>
                </td>
            </tr>
            <tr>
                <td class="cmlable">
                    服务类型：
                </td>
                <td>
                    <%=(TempData["SORD"] as Models.SORD).SERTYPNAME%>
                </td>
                <td class="cmlable">
                    IP地址：
                </td>
                <td>
                    <%=(TempData["SORD"] as Models.SORD).IPADR%>
                </td>
            </tr>
            <tr>
                <td class="cmlable">
                    预计时间：
                </td>
                <td>
                    <span class="cmdate">
                        <%=(TempData["SORD"] as Models.SORD).ECTIME%></span>&nbsp;(小时)
                </td>
                <td class="cmlable">
                    截止时间：
                </td>
                <td colspan="3" class="cmdate" title="<%=(TempData["SORD"] as Models.SORD).SUBDT.AddHours((TempData["SORD"] as Models.SORD).ECTIME).ToString("yyyy-MM-dd HH:mm:ss") %>">
                    <%=WUCSM.Helpers.DateTimeConvert.DateToString((TempData["SORD"] as Models.SORD).SUBDT.AddHours((TempData["SORD"] as Models.SORD).ECTIME))%>
                </td>
            </tr>
            <tr>
                <td style="width: 60px;" class="cmlable">
                    方法/结果：
                </td>
                <td style="width: 500px" colspan="5">
                    <%=(TempData["SORD"] as Models.SORD).PRCMTHRSTL%>
                </td>
            </tr>
        </table>
        <%
            string activeindex = Request["activeindex"];
            if (activeindex != "0" && activeindex != "1" && activeindex != "2")
                activeindex = "0";
        %>
        <div id="tabs1" class="mini-tabs" activeindex="<%=activeindex %>" style="width: 100%;
            height: 400px;">
            <div title="回复" url="<%=Url.RouteUrl(new { controller="Sord",action="SordReply" ,area="WUCSM"})+"?ordno="+Request["ordno"]%>">
            </div>
            <div title="评价" url="<%=Url.RouteUrl(new { controller="Sord",action="SordReview" ,area="WUCSM"})+"?ordno="+Request["ordno"]%>">
            </div>
            <div title="服务跟踪" url="<%=Url.RouteUrl(new { controller="Sord",action="SordTrack" ,area="WUCSM"})+"?ordno="+Request["ordno"]%>">
            </div>
        </div>
    </div>
    <script type="text/javascript">
        mini.parse();
        var curstt = '<%=(TempData["SORD"] as Models.SORD).STT%>';
        if (curstt != '0')
            mini.get('btndelete').setEnabled(false);
        if (curstt != '50')
            mini.get('btnendsd').setEnabled(false);
        if (curstt == '90') {
            mini.get('btnmovenstt').setEnabled(false);
            mini.get('btnupdate').setEnabled(false);
        }

        function UpdateSord() {
            mini.open({
                url: '<%=Url.RouteUrl(new { controller="Sord",action="UpdateSordInfo" ,area="WUCSM"}) %>?ordno=<%=Request["ordno"] %>',
                title: "编辑信息", width: 600, height: 420,
                ondestroy: function (action) {
                    if (action == 'ok') window.location.reload();
                }
            });
        }
        function DeleteSord() {
            mini.showMessageBox({
                showHeader: false,
                width: 250,
                title: '是否删除派工单[<%=Request["ordno"] %>]？',
                buttons: ["ok", "cancel"],
                message: '是否删除派工单[<%=Request["ordno"] %>]？',
                iconCls: 'mini-messagebox-question',
                callback: function (action) {
                    if (action != 'ok') return;
                    RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="DeleteSord" ,area="WUCSM"}) %>', '数据删除中', { ordno: '<%=Request["ordno"] %>' }, function () {
                        mini.showMessageBox({
                            title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                            message: '删除成功！', callback: function (action) {
                                window.location = '<%=Url.RouteUrl(new { controller="Sord",action="Index" ,area="WUCSM"}) %>';
                            }
                        });
                    });
                }
            });
        }
        function MoveNextStt() {
            var nextsttname = '<%=TempData.Keys.Contains("NEXTSTTCFG") ?  (TempData["NEXTSTTCFG"] as Models.STTCFG).NODNAME: "不可跳转"%>';
            mini.showMessageBox({
                showHeader: false,
                width: 250,
                title: '是否跳转至状态[' + nextsttname + ']？',
                buttons: ["ok", "cancel"],
                message: '是否跳转至状态[' + nextsttname + ']？',
                iconCls: 'mini-messagebox-question',
                callback: function (action) {
                    if (action != 'ok') return;
                    RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="MoveNextStt" ,area="WUCSM"}) %>', '跳转中', { ordno: '<%=Request["ordno"] %>', stt: '<%=TempData.Keys.Contains("NEXTSTTCFG") ?  (TempData["NEXTSTTCFG"] as Models.STTCFG).NODDTSTT: "0"%>' }, function () {
                        mini.showMessageBox({
                            title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                            message: '跳转成功！', callback: function (action) {
                                window.location.reload();
                            }
                        });
                    });
                }
            });
        }
        function EndSord(ordno) {
            mini.open({
                url: '<%=Url.RouteUrl(new { controller="Sord",action="EndSordInfo" ,area="WUCSM"}) %>?ordno=' + ordno,
                title: '派工单[' + ordno + '] - 验收', width: 600, height: 400,
                ondestroy: function (action) {
                    if (action == 'ok')
                        mini.showMessageBox({
                            title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                            message: '验收成功！', callback: function (action) {
                                window.location.reload();
                            }
                        });
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .mini-tabs-bodys
        {
            border: none;
        }
    </style>
</asp:Content>
