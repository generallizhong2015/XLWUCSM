__CreateJSPath = function (js) {
    var scripts = document.getElementsByTagName("script");
    var path = "";
    for (var i = 0, l = scripts.length; i < l; i++) {
        var src = scripts[i].src;
        if (src.indexOf(js) != -1) {
            var ss = src.split(js);
            path = ss[0];
            break;
        }
    }
    var href = location.href;
    href = href.split("#")[0];
    href = href.split("?")[0];
    var ss = href.split("/");
    ss.length = ss.length - 1;
    href = ss.join("/");
    if (path.indexOf("https:") == -1 && path.indexOf("http:") == -1 && path.indexOf("file:") == -1 && path.indexOf("\/") != 0) {
        path = href + "/" + path;
    }
    return path;
}

var bootPATH = __CreateJSPath("boot.js");

//debugger
mini_debugger = true;

//屏蔽Alert弹出窗
document.write('<script type="text/javascript">window.alert = function () {return;}</sc' + 'ript>');

//base
document.write('<script src="' + bootPATH + 'base/base.js" type="text/javascript"></sc' + 'ript>');
document.write('<link href="' + bootPATH + 'base/base.css" rel="stylesheet" type="text/css" />');

//miniui
document.write('<script src="' + bootPATH + 'jquery.min.js" type="text/javascript"></sc' + 'ript>');
document.write('<script src="' + bootPATH + 'miniui/miniui.js" type="text/javascript" ></sc' + 'ript>');
document.write('<link href="' + bootPATH + 'miniui/themes/default/miniui.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + bootPATH + 'miniui/themes/icons.css" rel="stylesheet" type="text/css" />');

//add
document.write('<script src="' + bootPATH + 'miniui/Portal.js" type="text/javascript"></sc' + 'ript>');
document.write('<link href="' + bootPATH + 'miniui/themes/default/portal.css" rel="stylesheet" type="text/css" />');
document.write('<script src="' + bootPATH + 'base/jquery.darktooltip.min.js" type="text/javascript"></sc' + 'ript>');
document.write('<link href="' + bootPATH + 'base/darktooltip.min.css" rel="stylesheet" type="text/css" />');
document.write('<script src="' + bootPATH + 'base/jquery.raty.js" type="text/javascript"></sc' + 'ript>');

//kindeditor
document.write('<link rel="stylesheet" href="' + bootPATH + 'kindeditor/themes/default/default.css" />');
document.write('<link rel="stylesheet" href="' + bootPATH + 'kindeditor/plugins/code/prettify.css" />');
document.write('<script charset="utf-8" src="' + bootPATH + 'kindeditor/kindeditor.js"></script>');
document.write('<script charset="utf-8" src="' + bootPATH + 'kindeditor/lang/zh_CN.js"></script>');
document.write('<script charset="utf-8" src="' + bootPATH + 'kindeditor/plugins/code/prettify.js"></script>');


//skin
var skin = getCookie("miniuiSkin");
if (skin) {
    document.write('<link href="' + bootPATH + 'miniui/themes/' + skin + '/skin.css" rel="stylesheet" type="text/css" />');
}

//document.write('<link href="' + bootPATH + 'miniui/themes/bootstrap/skin.css" rel="stylesheet" type="text/css" />');



////////////////////////////////////////////////////////////////////////////////////////
function getCookie(sName) {
    var aCookie = document.cookie.split("; ");
    var lastMatch = null;
    for (var i = 0; i < aCookie.length; i++) {
        var aCrumb = aCookie[i].split("=");
        if (sName == aCrumb[0]) {
            lastMatch = aCrumb;
        }
    }
    if (lastMatch) {
        var v = lastMatch[1];
        if (v === undefined) return v;
        return unescape(v);
    }
    return null;
}