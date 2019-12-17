<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>编辑信息</title>
    <script src="<%=Url.Content("~/Scripts/boot.js")%>" type="text/javascript"></script>
    <style type="text/css">
        .listFault
        {
            list-style:none;margin:0px;padding:0px;
            display:none;
        }
        .listFault li{width:100%;}
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
</head>
<body>
    <div id="form1" style="padding: 10px;">
        <input style="display:none" id="ISSYS" name="ISSYS" value="<%=TempData["isSys"]%>" />
        <table border="0" cellpadding="1" cellspacing="2">
            <tr>
                <td class="cmlable">
                    提交客户：
                </td>
                <td id="subCus">
                    <%=(TempData["SORD"] as Models.SORD).SUBCUSNAME%>
                </td>
                <td class="cmlable">
                    提交人：
                </td>
                <td id="subName">
                    <%=(TempData["SORD"] as Models.SORD).SUBMANNAME%>
                </td>
                <td class="cmlable">
                    提交时间：
                </td>
                <%--<td class="cmdate" id="subDate" title="<%=(TempData["SORD"] as Models.SORD).SUBDT.ToString("yyyy-MM-dd HH:mm:ss") %>">
                    <%=WUCSM.Helpers.DateTimeConvert.DateToString((TempData["SORD"] as Models.SORD).SUBDT)%>
                </td>--%>
                <td class="cmdate" id="subDate" title="<%=WUCSM.Helpers.DateTimeConvert.DateToString((TempData["SORD"] as Models.SORD).SUBDT)%>">
                    <%=WUCSM.Helpers.DateTimeConvert.DateToString((TempData["SORD"] as Models.SORD).SUBDT)%>
                </td>
            </tr>
            <tr>
                <td style="width: 60px;" class="cmlable">
                    正文描述：
                </td>
                <td style="width: 500px" colspan="5">
                    <input name="SUBTXT" id="SUBTXT" class="mini-textarea" style="width: 100%; height: 60px;"
                        required="true" value="<%=(TempData["SORD"] as Models.SORD).SUBTXT%>" />
                    <input name="ORDNO" id="ORDNO" value="<%=(TempData["SORD"] as Models.SORD).ORDNO%>" class="mini-textbox"
                        style="display: none;" />
                    <input name="SUBDT" id="SUBDT" value="<%=(TempData["SORD"] as Models.SORD).SUBDT.ToString("yyyy-MM-dd HH:mm:ss")%>"
                        class="mini-textbox" style="display: none;" />
                   <%--<input name="SUBDT" id="SUBDT" value="<%=WUCSM.Helpers.DateTimeConvert.DateToString((TempData["SORD"] as Models.SORD).SUBDT)%>"
                    class="mini-textbox" style="display: none;" />--%>
                    <input name="SUBCUS" id="SUBCUS" value="<%=(TempData["SORD"] as Models.SORD).SUBCUS%>" class="mini-textbox"
                        style="display: none;" />
                    <input name="SUBMAN" id="SUBMAN" value="<%=(TempData["SORD"] as Models.SORD).SUBMAN%>" class="mini-textbox"
                        style="display: none;" />
                    <input name="VERSION" id="VERSION" value="<%=(TempData["SORD"] as Models.SORD).VERSION%>" class="mini-textbox"
                        style="display: none;" />
                    <input name="PRCMAN" id="PRCMAN" value="<%=(TempData["SORD"] as Models.SORD).PRCMAN%>" class="mini-textbox"
                        style="display: none;" />
                        <input name="PRCDT" id="PRCDT" value="<%=(TempData["SORD"] as Models.SORD).PRCDT%>" class="mini-textbox"
                        style="display: none;" />
                        <input name="ACCDT" id="ACCDT" value="<%=(TempData["SORD"] as Models.SORD).ACCDT%>" class="mini-textbox"
                        style="display: none;" />
                </td>
            </tr>
          <%--  <tr>
                <td class="cmlable">
                    IP地址：
                </td>
                <td colspan="5">
                    <input name="IPADR" value="<%=(TempData["SORD"] as Models.SORD).IPADR%>" class="mini-textbox"
                        style="width: 150px;" required="true" />
                </td>
            </tr>--%>
            <tr>
                <td class="cmlable">
                    服务类型：
                </td>
                <td colspan="5">
                    <input class="mini-combobox" style="width: 100px;" textfield="NODNAME" name="SERTYP"
                        id="SERTYP" valuefield="NODDTSTT" value="<%=(TempData["SORD"] as Models.SORD).SERTYP%>"
                        required="true" />
                </td>
            </tr>
            <tr style="<%=(Session["CurUser"] as Models.USERS).USERTYP == "01"?"": "display:none;"%>">
                <td class="cmlable">
                    预计时间：
                </td>
                <td colspan="5">
                    <input   name="ECTIME" id="sp2" class="mini-spinner" value="<%=(TempData["SORD"] as Models.SORD).ECTIME%>"
                        minvalue="1" maxvalue="1000000" />
                    &nbsp;(小时)
                </td>
            </tr>
            <tr style="<%=(Session["CurUser"] as Models.USERS).USERTYP == "01"?"": "display:none;"%>">
                <td style="width: 60px;" class="cmlable">
                    处理结果：
                </td>
                <td style="width: 500px" colspan="5">
                    <input name="PRCMTHRSTL" id="PRCMTHRSTL" class="mini-textarea" value="<%=(TempData["SORD"] as Models.SORD).PRCMTHRSTL%>"
                        style="width: 100%; height: 60px;" />
                </td>
            </tr>
             <% if ((Session["CurUser"] as Models.USERS).USERTYP == "01")
                {%>
                <tr >
                <td style="width: 60px;" class="cmlable">
                    回访内容：
                </td>
                <td style="width: 500px" colspan="5">
                   
                    <% if ((Session["CurUser"] as Models.USERS).USERID == (TempData["SORD"] as Models.SORD).Revisit)
                       { %>
                       <input id="RevisitTxt" name="RevisitTxt" class="mini-textarea"  value="<%=(TempData["SORD"] as Models.SORD).RevisitTxt%>"
                        style="width: 100%; height: 60px;" />
                    <%}
                       else
                       { %>

                       <input readonly id="RevisitTxt" name="RevisitTxt" class="mini-textarea"  value="<%=(TempData["SORD"] as Models.SORD).RevisitTxt%>"
                        style="width: 100%; height: 60px;" />
                    <%} %>
                    
                </td>
            </tr>
                                                         
            <%}
                else
                { %>
            
                <tr style="display:none;">
                <td style="width: 60px;" class="cmlable">
                    回访内容：
                </td>
                <td style="width: 500px" colspan="5">
                    <input readonly id="RevisitTxt" name="RevisitTxt" class="mini-textarea"  value="<%=(TempData["SORD"] as Models.SORD).RevisitTxt%>"
                            style="width: 100%; height: 60px;" />
                </td>
            </tr>
                    
                 <%} %>
            
            <% if ((Session["CurUser"] as Models.USERS).USERTYP == "01")
               {%>
            <tr style="height:30px;">
                <td class="cmlable">
                    故障概述:
                </td>
                <td>
                    <input id="Fault" name="Fault" value="" />
                </td>
            </tr>
           <tr style="height:30px;">
                <td class="cmlable"></td>
                <td>
                    <ul class="listFault">
                    
                        <li><span class="menu">+</span>西联软件程序问题
                            <ul class="faults">
                                <li>程序编码错误</li>
                                <li>程序设计缺陷</li>
                                <li>程序完整性不够</li>
                                <li>系统不稳定</li>
                                <li>系统报表数据不一致</li>
                                <li>数据通讯错误</li>
                                <li>安装版本错误</li>
                            </ul>
                        </li>
                        <li><span class="menu">+</span>西联服务问题
                            <ul class="faults">
                                <li>服务失误</li>
                                <li>服务不完整造成连带错误</li>
                            </ul>
                        </li>
                        <li><span class="menu">+</span>用户问题
                            <ul class="faults">
                                <li>设备损坏（硬件、软件、病毒）</li>
                                <li>新增需求（含截帐）</li>
                                <li>因工程培训不到位造成客户使用错误</li>
                                <li>因客户自身能力造成客户使用错误</li>
                                <li>客户数据安全性管理问题</li>
                            </ul>
                        </li>
                        <li><span class="menu">+</span>(MIS+)
                            <ul class="faults">
                                <li>开发</li>
                                <li>BUG</li>
                                <li>客户使用问题</li>
                            </ul>
                        </li>
                    </ul>
                </td>
            </tr>
            <%}
               else
               {%>
               <tr style="height:30px;display:none">
                <td class="cmlable">
                    故障概述:
                </td>
                <td>
                    <input id="Text1" name="Fault" value="" />
                </td>
            </tr>
           <tr style="height:30px; display:none;">
                <td class="cmlable"></td>
                <td>
                    <ul class="listFault">
                    
                        <li><span class="menu">+</span>西联软件程序问题
                            <ul class="faults">
                                <li>程序编码错误</li>
                                <li>程序设计缺陷</li>
                                <li>程序完整性不够</li>
                                <li>系统不稳定</li>
                                <li>系统报表数据不一致</li>
                                <li>数据通讯错误</li>
                                <li>安装版本错误</li>
                            </ul>
                        </li>
                        <li><span class="menu">+</span>西联服务问题
                            <ul class="faults">
                                <li>服务失误</li>
                                <li>服务不完整造成连带错误</li>
                            </ul>
                        </li>
                        <li><span class="menu">+</span>用户问题
                            <ul class="faults">
                                <li>设备损坏（硬件、软件、病毒）</li>
                                <li>新增需求（含截帐）</li>
                                <li>因工程培训不到位造成客户使用错误</li>
                                <li>因客户自身能力造成客户使用错误</li>
                                <li>客户数据安全性管理问题</li>
                            </ul>
                        </li>
                        <li><span class="menu">+</span>(MIS+)
                            <ul class="faults">
                                <li>开发</li>
                                <li>BUG</li>
                                <li>客户使用问题</li>
                            </ul>
                        </li>
                    </ul>
                </td>
            </tr>

            <%} %>

            <tr style="<%=(Session["CurUser"] as Models.USERS).USERTYP == "01"?"": "display:none;"%>">
                <td class="cmlable">
                    状态：
                </td>
                <td colspan="5">
                    <input class="mini-combobox" onvaluechanged="sttChange()" style="width: 100px;" textfield="NODNAME" name="STT"
                        id="STT" valuefield="NODDTSTT" value="<%=(TempData["SORD"] as Models.SORD).STT%>"
                        required="true" />
                </td>
            </tr>
        </table>
    </div>
    <input type="hidden" id="usrId" name="usrId" value="<%=(Session["CurUser"] as Models.USERS).USERID%> " />
    <input type="hidden" id="Revisit" name="Revisit" value="<%=(TempData["SORD"] as Models.SORD).Revisit%> " />
    <div style="text-align: center; padding: 10px;">
        <a class="mini-button" onclick="onOk" style="width: 60px; margin-right: 20px;">确定</a>
        <a class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
    </div>
    <script src="../../../../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script type="text/javascript">
        mini.parse();
        mini.get("SERTYP").load(mini.decode('<%=TempData["SERTYPs"] %>'));
        mini.get("STT").load(mini.decode('<%=TempData["STTs"] %>'));
        var form = new mini.Form("form1");
        window.onload = function () { $(SUBTXT).focus(); }
        if ($("#usrId").val() == $("#Revisit").val())
            
//        $("textarea").eq(1).attr("disabled");
        var Stt = mini.get("STT").getValue("STT");
        function sttChange() {
            var issys = $("#ISSYS").val();
            var thisStt = mini.get("STT").getValue("STT");
            //判断是否超级用户，F：普通，T：超级管理员
            if (issys == "F") {
                if (thisStt < Stt) {
                    mini.get("STT").setValue(Stt);
                    //break;
                }
            }
        };

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


        function onOk(e) {
            var SUBTXT = mini.get("SUBTXT").getValue("SUBTXT");
            var ORDNO = mini.get("ORDNO").getValue("ORDNO");
            var SUBDT = mini.get("SUBDT").getValue("SUBDT");
            var SUBCUS = mini.get("SUBCUS").getValue("SUBCUS");
            var SUBMAN = mini.get("SUBMAN").getValue("SUBMAN");
            var SERTYP = mini.get("SERTYP").getValue("SERTYP");
            var VERSION = mini.get("VERSION").getValue("VERSION");
            var PRCMAN = mini.get("PRCMAN").getValue("PRCMAN");  
            var ACCDT = mini.get("ACCDT").getValue("ACCDT");
            var PRCDT = mini.get("PRCDT").getValue("PRCDT");
            var ECTIME = mini.get("sp2").getValue("sp2");
            var PRCMTHRSTL = mini.get("PRCMTHRSTL").getValue("PRCMTHRSTL");
            var RevisitTxt = mini.get("RevisitTxt").getValue("RevisitTxt");
            var Fault = $("#Fault").val();
            var Stt = mini.get("STT").getValue("STT");

            var sord = "{\"RevisitTxt\":\""+RevisitTxt+"\",\"ACCDT\":\"" + ACCDT + "\",\"PRCDT\":\"" + PRCDT + "\",\"SUBTXT\":\"" + SUBTXT + "\",\"ORDNO\":\"" + ORDNO + "\",\"SUBDT\":\"" + SUBDT + "\",\"SUBCUS\":\"" + SUBCUS + "\",\"SUBMAN\":\"" + SUBMAN + "\",\"VERSION\":\"" + VERSION + "\",\"PRCMAN\":\"" + PRCMAN + "\",\"PRCMTHRSTL\":\"" + PRCMTHRSTL + "\",\"Fault\":\"" + Fault + "\",\"SERTYP\":\"" + SERTYP + "\",\"ECTIME\":\"" + ECTIME + "\",\"STT\":\"" + Stt + "\"}";
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="Sord",action="UpdateSord" ,area="WUCSM"}) %>',
                type: 'post',
                data: {sord:sord},
                success: function () {
                    CloseWindow("ok");
                },
                error: function () { 
                }


            })


//            form.validate();
//            if (form.isValid() == false) return;
//            RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="UpdateSord" ,area="WUCSM"}) %>', '数据保存中', { sord: mini.encode(form.getData()) }, function () {
//                CloseWindow("ok");
//            });
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
        function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
    </script>
</body>
</html>
