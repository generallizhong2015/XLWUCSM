<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/BaseMdl.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
     成员管理
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <script type="text/javascript" src="../../../../Scripts/swfupload/swfupload.js"></script>
    <div style="width: 100%; margin-top: 30px;">
        <div id="portaltoolbar" style="border: 1px solid #cccccc; border-bottom: none; margin-top: 10px;
            padding: 3px 0px 3px 0px">
            &nbsp;&nbsp;&nbsp;登录号：<input id="LOGID" name="LOGID" class="mini-textbox" onenter="onKeyEnter" />
            &nbsp;&nbsp;&nbsp;用户姓名：<input id="USERNAME" name="USERNAME" class="mini-textbox"
                onenter="onKeyEnter" />
            &nbsp;&nbsp;&nbsp;用户状态：<input id="STT" name="STT" class="mini-combobox" style="width: 120px;"
                textfield="text" valuefield="id" emptytext="----不限----" shownullitem="true" nullitemtext="----不限----"
                data="sstt" onvaluechanged="RefreshData" value="1" />
            &nbsp; &nbsp;&nbsp;性别：<input id="SEX" name="SEX" class="mini-combobox" style="width: 120px;"
                textfield="text" valuefield="id" emptytext="----不限----" shownullitem="true" nullitemtext="----不限----"
                data="uset" onvaluechanged="RefreshData" />
          
            &nbsp;&nbsp;<a class="mini-button" onclick="RefreshData();" iconcls="icon-zoomin"
                plain="true">搜索</a>
        </div>
        <div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
            <table style="width: 100%;">
                <tr>
                    <td style="width: 100%;">
                       <a class="mini-button" iconcls="icon-add" plain="true" onclick="add()">新增</a>
                        <%-- <a class="mini-button" iconcls="icon-remove" plain="true"  <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("USERGRP","delete") %>  onclick="remove()">删除</a>--%>
                        <a class="mini-button" iconcls="icon-no" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("USERGRP","userno") %> onclick="userno()">用户停用</a>
                        <a class="mini-button" iconcls="icon-user" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("USERGRP","setuser") %> onclick="setuser()">激活账户</a>
                        <a class="mini-button" iconcls="icon-goto" plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("USERGRP","setpwd") %> onclick="setpwd()">重置密码</a>
                        <a class="mini-button" iconcls="icon-unlock" plain="true"  <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("USERGRP","savepwr") %>  onclick="setpwr()">权限授权</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="portalgrid" class="mini-datagrid" idfield="id" url="<%=Url.RouteUrl(new { controller="UserGrp",action="GetUsers" ,area="WUCSM"}) %>"
        allowcelledit="true" allowcellselect="true" onselectionchanged="onSelectionChanged"
        sizelist="[15,30,50,100]" multiselect="true" pagesize="15" sortfield="LOGID"
        sortorder="desc">
        <div property="columns">
            <div type="checkcolumn">
            </div>
            <div type="indexcolumn" style="text-align: center; width: 10px;">
                序号</div>
            <div field="LOGID" width="100" headeralign="center" allowsort="true">
                登录号</div>
            <div field="USERNAME" width="100" allowsort="true" headeralign="center">
                用户姓名</div>
            <div field="CUSID" width="50" allowsort="true" headeralign="center">
                客户号</div>
          <%--  <div field="CUSORGID" width="70" allowsort="true" headeralign="center">
                门店号</div>--%>
                   <div field="CUSNAME" width="170" allowsort="true" headeralign="center">
                客户名称</div>
            <div field="USERTYP" width="50" allowsort="true" headeralign="center" align="center"
                renderer="onUserTypRenderer" headeralign="center">
                用户类型</div>
            <div field="STT" width="50" allowsort="true" headeralign="center" align="center"
                renderer="onSttRenderer" headeralign="center">
                用户状态
                <input id="cSTT" name="cSTT" property="editor" onvaluechanged="updateuserstt" class="mini-combobox"
                    style="width: 100%;" data="[{ 'id': '1', 'text': '正常' }, { 'id': '2', 'text': '未授权' }, { 'id': '0', 'text': '停用'}]" />
            </div>
            <div field="SEX" width="40" allowsort="true" renderer="onSexRenderer">
                性别</div>
            <div field="ISSYS" width="50" allowsort="true" renderer="onIsSysRenderer">
                超级用户</div>
        </div>
    </div>
    <fieldset style=" border: solid 1px #aaa; position: relative; margin-bottom: 50px;
        margin-top: 10px;">
        <legend style="font-weight: bold">&nbsp;用户详细信息&nbsp;</legend>
        <div id="editForm1" style="padding: 5px; width: 100%">
            <input class="mini-hidden" id="USERID" name="USERID" />
            <input class="mini-hidden" id="CUSID" name="CUSID" />
            <input class="mini-hidden" id="CUSORGID" name="CUSORGID" />
            <input class="mini-hidden" id="ITEL" name="ITEL" />
            <table style="width: 100%">
                <tr>
                    <td style="width: 100px; text-align: center">
                        <span style="color: Red">*</span>登录账号：
                    </td>
                    <td>
                        <input id="Text1" name="LOGID" class="mini-textbox" enabled="false" required="true"
                            vtype="rangeLength:2,20" style="width: 250px" />
                    </td>
                    <td style="width: 60px;">
                        &nbsp;
                    </td>
                    <td style="width: 100px; text-align: center">
                        <span style="color: Red">*</span>用户姓名：
                    </td>
                    <td>
                        <input id="Text2" name="USERNAME" class="mini-textbox" maxlength="8" onvalidation="onChineseValidation"
                            required="true" style="width: 250px" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; text-align: center">
                        <span style="color: Red">*</span>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：
                    </td>
                    <td>
                        <input id="Text3" name="SEX" class="mini-combobox" data="[{ 'id': 'M', 'text': '男' }, { 'id': 'F', 'text': '女'}]"
                            required="true" style="width: 250px" value="M" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td style="width: 100px; text-align: center">
                        <span style="color: Red">*</span>用户性质：
                    </td>
                    <td>
                        <input id="Text4" name="USERTYP" class="mini-combobox" data=" [{ 'id': '02', 'text': '客户用户'}]"
                            required="true" style="width: 250px" value="02" />
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
                       <%-- <input id="ITEL" name="ITEL" class="mini-textbox" style="width: 65px" />--%>
                    </td>
                    <td rowspan="5" style="vertical-align: middle; text-align: center; width: 200px">
                        <img id="PIC" name="PIC" src="../../../../Images/tx.gif" style="width: 135px; height: 145px;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; text-align: center">
                        &nbsp;Q&nbsp;Q&nbsp;号码：
                    </td>
                    <td>
                        <input id="QQ" name="QQ" class="mini-textbox" vtype="int" maxlength="10" style="width: 250px" />
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
                        <input id="DPT" name="DPT" class="mini-combobox" style="width: 250px;" textfield="text"
                            emptytext="----请选择----" multiselect="false" nullitemtext="----请选择----" valuefield="id"
                            shownullitem="true" data="[{ 'id': '01', 'text': '信息部' }, { 'id': '02', 'text': '维护部' }, { 'id': '03', 'text': '其他部门'}]" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td style="width: 100px; text-align: center">
                        职务职称：
                    </td>
                    <td>
                        <input id="PSTN" name="PSTN" class="mini-combobox" style="width: 250px;" textfield="text"
                            emptytext="----请选择----" multiselect="false" nullitemtext="----请选择----" valuefield="id"
                            shownullitem="true" data="[{ 'id': '01', 'text': '职员' }, { 'id': '02', 'text': '经理' }, { 'id': '03', 'text': '总监' }, { 'id': '04', 'text': '其他'}]" />
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
                        <input id="Text5" name="STT" class="mini-combobox" style="width: 250px;" textfield="text"
                            valuefield="id" data="[{ 'id': '0', 'text': '停用' }, { 'id': '1', 'text': '正常' }, { 'id': '2', 'text': '未授权'}]"
                            value="1" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td style="width: 100px; text-align: center">
                        账户角色：
                    </td>
                    <td>
                        <input id="Text6" name="ISSYS" class="mini-combobox" style="width: 250px;" textfield="text"
                            valuefield="id" data="[{ 'id': 'T', 'text': '超级用户' }, { 'id': 'F', 'text': '普通用户'}]"
                            value="F" />
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
                            flashurl="/Scripts/swfupload/swfupload.swf" uploadurl='<%=Url.RouteUrl(new { controller="UserGrp",action="UpLoad" ,area="WUCSM"}) %>'
                            onuploadsuccess="onUploadSuccess" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-top: 5px; padding-right: 3px;" colspan="5">
                        <a class="mini-button" iconcls="icon-save" plain="false"  <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("USERGRP","update") %> onclick="SaveSvc()">保存</a>
                        <a class="mini-button" iconcls="icon-cancel" plain="false" onclick="Cancel()">取消</a>
                    </td>
                    <td style="text-align: left; padding-top: 5px; padding-right: 3px; padding-left: 30px">
                        <a class="mini-button" iconcls="icon-upload" plain="false"  <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("USERGRP","upload") %>  onclick="startUpload()">上传</a>
                    </td>
                </tr>
            </table>
            <input id="uInf" type="hidden" value='<%= ViewData["USERINF"]%>' />
        </div>
    </fieldset>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
      <script type="text/javascript">

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


          var utype = [{ 'id': '01', 'text': '系统用户' }, { 'id': '02', 'text': '客户用户'}];
          var sstt = [{ 'id': '1', 'text': '正常' }, { 'id': '2', 'text': '未授权' }, { 'id': '0', 'text': '停用'}];
          var uset = [{ 'id': 'M', 'text': '男' }, { 'id': 'F', 'text': '女'}];
          var uissys = [{ 'id': 'F', 'text': '否' }, { 'id': 'T', 'text': '是'}];
          mini.parse();


          function onUserTypRenderer(e) {
              for (var i = 0, l = utype.length; i < l; i++) {
                  var g = utype[i];
                  if (g.id == e.value) return g.text;
                  e.cellStyle = e.record.USERTYP == 02 ? "color:green;" : "color:black;";
              }
              return "";
          }
          function onSttRenderer(e) {
              for (var i = 0, l = sstt.length; i < l; i++) {
                  var g = sstt[i];
                  if (g.id == e.value) return g.text;
                  e.cellStyle = e.record.STT == 2 ? "color:red;" : (e.record.STT == 0 ? "color:blue;" : "color:green;");
              }
              return "";
          } function onSexRenderer(e) {
              for (var i = 0, l = uset.length; i < l; i++) {
                  var g = uset[i];
                  if (g.id == e.value) return g.text;
              }
              return "";
          }

          function onIsSysRenderer(e) {
              for (var i = 0, l = uissys.length; i < l; i++) {
                  var g = uissys[i];
                  if (g.id == e.value) return g.text;
                  e.cellStyle = e.record.ISSYS == 'T' ? "color:red;" : "color:black;";
              }
              return "";
          }


          window.onload = function () { RefreshData(); };

          //加载数据
          function RefreshData() {
              var LOGID = mini.get("LOGID").getValue();
              var USERNAME = mini.get("USERNAME").getValue();
              var STT = mini.get("STT").getValue();
              var SEX = mini.get("SEX").getValue();
            
              mini.get("portalgrid").load({ LOGID: LOGID, USERNAME: USERNAME, STT: STT, SEX: SEX });

          }
          function onKeyEnter(e) {
              RefreshData();
          }

          function updateuserstt() {
              var grid = mini.get("portalgrid");
              var rows = grid.getSelecteds();
              if (rows.length == 1) {
                  var stt = mini.get("cSTT").getValue();
                  grid.loading("操作中，请稍后......");
                  $.ajax({
                      type: 'post',
                      url: '<%=Url.RouteUrl(new { controller="UserGrp",action="SetUSER" ,area="WUCSM"}) %>',
                      data: { "allusers": JSON.stringify(rows), "stt": stt },
                      success: function (res) {
                          grid.reload();
                      },
                      error: function () {
                      }
                  });

              } else if (rows.length == 0) {
                  alert("请选择要激活的用户");
              } else {
                  alert("只能选择一行数据进行用户激活");
              }
          }

          function remove() {
              var grid = mini.get("portalgrid");
              var rows = grid.getSelecteds();
              if (rows.length > 0) {
                  if (confirm("确定删除选中记录？")) {
                      var effectRow = new Object();
                      effectRow["deleted"] = JSON.stringify(rows);

                      grid.loading("操作中，请稍后......");
                      $.ajax({
                          type: 'post',
                          url: '<%=Url.RouteUrl(new { controller="UserGrp",action="DeleteUsers" ,area="WUCSM"}) %>',
                          data: effectRow,
                          success: function (res) {
                              mini.alert("删除成功！");
                              grid.reload();
                          },
                          error: function () {
                          }
                      });
                  }
              } else {
                  alert("请选中一条记录");
              }
          }


          function userno() {
              var grid = mini.get("portalgrid");
              var rows = grid.getSelecteds();
              if (rows.length > 0) {
                  if (confirm("确定停用选中用户？")) {
                      var effectRow = new Object();
                      effectRow["allusers"] = JSON.stringify(rows);

                      grid.loading("操作中，请稍后......");
                      $.ajax({
                          type: 'post',
                          url: '<%=Url.RouteUrl(new { controller="UserGrp",action="USERno" ,area="WUCSM"}) %>',
                          data: effectRow,
                          success: function (res) {
                              mini.alert("停用成功！");
                              grid.reload();
                          },
                          error: function () {
                          }
                      });
                  }
              } else {
                  alert("请选中一条记录");
              }
          }

          function setuser() {
              var grid = mini.get("portalgrid");
              var rows = grid.getSelecteds();
              if (rows.length > 0) {
                  if (confirm("确定激活选中用户？")) {
                      var effectRow = new Object();
                      effectRow["allusers"] = JSON.stringify(rows);
                  
                      grid.loading("操作中，请稍后......");
                      $.ajax({
                          type: 'post',
                          url: '<%=Url.RouteUrl(new { controller="UserGrp",action="SetUSER" ,area="WUCSM"}) %>',
                          data: effectRow,
                          success: function (res) {
                              mini.alert("激活成功！");
                              grid.reload();
                          },
                          error: function () {
                          }
                      });
                  }
              } else {
                  alert("请选中一条记录");
              }
          }

          function setpwd() {
              var grid = mini.get("portalgrid");
              var rows = grid.getSelecteds();
              if (rows.length > 0) {
                  if (confirm("确定重置选中用户密码？")) {
                      var effectRow = new Object();
                      effectRow["allusers"] = JSON.stringify(rows);
                     
                      grid.loading("操作中，请稍后......");
                      $.ajax({
                          type: 'post',
                          url: '<%=Url.RouteUrl(new { controller="UserGrp",action="SetPWD" ,area="WUCSM"}) %>',
                          data: effectRow,
                          success: function (res) {
                              mini.alert("密码重置成功！");
                              grid.reload();
                          },
                          error: function () {
                          }
                      });
                  }
              } else {
                  alert("请选中一条记录");
              }
          }

          function setpwr() {
              var grid = mini.get("portalgrid");
              var row = grid.getSelected();
              if (row) {
                  mini.open({
                      url: '<%=Url.RouteUrl(new { controller="UserGrp",action="UserPwr" ,area="WUCSM"}) %>',
                      title: "用户权限", width: 280, height: 560,
                      onload: function () {
                          var iframe = this.getIFrameEl();
                          var data = { id: row.USERID, usertyp: row.USERTYP, userlogid: row.LOGID, username: row.USERNAME };
                          iframe.contentWindow.initzTreeData(data);
                      },
                      ondestroy: function (action) {
//                          grid.reload();

                      }
                  });

              } else {
                  alert("请选中一条记录");
              }

          }



          function add() {
              var grid = mini.get("portalgrid");
              var newRow = { name: "newrow" };
              grid.addRow(newRow, 0);

              grid.deselectAll();
              grid.select(newRow);
              mini.get("Text1").setEnabled(true);

          }

          function onSelectionChanged(e) {
              var form = new mini.Form("editForm1");
              var grid = e.sender;
              var record = grid.getSelected();
              if (record) {
                  editRow(record._uid);
              } else {
                  form.reset();
              }
          }

          function editRow(row_uid) {
              var grid = mini.get("portalgrid");
              var row = grid.getRowByUID(row_uid);
              if (row) {
                  var form = new mini.Form("editForm1");
                  if (grid.isNewRow(row)) { form.reset(); return; }
                  else {
                      mini.get("Text1").setEnabled(false);
                      form.loading();
                      $.ajax({
                          url: '<%=Url.RouteUrl(new { controller="UserGrp",action="GetUsersbyLogID" ,area="WUCSM"}) %>',
                          data: { LOGID: row.LOGID },
                          success: function (text) {
                              var o = mini.decode(text);
                              form.setData(o);
                              $("#PIC").attr("src", o["PIC"] == null ? "/Attachments/uimage/tx.gif" : o["PIC"]);
                              form.unmask();
                          }
                      });
                  }
                  grid.doLayout();
              }
          }
          function Cancel() {
              var frm = new mini.Form("editForm1");
              $("#PIC").attr("src", "/Attachments/uimage/tx.gif");
              frm.setData("");
          }
          function startUpload() {
              var grid = mini.get("portalgrid");
              var row = grid.getSelected();
              if (row) {
                  if (row.LOGID) {
                      var fileupload = mini.get("fileupload1");
                      fileupload.startUpload();
                  } else {
                      alert("请先填写并保存用户信息");
                  }
              } else {
                  alert("请选中一条记录");
              }


          }
          function onUploadSuccess(e) {
              $("#PIC").attr("src", e.serverData);
          }

          function SaveSvc() {
              var grid = mini.get("portalgrid");
              var row = grid.getSelecteds();
              if (row.length > 0) {
                  var frm = new mini.Form("#editForm1");
                  frm.validate();
                  if (frm.isValid() == false || frm.isChanged() == true) return;
                  var o = frm.getData(true, false);
                  var json = mini.encode(o);
                  $.ajax({
                      url: '<%=Url.RouteUrl(new { controller="UserGrp",action="SaveSvc" ,area="WUCSM"}) %>',
                      data: { data: json },
                      dataType: 'json',
                      async: false,
                      success: function (res) {
                          if (res.msg == "OK") {
                              mini.alert("保存成功!");
                              frm.setChanged(true);
                              $("#uInf")[0].value = json;
                              grid.reload();
                          } else {
                              mini.alert(res.msg);
                          }
                      },
                      error: function (jqXHR, textStatus, errorThrown) {
                          //                        alert(jqXHR.responseText);
                      }
                  });
              } else {
                  alert("请选中一条记录");
              }
          }
        
    </script>
</asp:Content>
