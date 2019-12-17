<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/BaseMdl.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    客服-客户关系
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="mini-splitter" style="width: 100%; height: 550px;">
        <div size="20%" showcollapsebutton="true">
            <div class="mini-toolbar" style="padding: 2px; border-top: 0; border-left: 0; border-right: 0;">
                <input class="mini-textbox" style="width: 130px" id="username" onenter="onKeyEnter" />
                <a class="mini-button" iconcls="icon-search" plain="true" onclick="TrSearch()">查找</a>
            </div>
            <div class="mini-fit">
                <ul id="tree1" class="mini-tree" url="<%=Url.RouteUrl(new { controller="UserCus",action="InitTree" ,area="WUCSM"}) %>"
                    style="width: 100%;" showtreeicon="true" textfield="name" idfield="id" parentfield="pid"
                    resultastree="false">
                </ul>
            </div>
        </div>
        <div showcollapsebutton="true">
            <div class="mini-toolbar" style="padding: 2px; border-top: 0; border-left: 0; border-right: 0;">
                <a class="mini-button" iconcls="icon-add" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("USERCUS","insert") %>
                    onclick="addRow()">新增</a> <a class="mini-button" iconcls="icon-remove" plain="true"
                        <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("USERCUS","delete") %> onclick="removeRow()">
                        删除</a>
            </div>
            <div class="mini-fit">
                <div id="grid1" class="mini-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0;"
                    url="<%=Url.RouteUrl(new { controller="UserCus",action="GetUserCuses" ,area="WUCSM"}) %>"
                    sizelist="[50,100,300,500]" multiselect="true" pagesize="50">
                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div type="indexcolumn" headeralign="center" style="text-align: center; width: 10px;">
                            序号</div>
                        <div field="CUSID" width="70" allowsort="true">
                            客户号</div>
                        <div field="CUSNAME" width="200" allowsort="true">
                            客户名称</div>
                        <div field="LNKR" width="60" allowsort="true">
                            联系人</div>
                        <div field="TEL" width="80" allowsort="true">
                            联系电话
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        mini.parse();

        var tree = mini.get("tree1");
        var grid = mini.get("grid1");

        tree.on("nodeselect", function (e) {
            if (e.isLeaf) {
                grid.load({ USERID: e.node.id });
            } else {
                grid.setData([]);
                grid.setTotalCount(0);
            }
        });

        function TrSearch() {
            var tree = mini.get("tree1");
            var keyValue = mini.get("username").getValue();
            var msgid = mini.loading("数据查询中，请稍后......");
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="UserCus",action="InitTree" ,area="WUCSM"}) %>',
                data: { username: keyValue },
                type: "post",
                success: function (text) {
                    var data = mini.decode(text);
                    tree.loadList(data);
                    mini.hideMessageBox(msgid);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
        }
        function onKeyEnter(e) { TrSearch(); }

        function addRow() {
            var win = new UserSelectWindow();
            var node = tree.getSelectedNode();
            if (!node) return;
            win.set({
                url: '<%=Url.RouteUrl(new { controller="UserCus",action="GetCuses" ,area="WUCSM"}) %>',
                title: "客户选择",
                width: 700,
                height: 500,
                keyLable: "客户名称:",
                params: { USERID: node.id }
            });
            win.setKeyField("CUSNAME");
            win.show();
            win.search();
            win.setData(null, function (action) {
                if (action == "ok") {
                    var rows = win.getData();
                    if (rows.length <= 0) { mini.alert("请选择至少一条数据!", "提示信息", false); return; }
                    grid.loading("保存中，请稍后......");
                    $.ajax({
                        url: '<%=Url.RouteUrl(new { controller="UserCus",action="SaveSvc" ,area="WUCSM"}) %>',
                        data: { data: mini.encode(rows), USERID: node.id },
                        type:"post",
                        success: function (text) {
                            if (text == "保存成功!") {
                                grid.reload();
                                notify(text);
                            }
                            grid.unmask();
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert(jqXHR.responseText);
                            grid.unmask();
                        }
                    });
                }
            });
        }
        function removeRow() {
            var rows = grid.getSelecteds();
            if (rows.length <= 0) { mini.alert("请选择至少一条数据!", "提示信息", false); return; }
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="UserCus",action="DelSvc" ,area="WUCSM"}) %>',
                data: { data: mini.encode(rows) },
                success: function (text) {
                    if (text == "删除成功!") {
                        grid.removeRows(rows, true);
                        notify(text);
                    }
                    grid.unmask();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
        }

        function notify(text) {
            mini.showMessageBox({
                showModal: true,
                width: 200,
                title: "提示信息",
                iconCls: "mini-messagebox-warning",
                message: text,
                timeout: 1200,
                x: 'right',
                y: 'bottom'
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <script src="<%=Url.Content("~/Scripts/miniui/UserSelectWindow.js")%>" type="text/javascript"></script>
</asp:Content>
