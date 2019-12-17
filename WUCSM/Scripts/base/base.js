function onSkinChange(skin) {
    mini.Cookie.set('miniuiSkin', skin, 100); //100天过期的话，可以保持皮肤切换
    window.location.reload()
}
window.onload = function () {
    var skin = mini.Cookie.get("miniuiSkin");
    if (skin != 'bootstrap') onSkinChange('bootstrap');
    if (skin) {
        var selectSkin = document.getElementById("selectSkin");
        if (selectSkin)
            selectSkin.value = skin;
    }
}
function RequestAjax(url, loadmsg, jsondata, callback, failurecallback) {
    $.ajax({
        type: "POST", url: url, data: jsondata, dataType: 'json',
        beforeSend: function () {
            if (!loadmsg) loadmsg = '正在处理中…';
            mini.mask({ el: document.body, cls: 'mini-mask-loading', html: loadmsg });
        },
        success: function (res) {
            mini.unmask(document.body);
            if (res.mes && res.mes != "")
                mini.showMessageBox({ title: "提示", iconCls: "mini-messagebox-info", buttons: ["ok"], message: res.mes });
            if (res.msg == "OK") {
                if (callback) callback(res);
                if (!res.cancel && res.url && res.url != "")
                    window.location = res.url;
            }
            else {
                if (res.url != "")
                    mini.showMessageBox({ title: "错误", iconCls: "mini-messagebox-error", buttons: ["ok"], message: res.msg, callback: function (action) { window.location = res.url; } });
                else
                    mini.showMessageBox({ title: "错误", iconCls: "mini-messagebox-error", buttons: ["ok"], message: res.msg });
                if (failurecallback) failurecallback(res);
            }
        },
        error: function (msg) {
            mini.unmask(document.body);
            mini.showMessageBox({ title: "错误", iconCls: "mini-messagebox-error", buttons: ["ok"], message: "数据请求地址" + url + "失败，请检查！" });
            if (failurecallback) failurecallback(msg);
        }
    });
}