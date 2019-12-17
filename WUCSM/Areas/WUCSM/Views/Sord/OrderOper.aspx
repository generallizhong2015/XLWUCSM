<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/BaseMdl.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	订单处理
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <div id="sordmainpanel" class="mini-panel" title="" style="width: 100%;" bodystyle="min-height:450px;"
        showtoolbar="true" showfooter="true">
        <!--toolbar-->
        <div id="toolbar1" property="toolbar" style="padding: 2px;">
            <div id="autorefresh" name="autorefresh" class="mini-checkbox" checked="true" readonly="false"
                text="自动刷新" onvaluechanged="onafvaluechanged">
            </div>
            <span id="spansp2">间隔-
                <input name="refreshm" id="sp2" style="width: 40px;" class="mini-spinner" value="3"
                    minvalue="1" maxvalue="30" onvaluechanged="onsp2valuechanged" />
                &nbsp;(分钟) </span>&nbsp;&nbsp;&nbsp;&nbsp;<a class="mini-button" onclick="RefreshData"
                    img="<%=Url.Content("~/Scripts/base/imagescss/zoom_16x16.png")%>">搜索</a>&nbsp;&nbsp;
            <div name="highsearch" class="mini-checkbox" checked="false" readonly="false" text="高级搜索"
                onvaluechanged="onhsvaluechanged">
            </div>
            &nbsp;&nbsp;
            <div name="showLogo" class="mini-checkbox" checked="false" readonly="false" text="显示功能区"
                onvaluechanged="onslvaluechanged">
            </div>
            <table border="0" cellpadding="1" cellspacing="2" id="searchform" style="display: none;">
                <tr>
                    <td>
                        &nbsp;单&nbsp;&nbsp;&nbsp;号：<input id="ORDNO" name="ORDNO" class="mini-textbox" style="width: 115px;" />
                    </td>
                    <td>
                        &nbsp;&nbsp; 客户经理：<input id="lookupcus1" name="USERIDS" class="mini-lookup" style="width: 200px;"
                            textfield="USERNAME" multiselect="true" valuefield="USERID" popupwidth="auto"
                            popup="#gridPanel1" grid="#datagridcus1" />
                    </td>
                    <%--<td>
                        &nbsp;&nbsp;服务类型：<input id="combo2" class="mini-combobox" style="width: 125px;" textfield="NODNAME"
                            name="SERTYP" valuefield="NODDTSTT" emptytext="--不限--" shownullitem="true" nullitemtext="--不限--" />
                    </td>--%>
                    <td>
                        &nbsp;&nbsp;受理人：<input id="combo2" class="mini-combobox" style="width: 125px;" textfield="USERNAME"
                            name="SERTYP" valuefield="USERID" emptytext="--不限--" shownullitem="true" nullitemtext="--不限--" />
                    </td>
                    <td>
                        &nbsp;&nbsp;排序：<input id="Text1" class="mini-combobox" style="width: 100px;" textfield="name"
                            name="sortfield" valuefield="id" emptytext="--默认排序--" shownullitem="true" nullitemtext="--默认排序--"
                            data="[{id:'SUBDT-asc',name:'提交时间(升序)'},{id:'SUBDT-desc',name:'提交时间(降序)'}]" />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;客&nbsp;&nbsp;&nbsp;户：<input id="lookupcus2" name="SUBCUS" class="mini-lookup"
                            style="width: 120px;" textfield="CUSNAME" valuefield="CUSID" popupwidth="auto"
                            popup="#gridPanel2" grid="#datagridcus2" />
                    </td>
                    <td>
                        &nbsp;&nbsp; 工单状态：<input id="combo1" class="mini-combobox" name="STT" textfield="NODNAME"
                            valuefield="NODDTSTT" emptytext="--不限--" shownullitem="true" nullitemtext="--不限--"
                            style="width: 200px" />
                    </td>
                    <td colspan="2">
                        &nbsp;&nbsp;提交时间：<input name="SDT" id="SDT" class="mini-datepicker" />
                        &nbsp;到&nbsp;<input name="EDT" id="EDT" class="mini-datepicker" />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;跟踪人：<input id="Tracer" class="mini-combobox" style="width: 125px;" textfield="USERNAME"
                            name="Tracer" valuefield="USERID" emptytext="--不限--" shownullitem="true" nullitemtext="--不限--" />
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;回&nbsp;访&nbsp;人：<input id="Revisit" class="mini-combobox" style="width: 125px;" textfield="USERNAME"
                            name="Revisit" valuefield="USERID" emptytext="--不限--" shownullitem="true" nullitemtext="--不限--" />
                    </td>
                </tr>
            </table>
        </div>
        <!--footer-->
        <div property="footer">
            <div id="pagermain" class="mini-pager" style="width: 100%;" onpagechanged="onPageChanged"
                sizelist="[20,50,100,500]" pagesize="20">
            </div>
        </div>
        <!--body-->
        <table id="tablemain" class="stable" border="0" cellpadding="0" cellspacing="0">
        </table>
    </div>
    <div id="gridPanel1" class="mini-panel" title="header" iconcls="icon-add" style="width: 450px;
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
    <div id="mcol">
        <img style="position:relative;top:10%" id="usrimage" src="" alt="" />
    </div>
    <div id="gridPanel2" class="mini-panel" title="header" iconcls="icon-add" style="width: 450px;
        height: 250px;" showtoolbar="true" showclosebutton="true" showheader="false"
        bodystyle="padding:0" borderstyle="border:0">
        <div property="toolbar" style="padding: 5px; padding-left: 8px; text-align: center;">
            <div style="float: left; padding-bottom: 2px;">
                <span>客户名称：</span>
                <input id="keyText2" class="mini-textbox" style="width: 160px;" onenter="onSearchClick2" />
                <a class="mini-button" onclick="onSearchClick2">查询</a> <a class="mini-button" onclick="onClearClick2">
                    清除</a>
            </div>
            <div style="float: right; padding-bottom: 2px;">
                <a class="mini-button" onclick="onCloseClick2">关闭</a>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div id="datagridcus2" class="mini-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0"
            showpagesize="false" showpageindex="false" url="<%=Url.RouteUrl(new { controller="FastQuery",action="QryCus" ,area="WUCSM"}) %>">
            <div property="columns">
                <div type="indexcolumn">
                </div>
                <div field="CUSID" width="70" allowsort="true">
                    客户编号</div>
                <div field="CUSNAME" width="300" allowsort="true">
                    客户名称</div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        mini.parse();
        mini.get("combo1").load(mini.decode('<%=TempData["STTs"] %>'));
        //        mini.get("combo2").load(mini.decode('<%=TempData["SERTYPs"] %>'));
        mini.get("combo2").load(mini.decode('<%=TempData["USERs"] %>'));
        mini.get("Tracer").load(mini.decode('<%=TempData["USERs"] %>'));
        mini.get("Revisit").load(mini.decode('<%=TempData["USERs"] %>'));
        var strName = "";
        var NewGridInterval;
        window.onload = function () { RefreshData(); NewGridInterval = setInterval("RefreshData()", 3 * 60 * 1000); }
        function onsp2valuechanged() {
            if (mini.get('autorefresh').getValue()) {
                clearInterval(NewGridInterval);
                NewGridInterval = setInterval("RefreshData()", mini.get('sp2').getValue() * 60 * 1000);
            }
        }
        function onhsvaluechanged(e) {
            var checked = this.getChecked();
            if (checked)
                $('#searchform').show();
            else
                $('#searchform').hide();
        }
        function onslvaluechanged(e) {
            var checked = this.getChecked();
            if (checked)
                $('.basehead').css("display", "block");
            else
                $('.basehead').css("display", "none");
        }

        function onafvaluechanged(e) {
            var checked = this.getChecked();
            if (checked) {
                NewGridInterval = setInterval("RefreshData()", mini.get('sp2').getValue() * 60 * 1000);
                $('#spansp2').show();
            }
            else {
                clearInterval(NewGridInterval);
                $('#spansp2').hide();
            }
        }
        function UpdateSord(ordno, ISSYS) {
            mini.open({
                url: '<%=Url.RouteUrl(new { controller="Sord",action="UpdateSordInfo" ,area="WUCSM"})+"?isSys=' + ISSYS + '&ordno="%>' + ordno,
                title: "编辑信息", width: 620, height: 330,
                ondestroy: function (action) {
                    if (action == 'ok') RefreshData();
                }
            });
        }
        function DeleteSord(ordno) {
            mini.showMessageBox({
                showHeader: false,
                width: 250,
                title: '是否删除派工单[' + ordno + ']？',
                buttons: ["ok", "cancel"],
                message: '是否删除派工单[' + ordno + ']？',
                iconCls: 'mini-messagebox-question',
                callback: function (action) {
                    if (action != 'ok') return;
                    RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="DeleteSord" ,area="WUCSM"}) %>', '数据删除中', { ordno: ordno }, function () {
                        mini.showMessageBox({
                            title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                            message: '删除成功！', callback: function (action) {
                                RefreshData();
                            }
                        });
                    });
                }
            });
        }
        function EditSordStt(ordno) {
            mini.showMessageBox({
                showHeader: false,
                width: 250,
                title: '确认作废派工单[' + ordno + ']？',
                buttons: ["ok", "cancel"],
                message: '确认作废派工单[' + ordno + ']？',
                iconCls: 'mini-messagebox-question',
                callback: function (action) {
                    if (action != 'ok') return;
                    RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="EditSordStt" ,area="WUCSM"}) %>', '处理中', { ordno: ordno }, function () {
                        mini.showMessageBox({
                            title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                            message: '操作成功！', callback: function (action) {
                                RefreshData();
                            }
                        });
                    });
                }
            });
        }

        function MoveNextStt(ordno, nextstt, nextsttname) {
            var str = "<div style=\"text-align: left;margin-left:20px;\">";
            str += "故障概述：<input id=\"Fault\" style=\"width:130px;\" name=\"Fault\" value=\"\" />";
            str += "<ul class=\"listFault\">";
            str += "<li><span class=\"menu\">+</span>西联软件程序问题";
            str += "           <ul class=\"faults\">";
            str += "            <li>程序编码错误</li>";
            str += "            <li>程序设计缺陷</li>";
            str += "            <li>程序完整性不够</li>";
            str += "            <li>系统不稳定</li>";
            str += "            <li>系统报表数据不一致</li>";
            str += "            <li>数据通讯错误</li>";
            str += "            <li>安装版本错误</li>";
            str += "        </ul>";
            str += "    </li>";
            str += "    <li><span class=\"menu\">+</span>西联服务问题";
            str += "        <ul class=\"faults\">";
            str += "            <li>服务失误</li>";
            str += "            <li>服务不完整造成连带错误</li>";
            str += "       </ul>";
            str += "   </li>";
            str += "   <li><span class=\"menu\">+</span>用户问题";
            str += "       <ul class=\"faults\">";
            str += "         <li>设备损坏（硬件、软件、病毒）</li>";
            str += "         <li>新增需求（含截帐）</li>";
            str += "         <li>因工程培训不到位造成客户使用错误</li>";
            str += "         <li>因客户自身能力造成客户使用错误</li>";
            str += "        <li>客户数据安全性管理问题</li>";
            str += "    </ul>";
            str += " </li>";
            str += "<li><span class=\"menu\">+</span>(MIS+)";
            str += "      <ul class=\"faults\">";
            str += "        <li>开发</li>";
            str += "        <li>BUG</li>";
            str += "        <li>客户使用问题</li>";
            str += "      </ul>";
            str += "</li>";
            str += "</ul>";
            str += "</div>";


            //<p>障碍描述：' + objs + '</p>
            mini.showMessageBox({
                showHeader: false,
                width: 350,
                height: 415,
                title: '是否跳转至状态[<span style="color:Green;">' + nextsttname + '</span>]？',
                buttons: ["ok", "cancel"],
                message: '是否跳转至状态[<span style="color:Green;">' + nextsttname + '</span>]？<p>' + str + '</p>',
                iconCls: 'mini-messagebox-question',
                callback: function (action) {
                    var fault = $("#Fault").val();
                    if (action == 'ok') {
                        if (fault != "") {
                            RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="MoveNextStt" ,area="WUCSM"}) %>', '跳转中', { ordno: ordno, stt: nextstt, fault: fault }, function () {
                                mini.showMessageBox({
                                    title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                                    message: '跳转成功！', callback: function (action) {
                                        RefreshData();
                                    }
                                });

                            });
                        }
                        else {

                            mini.alert("请选择概况描述！");
                        }
                    }

                }
            });
            //障碍概述
            $("#Fault").click(function () {
                $("table .listFault").toggleClass("show");
            });
            $(".menu").click(function () {
                var thisObj = $(this);
                add(thisObj);


            });
            function add(obj) {
                var thisVal = obj.text();
                if (thisVal == "+") {
                    $(obj).text("-");
                    $(obj).parent().find(".faults").css("display", "block");
                }
                else if (thisVal == "-") {
                    $(obj).text("+");
                    $(obj).parent().find(".faults").css("display", "none");
                }
            }

            $(".faults li").click(function () {
                var thisObj = $(this).text();
                $("#Fault").val(thisObj);
                //mini.alert($("#Fault").val());

            });
            //end
        }




        function replysd(ordno) {
            mini.open({
                title: '派工单[' + ordno + '] - 留言/回复',
                url: '<%=Url.RouteUrl(new { controller="Sord",action="SordReply" ,area="WUCSM"})+"?type=1&ordno="%>' + ordno,
                width: 700, height: 500,
                ondestroy: function (action) {
                    if (action == 'ok')
                        RefreshData();
                }
            }).showAtPos('center', 'middle');
        }
        //跟踪
        function TracerSord(ordno, TracerStt, name) {
            $.ajax({
                url: "/Sord/TracerSord",
                type: "post",
                data: { t: new Date(), ordno: ordno, TracerStt: TracerStt, Name: name },
                dataType: "json",
                success: function (action) {
                    console.log(action);
                    if (action.msg == 'OK') {
                        RefreshData();
                    } else {
                        mini.alert(action.msg)
                    }
                },
                error: function () {
                    mimi.alert("系统异常!")
                }
            });
        }
        //h回访
        function RevisitSord(ordno, RevisitStt) {
            mini.showMessageBox({
                showHeader: false,
                width: 350,
                //                height: 215,
                title: '回访内容',
                buttons: ["ok", "cancel"],
                message: '回访内容:<textarea style="margin-top:10px;height:50px;width:200px;resize:none;position:relative;top:15px;overflow:hidden; resize:none;" id="Fault"></textarea>',
                iconCls: 'mini-messagebox-question',
                callback: function (action) {
                    var fault = $("#Fault").val();
                    if (action == 'ok') {
                        if (fault != "") {
                            RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="RevisitSord" ,area="WUCSM"}) %>', '跳转中', { ordno: ordno, RevisitStt: RevisitStt, Fault: fault }, function () {
                                mini.showMessageBox({
                                    title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                                    message: '跳转成功！', callback: function (action) {
                                        RefreshData();
                                    }
                                });

                            });
                        }
                        else {

                            mini.alert("请输入内容！");
                        }
                    }
                }
            });
        }
        function startsord(ordno) {
            mini.open({
                url: '<%=Url.RouteUrl(new { controller="Sord",action="StartSordInfo" ,area="WUCSM"}) %>?ordno=' + ordno,
                title: '派工单[' + ordno + '] - 受理', width: 600, height: 350,
                ondestroy: function (action) {
                    if (action == 'ok') RefreshData();
                }
            });
        }
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

        var datagridcus2 = mini.get("datagridcus2");
        var keyText2 = mini.get("keyText2");
        function onSearchClick2(e) {
            datagridcus2.load({
                key: keyText2.value
            });
        }
        function onCloseClick2(e) {
            var lookupcus2 = mini.get("lookupcus2");
            lookupcus2.hidePopup();
        }
        function onClearClick2(e) {
            var lookupcus2 = mini.get("lookupcus2");
            lookupcus2.deselectAll();
        }


        function onPageChanged(e) {
            pagermain.pageIndex = e.pageIndex;
            pagermain.pageSize = e.pageSize;
            RefreshData();
        }
        var pagermain = mini.get('pagermain')
        function RefreshData() {
            //刷新自动允许JS垃圾回收
            if ($.browser.msie && ($.browser.version == "7.0") || ($.browser.version == "8.0") || ($.browser.version == "9.0") || ($.browser.version == "10.0")) {
                setTimeout(CollectGarbage);
            }
            var data = new mini.Form("#toolbar1").getData(true);
            if (data.sortfield && data.sortfield != '') {
                data.sortorder = data.sortfield.split('-')[1];
                data.sortfield = data.sortfield.split('-')[0];
            }
            else {
                data.sortorder = 'desc';
                data.sortfield = 'SUBDT';
            }
            data.pageIndex = pagermain.pageIndex;
            data.pageSize = pagermain.pageSize;
            RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="GetSord" ,area="WUCSM"}) %>', '获取数据中', data, function (res) {
                $(' > tbody', tablemain).remove();
                $(res.data).each(function (i, item) {
                    var ahtml = '<tbody>';
                    ahtml = ahtml + HandleHtml(item);
                    ahtml = ahtml + '</tbody>';
                    $(tablemain).append(ahtml);
                    prettyPrint();
                    mini.parse();
                });
                pagermain.update(pagermain.pageIndex, pagermain.pageSize, res.total)
            }, function () {
                mini.get('autorefresh').setValue(false);
                clearInterval(NewGridInterval);
                $('#spansp2').hide();
            });
        }
        //  获取客户经理名称
        function GetName(usrId) {
            $.ajax({
                url: "/Sord/GetName",
                type: "post",
                data: { t: new Date(), UserID: usrId },
                dataType: "text",
                async: false,
                success: function (action) {

                    strName = action
                    console.log(strName);
                },
                error: function () {
                    mimi.alert("系统异常!")
                }
            });
        }
        function openimg(object) {
            var imgurl = $(object).attr("src");
            $("#usrimage").show();
            getimgWh(imgurl, function (w, h) {
                $("#usrimage").attr("src", imgurl);

                $("#mcol").addClass("usrimg");
                $("#usrimage").click(function () {
                    $(this).hide();
                    $("#mcol").removeClass("usrimg");
                })
                //console.log({ width: w, height: h });
                //返回图片实际大小

            });

        }

        function getimgWh(url, callback) {
            //通过数据流获取图片实际大小
            var img = new Image();
            img.src = url;
            if (img.complete) {
                callback(img.width, img.height);
                //判断是否已经缓存
            } else {
                img.onload = function () {
                    callback(img.height, img.width);
                }
            }
        }

        function HandleHtml(item) {
            var wcbaseurl = '';
            var ahtml = '';
            ahtml = ahtml + '<tr class="scontent">';
            ahtml = ahtml + '<td class="sprcman">'
            ahtml = ahtml + '单号:<a title="' + item.ORDNO + '" href="<%=Url.RouteUrl(new { controller="Sord",action="SordInfo" ,area="WUCSM"}) %>?ordno=' + item.ORDNO + '" target="_blank">' + item.ORDNO + '</a><br />';
            ahtml = ahtml + '<span style="width: 40px; height: 40px;">';
            if (item.TracerStt == 1) {
                GetName(item.Tracer);
                ahtml = ahtml + '跟踪人:<a title="' + item.ORDNO + '" style="color:#000" target="_blank">' + strName + '</a><br />';
            }
            if (item.PRCMAN && item.PRCMAN != '') {
                ahtml = ahtml + '<img class="userMiniPhoto" align="center" style="width: 40px; height: 40px;" alt="" src="' + wcbaseurl + (!item.PRCMANPIC || item.PRCMANPIC == '' ? '/Images/user.png' : item.PRCMANPIC) + '">';
                ahtml = ahtml + '&nbsp;' + item.PRCMANNAME + "</span>";
            }
            else {
                ahtml = ahtml + '暂无人受理';
            }
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="smian">';
            ahtml = ahtml + '<div class="mini-panel" title="" style="width:100%;" showtoolbar="false" showfooter="false" showCollapseButton="false">';
            ahtml = ahtml + '<table border="0" cellSpacing="0" cellPadding="0">';
            ahtml = ahtml + '<tbody><tr>';

            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '客户名称:';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td style=" width:140px; color:red">';
            ahtml = ahtml + item.SUBCUSNAME.toString();
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="cmlable" style="width:50px;">';
            ahtml = ahtml + '提交人:';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td style=" width:50px;">';
            ahtml = ahtml + item.SUBMANNAME.toString().substr(0, 4);
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="cmlable" style="width:30px;">';
            ahtml = ahtml + ' 电话:';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td  style="width:90px;">';
            ahtml = ahtml + item.SUBMANMOVTEL;
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="cmlable" style="width:25px;">';
            ahtml = ahtml + '  ';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td style="width:80px;">';
            //            ahtml = ahtml + item.IPADR;
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="cmlable" style="width:80px;">';
            ahtml = ahtml + '提交时间:';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td style="width:140px;" title="' + item.SUBDT + '">';
            ahtml = ahtml + item.SUBDT;
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="cmlable" style="width:40px;">';
            ahtml = ahtml + '预计:';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td  style="width:55px;">';
            ahtml = ahtml + '<span class="cmdate">' + item.ECTIME + '</span>&nbsp;(小时)';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';

            ahtml = ahtml + '<tr>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '远程类型:';
            ahtml = ahtml + '</td>';
            if (item.SERSYS != undefined) {
                ahtml = ahtml + '<td style=" width:140px; color:red">';
                var serTyp = item.SERSYS;
                switch (item.SERSYS) {
                    case "T":
                        serTyp = "TeamView"
                        break;
                    case "P":
                        serTyp = "Pcanywhere";
                        break;
                    case "X":
                        serTyp = "XT800";
                        break;
                    default:

                }
                ahtml = ahtml + serTyp;
                ahtml = ahtml + '</td>';
            }
            ahtml = ahtml + '<td class="cmlable" style="width:50px;">';
            ahtml = ahtml + '账 号:';
            ahtml = ahtml + '</td>';
            if (item.USRNUM != undefined) {
                ahtml = ahtml + '<td style=" width:140px; color:red">';
                ahtml = ahtml + item.USRNUM;
                ahtml = ahtml + '</td>';

            }
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="cmlable" style="width:50px;">';
            ahtml = ahtml + '密码:';
            ahtml = ahtml + '</td>';
            if (item.USRPASS != undefined) {
                ahtml = ahtml + '<td style=" width:140px; color:red">';
                ahtml = ahtml + item.USRPASS;
                ahtml = ahtml + '</td>';
            }
            ahtml = ahtml + '</tr>';

            ahtml = ahtml + '<tr>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '服务正文:';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td colspan="7" style="width:585px">';
            ahtml = ahtml + item.SUBTXT.replace('\n', '<br/>');
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td colspan="2" style="text-align:right;">';
            ahtml = ahtml + '<div>';
            if (item.STT != '-1')
                ahtml = ahtml + '<a class="mini-button" title="点击作废" style="color:red" onclick="EditSordStt(' + item.ORDNO + ');">作废</a> ';
            if (item.STT != '0' && item.STT != '50' && item.STT != '90')
                ahtml = ahtml + '<a class="mini-button" onclick="MoveNextStt(' + item.ORDNO + ',' + item.NEXTSTT + ',\'' + item.NEXTSTTNAME + '\');">[<span style="color:Green;">' + item.NEXTSTTNAME + '</span>]</a>';
            
            ahtml = ahtml + '</div></div>';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td colspan="2" class="sheadstt sstt' + item.STT + '">';
            ahtml = ahtml + item.STTNAME;
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';

            ahtml = ahtml + '<tr>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '图片详情:';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td>';
            if (item.USRIMG == null || item.USRIMG == undefined || item.USRIMG == "") {
            } else {
                ahtml = ahtml + '<img id="usrImg" name="usrImg" style="width: 100px; height: 10px;cursor:pointer;" onclick="openimg(this)" alt="" src="' + item.USRIMG + '">';
            }
            //ahtml = ahtml + '<img src="../../../../Attachments/uimage/20150212.png" />';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';

            ahtml = ahtml + '</tbody></table>';
            ahtml = ahtml + '</div>';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';
            return ahtml;
        }
    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .mini-button-iconTop .mini-button-icon
        {
            padding-top: 30px;
        }
        .mini-panel-border.mini-grid-border
        {
            border: none;
        }
        .mytable
        {
            width: 100%;
            white-space: normal;
            word-break: normal;
        }
        .cmlable
        {
            width: 70px;
            color: #4537fa;
            padding-left: 1px;
        }
        .mini-panel-header
        {
            visibility: hidden;
            height: 0px;
        }
        .sprcman
        {
            padding-top: 5px;
            padding-left: 10px;
            width: 100px;
        }
        .smian
        {
            width: auto;
        } 
        .cmtlable
        {
            width: 45px;
            color: #4537fa;
            font-weight: 200;
            text-align: right;
        }
        .sheadstt
        {
            width: 75px;
            font-size: 13px;
            text-align: right;
            margin: 0 auto;
        }
        /*状态*/
        .sstt0
        {
            color: Red;
        }
        .sstt20
        {
            color: Green;
        }
        .sstt30
        {
            color: Green;
        }
        .sstt40
        {
            color: Green;
        }
        .sstt50
        {
            color: Black;
        }
        .sstt90
        {
            color: Black;
        }
        .basehead
        {
            display: none;
        }
        .usrimg
        {
            position: fixed; top: 0px; 
            left: 0px; width: 100%; height: 100%;
            background: #747474; filter: alpha(opacity=30); -moz-opacity: 0.9; opacity: 0.9; z-index: 10000;     
            text-align:center;
            /*position:relative;*/
            /*top:-50%;*/
        }
        .imghie
        {
            display:none;
        }
        .listFault
        {
            list-style:none;margin:0px;padding:0px;
            display:none;
        }
        .menu
        {
            font-size:17px;
            padding:0px 2px 0px 0px;
            cursor:pointer;
        }
        .faults
        {
            list-style:none;
            display:none;
        }
         .show
        {
            display:block;
        }
    </style>
</asp:Content>
