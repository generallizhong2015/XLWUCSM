/*
弹出窗口标准模板：弹出选择面板
注意，只需要修改搜索框和mini.DataGrid相关的列配置信息即可。
*/

UserSelectWindow = function () {
    UserSelectWindow.superclass.constructor.call(this);
    this.initControls();
    this.initEvents();
}
mini.extend(UserSelectWindow, mini.Window, {

    url: "",
    keyField: "key",
    multiSelect: true,
    title: "选择客户",
    keyLable: "名称：",
    searchLable: "查询：",
    params: {},
    width: 580,
    height: 350,
    bodyStyle: "padding:0;",
    allowResize: true,
    showModal: true,
    showToolbar: true,
    showFooter: true,
    initControls: function () {
        var toolbarEl = this.getToolbarEl();
        var footerEl = this.getFooterEl();
        var bodyEl = this.getBodyEl();

        //toolbar
        var labelId = this.id + "$label";
        var topHtml =
            '<div style="padding:5px;text-align:left;">'
                + '<span id="' + labelId + '">' + this.keyLable + '</span>'
                + '<input name="keyText" class="mini-textbox" style="width:160px;"/> '
                + '<a name="searchBtn" class="mini-button">查找</a>'
                 + '<span style="display:inline-block;width:280px;"></span>'
                + '<a name="okBtn" class="mini-button" style="width:60px;">保存</a>'
                 + '<span style="display:inline-block;width:20px;"></span>'
                  + '<a name="cancelBtn" class="mini-button" style="width:60px;">关闭</a>'
            + '</div>';
        jQuery(toolbarEl).append(topHtml);

        //body        
        this.grid = new mini.DataGrid();
        this.grid.set({
            multiSelect: true,
            sizeList: [20, 50, 100],
            pageSize:20,
            style: "width: 100%;height: 100%;",
            borderStyle: "border:0",
            columns: [
                { type: "checkcolumn", header: "" },
                { header: "客户帐号", field: "CUSID", width: "70px" },
                { header: "客户名称", field: "CUSNAME", width: "200px" },
                { header: "联系人", field: "LNKR", width: "60px" },
                { header: "联系电话", field: "TEL", width: "80px" },
                { header: "服务截止日", field: "DISDATE", width: "80px", format: 'yyyy-MM-dd' }
            ]
        });
        this.grid.setUrl(this.url);
        this.grid.render(bodyEl);

        //组件对象
        mini.parse(this.el);
        this._okBtn = mini.getbyName("okBtn", this);
        this._cancelBtn = mini.getbyName("cancelBtn", this);
        this._searchBtn = mini.getbyName("searchBtn", this);
        this._keyText = mini.getbyName("keyText", this);
    },
    initEvents: function () {
        this._searchBtn.on("click", function (e) {
            var key = this._keyText.getValue();
            this.search(key);
        }, this);
        this._keyText.on("enter", function (e) {
            var key = this._keyText.getValue();
            this.search(key);
        }, this);

        /////////////////////////////////////
        this._okBtn.on("click", function (e) {
            var ret = true;
            if (this._Callback) ret = this._Callback('ok');
            if (ret !== false) {
                this.hide();
            }
        }, this);
        this._cancelBtn.on("click", function (e) {
            var ret = true;
            if (this._Callback) ret = this._Callback('cancel');
            if (ret !== false) {
                this.hide();
            }
        }, this);
        this.on("beforebuttonclick", function (e) {
            if (e.name == "close") {
                e.cancel = true;
                var ret = true;
                if (this._Callback) ret = this._Callback('close');
                if (ret !== false) {
                    this.hide();
                }
            }
        }, this);
    },
    setKeyLable: function (value) {
        var labelId = this.id + "$label";
        var label = document.getElementById(label);
        if (label) {
            label.innerHTML = value;
            this.keyLable = value;
        }
    },
    setSearchLable: function (value) {
        this._searchBtn.setText(value);
    },
    setUrl: function (value) {
        this.url = value;
        this.grid.setUrl(value);
    },
    setKeyField: function (value) {
        this.keyField = value;
    },
    setMultiSelect: function (value) {
        this.multiSelect = value;
        this.grid.setMultiSelect(value);
    },
    search: function (key) {
        var args = this.params;
        args[this.keyField] = key;
        this.grid.load(args);
    },
    setData: function (data, callback) {
        this._Callback = callback;
    },
    getData: function () {
        var row;
        if (this.grid.multiSelect) {
            row = this.grid.getSelecteds();
        }
        else
            row = this.grid.getSelected();
        return row;
    }
});
mini.regClass(UserSelectWindow, "userselectwindow");