<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/BaseMdl.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    通知发布
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="width: 100%">
        <div id="portaltoolbar" style="border: 1px solid #cccccc; border-bottom: none; margin-top: 10px;
            padding: 3px 0px 3px 0px">
            &nbsp; &nbsp;&nbsp;通知状态：<input name="STT" class="mini-combobox" style="width: 80px;"
                textfield="text" valuefield="id" emptytext="--不限--" shownullitem="true" nullitemtext="--不限--"
                data="Stts" value="10" />
            &nbsp;&nbsp;&nbsp;是否有效：<input name="ISVLD" class="mini-combobox" style="width: 80px;"
                textfield="text" valuefield="id" emptytext="--不限--" shownullitem="true" nullitemtext="--不限--"
                data="Vlds" value="T" />
            &nbsp;&nbsp;&nbsp;生效日期：<input name="SPUBDT" class="mini-datepicker" />
            &nbsp;&nbsp;&nbsp;通知内容：
            <input name="NTCTXT" class="mini-textbox" style="width: 120px" />
            &nbsp;&nbsp;<a class="mini-button" iconcls="icon-zoomin" plain="true" onclick="search()">搜索</a>
        </div>
        <div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
            <table style="width: 100%;">
                <tr>
                    <td style="width: 100%;">
                        <a class="mini-button" iconcls="icon-add" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("NTCPUB","update") %>
                            onclick="newRow()">新增</a> <a class="mini-button" iconcls="icon-remove" plain="true"
                                <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("NTCPUB","delete") %> onclick="remove()">
                                删除</a> <a class="mini-button" iconcls="icon-ok" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("NTCPUB","release") %>
                                    onclick="pubRow()">发布</a> <a class="mini-button" iconcls="icon-split" plain="true"
                                        <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("NTCPUB","invalid") %> onclick="rspRow()">
                                        作废</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 280px;" url="<%=Url.RouteUrl(new { controller="NtcPub",action="GetNtcPubs" ,area="WUCSM"}) %>"
        idfield="id" onbeforeload="beforeloadnew" onselectionchanged="onSelectionChanged"
        sizelist="[20,50,100,500]" multiselect="true" pagesize="20">
        <div property="columns">
            <div type="checkcolumn">
            </div>
            <div type="indexcolumn" style="text-align: center; width: 10px;">
                序号</div>
            <div field="NTCPUBNO" width="80" headeralign="center" allowsort="true">
                发布单号</div>
            <div field="PUBDT" width="70" allowsort="true" headeralign="center" dateformat="yyyy-MM-dd">
                生效日期</div>
            <div field="DISDT" width="70" allowsort="true" headeralign="center" dateformat="yyyy-MM-dd">
                失效日期</div>
            <div field="ISVLD" width="50" allowsort="true" headeralign="center" renderer="onVldRenderer"
                align="center" headeralign="center">
                是否有效</div>
            <div field="STT" width="50" allowsort="true" headeralign="center" renderer="onSttRenderer"
                align="center" headeralign="center">
                通知状态</div>
            <div field="MKR" width="60" allowsort="true" align="center" headeralign="center"
                visible="false">
                制单人</div>
            <div field="NTCCUS" width="100">
                通知客户</div>
            <div field="MKDTT" width="70" headeralign="center" dateformat="yyyy-MM-dd HH:mm:ss">
                制单时间</div>
            <div field="NTCTXT" width="200" allowsort="true">
                通知内容</div>
        </div>
    </div>
    <fieldset style=" border: solid 1px #aaa; position: relative; margin-top: 5px;">
        <legend style="font-weight: bold">&nbsp;通知详细信息&nbsp;</legend>
        <div id="editForm1" style="padding: 5px;">
            <input class="mini-hidden" id="MKR" name="MKR" />
            <input class="mini-hidden" id="MKDTT" name="MKDTT" />
            <table style="width: 100%;">
                <tr>
                    <td style="width: 100px;">
                        通知单号：
                    </td>
                    <td style="width: 130px;">
                        <input id="NTCPUBNO" name="NTCPUBNO" class="mini-textbox" value="默认" enabled="false" />
                    </td>
                    <td style="width: 100px;">
                        生效日期：
                    </td>
                    <td style="width: 130px;">
                        <input name="PUBDT" class="mini-datepicker" format="yyyy-MM-dd" />
                    </td>
                    <td style="width: 100px;">
                        失效日期：
                    </td>
                    <td style="width: 130px;">
                        <input name="DISDT" class="mini-datepicker" format="yyyy-MM-dd" />
                    </td>
                    <td style="width: 100px;">
                        通知状态：
                    </td>
                    <td style="width: 130px;">
                        <input id="STT" name="STT" class="mini-combobox" data="Stts" shownullitem="true"
                            enabled="false" multiselect="false" value="10" required="true" allowinput="true"
                            shownullitem="true" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px;">
                        通知客户：
                    </td>
                    <td colspan="5">
                        <input id="NTCCUS" name="NTCCUS" class="mini-lookup" style="width: 100%;" textfield="CUSNAME"
                            valuefield="CUSID" popupwidth="auto" popup="#gridPanel" grid="#datagrid2" multiselect="true" />
                    </td>
                    <td style="width: 100px;">
                        是否有效：
                    </td>
                    <td style="width: 130px;">
                        <input id="ISVLD" name="ISVLD" class="mini-combobox" data="Vlds" shownullitem="true"
                            enabled="false" multiselect="false" value="T" required="true" allowinput="true"
                            shownullitem="true" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px;">
                        通知内容：
                    </td>
                    <td colspan="7" style="text-align: left">
                        <textarea class="mini-textarea" id="NTCTXT" name="NTCTXT" emptytext="请输入通知类容" style="width: 100%;
                            height: 80px; text-align: left"></textarea>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-top: 5px; padding-right: 3px;" colspan="8">
                        <a class="mini-button" iconcls="icon-save" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("NTCPUB","update") %>
                            onclick="updateRow()">保存</a> <a class="mini-button" iconcls="icon-cancel" plain="true"
                                <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("NTCPUB","update") %> onclick="cancelRow()">
                                取消</a>
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
    <div id="gridPanel" class="mini-panel" title="header" iconcls="icon-add" style="width: 450px;
        height: 250px;" showtoolbar="true" showclosebutton="true" showheader="false"
        bodystyle="padding:0" borderstyle="border:0">
        <div property="toolbar" style="padding: 5px; padding-left: 8px; text-align: center;">
            <div style="float: left; padding-bottom: 2px;">
                <span>姓名：</span>
                <input id="keyText" class="mini-textbox" style="width: 160px;" onenter="onSearchClick" />
                <a class="mini-button" onclick="onSearchClick">查询</a> <a class="mini-button" onclick="onClearClick">
                    清除</a>
            </div>
            <div style="float: right; padding-bottom: 2px;">
                <a class="mini-button" onclick="onCloseClick">关闭</a>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div id="datagrid2" class="mini-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0"
            showpagesize="false" showpageindex="false" url="<%=Url.RouteUrl(new { controller="NtcPub",action="GetCus" ,area="WUCSM"}) %>"
            sizelist="[20,50,100,500]" pagesize="20">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div field="CUSID" width="120" headeralign="center" allowsort="true">
                    客户编号</div>
                <div field="CUSNAME" width="120" headeralign="center" allowsort="true">
                    客户名称</div>
                <div field="LNKR" width="100">
                    联系人</div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var Stts = [{ 'id': '10', 'text': '待发布' }, { 'id': '90', 'text': '已发布'}];
        var Vlds = [{ 'id': 'T', 'text': '有效' }, { 'id': 'F', 'text': '无效'}];
        mini.parse();
        var editForm = document.getElementById("editForm1");
        var form = new mini.Form("editForm1");
        var grid = mini.get("datagrid1");
        var grid2 = mini.get("datagrid2");
        var keyText = mini.get("keyText");
        grid.load();
        grid.sortBy("NTCPUBNO", "desc");
        grid2.load();

        function onVldRenderer(e) { for (var i = 0, l = Vlds.length; i < l; i++) { var g = Vlds[i]; if (g.id == e.value) return g.text; } return ""; }
        function onSttRenderer(e) { for (var i = 0, l = Stts.length; i < l; i++) { var g = Stts[i]; if (g.id == e.value) return g.text; } return ""; }
        function newRow() { var row = {}; grid.addRow(row, 0); editRow(row._uid); }

        function onSelectionChanged(e) {
            var grid = e.sender;
            var record = grid.getSelected();
            if (record) editRow(record._uid);
            else form.reset();
        }

        function remove() {
            var rows = grid.getSelecteds();
            if (rows.length <= 0) alert("请选中一条记录");
            else {
                if (confirm("确定删除选中记录？")) {
                    var NtcPubNos = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        NtcPubNos.push(r.NTCPUBNO);
                    }
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: '<%=Url.RouteUrl(new { controller="NtcPub",action="DelSvc" ,area="WUCSM"}) %>',
                        data: { NTCPUBNO: NtcPubNos.toString() },
                        success: function (text) {
                            grid.reload();
                        },
                        error: function () { }
                    });
                }
            }
        }

        function editRow(row_uid) {
            var row = grid.getRowByUID(row_uid);
            if (row) {
                var form = new mini.Form("editForm1");
                if (grid.isNewRow(row)) { form.reset(); return; }
                else {
                    form.loading();
                    $.ajax({
                        url: '<%=Url.RouteUrl(new { controller="NtcPub",action="GetNtcPub" ,area="WUCSM"}) %>',
                        data: { PUBNO: row.NTCPUBNO },
                        success: function (text) {
                            var o = mini.decode(text);
                            form.setData(o);
                            var xx = mini.get("NTCCUS");
                            xx.setText(o["NTCCUS"]);
                            xx.setValue(o["NTCCUS"]);
                            form.unmask();
                        }
                    });
                }
                grid.doLayout();
            }
        }
        function cancelRow() {
            var row = grid.getSelecteds()[0];
            editRow(row._uid);
        }

        function pubRow() {
            var form = new mini.Form("editForm1");
            var o = form.getData();
            grid.loading("发布中，请稍后......");
            var json = mini.encode([o]);
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="NtcPub",action="PubSvc" ,area="WUCSM"}) %>',
                data: { data: json },
                success: function (text) {
                    alert(text);
                    grid.reload();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
        }

        function rspRow() {
            var form = new mini.Form("editForm1");
            var o = form.getData();
            grid.loading("作废中，请稍后......");
            var json = mini.encode([o]);
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="NtcPub",action="RspSvc" ,area="WUCSM"}) %>',
                data: { data: json },
                success: function (text) {
                    grid.reload();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
        }

        function updateRow() {
            var form = new mini.Form("editForm1");
            var o = form.getData();
            grid.loading("保存中，请稍后......");
            var json = mini.encode([o]);
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="NtcPub",action="SaveSvc" ,area="WUCSM"}) %>',
                data: { data: json },
                success: function (text) {
                    grid.reload();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
        }

        function search() { grid.reload(); }
        function beforeloadnew(e) { $.extend(e.data, new mini.Form("#portaltoolbar").getData(true)) }

        function onSearchClick(e) { datagrid2.load({ CUSNAME: keyText.value }); }
        function onCloseClick(e) { var NTCCUS = mini.get("NTCCUS"); NTCCUS.hidePopup(); }
        function onClearClick(e) { var NTCCUS = mini.get("NTCCUS"); NTCCUS.deselectAll(); }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
</asp:Content>
