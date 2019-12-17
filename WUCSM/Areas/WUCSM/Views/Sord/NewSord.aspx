<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>申请派工</title>
    <script src="<%=Url.Content("~/Scripts/boot.js")%>" type="text/javascript"></script>
</head>
<body>
    <div id="form1" style="padding: 10px;">
    <input type="text" style="display:none" id="IP" name="name" value="<%=TempData["IP"]%> " />
        <table border="0" cellpadding="1" cellspacing="2">
            <tr>
                <td style="width: 60px;" class="cmlable">
                    申请方：
                </td>
                <td style="width: 500px" colspan="3">
                    <%=(TempData["CUS"] as Models.CUS).CUSNAME%>
                </td>
                <td style="width: 60px;" class="cmlable">
                    申请人：
                </td>
                <td>
                    <%=(TempData["USER"] as Models.USERS).USERNAME%>
                </td>
            </tr>
            <tr>
                <td class="cmlable">
                    联系电话：
                </td>
                <td>
                    <%--<input name="SUBMANMOVTEL" value="<%=(TempData["USER"] as Models.USERS).MOVTEL%>"
                        class="mini-textbox" style="width: 120px;" required="true" />--%>
                        <%--<span id="SUBMANMOVTEL"> <%=(TempData["USER"] as Models.USERS).MOVTEL%> </span>--%>
                        <input name="SUBMANMOVTEL" id="SUBMANMOVTEL" value="<%=(TempData["USER"] as Models.USERS).MOVTEL%>"
                        style="width: 120px;" required="true" />
                </td>
                <%--<td class="cmlable">
                    IP地址：
                </td>--%>
                <td class="cmlable">
                 远程类型：
                </td>
                <td>
                    <select id="serSys" onchange="serSys()">
                    
                        <option value="">请选择远程类型</option>
                        <option value="T">Teamview软件</option>
                        <option value="P">pcanywhere</option>
                        <option value="X">XT800</option>
                    </select>
                </td>
               <%-- <td>
                    <%--<input name="IPADR" value="<%=TempData["IP"] %>" class="mini-textbox" style="width: 150px;"
                        required="true" />
                        <span id="IPADR"><%=TempData["IP"] %></span>
                </td>--%>
                <td class="cmlable">
                    服务类型：
                </td>
                <td>
                    <%--<input id="SERTYP" class="mini-combobox" style="width: 80px;" textfield="NODNAME"
                        name="SERTYP" valuefield="NODDTSTT" value="01" required="true" />--%>
                    <select id="SERTYP">
                        <option value="01">远程</option>
                        <option value="02">现场</option>
                        <option value="03">需求</option>
                        <option value="04">其他</option>
                    </select>
                </td>
            </tr>
            <tr id="sysTyp" style="display:none;">
                <td class="cmlable usrNum"><span id="usrNum"> </span></td>
                <td><input type="text" name="TVNum" id="USRSNUM" data-tip="账号不能为空" value="" /></td>
                <td class="cmlable usrPass"><span id="usrPass">TV密码</span></td>
                <td><input type="text"  required="true" name="password"id="password" value="" /></td>
            </tr>
            <tr>
                <td class="cmlable">
                    <span id="btnfile" style="border:0; width:60px;background-color:#fafbf6;color:#83888d;cursor:pointer;">上传图片： </span>
                </td>
                <td>
                    <%--<img id="usrImg" name="usrImg" style="cursor:pointer; width:80%;height:5%;" src="" alt="" />--%>
                    <img id="usrImg" name="usrImg" style="width: 100px; height: 10px; cursor:pointer;" src="" alt="" />
					<%--<input id="USRIMGS" name="USRIMGS" value="" type="hidden" style="display: none;"   class="mini-textbox" />--%>
                    <%--<input id="USRIMGS" name="USRIMGS" value="选择图片" type="image" style="cursor:pointer; width:80%;height:5%;" src="" alt=""   class="mini-textbox" />--%>
                </td>
            </tr>
            <tr>
                <td style="width: 60px;" class="cmlable">
                    服务正文：
                </td>
                <td colspan="5">
                    <%--<input name="SUBTXT" id="SUBTXT" class="mini-textarea" style="width: 100%; height: 60px;"
                        required="true" />--%>
                    <textarea id="SUBTXT" style="width: 100%; height: 60px;" rows="3" cols="20" wrap="physical" required="true"> </textarea>
                </td>
            </tr>
        </table>
    </div>
    <form action="" method="post" enctype = "multipart/form-data" id="formImg">
        <input type="hidden" id="type" name="type" value="image" />
        <input id="addfile" value="" style="display: none;" type="file" name="imgFile" accept="image/jpeg,image/gif,image/x-ms-bmp,image/x-png" data-type="file" />
    </form>
    <div style="text-align: center; padding: 10px;">
        <a class="mini-button" onclick="onOk" style="width: 60px; margin-right: 20px;">确定</a>
        <a class="mini-button" onclick="onCancel" style="width: 60px;">关闭</a>
    </div>
    <script src="../../../../Scripts/jquery-form.js" type="text/javascript"></script>
    <script type="text/javascript">
        mini.parse();



        //        mini.get("SERTYP").load(mini.decode('<%=TempData["SERTYPs"] %>'));
        var form = new mini.Form("form1");

//        $(document).ready(function () {
//            mini.alert("尊敬的客户，您好！感谢您选择西联软件！");
//        });

        window.onload = function () { $(SUBTXT).focus(); }
        //        var SERTYP = $("#SERTYP").value();
        //        var index = ("#SERTYP options:selected").val();
        $(document).on("click", "#usrImg", function () {
            $("#usrImg").toggle(function () {
                $("#usrImg").height(10);
                $("#usrImg").width(100);
            }, function () {
                $("#usrImg").height("100%");
                $("#usrImg").width("100%");
            })

        });

        var SERTYP = "01";
        $("#SERTYP").change(function () {
            //var index = $(this)[0].selectedIndex//获取当前被选中的option
            SERTYP = this.options[this.selectedIndex].value; //获取当前被选中的option文本
            //            switch (SERTYP) {
            //                case 远程:
            //                    index = "01";
            //                    break;
            //                case 现场:
            //                    index = "02";
            //                    break;
            //                case 需求:
            //                    index = "03";
            //                    break;
            //                case 其他:
            //                    index = "04";
            //                    break;
            //                default:

            //            }
            //            mini.alert(SERTYP);
        });

        //上传图片
        $("#btnfile").click(function () {
            $("#addfile").click();
        });
        //选择图片后
        $("#addfile").change(function () {
            $("#formImg").submit();

        });
        $("#formImg").submit(function () {
            $(this).ajaxSubmit(options);
            return false;
        });
        var options = {
            url: "/Upload/UploadFile",
            dataType: 'json',
            error: function () { alert("系统异常"); },
            success: function (data) {
                if (data.error == 0) {//上传成功
                    //                    mini.alert(11);
                    $("#usrImg").attr("src", data.url);
                    //                    $("input[name=USRIMGS]").val(data.url);
                    //                    var img = $("input[name=USRIMGS]").val(data.url);
                    //                    $("#USRIMGS").text(data.url);
                    //                    var img = $("#USRIMGS").text(data.url);
                    //                    mini.alert(img);

                } else {
                    mini.alert(data.message);
                }
            }

        };

        function serSys() {
            serTyp();
        }


        function serTyp() {
            var selval = document.getElementById("serSys").value;
            var trDis = document.getElementById("sysTyp");
            if (selval == "T") {
                document.getElementById("USRSNUM").value = "";
                trDis.style.display = "";
                document.getElementById("usrNum").innerHTML = "TV账号:";
                document.getElementById("usrPass").innerHTML = "TV密码:";
                document.getElementById("password").value = " ";
                document.getElementById("password").style.display = "";
                //                $(".usrNum span").text("TV账号");
                //                $(".usrPass span").text("TV密码");

            }
            else if (selval == "P") {
                document.getElementById("USRSNUM").value = "";
                trDis.style.display = "";
                document.getElementById("usrNum").innerHTML = "IP地址:";
                //document.getElementById("USRSNUM").style.border = "none";
                document.getElementById("USRSNUM").value = document.getElementById("IP").value;
                document.getElementById("usrPass").innerHTML = "密 码:";
                document.getElementById("usrPass").innerHTML = " ";
                document.getElementById("password").value = "无";
                //                document.getElementById("password").setAttribute("disabled", "true");
                document.getElementById("password").style.display = "none";
                //                $(".usrNum span").text("IP地址");
                //                $(".usrPass span").text("IP密码");
                //                $("input[name=password]").attr("disabled", true);
            }
            else if (selval == "X") {
                document.getElementById("USRSNUM").value = "";
                trDis.style.display = "";
                document.getElementById("usrNum").innerHTML = "XT账号:";
                document.getElementById("usrPass").innerHTML = "XT密码:";
                document.getElementById("password").value = " ";
                document.getElementById("password").style.display = ""; 
            }
        }

        function onOk(e) {
            //            form.validate();
            //            if (form.isValid() == false) return;
            //            RequestAjax('<%=Url.RouteUrl(new { controller="Sord",action="InsertSord" ,area="WUCSM"}) %>', '数据保存中', { sord: mini.encode(form.getData()) }, function () {
            //                CloseWindow("ok");
            //            });


            var selval = document.getElementById("serSys").value;
            var SUBMANMOVTEL = document.getElementById("SUBMANMOVTEL").value;

            var IPADR = $("#IPADR").text();
            var usrImg = $("#usrImg").attr("src");
            var SUBTXT = document.getElementById("SUBTXT").value;
            var usrNum = document.getElementById("USRSNUM").value; //远程类型账号
            var usrPass = document.getElementById("password").value; //密码
            var soed = "{\"SUBMANMOVTEL\":\"" + SUBMANMOVTEL + "\",\"IPADR\":\"" + IPADR + "\",\"SERTYP\":\"" + SERTYP + "\",\"usrImg\":\"" + usrImg + "\",\"SUBTXT\":\"" + SUBTXT + "\",\"serSys\":\"" + selval + "\",\"usrNum\":\"" + usrNum + "\",\"usrPass\":\"" + usrPass + "\"}";

            if (SUBTXT == "" || SUBMANMOVTEL == "") {
                mini.alert("请输入联系方式或者服务正文！");
                return;
            }
            else if (selval == "") {
                mini.alert("请选择远程类型！");
                return;
            }
            else if (usrNum == "") {
                mini.alert("请输入9位数以上的账号");
                return;
            } 
//            else if (usrNum != "") {
//                var selval = document.getElementById("serSys").value;
//                if (selval == "P") {
//                    if (!checkIpAddr(usrNum)) {
//                        mini.alert("为了准确连接，请填写正确的外网IP地址");
//                        return;
//                    }
//                }
//                if (selval == "T" && usrNum.length < 9) {
//                    mini.alert("为了准确连接，请填写正确的TV帐号");
//                    return;
//                }
//            }
            else if (usrPass == "") {
                mini.alert("请输入远程软件密码");
                return;
            }
//            else if (usrPass != "") {
//                if (usrPass.length < 4) {
//                    mini.alert("为了准确连接，请填写正确的TV密码");
//                    return;
//                }
//            }
            else {
                if (usrNum != "") {
                    var selval = document.getElementById("serSys").value;
                    if (selval == "P") {
                        if (!checkIpAddr(usrNum)) {
                            mini.alert("为了准确连接，请填写正确的外网IP地址");
                            return;
                        }
                    }
                    if (selval == "T" && usrNum.length < 9) {
                        mini.alert("为了准确连接，请填写正确的TV帐号");
                        return;
                    }
                }
                if (usrPass != "" && usrPass != "无") {
                    if ($.trim(document.getElementById("password").value).length < 4) {
                        mini.alert("为了准确连接，请填写正确的TV密码");
                        return;
                    }
                }
                newSord(soed);
            }

        }

        function newSord(soed) {
            $.ajax({
                url: '<%=Url.RouteUrl(new { controller="Sord",action="InsertSord" ,area="WUCSM"}) %>',
                type: "post",
                data: { sord: soed },
                error: function () { mini.alert("系统异常！") },
                success: function () {
                    CloseWindow("ok");
                }

            });
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
        function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
        //判断IP 是否合法
        function checkIpAddr(ipaddr) {
            if ($.trim(ipaddr) == "") {
                return false;
            }

            var ss = ipaddr.split(".");

            if (ss.length != 4) {
                return false;
            }

            var i = 0;
            for (i = 0; i < ss.length; i++) {
                if ($.isNumeric(ss[i]) != true || parseInt(ss[i]) < 0 || parseInt(ss[i]) > 255) {
                    return false;
                }
            }

            return true;

        }
    </script>
</body>
</html>
