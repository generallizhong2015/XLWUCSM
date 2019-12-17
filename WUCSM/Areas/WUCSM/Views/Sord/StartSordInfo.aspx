<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>受理派工单</title>
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
        <table border="0" cellpadding="1" cellspacing="2" width="500px;">
            <tr style="height: 30px;">
                <td style=""class="cmlable">
                    处理单号：
                </td>
                <td style="width: 300px">
                    <input id="ordno" name="ordno" class="mini-textbox" allowinput="false" required="true"
                        value='<%=(TempData["SORD"] as Models.SORD).ORDNO%>' />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td style=" " class="cmlable">
                    处理员工：
                </td>
                <td style="width: 300px">
                    <input id="users" class="mini-combobox" style="width: 200px;" textfield="USERNAME"
                        name="users" valuefield="USERID" required="true" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td class="cmlable">
                    开始时间：
                </td>
                <td>
                    <input id="sdt" class="mini-datepicker" style="width: 200px;" nullvalue="null" name="sdt"
                        format="yyyy-MM-dd H:mm:ss" timeformat="H:mm:ss" showtime="true" showokbutton="true"
                        showclearbutton="false" />
                </td>
            </tr>
            <tr style="height: 30px;">
                <td class="cmlable">
                    预计时间：
                </td>
                <td>
                    <input name="ectime" id="sp2" class="mini-spinner" value="<%=(TempData["SORD"] as Models.SORD).ECTIME%>"
                        minvalue="0" maxvalue="1000000" required="true" />
                    &nbsp;(小时)
                </td>
            </tr>
            <%--<tr style="height:30px;">
                <td class="cmlable">
                    故障概述:
                </td>
                <td>
                    <input id="Fault" name="Fault" value="" />
                </td>
            </tr>--%>
           <%-- <tr style="height:30px;">
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
                    </ul>
                </td>
            </tr>--%>
        </table>
    </div>
    <div style="height: 0px">
        &nbsp;</div>
    <div style="text-align: center;">
        <a class="mini-button" onclick="onOk" style="width: 60px; margin-right: 20px;">确定</a>
        <a class="mini-button" onclick="onCancel" style="width: 60px;">关闭</a>
    </div>
    <script src="../../../../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script type="text/javascript">
        mini.parse();
        var form = new mini.Form("form1");
        mini.get("users").load(mini.decode('<%=TempData["USERs"] %>'));
        var usrName = '<%=TempData["UsrName"] %>';
        window.onload = function () {
            var date = new Date();
            var t1 = mini.get("sdt");
            t1.setValue(date);

            var thisUsr = mini.get('users');
            thisUsrData = thisUsr.data;
            for (var i = 0; i < thisUsrData.length; i++) {
                if (thisUsrData[i].USERNAME == usrName) {
                    thisUsr.select(thisUsrData[i]);
                }
            }



        }
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

            //            var ordno = mini.get("ordno").getValue("ordno");
            //            var users = mini.get("users").getValue("users");
            //            var sdtime= mini.get("sdt").getValue("sdt");
            //            var sdt = Convertdate(sdtime);
            //            var ectime = mini.get("sp2").getValue("sp2");
            //            var fault = $("#Fault").val();
            //            mini.alert(sdt);
            //            $.ajax({
            //                url: '<%=Url.RouteUrl(new { controller="Sord",action="StartSord" ,area="WUCSM"}) %>',
            //                type: "post",
            //                data: { ordno: ordno, users: users, sdt: sdt, ectime: ectime},
            //                error: function () { mini.alert("系统异常！") },
            //                success: function () {
            //                    CloseWindow("ok");
            //                }

            //            });

            form.validate();
            if (form.isValid() == false) return;
            RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="StartSord" ,area="WUCSM"}) %>', '数据提交中', form.getData(true, false), function () {
                CloseWindow("ok");
            });
        }

        //时间转换方法
        function Convertdate(UTCstr) {
            //Tue May 5 0:00:00 UTC+0800 2015   
            UTCstr = UTCstr + "";
            var date = ""; //month  
            var month = new Array();
            month["Jan"] = 01; month["Feb"] = 02; month["Mar"] = 03; month["Apr"] = 04; month["May"] = 05; month["Jan"] = 06;
            month["Jul"] = 7; month["Aug"] = 8; month["Sep"] = 9; month["Oct"] = 10; month["Nov"] = 11; month["Dec"] = 12;
            //week 
            var week = new Array();
            week["Mon"] = "一"; week["Tue"] = "二"; week["Wed"] = "三"; week["Thu"] = "四"; week["Fri"] = "五"; week["Sat"] = "六"; week["Sun"] = "日";
            //字符串拼接  
            str = UTCstr.split(" ");
            date = str[5] + "/";
            //2015-05-05 00:00:00 格式  
            date = date + month[str[1]] + "/" + str[2] + " " + str[3];
            //2015-05-05格式  
            //date=date+month[str[1]]+"-"+str[2];  
            //date=date+" 周"+week[str[0]];  
            return date;
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
