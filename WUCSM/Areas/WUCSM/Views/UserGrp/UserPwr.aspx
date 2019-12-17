<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户权限</title>
    <link href="<%=Url.Content("~/Scripts/zTree/css/zTreeStyle/zTreeStyle.css")%>" rel="Stylesheet"
        type="text/css" />
    <script src='<%=Url.Content("~/Scripts/jquery.min.js")%>' type="text/javascript"></script>
    <script src="<%=Url.Content("~/Scripts/boot.js")%>" type="text/javascript"></script>
    <script src='<%=Url.Content("~/Scripts/zTree/js/jquery.ztree.core-3.5.min.js")%>'
        type="text/javascript"></script>
    <script src='<%=Url.Content("~/Scripts/zTree/js/jquery.ztree.excheck-3.5.min.js")%>'
        type="text/javascript"></script>
    <style type="text/css">
        .tip-norole
        {
            font-size: 11px;
            padding: 2px 0 2px 25px;
            background: url(/Images/icon-box.png) no-repeat 2px center;
            border-bottom: 1px dashed #c3c3c3;
        }
        .tip-norole span b
        {
            color: #e4393c;
        }
    </style>
    <script type="text/javascript">

        function initzTreeData(data) {
            $("#hiduserid").val(data.id);
            var zTreeNodes;
            $.ajax({
                type: 'post', async: false,
                url: '<%=Url.RouteUrl(new { controller="User",action="GetModuleListzTree" ,area="WUCSM"}) %>',
                data: { userid: data.id, usertyp: data.usertyp },
                success: function (infoData) {
                    zTreeNodes = infoData;
                },
                error: function (msg) {
                }
            });

            $.fn.zTree.init($("#zTreePanel"), zTreeSet, zTreeNodes);

            var allmenu = getCheckedMenu();
            if (allmenu == null || allmenu == undefined || allmenu.length <= 0) {
                $("#tipNoRole").html('<b>选择用户【' + data.userlogid + '】</br>无任何操作权限，可选择下面菜单为其授权</b>');
            } else {
                $("#tipNoRole").html('<b>选择用户【' + data.userlogid + '】</b>');
            }
        }
        //zTree默认参数配置
        var zTreeSet = {
            view: {
                fontCss: zTreeGetFont,
                nameIsHTML: true,
                dblClickExpand: false,
                showLine: true,
                expandSpeed: "fast"//"slow", "normal", "fast", ""
            },
            check: {
                enable: true
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onClick: zTreeClick
            }
        };
        function zTreeGetFont(treeId, node) {
            return node.font ? node.font : {};
        }
        function zTreeClick(e, treeId, treeNode) {
            //点击文字行展开或者关闭
            var zTree = $.fn.zTree.getZTreeObj("zTreePanel");
            zTree.expandNode(treeNode);
        }


        //得到当前所有勾选的菜单（若没有勾选，则返回null）
        function getCheckedMenu() {
            var zTree = $.fn.zTree.getZTreeObj("zTreePanel");
            var nodes = zTree.getCheckedNodes(true);
            var checkedId = [];
            var count = 0; //此处目的过滤掉值为0的节点（即总节点）
            for (var i = 0; i < nodes.length; i++) {
                if (nodes[i].id != "0" && nodes[i].id.indexOf("|") >= 0) {
                    checkedId[count] = nodes[i].id;
                    count++;
                }
            }
            return checkedId.join(',');
        }

        function SaveSvc() {
            var userid = $("#hiduserid").val();
            var treeObj = $.fn.zTree.getZTreeObj("zTreePanel");
            var nodes = treeObj.getCheckedNodes(true);
            if (nodes == null || nodes == undefined || nodes.length <= 0) {
                if (confirm("未选择任何操作权限，确认保存？")) {
                    $.ajax({
                        url: '<%=Url.RouteUrl(new { controller="User",action="SaveSvcTree" ,area="WUCSM"}) %>',
                        data: { "userid": userid, "diytreeid": getCheckedMenu() },
                        dataType: 'json',
                        async: false,
                        success: function (res) {
                            if (res.msg == "OK") {
                                mini.alert("保存成功!");
                                //                                winClose();
                            }
                            else {
                                mini.alert(res.msg);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //                        alert(jqXHR.responseText);
                        }
                    });
                }
            } else {
                $.ajax({
                    url: '<%=Url.RouteUrl(new { controller="User",action="SaveSvcTree" ,area="WUCSM"}) %>',
                    data: { "userid": userid, "diytreeid": getCheckedMenu() },
                    dataType: 'json',
                    async: false,
                    success: function (res) {
                        if (res.msg == "OK") {
                            mini.alert("保存成功!");
                            //                            winClose();
                        } else {
                            mini.alert(res.msg);
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //                        alert(jqXHR.responseText);
                    }
                });
            }
        }


        function winClose() {
            window.CloseOwnerWindow();
        }
    </script>
</head>
<body style="background-color: #ffffff;">
    <input id="hiduserid" name="hiduserid" type="hidden" />
    <div style=" padding: 2px 0 2px 25px;border-bottom: 1px dashed #c3c3c3;">
        <a class="mini-button" iconcls="icon-save" style="background-color: #f5f5f5;" plain="false"
            onclick="SaveSvc()">保存</a>
        <%-- <a class="mini-button" iconcls="icon-undo" style="background-color: #f5f5f5;" plain="false" onclick="initdata()">重置</a>--%>
        <a class="mini-button" iconcls="icon-close" style="background-color: #f5f5f5;" plain="false"
            onclick="winClose()">关闭</a>
    </div>
    <div class="tip-norole">
        所选角色：<span id="tipNoRole">暂无选择</span>
    </div>
    <div style="text-align: center">
        <ul id="zTreePanel" class="ztree" />
    </div>
</body>
</html>
