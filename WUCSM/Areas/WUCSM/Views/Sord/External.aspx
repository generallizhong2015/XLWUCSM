<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/BaseMdl.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    服务工单
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <input id="SMG" type="hidden" value='<%= TempData["TIPs"]%>' />
    <input id="isUser" type="hidden" name="isUser" value="<%= TempData["IsUse"]%>" />
    <input type="hidden" id="isMis" name="isMis" value="<%= TempData["IsMis"] %>" />
    
    <%--</div>--%>
    <div id="toolbar-main" class="mini-toolbar" style="margin: 0px 0px 5px 0px; background-color: #edf6fd;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 100%;">
                    <div id="scrollDiv" class="scrollDiv">
                        <ul>
                     <%--  <% 
                            var NTCPUBS = TempData["NTCPUBs"] as IList<Models.NTCPUB>;                            
                        %>                      
                            
                        <li>
                        <a href="<%=Url.RouteUrl(new { controller="NtcPubView",action="Index" ,area="WUCSM"}) %>"><%=NTCPUBS[0].NTCTXT%>
                        <%= WUCSM.Helpers.DateTimeConvert.DateToString(NTCPUBS[0].MKDTT) %></a>
                            
                        </li>

                        <li>
                            <a href="http://pan.baidu.com/s/1i3YOtCh"><%=NTCPUBS[1].NTCTXT%>
                            <%= WUCSM.Helpers.DateTimeConvert.DateToString(NTCPUBS[1].MKDTT) %></a>
                        </li>--%>
                            <%
                                foreach (var NTCPUB in TempData["NTCPUBs"] as IList<Models.NTCPUB>)
                                {
                            %>
                            <li bllid="<%=NTCPUB.NTCPUBNO %>" title="<%=NTCPUB.NTCTXT %>    <%= WUCSM.Helpers.DateTimeConvert.DateToString(NTCPUB.MKDTT) %>">
                                
                                <%--<a href="http://pan.baidu.com/s/1i3YOtCh">content</a>--%>
                                <% if (NTCPUB.NTCPUBNO == "1701100009")
                                   { %>
                                <a href="<%=Url.RouteUrl( new { controller="Happy",action="NewsYeas" ,area="WUCSM"}) %>" target="_blank">
                                    <%=NTCPUB.NTCTXT%>
                                    &nbsp;&nbsp;&nbsp;&nbsp; <%= WUCSM.Helpers.DateTimeConvert.DateToString(NTCPUB.MKDTT)%>
                                </a>
                                <%}
                                   else if (NTCPUB.NTCPUBNO == "1610280014")
                                   { %>
                                    <a href="<%=Url.RouteUrl( new { controller="NtcPubView",action="Index" ,area="WUCSM"}) %>" target="_blank">
                                    <%=NTCPUB.NTCTXT%>
                                    &nbsp;&nbsp;&nbsp;&nbsp;<%= WUCSM.Helpers.DateTimeConvert.DateToString(NTCPUB.MKDTT)%>
                                    </a>
                                   <%} %>
                                   <% 
                                       else if (NTCPUB.NTCPUBNO == "1609220007")
                                       { %>
                                    <a href="<%=Url.RouteUrl( new { controller="NtcPubView",action="Index" ,area="WUCSM"}) %>" target="_blank">
                                    <%=NTCPUB.NTCTXT%>
                                    &nbsp;&nbsp;&nbsp;&nbsp;<%= WUCSM.Helpers.DateTimeConvert.DateToString(NTCPUB.MKDTT)%>
                                    </a>
                                    <%}%>
                                    <%
                                       else { %>
                                       <!--<a href="../../../../Images/关于2018春节期间确保商场系统运行稳定的通知.pdf" >-->
                                       <a href="<%=Url.RouteUrl( new { controller="NtcPubView",action="Index" ,area="WUCSM"}) %>" >
                                            <%=NTCPUB.NTCTXT%>
                                            &nbsp;&nbsp;&nbsp;&nbsp; <%= WUCSM.Helpers.DateTimeConvert.DateToString(NTCPUB.MKDTT)%>
                                        </a>
                                        <%--<a href="<%=Url.RouteUrl( new { controller="NtcPubView",action="Index" ,area="WUCSM"}) %>" target="_blank">
                                            <%=NTCPUB.NTCTXT%>
                                            &nbsp;&nbsp;&nbsp;&nbsp; <%= WUCSM.Helpers.DateTimeConvert.DateToString(NTCPUB.MKDTT)%>
                                        </a>--%>
                                       <%}
                                     %>
                                </li>
                            <%
                                }
                            %>
                          

                        </ul>
                    </div>
                </td>
                <td style="white-space: nowrap;">
                    <%--<a id="newsords" class="mini-button mini-button-iconTop" img="<%=Url.Content("~/Scripts/base/imagescss/additem_32x32.png")%>"
                        plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("SORDEL","insert") %>
                        onclick="NewSord">申请派工</a>--%>
                </td>
            </tr>
        </table>
    </div>
    <div class="mini-panel" title="我的派工单" style="width: 100%;" bodystyle="min-height:200px;"
        showtoolbar="true" showfooter="true">
        <!--toolbar-->
        <div id="toolbar1" property="toolbar" style="padding: 5px;">
            筛选：<input id="subdt" required="true" style="width: 90px;" class="mini-textboxlist"
                name="subdt" value="default" text="全部时间" />
            <input id="sordstt" required="true" style="width: 90px;" class="mini-textboxlist"
                name="sordstt" value="default" text="全部状态" />
            <input id="sertyp" required="true" style="width: 90px;" class="mini-textboxlist"
                name="sertyp" value="default" text="全部类型" />
            排序：<input id="sortfield" required="true" style="width: 100px;" class="mini-textboxlist"
                name="sortfield" value="SUBDT-desc" text="默认排序" />
            <div>
                <a href="" onclick="openEile" class="mini-button mini-button-iconTop" plain="true" style="float:right;">投诉</a>
                <a id="newsords" style="float: right;" class="mini-button mini-button-iconTop" img="<%=Url.Content("~/Scripts/base/imagescss/additem_32x32.png")%>"
                        plain="true" <%=new WUCSM.Helpers.HtmlPwrFilter().Handle("SORDEL","insert") %>
                        onclick="">申请派工</a>
                        
            </div>
            <br />
            <div id="autorefresh" name="autorefresh" class="mini-checkbox" checked="true" readonly="false"
                text="自动刷新" onvaluechanged="onafvaluechanged">
            </div>
            <span id="spansp2">间隔-
                <input name="refreshm" id="sp2" style="width: 40px;" class="mini-spinner" value="3"
                    minvalue="1" maxvalue="30" onvaluechanged="onsp2valuechanged" />
                &nbsp;(分钟) </span>

                
        
        </div>


        <!--footer-->
        <div property="footer">
            <div id="pagermain" class="mini-pager" style="width: 100%;" onpagechanged="onPageChanged"
                sizelist="[5,10,20,50,100,500]" pagesize="5">
            </div>
        </div>
        <!--body-->
        <table id="tablemain" class="stable" border="0" cellpadding="0" cellspacing="0">
        </table>
    </div>
    <div id="subdt-content" style="display: none;">
        <div class="mymenucontent">
            <a href="javascript:void(0);" onclick="onSelectedChanged('default','全部时间','subdt');">
                全部时间</a><br />
            <a href="javascript:void(0);" onclick="onSelectedChanged('1','一天','subdt');">一天</a><br />
            <a href="javascript:void(0);" onclick="onSelectedChanged('2','两天','subdt');">两天</a><br />
            <a href="javascript:void(0);" onclick="onSelectedChanged('7','一周','subdt');">一周</a><br />
            <a href="javascript:void(0);" onclick="onSelectedChanged('30','一个月','subdt');">一个月</a><br />
            <a href="javascript:void(0);" onclick="onSelectedChanged('90','三个月','subdt');">三个月</a>
        </div>
    </div>
    <div id="sortfield-content" style="display: none;">
        <div class="mymenucontent">
            <a href="javascript:void(0);" onclick="onSelectedChanged('SUBDT-desc','默认排序','sortfield');">
                默认排序</a><br />
            <a href="javascript:void(0);" onclick="onSelectedChanged('SUBDT-asc','提交时间(升序)','sortfield');">
                提交时间(升序)</a><br />
            <a href="javascript:void(0);" onclick="onSelectedChanged('SUBDT-desc','提交时间(降序)','sortfield');">
                提交时间(降序)</a><br />
        </div>
    </div>
    <div id="mcol">
        <img style="position:relative;top:30%" id="usrimage" src="" alt="" />
    </div>
    <div id="sordstt-content" style="display: none;">
        <div class="mymenucontent">
            <a href="javascript:void(0);" onclick="onSelectedChanged('default','全部状态','sordstt');">
                全部状态</a><br />
            <%
                foreach (Models.STTCFG STTCFG in TempData["STTs"] as IList<Models.STTCFG>)
                {
            %>
            <a href="javascript:void(0);" onclick="onSelectedChanged('<%=STTCFG.NODDTSTT %>','<%=STTCFG.NODNAME %>','sordstt');">
                <%=STTCFG.NODNAME %></a><br />
            <%
                } 
            %>
        </div>
    </div>
    <div id="sertyp-content" style="display: none;">
        <div class="mymenucontent">
            <a href="javascript:void(0);" onclick="onSelectedChanged('default','全部类型','sertyp');">
                全部类型</a><br />
            <%
                foreach (Models.STTCFG STTCFG in TempData["SERTYPs"] as IList<Models.STTCFG>)
                {
            %>
            <a href="javascript:void(0);" onclick="onSelectedChanged('<%=STTCFG.NODDTSTT %>','<%=STTCFG.NODNAME %>','sertyp');">
                <%=STTCFG.NODNAME %></a><br />
            <%
                } 
            %>
        </div>
    </div><a  target="_blank" id="clicMis" onclick="msgImg()"></a>

    <div id="disBox" class="mini-panel-border" style=" width:100px;height:200px; margin-top:0px;   position: absolute;
    top: 0;
    left: 1%;
    width: 15%;
    border: 1px solid #ccc;
    z-index:!important 88888888888px;
    <%--padding: 10px;--%>
    ">
    <div class="mini-panel-header-inner" style="border-bottom:1px solid #ccc"><span class="mini-panel-icon " style="display: none;"></span><div class="mini-panel-title">温馨提醒</div><div id="mini-tools" class="mini-tools"><span id="Span1" class="mini-tools-collapse " style=";display:none;"></span><span id="Span2" class="mini-tools-min " style=";display:none;"></span><span id="Span3" class="mini-tools-max " style=";display:none;"></span><span id="Span4" class="mini-tools-close " style=";"></span></div></div>
        <div id="content" style="padding:15px;cursor:pointer" >
        <% 
            var num = 1;
        foreach (var NTCPUB in TempData["NTCPUBs"] as IList<Models.NTCPUB>)
        {
        %>
            <% if (NTCPUB != null)
               {%>
               <%--<input type="hidden" name="hidPfd" id="hidPfd" value="<%= WUCSM.Helpers.DateTimeConvert.DateToString(NTCPUB.MKDTT)%>" />--%>
               <div title="<%=NTCPUB.NTCTXT%>"  <%= WUCSM.Helpers.DateTimeConvert.DateToString(NTCPUB.MKDTT) %>">
               
                     <lable style="font-size:15px"><%=num++%>.</lable>  
                     <%--<a href="../../../../Images/关于2018春节期间确保商场系统运行稳定的通知.pdf"><%=NTCPUB.NTCTXT = NTCPUB.NTCTXT.Length > 30 ? NTCPUB.NTCTXT.Substring(0, 30) + "......" : NTCPUB.NTCTXT%>
                     </a>--%>
                     <!--<a href="../../../../Images/关于2018春节期间确保商场系统运行稳定的通知.pdf">-->
                     <a href="<%=Url.RouteUrl( new { controller="NtcPubView",action="Index" ,area="WUCSM"}) %>" >
                     <%=NTCPUB.NTCTXT%>
                     </a>
                </div>
            <% }%>
        <%
         }
        %>
        </div>
    </div>
 <script type="text/javascript">
     var xleft = 0;
     var ytop = 0;
     var movex = 1;
     var movey = 1;
     var isRun = true;
     function move() {

         if (isRun) {
             xleft += movex;
             ytop += movey;
             //         var xgg = $("#disBox");
             var xgg = document.getElementById("disBox");
             //         xgg.style.top = ytop;
             //         xgg.style.left = xleft;
             $("#disBox").css("top", ytop);
             if (xleft + xgg.offsetWidth >= document.body.clientWidth || xleft <= 0) {
                 movex = -movex;
             }
             //注意 document.body.clientHeight 兼容问题
             if (ytop + xgg.offsetHeight >= document.body.clientHeight || ytop <= 0) {
                 movey = -movey;
             }
         }
        

     }
     setInterval(move, 20);
     if ($("#content a").html() > 60) { 
        $("#content").css("text-overflow","ellipsis");
     }
     //鼠标移入事件
     $("#content").mouseover(function () {
         isRun = false;
     });
     $("#mini-tools").mouseover(function () {
         isRun = false;
     });
     //鼠标移除事件
     $("#content").mouseout(function () {
         isRun = true;
     })
     $("#mini-tools").mouseout(function () {
         isRun = true;
     })
     //关闭按钮事件
     $("#mini-tools").click(function () {
         $("#disBox").css("display", "none");
     })
     //内容为空则隐藏
     if ($("#content").html().replace(/(^\s+)|(\s+$)/g, "") == "") {
         $("#disBox").css("display", "none");
     }
 </script>


    <%--<div id="clicMis" onclick="msgImg()">
    </div>--%>
    <script type="text/javascript">

        mini.parse();
        var isMis = $("#isMis").val();
//        if (isMis == "10") {
//            $("#clicMis").click();
//                }
         msgImgs();


         function msgImgs() {
            
//            window.open("../../../../Images/02数据安全管理须知180516.pdf")
            //$("#aa").click();
             //window.open("/Happy/NewsYeas");

            mini.open({
                url: '<%=Url.RouteUrl(new { controller="Happy",action="NewsYeas" ,area="WUCSM"}) %>',
                url: '#disBox',
                title: '温馨提示', width: 170, height: 160,
                ondestroy: function (action) {
                    if (action == 'ok') RefreshData();
                }
            });

        }
     

        function openEile() {

            mini.showMessageBox({
                title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                message: "如果您对服务不满意或者有更好的建议，可以随时联系028-62997255，或发送至邮箱E-mail:lyh@wumis.com！", callback: function (action) {

                    window.open("https://mail.qq.com/cgi-bin/loginpage");
                }
            })


        }

        //        $("#scrollDiv ul li").each(function (i, a) {
        //            console.log(i);
        //            if ($(a).attr("bllid") == "1511030001") {
        //                //$(this).find("a").href("/NtcpubView/Index")
        //                $(this).click(function () {

        //                    window.open("/Happy/NewsYeas");
        //                });
        //            } else if ($(a).attr("bllid") == "1610280014") {
        //                $(this).click(function () {
        //                    window.open("/NtcPubView/Index");

        //                })

        //            }
        //            else if ($(a).attr("bllid") == "1609220007") {
        //                $(this).click(function () {
        //                    window.open("/NtcPubView/Index");
        //                })
        //                
        //            }

        //        })




        var NewGridInterval;
        function onsp2valuechanged() {
            if (mini.get('autorefresh').getValue()) {
                clearInterval(NewGridInterval);
                NewGridInterval = setInterval("RefreshData()", mini.get('sp2').getValue() * 60 * 1000);
            }
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
            var data = new mini.Form("#toolbar1").getData();
            if (data.sortfield != 'default') {
                data.sortorder = data.sortfield.split('-')[1];
                data.sortfield = data.sortfield.split('-')[0];
            }
            else {
                data.sortorder = 'desc';
                data.sortfield = 'SUBDT';
            }
            data.pageIndex = pagermain.pageIndex;
            data.pageSize = pagermain.pageSize;
            RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="GetMySord" ,area="WUCSM"}) %>', '获取数据中', data, function (res) {
                $(' > tbody', tablemain).remove();

                $(res.data).each(function (i, item) {
                    //                    mini.alert(item.USRIMG);
                    var ahtml = '<tbody>';
                    ahtml = ahtml + HandleHtml(item);
                    ahtml = ahtml + '</tbody>';
                    $(tablemain).append(ahtml);
                    $(item.SORDREVIEWs).each(function (SORDREVIEW_I, SORDREVIEW) {
                        $('#star' + SORDREVIEW.APPRID).raty({
                            hintList: ['很不满意', '不满意', '满意', '很满意', '非常满意'],
                            readOnly: true,
                            start: parseInt('' + SORDREVIEW.DGR),
                            path: '<%=Url.Content("~/Images")%>',
                            starOn: 'star-on.png',
                            starOff: 'star-off.png'
                        });
                    });
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

        //        var isopen = false;
        //        var w = 200;
        //        var h = 200;
        //        $(document).on("click", "#usrImg", function () {
        //            if (!isopen) {
        //                isopen = true;
        //                $(this).width(100);
        //                $(this).height(10);
        //            }
        //            else {
        //                isopen = false;
        //                $(this).width("100%");
        //                $(this).height("100%");
        //            }

        //        });
        function HandleHtml(item) {
            var wcbaseurl = '';
            var ahtml = '';
            ahtml = ahtml + '<tr class="shead">';
            ahtml = ahtml + '<td class="sicon">';
            ahtml = ahtml + '<img src="' + wcbaseurl + '/Scripts/base/imagescss/' + (item.ISTODAY ? 'newtask' : 'task') + '_32x32.png" width="28" height="28" />';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="sordno">';
            ahtml = ahtml + '单号：<a title="' + item.ORDNO + '" href="<%=Url.RouteUrl(new { controller="Sord",action="SordInfo" ,area="WUCSM"}) %>?ordno=' + item.ORDNO + '" target="_blank">' + item.ORDNO + '</a>';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="stitle" colSpan="2">';
            ahtml = ahtml + '<table border="0" cellSpacing="0" cellPadding="0" style="width:100%;">';
            ahtml = ahtml + '<tbody>';
            ahtml = ahtml + '<tr>';
            ahtml = ahtml + '<td><div class="process">';
            $(item.SORDPROCESs).each(function (SORDPROCES_I, SORDPROCES) {
                if (SORDPROCES_I != 0)
                    ahtml = ahtml + '<div class="proce ' + (SORDPROCES.ISHANDLE ? '' : 'wait') + '"></div>';
                ahtml = ahtml + '<div class="node ' + (SORDPROCES.ISHANDLE ? '' : 'wait') + '">';
                ahtml = ahtml + '<ul><li>' + SORDPROCES.STTNAME + '</li><li style="color:#999;" title="' + SORDPROCES.HANDLEDT + '">' + SORDPROCES.HANDLEDTXT + '</li></ul>';
                ahtml = ahtml + '</div>';
            });
            ahtml = ahtml + '</div></td>';
            if (item.STT != "0") {
                ahtml = ahtml + '<td style="width:200px;color:red">';
                ahtml = ahtml + item.PRCDT;
                ahtml = ahtml + '</td>';
            }
            ahtml = ahtml + '<td class="sheadstt sstt' + item.STT + '">';
            ahtml = ahtml + item.STTNAME;
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';
            ahtml = ahtml + '</tbody>';
            ahtml = ahtml + '</table>';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';
            ahtml = ahtml + '<tr class="scontent">';
            ahtml = ahtml + '<td class="sprcman" colSpan="2">';
            if (item.PRCMAN && item.PRCMAN != '') {
                ahtml = ahtml + '<img class="userMiniPhoto" style="width: 90px; height: 90px;" alt="" src="' + wcbaseurl + (!item.PRCMANPIC || item.PRCMANPIC == '' ? '/Images/user.png' : item.PRCMANPIC) + '">';
                ahtml = ahtml + '<br>';
                ahtml = ahtml + '工号：' + item.PRCMAN;
                ahtml = ahtml + '<br>';
                ahtml = ahtml + '姓名：' + item.PRCMANNAME;
            }
            else {
                ahtml = ahtml + '暂无人受理';
            }
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="smian">';
            ahtml = ahtml + '<div class="mini-panel" title="主信息" style="width:100%;" showtoolbar="false" showfooter="false" showCollapseButton="true">';
            ahtml = ahtml + '<table border="0" cellSpacing="0" cellPadding="0">';
            ahtml = ahtml + '<tbody>';
            ahtml = ahtml + '<tr>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '服务正文：';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td>';
            ahtml = ahtml + item.SUBTXT.replace('\n', '<br/>');
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';

            ahtml = ahtml + '<tr>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '图片详情：';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td>';
            if (item.USRIMG == undefined || item.USRIMG == null || item.USRIMG == "") {
            } else {
                ahtml = ahtml + '<img id="usrImg" name="usrImg" style="width: 100px; height: 10px;cursor:pointer;" onclick="openimg(this)" alt="" src="' + item.USRIMG + '">';
                //            ahtml = ahtml + '<img src="../../../../Attachments/uimage/20150212.png" />';
            }
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';

            ahtml = ahtml + '<tr>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '处理方法：';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td>';
            //            ahtml = ahtml + item.PRCMTHRSTL.replace('\n', '<br/>');
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';
            ahtml = ahtml + '<tr>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '客户评价：';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td>';
            $(item.SORDREVIEWs).each(function (SORDREVIEW_I, SORDREVIEW) {
                ahtml = ahtml + '满意度--<span id="star' + SORDREVIEW.APPRID + '"></span>';
                ahtml = ahtml + '<div>' + SORDREVIEW.APPRTXT + '</div>';
            });
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';
            ahtml = ahtml + '</tbody></table>';
            ahtml = ahtml + '</div>';
            ahtml = ahtml + '<div class="mini-panel" title="工单跟踪" style="width:100%;margin-top: 2px;" showtoolbar="false" showfooter="false" showCollapseButton="true" expanded="false">';
            var trackcount = item.SORDTRACKs.length;
            $(item.SORDTRACKs).each(function (SORDTRACK_I, SORDTRACK) {
                ahtml = ahtml + '<div class="linkTrack ' + (SORDTRACK_I == trackcount - 1 ? 'current' : '') + '">';
                ahtml = ahtml + '<div title="' + SORDTRACK.PRCDT + '">';
                ahtml = ahtml + SORDTRACK.PRCDTXT;
                ahtml = ahtml + '</div>';
                ahtml = ahtml + '<span>[' + SORDTRACK.PRCRNAME + ']' + SORDTRACK.BRF + '</span>';
                ahtml = ahtml + '</div>';
                ahtml = ahtml + '</div>';
                ahtml = ahtml + '<span>[' + SORDTRACK.PRCRNAME + ']' + SORDTRACK.BRF + '</span>';
                ahtml = ahtml + '</div>';
            });
            ahtml = ahtml + '<div class="mini-panel" title="留言/回复" style="width:100%;margin-top: 2px;" showtoolbar="false" showfooter="false" showCollapseButton="true">';
            $(item.SORDREPLYs).each(function (SORDREPLY_I, SORDREPLY) {
                ahtml = ahtml + '<div style="' + (!SORDREPLY.ISME ? 'text-align:left;float:left;' : 'text-align:right;float:right;') + '">';
                ahtml = ahtml + '<span class="mini-panel-border" style="background: rgb(222, 231, 248); padding: 2px; border: 1px solid rgb(202, 216, 243);">' + (!SORDREPLY.ISME ? SORDREPLY.SUBMANNAME : '我') + ' <span style="' + (SORDREPLY.ISTODAY ? 'color:#0000ff;' : '') + '" title="' + SORDREPLY.SUBDT + '">' + SORDREPLY.SUBDTXT + '</span> </span><ins class="dark-tooltip light medium north animated flipIn" style="font-size: 9pt; margin-top: 8px; display: block; position: relative; max-width: 300px; opacity: 1;">';
                ahtml = ahtml + '<div>';
                ahtml = ahtml + '<div>';
//                ahtml = ahtml + SORDREPLY.SUBTXT;
                ahtml = ahtml + SORDREPLY.SUBTXT.replace('\n', '<br/>');
                ahtml = ahtml + '</div>';
                ahtml = ahtml + '</div>';
                ahtml = ahtml + '<div class="tip" style="' + (!SORDREPLY.ISME ? 'left: 15px; right: auto;' : 'left: auto; right: 15px;') + '">';
                ahtml = ahtml + '</div>';
                ahtml = ahtml + '</ins>';
                ahtml = ahtml + '</div><div style="width:100%;clear:both;display:block;height:5px;line-height:5px;"></div>';
            });
            ahtml = ahtml + '</div>';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="soperate">';
            ahtml = ahtml + '<div class="mini-panel" title="其他" style="width:100%;" showtoolbar="false" showfooter="true" showCollapseButton="true">';
            ahtml = ahtml + '<table border="0" cellSpacing="0" cellPadding="0">';
            ahtml = ahtml + '<tbody><tr>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '提交客户：';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td style="width:150px;">';
            ahtml = ahtml + item.SUBCUSNAME.toString();
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '提交人：';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td style=" width:65px; vertical-align: top;">';
            ahtml = ahtml + item.SUBMANNAME.toString().substr(0, 5);
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';
            ahtml = ahtml + '</tr>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '提交时间：';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td style="' + (item.ISTODAY ? 'color:#0000ff;' : '') + '" title="' + item.SUBDT + '">';
            ahtml = ahtml + item.SUBDTXT;
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '服务类型：';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td>';
            ahtml = ahtml + item.SERTYPNAME;
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';
            ahtml = ahtml + '<tr>';
            if (item.STT == 0) {
                ahtml = ahtml + '<td class="cmlable">';
                ahtml = ahtml + 'IP地址：';
                ahtml = ahtml + '</td>';
                ahtml = ahtml + '<td>';
                ahtml = ahtml + item.IPADR;
                ahtml = ahtml + '</td>';
            }
            else {
                ahtml = ahtml + '<td class="cmlable">';
                ahtml = ahtml + '处理时间：';
                ahtml = ahtml + '</td>';
                ahtml = ahtml + '<td class="cmdate">';
                ahtml = ahtml + item.PRCDT;
                ahtml = ahtml + '</td>';
            }
            ahtml = ahtml + '<td class="cmlable ">';
            ahtml = ahtml + '预计时间：';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td>';
            ahtml = ahtml + '<span class="cmdate">' + item.ECTIME + '</span>&nbsp;(小时)';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';
            ahtml = ahtml + '<tr>';
            ahtml = ahtml + '<td class="cmlable">';
            ahtml = ahtml + '截止时间：';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '<td class="cmdate" title="' + item.ECDT + '">';
            ahtml = ahtml + item.ECDTXT;
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';
            ahtml = ahtml + '</tbody></table>';
            ahtml = ahtml + '<div property="footer" style="padding: 2px;">';
            ahtml = ahtml + '<a class="mini-button" onclick="UpdateSord(' + item.ORDNO + ');">查看</a> ';
            //                        ahtml = ahtml + '<a class="mini-button" onclick="replysd(' + item.ORDNO + ');">留言</a>';
            ahtml = ahtml + '<a class="mini-button" style="' + (item.STT != '0' ? 'display:none;' : '') + '" onclick="DeleteSord(' + item.ORDNO + ');">删除</a> ';
            ahtml = ahtml + '<a class="mini-button" style="' + (item.STT != '50' ? 'display:none;' : 'color:green;') + '" onclick="EndSord(' + item.ORDNO + ');">验收</a>';
            if (item.STT == 50) {
                mini.showMessageBox({
                    title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                    message: " 亲，您有留言未验收哦!", callback: function (action) {

                    }
                })
            }
            ahtml = ahtml + '</div></div>';

            ahtml = ahtml + '</div>';
            ahtml = ahtml + '</td>';
            ahtml = ahtml + '</tr>';
            return ahtml;
        }
        function UpdateSord(ordno) {
            mini.open({
                url: '<%=Url.RouteUrl(new { controller="Sord",action="UpdateSordInfo" ,area="WUCSM"}) %>?ordno=' + ordno,
                title: "编辑信息", width: 600, height: 250,
                ondestroy: function (action) {
                    if (action == 'ok') RefreshData();
                }
            });
        }
        function collapsereplypanel(ordno) {
            var replyp = mini.getbyName('replypanel' + ordno);
            replyp.setExpanded(!replyp.expanded);
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
        function EndSord(ordno) {
            mini.open({
                url: '<%=Url.RouteUrl(new { controller="Sord",action="EndSordInfo" ,area="WUCSM"}) %>?ordno=' + ordno,
                title: '派工单[' + ordno + '] - 验收', width: 600, height: 400,
                ondestroy: function (action) {
                    if (action == 'ok')
                        mini.showMessageBox({
                            title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                            message: '验收成功！', callback: function (action) {

                                RefreshData();
                            }
                        });
                }
            });
        }
        function replysd(ordno) {
            mini.open({
                title: '派工单[' + ordno + '] - 留言/回复',
                url: '<%=Url.RouteUrl(new { controller="Sord",action="SordReply" ,area="WUCSM"})+"?type=1&ordno="%>' + ordno,
                width: 700, height: 400,
                ondestroy: function (action) {
                    if (action == 'ok')
                        RefreshData();
                }
            }).showAtPos('center', 'middle');
        }
        function onSelectedChanged(value, text, id) {
            var tbl = mini.get(id);
            tbl.setValue(value);
            tbl.setText(text);
            $('body > .dark-tooltip').hide();
            $('#' + id + ' li:eq(0)').attr('data-tooltip', '#' + id + '-content').darkTooltip();
            RefreshData();
        }

        AsLable(mini.get('subdt'));
        AsLable(mini.get('sortfield'));
        AsLable(mini.get('sordstt'));
        AsLable(mini.get('sertyp'));
        function AsLable(txtboxlist) {
            txtboxlist.setReadOnly(true);
            txtboxlist.setIsValid(true);
            txtboxlist.addCls("asLabel");
        }

        $("#newsords").click(function () {

            var isUser = document.getElementById("isUser").value;
            //mini.alert(isUser);

            //判断该用户是否被禁用
            if (isUser == "T") {
                var myDate = new Date();
                var h = myDate.getHours() < 10 ? "0" + myDate.getHours() : myDate.getHours();
                var m = myDate.getMinutes() < 10 ? "0" + myDate.getMinutes() : myDate.getMinutes();     //获取当前分钟数(0-59)
                var time = h + ":" + m;
                var Uid = 17 + ":" + 30;

                //            var data1 = new Date(time);
                //            var data2 = new Date(Uid);
                if (time > Uid) {//判断是否上班时间
                    $.ajax({
                        url: '<%=Url.RouteUrl(new { controller="Sord",action="NewSordMsg" ,area="WUCSM"}) %>',
                        type: "post",
                        data: {},
                        dataType: "text",
                        success: function (e) {

                            mini.showMessageBox({
                                title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                                message: e, callback: function (action) {

                                    NewSord();
                                }
                            })

                        }

                    });
                }
                else {
                    $.ajax({
                        url: '<%=Url.RouteUrl(new { controller="Sord",action="NewSordCall" ,area="WUCSM"}) %>',
                        type: "post",
                        data: {},
                        dataType: "text",
                        success: function (e) {

                            mini.showMessageBox({
                                title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"],
                                message: e, callback: function (action) {

                                    NewSord();
                                }
                            })

                        }

                    });
                } //判断上下班时间结束
            }
            else if (isUser == "F") {
                mini.alert("亲！你的权限已受限制，请联系西联公司相关人员。");
            }

        });

        function NewSord() {
            mini.open({
                url: '<%=Url.RouteUrl(new { controller="Sord",action="NewSord" ,area="WUCSM"}) %>',
                title: "申请派工", width: 700, height: 260,
                ondestroy: function (action) {
                    if (action == 'ok') RefreshData();
                }
            });
        }
        $(function () {
            $('#subdt li:eq(0)').attr('data-tooltip', '#subdt-content').darkTooltip();
            $('#sortfield li:eq(0)').attr('data-tooltip', '#sortfield-content').darkTooltip();
            $('#sordstt li:eq(0)').attr('data-tooltip', '#sordstt-content').darkTooltip();
            $('#sertyp li:eq(0)').attr('data-tooltip', '#sertyp-content').darkTooltip();
        });

        function AutoScroll(obj) {
            if ($('#scrollDiv li').length > 2) {
                $(obj).find("ul:first").animate({ marginTop: "-25px" }, 500, function () {
                    $(this).css({ marginTop: "0px" }).find("li:first").appendTo(this);
                });
            }
        }
        var aditv;
        $(document).ready(function () {
            if ($("#SMG").val() && $("#SMG").val() != "") {
                mini.alert($("#SMG").val(), "", function () { RefreshData(); NewGridInterval = setInterval("RefreshData()", 3 * 60 * 1000); });
            }
            else {
                window.onload = function () { RefreshData(); NewGridInterval = setInterval("RefreshData()", 3 * 60 * 1000); };
            }
            aditv = setInterval('AutoScroll("#scrollDiv")', 2000)
            $('#scrollDiv').hover(function () {
                clearInterval(aditv);
            }, function () {
                aditv = setInterval('AutoScroll("#scrollDiv")', 2000)
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .asLabel .mini-textbox-border, .asLabel .mini-textbox-input, .asLabel .mini-buttonedit-border, .asLabel .mini-buttonedit-input, .asLabel .mini-textboxlist-border
        {
            border: 0;
            background: none;
            cursor: default;
        }
        .asLabel .mini-buttonedit-button, .asLabel .mini-textboxlist-close, .asLabel .mini-textboxlist-input
        {
            display: none;
        }
        .asLabel .mini-textboxlist-item
        {
            padding-right: 8px;
        }
        #toolbar-main .mini-button-text.mini-button-icon
        {
            padding-top: 35px;
        }
        .cmlable
        {
            vertical-align: top;
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
    </style>
</asp:Content>
