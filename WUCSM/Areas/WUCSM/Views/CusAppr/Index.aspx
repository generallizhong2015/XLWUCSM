<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/BaseMdl.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    统计分析
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="portaltoolbar" style="border: 1px solid #cccccc; border-bottom: none; margin-top: 10px;
        padding: 3px 0px 3px 0px">
       <%-- &nbsp;&nbsp; 客户经理：<input id="lookupcus1" name="USERIDS" class="mini-lookup" style="width: 200px;"
            textfield="USERNAME" multiselect="true" valuefield="USERID" popupwidth="auto"
            popup="#gridPanel1" grid="#datagridcus1" />--%>
        &nbsp;统计起日：<input name="SDT" class="mini-datepicker" style="width: 120px;" />
        &nbsp;统计止日：<input name="EDT" class="mini-datepicker" style="width: 120px;" />
        &nbsp;&nbsp;<a class="mini-button" iconcls="icon-zoomin" plain="true" onclick="search()">搜索</a>
        &nbsp;&nbsp;<a class="mini-button" iconcls="icon-close" plain="true" onclick="reset()">重置</a>
    </div>
    <div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 100%;">
                    <a class="mini-button" iconcls="icon-goto" plain="true" onclick="View()">详细数据</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="portalgrid" class="mini-datagrid" idfield="id" url="<%=Url.RouteUrl(new { controller="CusAppr",action="GetCusAppr" ,area="WUCSM"}) %>"
        allowcelledit="true" allowcellselect="true" allowcellselect="true" sizelist="[30,50,100]"
        onbeforeload="beforeloadnew" multiselect="true" pagesize="50" sortfield="USERID"
        sortorder="desc">
        <div property="columns">
            <div type="checkcolumn">
            </div>
            <div type="indexcolumn" style="text-align: center; width: 10px;">
                序号</div>
            <div field="USERID" width="70" headeralign="center" allowsort="true">
                编号</div>
            <div field="USERNAME" width="70" headeralign="center" allowsort="true">
                名称</div>
            <div field="COUNT" width="80" headeralign="center" allowsort="true">
                累计数</div>
            <div field="ACCEPT_COUNT" width="80" allowsort="true" headeralign="center">
                已验收</div>
            <div field="NACCEPT_COUNT" width="80" allowsort="true" headeralign="center">
                未验收</div>
            <div field="UNTREATED_COUNT" width="80" allowsort="true" headeralign="center">
                未处理</div>
            <div field="FIVEDGR" width="60" allowsort="true" headeralign="center">
                五星</div>
            <div field="FOURDGR" width="60" allowsort="true" headeralign="center">
                四星</div>
            <div field="THREEDGR" width="60" allowsort="true" headeralign="center">
                三星</div>
            <div field="TWODGR" width="60" allowsort="true" headeralign="center">
                二星</div>
            <div field="ONEDGR" width="60" allowsort="true" headeralign="center">
                一星</div>
            <div field="NODGR" width="60" allowsort="true" headeralign="center">
                无星</div>
        </div>
    </div>
    <%-- 弹出窗口    --%>
    <%--<div id="gridPanel1" class="mini-panel" title="header" iconcls="icon-add" style="width: 450px;
        height: 250px;" showtoolbar="true" showclosebutton="true" showheader="false"
        bodystyle="padding:0" borderstyle="border:0">
        <div property="toolbar" style="padding: 5px; padding-left: 8px; text-align: center;">
            <div style="float: left; padding-bottom: 2px;">
                <span>客户经理：</span>
                <input id="keyText1" class="mini-textbox" style="width: 160px;" onenter="onSearchClick1" />
                <a class="mini-button" onclick="onSearchClick1">查询</a> <a class="mini-button" onclick="onClearClick1">
                    清除</a>
            </div>
            <div style="float: right; padding-bottom: 2px;">
                <a class="mini-button" onclick="onCloseClick1">关闭</a>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div id="datagridcus1" class="mini-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0"
            showpagesize="false" showpageindex="false" url="<%=Url.RouteUrl(new { controller="FastQuery",action="QryAdminUser" ,area="WUCSM"}) %>">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div field="USERID" width="70" allowsort="true">
                    编号</div>
                <div field="USERNAME" width="300" allowsort="true">
                    姓名</div>
            </div>
        </div>
    </div>
    <div id="editWindow" class="mini-window" title="服务单信息" style="height: 430px; width: 900px;"
        showmodal="true" allowresize="true" allowdrag="true">
        <div id="editform" class="mini-datagrid" idfield="id" url="<%=Url.RouteUrl(new { controller="CusAppr",action="GetCusApprOrd" ,area="WUCSM"}) %>"
            allowcelledit="true" allowcellselect="true" allowcellselect="true" sizelist="[30,50,100]"
            style="height: 390px" multiselect="true" pagesize="50" sortfield="ORDNO" sortorder="desc">
            <div property="columns">
                <div type="indexcolumn" style="text-align: center; width: 10px;">
                    序号</div>
                <div field="ORDNO" width="60" headeralign="center" allowsort="true">
                    单号</div>
                <div field="SUBCUSNAME" width="70" headeralign="center" allowsort="true">
                    客户</div>
                <div field="PRCMANNAME" width="50" headeralign="center" allowsort="true">
                    处理人</div>
                <div field="SUBDT" width="60" allowsort="true" headeralign="center">
                    提交日期
                </div>
                <div field="STTNAME" width="60" allowsort="true" headeralign="center">
                    状态
                </div>
                <div field="SUBTXT" width="200" allowsort="true" headeralign="center">
                    提交内容
                </div>
            </div>
        </div>
    </div>--%>
    <script type="text/javascript">
        mini.parse();
        var grid = mini.get("portalgrid");
        grid.load();

        var datagridcus1 = mini.get("datagridcus1");
        var keyText1 = mini.get("keyText1");
        function onSearchClick1(e) {
            datagridcus1.load({
                key: keyText1.value
            });
        }
        function onCloseClick1(e) {
            var lookupcus1 = mini.get("lookupcus1");
            lookupcus1.hidePopup();
        }
        function onClearClick1(e) {
            var lookupcus1 = mini.get("lookupcus1");
            lookupcus1.deselectAll();
        }

        function View() {
            var CueCell = grid.getCurrentCell();
            var userid = CueCell[0]["USERID"];
            var sdt = CueCell[0]["SDT"];
            var edt = CueCell[0]["EDT"];
            var field = CueCell[1]["field"];
            mini.get("editWindow").show();
            mini.get("editform").load({ USERID: userid, SDT: sdt, EDT: edt, FIELD: field });
        }

        function search() {
            var pfrm = new mini.Form("#portaltoolbar");
            var o = pfrm.getData();
            grid.reload();
        }
        function reset() { var pfrm = new mini.Form("#portaltoolbar"); pfrm.reset(); }
        function beforeloadnew(e) { $.extend(e.data, new mini.Form("#portaltoolbar").getData(true)) }
    </script>
</asp:Content>
<asp:Content ID="Conteant3" ContentPlaceHolderID="head" runat="server">
</asp:Content>
