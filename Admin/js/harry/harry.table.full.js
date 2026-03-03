/*-------  生成数据表格  --------
| author : harry                |
| date   : 2005-12-11           |
| version: 1.15                 |
-------------------------------*/
/*
问题：
？1、查询、重置按钮事件无效；
？2、批量操作、其他功能太小，二级菜单最好添加mouseover背景；
？3、表格的无数据区域怎么处理；
--4、self.table.body生成时对象赋值错误；
--5、排序，翻页等动态事件无效；
？6、提示信息没有正常显示；
？7、当前页点击时要取消向后台的数据请求
*/
/*菜单属性*/
function MenuInfo(obj, index, title, url)
{
    this.obj = self || null;    /*自身引用*/
    this.index = index || "";   /*排序*/
    this.title = title || "无"; /*标题*/
    this.url = url || "";       /*链接地址*/
};
/*查询条件属性*/
function SearchInfo(obj, index, type, title, id, name, width, html)
{
    this.obj = self || null;        /*自身引用*/
    this.index = index || "";       /*排序*/
    this.type = type || "text";     /*内容、控件类型*/
    this.title = title || "";       /*标题*/
    this.id = id || "";             /*id，对应字段名*/
    this.name = name || "";         /*name，对应查询方式（=、>、<、like）*/
    this.width = width || "120px";  /*宽度(带单位)*/
    this.html = html || "";         /*html代码*/
};
/*表格列属性*/
function ColumnInfo(obj, index, title, width, align, sort, field, order)
{
    this.obj = self || null;        /*自身引用*/  
    this.index = index || "";       /*排序*/
    this.title = title || "&nbsp;"; /*标题*/
    this.width = width || "";       /*宽度(带单位)*/
    this.align = align || "left";   /*文本对齐格式*/
    this.sort = sort || false;      /*是否排序*/
    this.field = field || "";       /*字段名称*/
};
/*封闭方法回调*/
function uploadTableList()
{
    $("#btn_call_table_update").click();
}
function Table()
{
    var self = this;    /*自身引用*/
    this.title = "";    /*标题*/
    this.requestURL = "/Admin/ajax/full.ashx"   /*访问地址*/
    this.table =        /*表格引用集合*/
    {
        obj: null,      /*自身*/
        panel: null,    /*表格容器*/
        title: null,    /*标题*/
        body: null,     /*数据体*/
        tooltip: null,  /*提示*/
        checkAll: null, /*多选框*/
        msg: null,      /*翻页信息*/
        pageIndex: null, /*页码*/
        goPage: null    /*跳转*/
    };
    this.state =
    {
        batchs: false,  /*是否批量操作*/
        opers: false,   /*是否表内操作*/
        order: false    /*是否多列排序*/
    };
    this.array =        /*集合*/
    {
        batchs: [],     /*批量操作集合*/
        menus: [],      /*下拉菜单集合*/
        searchs: [],    /*检索条件集合*/
        columns: [],    /*标题集合*/
        opers: []       /*操作菜单集合*/
    };
    /*分页属性*/
    this.pager =
    {
        tname: "",  /*表名*/
        fields: [], /*字段集合*/
        where: [],  /*查询集合*/
        columns: "t1.id", /*总排序列*/
        order: "",  /*当前排序列*/

        style: 0,   /*排序方式*/
        index: 1,   /*当前页码*/
        size: 10,   /*每页显示行数*/
        record: 0,  /*结果数*/
        count: 1,   /*总页数*/

        distinct: 15, /*每页显示行数*/
        primarykey: "t1.id", /*编号集合*/
        rownumber: 1, /*总页数*/

        operType: "", /*附加的操作类型*/
        ids: "",    /*编号集合*/
        value1: "", /*修改状态时记录*/
        value2: "", /*页面搜索条件*/
        value3: "", /*附加值3*/

        index1: 0,  /*上一排序列位置*/
        index2: 0,  /*当前排序列位置*/
        tags: [],   /*当前排序列位置*/

        auto: true  /*是否自动附加管理员匹配与默认列*/
    };
    /*添加查询条件*/
    this.addSearch = function (type, title, id, name, width, html) { self.array.searchs.push(new SearchInfo(null, self.array.searchs.length, type, title, id, name, width, html)); };
    /*添加列*/
    this.addColumn = function (width, field, title, align, sort) { self.array.columns.push(new ColumnInfo(null, self.array.columns.length, (self.array.columns.length - 0 + 1) + ". " + title, width || "100px", align || "left", sort || false, field)); };
    /*发送ajax请求*/
    this.startHttp = function ()
    {
        if (self.requestURL == "") { self.setToolTip("无效的访问地址", true); return; }
        /*获取查询*/
        var temp_where = [];
        for (var sl = self.array.searchs.length, i = 0; i < sl; i++)
        {
            var s = self.array.searchs[i];
            if (s.type == "time" || (s.obj[0] && $(s.obj[0]).val() != ""))
            {
                switch (s.type)
                {
                    case "text": { temp_where.push(s.id.replace("_", ".") + " " + s.name.replace("》=", ">=").replace("《=", "<=") + " '" + (s.name == "like" ? "%" : "") + "" + $(s.obj[0]).val() + "" + (s.name == "like" ? "%" : "") + "'"); break; }
                    case "time": { if ($(s.obj[0]).val()) { temp_where.push(s.id.replace("_", ".") + ">='" + $(s.obj[0]).val() + "'"); } if ($(s.obj[1]).val()) { temp_where.push(s.id.replace("_", ".") + "<='" + $(s.obj[1]).val() + "'"); } break; }
                    case "select": { temp_where.push(s.id.replace("_", ".") + " " + s.name.replace("》=", ">=").replace("《=", "<=") + " '" + (s.name == "like" ? "%" : "") + "" + $(s.obj[0]).val() + "" + (s.name == "like" ? "%" : "") + "'"); break; }
                    case "dropdown": { temp_where.push(s.id.replace("_", ".") + " " + s.name.replace("》=", ">=").replace("《=", "<=") + " '" + (s.name == "like" ? "%" : "") + "" + $(s.obj[1]).val() + "" + (s.name == "like" ? "%" : "") + "'"); break; }
                }
            }
        }
        self.pager.where = self.pager.value2 + (self.pager.value2 != "" && temp_where.length > 0 ? " and " : "") + temp_where.join(" and ");
        $.ajax({
            type: "POST",
            url: self.requestURL,
            data: self.pager,
            success: function (r)
            {
                if (self.state.batchs) { self.table.checkAll.attr("checked", false); }
                if (r == "") { self.setToolTip("数据错误", true); return; }
                self.updateTable(r.split("$$"));
            }
        });
    };
    /*模板列*/
    this.template_tr = function (newRow, cells) { var columns = self.array.columns; for (var i = 0; i < columns.length; i++) { newRow.append($("<td style='text-align:" + columns[i].align + "'>" + (cells[i + 1] != null && cells[i + 1] != "" ? cells[i + 1] : "&nbsp") + "</td>")); } return newRow; };
    /*添加数据*/
    this.updateTable = function (r)
    {
        self.table.body.empty();
        /*加载页面信息*/
        var pager = eval("(" + r[0] + ")");
        if (pager.length == 0) { self.setToolTip("无效的分页信息", true); return; }
        else
        {
            /*设置分页信息*/
            self.pager.record = pager[0].record;
            self.pager.count = pager[0].count;
            //self.pager.columns = pager[0].columns;
            //self.table.message.html(self.pager.record + "&nbsp结果&nbsp&nbsp|<b>&nbsp&nbsp页码：</b>&nbsp<div>" + (self.pager.index > self.pager.count ? self.pager.count : self.pager.index) + "</div><p>/</p>" + self.pager.count + "&nbsp&nbsp&nbsp 每页 ");
            self.table.message.html(self.pager.record + " 结果&nbsp;&nbsp;&nbsp;&nbsp;页码：" + (self.pager.index > self.pager.count ? self.pager.count : self.pager.index) + "/" + self.pager.count);
            /*设置排序状态*/
            var seat = self.state.batchs ? 1 : 0, childs = self.table.title.find("th");
            if (!self.state.order)
            {
                $(childs[self.pager.index1 - -seat]).children("img").attr("src", "/Admin/img/arrows.png");
                $(childs[self.pager.index2 - -seat]).children("img").attr("src", "/Admin/img/arrows" + self.pager.style + ".png");
                self.pager.index1 = self.pager.index2;
            }
            else
            {
                //alert("多字段排序啦！");
                var columns = self.pager.columns;
                for (var sl = self.array.columns.length, i = 0; i < sl; i++)
                {
                    //当前对象
                    var col = self.array.columns[i];
                    //当前列
                    var cell = $(childs[i - -seat]);
                    if (columns.indexOf(col.field + " asc") > -1) { cell.children("div").attr("className", "tableStyleHead dataOrder1"); }
                    else if (columns.indexOf(col.field + " desc") > -1) { cell.children("div").attr("className", "tableStyleHead dataOrder0"); }
                    else { cell.children("div").attr("className", "tableStyleHead"); }
                }
                self.pager.index1 = self.pager.index2;
            }
        }
        /*加载数据*/
        var list = eval("(" + r[1] + ")");
        if (list.length == 0) { self.setToolTip("没有搜索到需要的结果", true); return; }
        else
        {
            self.setToolTip("正在加载数据...", true);
            /*初始化返回字段信息*/
            if (self.pager.tags.length == 0) { jQuery.each(list[0], function (k, val) { self.pager.tags.push(k); }); }
            /*加载数据*/
            for (var i = 0; i < list.length; i++)
            {
                /*分割数据为数组*/
                var cells = []; for (var j = 0; j < self.pager.tags.length; j++) { cells[j] = list[i][self.pager.tags[j]]; }
                /*生成row*/
                var newRow = self.template_tr($("<tr></tr>"), cells); /* class='" + (i % 2 != 0 ? "tableColor" : "") + "'*/
                /*单选框*/
                if (self.state.batchs)
                {
                    newRow.prepend($("<td><input id='" + cells[1] + "' name='chks' type='checkbox' class='form-checkbox'/></td>"));
                    newRow.find("input:checkbox").click(function () { self.setCheckbox(this); });
                }
                /*操作栏*/
                if (self.state.opers)
                {
                    newRow.append(self.getOperatesHtml(cells[1]));
                }
                self.table.body.append(newRow);
            }
            /*行双击事件：被选中*/
            self.table.body.find("tr").dblclick(function () { $(this).find("input[type='checkbox']")[0].click(); });
        }
        self.setToolTip("", false);
    };
    /*页面跳转
    */
    this.page_go = function (index) { if (index && index != self.pager.index) { self.pager.index = index; } self.startHttp(); };
    this.page_pre = function () { if (self.pager.index > 1) { self.page_go(--self.pager.index); } };
    this.page_next = function () { if (self.pager.index != self.pager.count) { self.page_go(++self.pager.index); } };
    this.page_last = function () { if (self.pager.count != 1 && self.pager.count != self.pager.index) { self.page_go(self.pager.count); } };
    /*----- 页面操作 -----------*/
    /*排序*/
    this.ajax_sort = function (index)
    {
        self.pager.order = self.array.columns[index].field;
        if (!self.state.order)
        {
            //当前列排序颠倒，其他列默认第一次点击为倒序
            self.pager.style = self.pager.index1 == index ? (self.pager.style == 1 ? 0 : 1) : 0;
            self.pager.index2 = index;
            self.pager.columns = self.pager.order + (self.pager.style == 0 ? " desc" : " asc");
        }
        else
        {
            //当前列排序颠倒
            self.pager.style = self.array.columns[index].sort = self.array.columns[index].sort == 1 ? 0 : 1;
            self.pager.columns = self.pager.columns.replace(self.pager.order + (self.pager.style == 0 ? " asc" : " desc"), self.pager.order + (self.pager.style == 0 ? " desc" : " asc"));
        }
        self.page_go();
    };
    /*删除信息*/
    this.ajax_del = function (ids)
    {
        if (ids && ids != "" && window.confirm("确认要删除这 < " + ((ids + "").indexOf(",") > -1 ? ids.split(",").length : 1) + " > 条信息？"))
        {
            self.pager.operType = "ajax_del";
            self.pager.ids = ids;
            self.startHttp();
        }
    };
    /*批量删除*/
    this.ajax_dels = function ()
    {
        self.ajax_del(self.getCheckbox());
    };
    /*更改状态*/
    this.ajax_used = function (ids, state)
    {
        if (ids && ids != "" && window.confirm("确认要修改这 < " + ((ids + "").indexOf(",") > -1 ? ids.split(",").length : 1) + " > 条信息的使用状态？"))
        {
            self.pager.operType = "ajax_used";
            self.pager.ids = ids;
            self.pager.value1 = state;
            self.startHttp();
        }
    };
    /*批量更改*/
    this.ajax_useds = function (ids, state)
    {
        self.ajax_used(ids || self.getCheckbox(), state);
    };
    /*审核*/
    this.ajax_audit = function (ids, state)
    {
        if (ids && ids != "" && window.confirm("确认要修改这 < " + ((ids + "").indexOf(",") > -1 ? ids.split(",").length : 1) + " > 条信息的审核状态？"))
        {
            self.addParam("state", state) && self.addParam("ids", ids) && self.startHttp("ajax_audit");
        }
    };
    /*批量审核*/
    this.ajax_audits = function (ids, state)
    {
        self.ajax_audit(ids || self.getCheckbox(), state);
    };
    /*checkbox操作
    */
    this.getCheckbox = function ()
    {
        var ids = [];
        self.table.body.find("input").each(function () { if ($(this).is(':checked')) { ids.push($(this).attr("id")); } });
        return ids.join(",");
    };
    this.setCheckbox = function (target)
    {
        if (target.name == "") { self.table.body.find("input").attr("checked", target.checked); }
        else
        {
            var _checkboxs = self.table.body.find("input:checkbox[name='chks']:checked");
            var _check = target.checked ? true : (_checkboxs.length == 0 ? false : true);
            self.table.checkAll.attr("checked", _check);
        }
        target.blur();
    };
    /*设置提示信息*/
    this.setToolTip = function (content, display) { self.table.tooltip.html("<img src='/Admin/img/table/loading1.gif' style='margin-top:2px;margin-left:-10px;position:absolute' />&nbsp&nbsp&nbsp" + content); self.table.tooltip.css("display", (display = display ? "block" : "none")); };
    /*得到表格内操作内容的html*/
    this.getOperatesHtml = function (id)
    {
        if (self.array.opers.length == 0) { return; }
        var _menus = "," + self.array.opers.join(",") + ",";
        var _td = $("<td style='text-align:center;overflow:visible'></td>");
        if (_menus.indexOf(",删除,") > -1)
        {
            _td.append($("<a>[ 删除 ]</a>").click(function () { self.ajax_del(id); }));
        }
        return _td;
    };

    /*信息修改
    */
    this.getEditHtml = function (newCell, id, sole, value, url, title, width, height) { return $("<td style='cursor:pointer;color:green' title='" + (title || "点击编辑信息") + "'> [ " + value + " ] </td>").click(function () { top.openWindows(window, url, title, width, height); }); };
    /*信息删除
    */
    this.getDeleteHtml = function (newCell, id, sole, value)
    {
        newCell.style.cursor = "pointer";
        newCell.style.textAlign = "center";
        newCell.onclick = function () { t1.ajax_del(id); }
        newCell.innerHTML = " [ <a title='点击删除信息'>&nbsp;删除&nbsp</a> ] ";
        return newCell;
    };
    /*设置状态
    */
    this.getUsedHtml = function (newCell, id, sole, value)
    {
        return $("<td class='condition' style='padding:5px;cursor:pointer'><img src='/Admin/img/" + (value == "0" ? "off" : "on") + ".png'></td>").click(function () { self.ajax_used(id, (this.firstChild.src.indexOf("on") > -1 ? "0" : "1")); });
    };
    /*设置审核
    */
    this.getAuditHtml = function (newCell, id, sole, value)
    {
        var r = value == "0";
        newCell = $("<td style='cursor:pointer;text-align:center'><a style='color:" + (value == "0" ? "red'> [ &nbsp;审核未通过&nbsp" : "green'> [ &nbsp;审核通过&nbsp") + " ] </a></td>");
        newCell.click(function () { self.ajax_audit(id, (this.innerText.indexOf("未通过") > -1 ? "1" : "0")); });
        return newCell;
    };

    /*初始化
    */
    this.init = function ()
    {
        document.body.onselectstart = function () { return false; } /*禁止左键拖选*/
        document.body.oncontextmenu = function () { return false; } /*禁止右键菜单*/
        self.state.batchs = self.array.batchs.length > 0; /*批量操作*/
        self.state.opers = self.array.opers.length > 0; /*其他功能*/
        setField(); /*清理column.field属性，设置pager.fields属性*/
        setOrder(); /*设置排序信息*/
        /*创建标题*/
        $(document.body).append(self.title);
        /*创建查询、表格*/
        $(document.body).append($("<div class='container-fluid'></div>").append($("<div class='card'></div>").append(createSearch()).append(createTable())));
        /*创建外调接口*/
        $(document.body).append(createCall()).html();
        /*下拉菜单动效*/
        if (".dropdown")
        {
            $(".dropdown").mouseenter(function () { $(this).find("ul").stop().css("display", "block") });
            $(".dropdown").mouseleave(function () { $(this).find("ul").stop().css("display", "none") });

        }
        /*提示信息区域：宽度为整体宽度*/
        self.table.tooltip.css("width", self.table.title.width());
        /*键盘操作*/
        window.focus();
        document.onkeydown = function (evt)
        {
            if (event.keyCode == "13") { self.page_go(1); return; } /*enter*/
            if (event.keyCode == "27") { top.closeWindows(); return; } /*esc*/
            if (event.keyCode == "37") { self.page_pre(); return; } /*上一页*/
            if (event.keyCode == "39") { self.page_next(); return; } /*下一页*/
            if (event.keyCode == "65") { self.table.checkAll.click(); self.setCheckbox(self.table.checkAll[0]); return; } /*全选*/
            if (event.keyCode == "68") { self.ajax_dels(); return; } /*删除*/
            //if (event.keyCode == "85") { } /*使用状态*/
        };
        /*检测*/
        var result = self.check(); if (result && result != "") { alert(result); return; }
        /*第一次请求数据*/
        self.page_go(1);
    };
    /*检测
    */
    this.check = function ()
    {
        if (self.pager.fields == "") { return "[ self.pager.fields ] 不能为空"; }
        if (self.pager.columns == "") { return "[ self.pager.columns ] 不能为空"; }
        if (self.pager.order == "") { return "[ self.pager.order ] 不能为空"; }
        if (self.pager.style == "") { return "[ self.pager.style ] 不能为空"; }
    };
    /*清理自定义列column.field（列名称）属性，设置pager.fields（请求字段集合）属性
    */
    var setField = function ()
    {
        for (var l = self.array.columns.length, i = 0; i < l; i++)
        {
            var column = self.array.columns[i], field = column.field.replace("=", " as ").replace("  ", " ");
            /*设置列名称*/
            column.field = field.split(" ")[0];
            /*设置请求字段*/
            self.pager.fields.push(field);
        }
        self.pager.fields = self.pager.fields.join(",");
    };
    /*单、多字段排序时设置pager.order、pager.style、pager.index1、pager.columns属性
    */
    var setOrder = function ()
    {
        /*单字段排序*/
        if (!self.state.order)
        {
            /*未指定排序列*/
            if (self.pager.order == "")
            {
                for (var l = self.array.columns.length, i = 0; i < l; i++)
                {
                    var column = self.array.columns[i], c_order = column.sort + "";
                    /*取第一个排序列*/
                    if (c_order == "0" || c_order == "1")
                    {
                        self.pager.order = column.field;
                        self.pager.style = c_order;
                        self.pager.index1 = self.pager.index2 = i;
                        self.pager.columns = self.pager.order + (c_order == "0" ? " desc" : " asc");
                        break;
                    }
                }
            }
        }
        //多字段排序
        else
        {
            var sort = []; /*排序列集合*/
            for (var l = self.array.columns.length, i = 0; i < l; i++)
            {
                var column = self.array.columns[i], c_order = column.sort + "";
                if (c_order == "0" || c_order == "1")
                {
                    /*叠加排序列*/
                    sort.push(column.field + (c_order == "0" ? " desc" : " asc"));
                    /*未指定排序列时*/
                    if (self.pager.order == "")
                    {
                        self.pager.order = column.field;
                        self.pager.style = c_order;
                        self.pager.index1 = self.pager.index2 = i;
                        /*self.pager.columns = self.pager.order + (c_order == "0" ? " desc" : " asc");*/
                    }
                }
            }
            self.pager.columns = sort.join(",");
        }
    };

    /*创建标题
    var createHead = function ()
    {
    if (!self.title || self.title == "") { alert("error:无效的标题信息"); return; }
    var ol = $("<ol class='breadcrumb'></ol>").append("<span>位置：</span>"), titles = self.title.split("-");
    for (var i = 0; i < titles.length; i++)
    {
    ol.append("<li " + (i == (titles.length - 1) ? " class='active'" : "") + "><a>" + titles[i] + "</a></li>");
    }
    return $("<div class='breadcrumb-box'></div>").append(ol);
    };*/

    /*创建查询
    */
    var createSearch = function ()
    {
        var div_head = $("<div class='card-header card-header-lg'></div>"), div_head_top = $("<div class='form-top'></div>");
        /*查询*/
        if (self.array.searchs.length >= 0)
        {
            for (var l = self.array.searchs.length, i = 0; i < l; i++)
            {
                var search = self.array.searchs[i], type = search.type, search_div = null;
                switch (type)
                {
                    /*case "html": { search_div = $("<div class='input-inline'>" + search.html + "</div>"); break; }*/ 
                    case "text": { search_div = $("<div class='input-inline'><input type='text' id='" + search.id + "' name='" + search.name + "' style='width:" + search.width + "' class='form-input searchs' maxlength='15' placeholder='" + search.title + "' autocomplete='off'/></div>"); break; }
                    case "time": { search_div = $("<div class='input-inline form-date'><i class='fa fa-calendar'></i><input type='text' id='" + search.id + "' onclick='WdatePicker()' style='width:" + search.width + "' class='form-input searchs' readonly='readonly' placeholder='开始时间' autocomplete='off'></div><div class='form-mid'>-</div><div class='input-inline form-date'><i class='fa fa-calendar'></i><input type='text' id='" + search.id + "' onclick='WdatePicker()' style='width:" + search.width + "' class='form-input searchs' readonly='readonly' placeholder='结束时间' autocomplete='off'></div>"); break; }
                    case "select": { search_div = $("<div class='input-inline'>" + search.html + "<select id='" + search.id + "' name=\"" + search.name + "\" style='width:" + search.width + "' class='form-select searchs' placeholder='" + search.title + "'>" + (search.title == "使用状态" ? "<option value=''>全部</option><option value='1'>正常</option><option value='0'>禁用</option>" : search.html) + "</select></div>"); break; }
                    case "dropdown": { search_div = $("<div class='input-inline'><input type='text' id='" + search.id + "1' name='" + search.name + "' style='width:" + search.width + "' class='form-input searchs' maxlength='15' readonly='readonly' placeholder='" + search.title + "' autocomplete='off'/><input id='" + search.id + "' class='searchs' type='hidden' /></div>"); break; }
                }
                div_head_top.append($("<div class='form-inline'></div>").append("<label class='form-label'>" + search.title + "</label>").append(search_div));
                search.obj = search_div.find(".searchs"); /*查询内容的控件集合*/
            }
            /*按钮*/
            div_head_top.append($("<div class='form-inline'></div>").append($("<div class='input-inline'></div>").append($("<button type='button' style='margin-left:0' class='btn btn-primary'>提交</button>").click(function () { self.page_go(1); })).append($("<button type='reset' class='btn btn-default'>刷新</button>").click(function () { document.form_table_reset.reset(); self.page_go(); }))));
        }

        /*批量操作、菜单*/
        var b = self.state.batchs, m = self.array.menus.length > 0;
        if (b || m)
        {
            var div_inline = $("<div class='input-inline'></div>");
            var batchs = self.array.batchs, menus = self.array.menus;
            if (b)/*批量操作*/
            {
                var div_dropdown = $("<div class='btn btn-default dropdown'></div>"), ul_menu = $("<ul class='dropdown-menu'></ul>");
                for (var l = batchs.length, i = 0; i < l; i++)
                {
                    var type = batchs[i], li = null;
                    switch (type)
                    {
                        case "-": { li = $("<div class='nav-divider'></div>"); break; }
                        case "启用": { li = $("<li><a><i class='fa fa-caret-right'></i>&nbsp;&nbsp;启用</a></li>").click(function () { self.ajax_useds(null, "1"); }); break; }
                        case "禁用": { li = $("<li><a><i class='fa fa-caret-right'></i>&nbsp;&nbsp;禁用</a></li>").click(function () { self.ajax_useds(null, "0"); }); break; }
                        case "删除": { li = $("<li><a><i class='fa fa-caret-right'></i>&nbsp;&nbsp;删除</a></li>").click(function () { self.ajax_dels(null, "0"); }); break; }
                    }
                    ul_menu.append(li);
                }
                div_inline.append(div_dropdown.append("<i class='fa fa-navicon'></i>  批量操作").append(ul_menu));
            }
            if (m)/*菜单*/
            {
                div_inline.append($("<div class='btn btn-default dropdown'></div>").append("<i class='fa fa-cube'></i>  其他功能").append($("<ul id='operMenus' class='dropdown-menu'></ul>").html(self.array.menus)));
            }
            div_head_top.append($("<div class='form-inline right'></div>").append(div_inline));
        }
        return div_head.append($("<form name='form_table_reset'></form>").append(div_head_top));
    };
    /*创建表格
    */
    var createTable = function ()
    {
        var height = (self.pager.size - -1) * 38 - 5;
        self.table.panel = $("<div class='table-box'>").css("height", height); /*表格容器，设置高度*/
        self.table.obj = $("<table class='table table-striped table-hover table-bordered'></table>"); /*表格*/
        /*---- 标题区域 ----*/
        self.table.title = $("<thead><tr></tr></thead>");
        var tr_title = self.table.title.children().eq(0); /*标题tr*/
        /*多选框*/
        if (self.state.batchs)
        {
            tr_title.append($("<th></th>").append(self.table.checkAll = $("<input type='checkbox' class='form-checkbox' />").click(function () { self.setCheckbox(this); })));
        }
        /*数据列*/
        for (var columns = self.array.columns, i = 0; i < columns.length; i++)
        {
            var th_title = $("<th width='" + columns[i].width + "'>" + columns[i].title + "&nbsp;</th>");
            if (columns[i].sort)
            {
                th_title.css("cursor", "pointer");
                th_title.append($("<img name='" + i + "' src='/Admin/img/arrows.png'>"));
                th_title.click(function () { self.ajax_sort($(this).children().eq(0).attr("name")); });
            }
            tr_title.append(th_title);
        }
        /*操作列*/
        if (self.state.opers)
        {
            tr_title.append($("<th style='width:" + (self.array.opers.length * 1) + "00px'></th>"));
        }
        self.table.obj.append(self.table.title);
        /*---- 数据区域 ----*/
        self.table.panel.append(self.table.obj.append(self.table.body = $("<tbody></tbody>")));
        /*---- 提示区域 ----*/
        self.table.panel.append(self.table.tooltip = $("<div style='top:58px;height:" + (height - 198) + "px;text-align:center;font-size:14px;background:#ededed;padding-top:150px;position:absolute'></div>"));
        /*---- 分页区域 ----*/
        var div_pager = $("<div class='pagination-box'></div>"), ul_pager = $("<ul class='pagination'>");
        ul_pager.append($("<li>总计 </li>").append(self.table.message = $("<span></span>"))); /*100 结果&nbsp;&nbsp;&nbsp;&nbsp;页码：1/2*/
        //ul_pager.append($("<li>每页&nbsp;</li>").append(self.table.pageIndex = $("<input type='text' value='" + self.pager.size + "' autocomplete='off'/>").change(function () { self.page_go(self.pager.index); })).append(" 条 &nbsp;&nbsp;&nbsp;&nbsp;"));
        ul_pager.append($("<li style='cursor:pointer'><a>首页</a></li>").click(function () { self.page_go(1); }));
        ul_pager.append($("<li style='cursor:pointer'><a>上一页</a></li>").click(function () { self.page_pre(); }));
        ul_pager.append($("<li style='cursor:pointer'><a>下一页</a></li>").click(function () { self.page_next(); }));
        ul_pager.append($("<li style='cursor:pointer'><a>尾页</a></li>").click(function () { self.page_last(); }));
        ul_pager.append($("<li>&nbsp;&nbsp;&nbsp;&nbsp;到第&nbsp;</li>").append(self.table.goPage = $("<input type='text' style='width:30px;text-align:center' class='input1' maxlength='4' autocomplete='off'/>")).append("&nbsp;页&nbsp;&nbsp;"));
        ul_pager.append($("<li></li>").append($("<button type='button' class='btn-primary'>跳转</button>").click(function () { var pn = self.table.goPage.val(); if (pn != "") { self.page_go(pn) } })));
        div_pager.append(ul_pager);
        return $("<div class='card-body'></div>").append(self.table.panel).append(div_pager);
    };

    /*查询方法的外部调用接口
    */
    var createCall = function ()
    {
        return $("<span></span>").append($("<input id='btn_call_table_update' type='button' style='display:none' />").click(function () { self.page_go(); }));
    }
};

/*显示js对象所有属性、方法*/
function showPropertys(obj)
{
    var attributes = "", methods = "", count1 = 0, count2 = 0;
    for (a in obj)
    {
        if (typeof (obj[a]) == "function")
        {
            methods += "M" + (count1++) + "：" + a + ' = ' + obj[a] + "()\r\n";
        }
        else
        {
            attributes += "A" + (count2++) + "：" + a + ' = ' + obj[a] + "\r\n";
        }
    }
    return { "methods": methods, "attributes": attributes }
}
/*计算时间差值（秒）*/
function comptime(start, end)
{
    if (!start || start == "") { return null; }
    return Math.round((Date.parse(end || new Date()) - Date.parse(start)) / 1000);
}