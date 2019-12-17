<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/BaseMdl.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    通知公告
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="portaltoolbar" style="border: 1px solid #cccccc; border-bottom: none; margin-top: 10px;
        padding: 3px 0px 3px 0px">
        &nbsp;&nbsp;&nbsp;生效日期：<input name="SPUBDT" class="mini-datepicker" />
        &nbsp;&nbsp;&nbsp;通知内容：
        <input name="NTCTXT" class="mini-textbox" style="width: 120px" />
        &nbsp;&nbsp;<a class="mini-button" iconcls="icon-zoomin" plain="true" onclick="search()">搜索</a>
        <a class="mini-button" iconcls="icon-close" plain="true" onclick="clear()">清空</a>
    </div>
    <div id="datagrid1" class="mini-datagrid" style="width: 100%;" url="<%=Url.RouteUrl(new { controller="NtcPbuExternal",action="GetNtcPubs" ,area="WUCSM"}) %>"
        onbeforeload="beforeloadnew" allowrowselect="false" onshowrowdetail="onShowRowDetail"
        autohiderowdetail="false">
        <div property="columns">
            <div type="indexcolumn" style="text-align: center;">
            </div>
            <div type="expandcolumn">
                详情
            </div>
            <div field="NTCPUBNO" width="100" allowsort="true">
                发布单号</div>
            <div field="MKDTT" width="120" dateformat="yyyy-MM-dd HH:mm:ss">
                发布日期</div>
            <div field="MKR" width="60" dateformat="yyyy-MM-dd HH:mm:ss">
                发布人</div>
            <div field="MKRNAME" width="60">
                发布人</div>
            <div field="NTCTXT" width="320" headeralign="center" allowsort="true">
                内容</div>
        </div>
    </div>
    <script id="formTemplate" type="text/x-jquery-tmpl">
            <table class="detailForm" style="width:100%; ">
                <tr>
                    <td style="width:30px;text-align: center;color:Red; font-weight:bold">内容：</td>
                    <td style="width:250px;text-align: left;color:Red;">${NTCTXT}</td>
                </tr>
            </table>
    </script>
    <script type="text/javascript">
        mini.parse();

        var grid = mini.get("datagrid1");
        grid.load();
        grid.sortBy("NTCPUBNO", "desc");
        var Genders = [{ id: 1, text: '男' }, { id: 2, text: '女'}];
        function onGenderRenderer(e) {
            for (var i = 0, l = Genders.length; i < l; i++) {
                var g = Genders[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }

        function search() { grid.reload(); }
        function clear() { var pfrm = new mini.Form("#portaltoolbar"); pfrm.reset(); }
        function beforeloadnew(e) { $.extend(e.data, new mini.Form("#portaltoolbar").getData(true)) }

        function onShowRowDetail(e) {
            var grid = e.sender;
            var row = e.record;
            var td = grid.getRowDetailCellEl(row);
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="NtcPbuExternal",action="GetNtcPub" ,area="WUCSM"}) %>',
                data: { PUBNO: row.NTCPUBNO },
                success: function (text) {
                    var o = mini.decode(text);
                    td.innerHTML = "";
                    $("#formTemplate").tmpl(o).appendTo(td);
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <script src="<%=Url.Content("~/Scripts/miniui/jquery.tmpl.js")%>" type="text/javascript"></script>
</asp:Content>
