<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/BaseMdl.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    客户资料
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="portaltoolbar" style="border: 1px solid #cccccc; border-bottom: none; margin-top: 10px;
        padding: 3px 0px 3px 0px">
        &nbsp;&nbsp;状态：<input name="STT" class="mini-combobox" style="width: 80px;" textfield="text"
            valuefield="id" emptytext="--不限--" shownullitem="true" nullitemtext="--不限--"
            data="STTs" />
        &nbsp;联系人：<input name="LNKR" class="mini-textbox" style="width: 120px;" />
        &nbsp;联系电话：<input name="TEL" class="mini-textbox" style="width: 120px;" />
        &nbsp;服务止日：<input name="DISDATE" class="mini-datepicker" style="width: 120px;" />
        &nbsp;客户名称：<input name="CUSNAME" class="mini-textbox" style="width: 120px;" />
        &nbsp;&nbsp;<a class="mini-button" iconcls="icon-zoomin" plain="true" onclick="search()">搜索</a>
        &nbsp;&nbsp;<a class="mini-button" iconcls="icon-close" plain="true" onclick="reset()">重置</a>
    </div>
    <div class="mini-toolbar" style="padding: 2px;">
        <a class="mini-button" iconcls="icon-add" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("CUS","update") %>
            onclick="addRow()">新增客户</a> <a class="mini-button" iconcls="icon-remove" plain="true"
                <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("CUS","update") %> onclick="delRow()">
                移除客户</a> <span class="separator"></span><a class="mini-button" iconcls="icon-add"
                    plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("CUS","update") %> onclick="addOrgRow()">
                    新增门店</a> <a class="mini-button" iconcls="icon-remove" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("CUS","update") %>
                        onclick="delOrgRow()">移除门店</a>
        <%--<a class="mini-button" iconcls="icon-remove" plain="true" onclick="ImpExl()">导入</a>--%>
    </div>
    <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: auto;" allowresize="true"
        url="<%=Url.RouteUrl(new { controller="Cus",action="GetCuses" ,area="WUCSM"}) %>"
        onbeforeload="beforeloadnew" onselectionchanged="onSelectionChanged" idfield="id"
        onshowrowdetail="onShowRowDetail" sizelist="[20,50,100,500]" pagesize="50">
        <div property="columns">
            <div type="expandcolumn">
            </div>
            <div field="CUSID" width="60" headeralign="center" allowsort="true">
                客户编号
                <input property="editor" class="mini-textbox" />
            </div>
            <div field="CUSNAME" width="160" allowsort="true" headeralign="center">
                客户名称
            </div>
            <div field="LNKR" width="60" headeralign="center">
                联系人
            </div>
            <div field="TEL" width="100">
                联系电话
            </div>
            <div field="DISDATE" width="65" allowsort="true" dateformat="yyyy-MM-dd" headeralign="center"
                align="center">
                服务到期日
            </div>
            <div field="ADR" width="160">
                联系地址
            </div>
            <div field="STT" width="35" renderer="onSttRenderer" headeralign="center" align="center">
                状态
            </div>
            <div width="35" renderer="oprenderer" headeralign="center" align="center">
            </div>
        </div>
    </div>
    <br />
    <div id="cusorg_grid" class="mini-datagrid" style="width: 100%; height: 150px;" onshowrowdetail="onOrgShowRowDetail"
        s url="<%=Url.RouteUrl(new { controller="Cus",action="GetCusOrgs" ,area="WUCSM"}) %>">
        <div property="columns">
            <div type="expandcolumn">
            </div>
            <div field="CUSORGID" width="45" align="center" headeralign="center" allowsort="true">
                编号</div>
            <div field="CUSORGNAME" width="200" allowsort="true">
                门店名称</div>
            <div field="LNKR" width="70" headeralign="center" align="center">
                联系人
            </div>
            <div field="TEL" width="80">
                联系电话
            </div>
            <div field="ADR" width="180">
                联系地址
            </div>
            <div field="STT" width="40" renderer="onSttRenderer" headeralign="center" align="center">
                状态
            </div>
            <div width="35" renderer="org_oprenderer" headeralign="center" align="center">
            </div>
        </div>
    </div>
    <div id="editForm1" style="display: none;">
        <input class="mini-hidden" name="CUSID" value="默认" />
        <input class="mini-hidden" name="UPRT" />
        <input class="mini-hidden" name="UPTR" />
        <table style="width: 100%;">
            <tr>
                <td style="width: 100px; text-align: center">
                    客户名称:
                </td>
                <td style="width: 400px;" colspan="3">
                    <input name="CUSNAME" class="mini-textbox" style="width: 100%" required="true" />
                </td>
                <td style="width: 100px; text-align: center">
                    服务止日:
                </td>
                <td style="width: 200px;">
                    <input name="DISDATE" class="mini-datepicker" required="true" style="width: 100%" />
                </td>
                <td style="width: 100px; text-align: center">
                    电子邮箱:
                </td>
                <td style="width: 200px;">
                    <input name="EMAIL" class="mini-textbox" vtype="email" style="width: 100%" />
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    联系地址:
                </td>
                <td colspan="3">
                    <input name="ADR" class="mini-textbox" style="width: 100%" />
                </td>
                <td style="text-align: center">
                    联&nbsp;系&nbsp;人:
                </td>
                <td>
                    <input name="LNKR" class="mini-textbox" style="width: 100%" />
                </td>
                <td style="text-align: center">
                    联系电话:
                </td>
                <td>
                    <input name="TEL" class="mini-textbox" style="width: 100%" required="true" />
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    客户状态:
                </td>
                <td>
                    <input name="STT" enabled="false" class="mini-combobox" data="STTs" style="width: 60px"
                        value="T" />
                </td>
                <td style="text-align: center">
                    自定义号:
                </td>
                <td>
                    <input name="PREFIX" class="mini-textbox" style="width: 100%" vtype="maxLength:8" />
                </td>
                <td style="text-align: right; padding-top: 5px; padding-right: 3px;" colspan="6">
                    <a class="mini-button" iconcls="icon-save" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("CUS","update") %>
                        onclick="updateRow()">保存</a> <a class="mini-button" iconcls="icon-cancel" plain="true"
                            <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("CUS","update") %> onclick="cancelRow()">
                            取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="editOrgForm" style="display: none;">
        <input class="mini-hidden" id="CUSID" name="CUSID" value="默认" />
        <input class="mini-hidden" name="CUSORGID" value="默认" />
        <table style="width: 100%;">
            <tr>
                <td style="width: 100px; text-align: center">
                    门店名称:
                </td>
                <td style="width: 400px;">
                    <input name="CUSORGNAME" class="mini-textbox" style="width: 100%" required="true" />
                </td>
                <td style="width: 100px; text-align: center">
                    联系电话:
                </td>
                <td style="width: 200px;">
                    <input name="TEL" class="mini-textbox" style="width: 140px" />
                </td>
                <td style="width: 100px; text-align: center">
                    客户状态:
                </td>
                <td>
                    <input name="STT" enabled="false" class="mini-combobox" data="STTs" style="width: 120px"
                        value="T" />
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    联系地址:
                </td>
                <td>
                    <input name="ADR" class="mini-textbox" style="width: 280px" />
                </td>
                <td style="text-align: center">
                    联&nbsp;系&nbsp;人:
                </td>
                <td>
                    <input name="LNKR" class="mini-textbox" style="width: 140px" />
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td style="text-align: right; padding-top: 5px; padding-right: 3px;" colspan="6">
                    <a class="mini-button" iconcls="icon-save" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("CUS","update") %>
                        onclick="updateOrgRow()">保存</a> <a class="mini-button" iconcls="icon-cancel" plain="true"
                            <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("CUS","update") %> onclick="cancelOrgRow()">
                            取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="win1" class="mini-window" title="Window" style="width: auto; height: 40;"
        showshadow="true" allowdrag="true">
        <input id="fileupload1" class="mini-fileupload" name="Fdata" limittype="*.xls;*.xlsx;"
            flashurl="/Scripts/swfupload/swfupload.swf" uploadurl='<%=Url.RouteUrl(new { controller="Cus",action="UpLoad" ,area="WUCSM"}) %>'
            onuploadsuccess="onUploadSuccess" />
        <a class="mini-button" iconcls="icon-upload" plain="false" onclick="startUpload()">上传</a>
    </div>
    <script type="text/javascript">
        var STTs = [{ 'id': 'T', 'text': '正常' }, { 'id': 'F', 'text': '停用'}];
        mini.parse();
        var editForm = document.getElementById("editForm1");
        var editOrgForm = document.getElementById("editOrgForm");
        var grid = mini.get("datagrid1");
        var cusorg_grid = mini.get("cusorg_grid");
        cusorg_grid.showPager=false;
        grid.load();
        grid.sortBy("CUSID", "desc");

        function onSttRenderer(e) {
            e.cellStyle = e.record.STT == 'T' ? "color:green;" : "color:red;";
            for (var i = 0, l = STTs.length; i < l; i++) {
                var g = STTs[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }
        function onShowRowDetail(e) {
            var row = e.record;
            //将editForm元素，加入行详细单元格内
            var td = grid.getRowDetailCellEl(row);
            td.appendChild(editForm);
            editForm.style.display = "";
            //表单加载员工信息
            var form = new mini.Form("editForm1");
            if (grid.isNewRow(row)) {
                form.reset();
            } else {
                grid.loading();
                $.ajax({
                    url:"<%=Url.RouteUrl(new { controller="Cus",action="GetCus" ,area="WUCSM"}) %>",
                     data: { CUSID: row.CUSID },
                    success: function (text) {
                        var o = mini.decode(text);
                        form.setData(o);
                        grid.unmask();
                    }
                });
            }
        }

        function cancelRow() {
            var form = new mini.Form("editForm1");
            form.reset();
            editForm.style.display = "none";
        }

        function updateRow() {
            var form = new mini.Form("editForm1");
            form.validate();
            if (form.isValid() == false || form.isChanged() == true) return;
            var o = form.getData(true,false);
            grid.loading("保存中，请稍后......");
            var json = mini.encode(o);
            $.ajax({
                url:"<%=Url.RouteUrl(new { controller="Cus",action="SaveSvc" ,area="WUCSM"}) %>",
                data: { data: json },
                success: function (text) {
                  var row = grid.findRow(function(row){
                  if(row.CUSID == o["CUSID"]) return true;});
                  grid.updateRow(row, mini.decode(text));
                  grid.acceptRecord(row);
                  form.setData(mini.decode(text));
                  grid.unmask();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    grid.unmask();
                }
            });
        }
         function oprenderer(e) {
            var  DisStr="停用";
            var cusid=e.record.CUSID;
            if(e.record.STT=="F") DisStr="启用"
            var s = '<a class="Delete_Button" href="javascript:AdjRow(\'' + cusid + '\')">'+DisStr+'</a>';
            return s;
        }
        function AdjRow(cusid){
            grid.loading();
            $.ajax({
                url:'<%=Url.RouteUrl(new { controller="Cus",action="CusAdj" ,area="WUCSM"}) %>',
                data: { CUSID: cusid },
                success: function (text) {
                  var row = grid.findRow(function(row){
                  if(row.CUSID == cusid) return true;});
                  grid.updateRow ( row, mini.decode(text));
                  grid.unmask();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    grid.unmask();
                }
            });
        }

        function addRow() {            
            var row = {"CUSID":"默认"};
            grid.addRow(row, 0);
        }

       function delRow(){
          var row=  grid.getSelected();
          if(row==null) return;
          if(row.CUSID =="默认") grid.removeRow(row,true);
       }

        function search() {
            var pfrm = new mini.Form("#portaltoolbar");
            var o = pfrm.getData();
            grid.reload();
        }
        function reset(){  var pfrm = new mini.Form("#portaltoolbar");pfrm.reset();}
        function beforeloadnew(e) { $.extend(e.data, new mini.Form("#portaltoolbar").getData(true)) }

//------------------------------------------------------门店操作-------------------------------------------------------------------//
         function onSelectionChanged(e) {
            var grid = e.sender;
            var record = grid.getSelected();
            if (record) {
                cusorg_grid.load({ CUSID: record.CUSID });
            }
        }

        function onOrgShowRowDetail(e){
            var row = e.record;
            //将editForm元素，加入行详细单元格内
            var td = cusorg_grid.getRowDetailCellEl(row);
            td.appendChild(editOrgForm);
            editOrgForm.style.display = "";
            //表单加载员工信息
            var orgform = new mini.Form("editOrgForm");
            if (cusorg_grid.isNewRow(row)) {
                orgform.reset();
                mini.get("CUSID").setValue(row.CUSID);
            } else {
                cusorg_grid.loading();
                $.ajax({
                    url:"<%=Url.RouteUrl(new { controller="Cus",action="GetCusOrg" ,area="WUCSM"}) %>",
                    data: { CUSID: row.CUSID,CUSORGID:row.CUSORGID},
                    success: function (text) {
                        var o = mini.decode(text);
                        orgform.setData(o);
                        cusorg_grid.unmask();
                    }
                });
            }
        }

         function cancelOrgRow() {
            var orgform = new mini.Form("editOrgForm");
            orgform.reset();
            editOrgForm.style.display = "none";
        }

        function updateOrgRow() {
            var orgform = new mini.Form("editOrgForm");
            var o = orgform.getData(true,false);
            cusorg_grid.loading("保存中，请稍后......");
            var json = mini.encode(o);
            $.ajax({
                url:"<%=Url.RouteUrl(new { controller="Cus",action="SaveCusOrg" ,area="WUCSM"}) %>",
                data: { data: json },
                success: function (text) {
                  var row = cusorg_grid.findRow(function(row){
                  if(row.CUSORGID == o["CUSORGID"]) return true;});
                  cusorg_grid.updateRow(row, mini.decode(text));
                  cusorg_grid.acceptRecord(row);
                  orgform.setData(mini.decode(text));
                  cusorg_grid.unmask();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    cusorg_grid.unmask();
                }
            });
        }
         function org_oprenderer(e) {
            var  DisStr="停用";
            var cusid=e.record.CUSID;
            var cusorgid=e.record.CUSORGID
            if(e.record.STT=="F") DisStr="启用"
            var s = '<a class="Delete_Button" href="javascript:AdjOrgRow(\'' + cusid + '\',\''+cusorgid+'\')">'+DisStr+'</a>';
            return s;
        }

         function AdjOrgRow(cusid,cusorgid){
            cusorg_grid.loading();
            $.ajax({
                url:'<%=Url.RouteUrl(new { controller="Cus",action="CusOrgAdj" ,area="WUCSM"}) %>',
                data: { CUSID: cusid ,CUSORGID:cusorgid},
                success: function (text) {
                  var row =cusorg_grid .findRow(function(row){
                  if(row.CUSORGID == cusorgid) return true;});
                  cusorg_grid.updateRow ( row, mini.decode(text));
                  cusorg_grid.unmask();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    cusorg_grid.unmask();
                }
            });
        }

         function addOrgRow() { 
           var cusrow=  grid.getSelected();
           if(cusrow==null){ mini.alert("请选择客户!");  return ;}
           var row = {"CUSORGID":"默认","CUSID":cusrow.CUSID};
            cusorg_grid.addRow(row, 0);
        }

       function delOrgRow(){var row=cusorg_grid.getSelected();if(row==null) return;if(row.CUSORGID =="默认") cusorg_grid.removeRow(row,false);}
       function ImpExl(){var win = mini.get("win1");win.showAtPos("center", "middle");}
       function startUpload() { var fileupload = mini.get("fileupload1"); fileupload.startUpload(); }
       function onUploadSuccess(e) { mimi.alert(e.toString()); }

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="<%=Url.Content("~/Scripts/swfupload/swfupload.js")%>"></script>
</asp:Content>
