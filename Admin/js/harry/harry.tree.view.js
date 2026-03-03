if (!Ajax) { var Ajax = function (r, p, m) { var s = this; var x; this.r = r || location.href.substr(location.href.lastIndexOf("/") + 1); this.p = p || ""; this.m = m || "post"; this.onCom = function () { }; this.start = function (p) { try { if (!x) { if (window.ActiveXObject) { try { x = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { x = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } } else if (window.XMLHttpRequest) { x = new XMLHttpRequest(); if (x.overrideMimeType) { x.overrideMimeType("text/xml"); } } if (!x) { alert("不能创建XMLHttpRequest对象实例"); } } s.p = (p ? p : s.p) + "&" + new Date().getTime(); x.open(s.m, s.r + (s.r.indexOf("?") > -1 ? "&" : "?") + s.p, true); if (s.m.toLowerCase() == "get") { x.send(null); } else if (s.m.toLowerCase() == "post") { x.setRequestHeader('Content-type', 'application/x-www-form-urlencoded'); x.send(s.p); } else { alert("无效的请求方式 [ " + s.m + " ] "); return; } x.onreadystatechange = function () { if (x.readyState == 4 && x.status == 200) { var t = x.responseText; if (t.indexOf("rror") == 1) { alert(t); } else if (t.indexOf("eload") == 1) { alert(t); top.location.assign('../login.aspx'); } else { s.onCom(t); } } }; } catch (e) { } }; } };
/******    树形下拉列表    ******
* author : harry                *
* date   : 2009-04-16           *
* version: 1.2                  *
********************************/
/*
    log:
*/
function TreeControl(tableName)
{
    var self = this;
    this.treeview;
    this.contextMenu;

    this.node_isClick = false;          //是否正在执行点击操作
    this.node_isSelect = false;         //是否正在执行选择操作
    this.maxLev = { add: 10, del: 10, update: 10, show: 10 };
    this.requestUrl = tableName ? "/Admin/ajax/tree.ashx" : location.href.substr(location.href.lastIndexOf("/") + 1);

    /*——— 操作 ——————————————————————————————*/

    /*初始化一个节点对象*/
    this.createNode = function (text, value) { var newNode = new CFlyTreeNode(); newNode.setText(text || ""); newNode.setValue(value || ""); return newNode; };
    //清空节点
    this.clear = function () { self.treeview && window.confirm("确认要清空所有信息？") && self.treeview.clearNodes(); };
    //得到节点全路径
    this.getNodePath = function (targetNode) { targetNode = targetNode || self.getSelected(); var fullName = targetNode.getText().replace(/<\/?.+?>/g, "").trim(); if (targetNode.getParent()) { fullName = self.getNodePath(targetNode.getParent()) + "-" + fullName; } return fullName; };
    //打开节点
    this.open = function (isAll, targetNode) { targetNode = targetNode || self.getSelected(); if (targetNode) { targetNode.expand(); var childNodes = targetNode.getChildNodes(); if (isAll && childNodes.length > 0) { for (var i in childNodes) { self.open(true, childNodes[i]); } } } };
    this.open_parent = function (isAll, targetNode) { targetNode = targetNode || self.getSelected(); if (targetNode && targetNode.getParent()) { targetNode.getParent().expand(); isAll && self.open_parent(isAll, targetNode.getParent()); } };
    //关闭节点
    this.close = function (isAll, targetNode) { targetNode = targetNode || self.getSelected(); if (targetNode) { targetNode.collapse(); var childNodes = targetNode.getChildNodes(); if (isAll && childNodes.length > 0) { for (var i in childNodes) { self.close(true, childNodes[i]); } } } };

    //增加节点
    this.addNode = function (parentNode, newNode, text, value)
    {
        parentNode = parentNode || self.getSelected();
        if (parentNode && parentNode.getLevel() < self.maxLev.add - 1 && window.confirm("确认要为 [ " + parentNode.getText().split(" ")[0] + " ] 增加子节点？"))
        {
            newNode = newNode || self.createNode(text || "新节点", value);
            var a = new Ajax(self.requestUrl);
            a.onCom = function (r)
            {
                if (r != "false")
                {
                    newNode.setValue(r);
                    if (parentNode.getPopulateNodesOnDemand()) { parentNode.expand(); }
                    else
                    {
                        parentNode.addNode(newNode);
                        if (!parentNode.getExpanded()) { parentNode.expand(); }
                    }
                    newNode.select();
                }
            }
            a.start("at=addNode" + (tableName ? "&tb=" + tableName : "") + "&ps=" + parentNode.getValue() + "&name=" + encodeURIComponent(newNode.getText().replace(/<\/?.+?>/g, "").trim()) + "&index=" + parentNode.getChildNodes().length);
        }
    };
    //删除单个节点
    this.remove_self = function (targetNode)
    {
        targetNode = targetNode || self.getSelected();
        if (!targetNode) { return; }
        if (targetNode.getChildNodes().length > 0) { alert("节点存在子节点，不能删除"); return; }
        if (window.confirm("确认要删除选中节点？")) //[ " + targetNode.getText() + " ] 
        {
            var a = new Ajax(self.requestUrl);
            a.onCom = function (r) { r == "true" && targetNode.remove(); }
            a.start("at=remove_self&ps=" + targetNode.getParent().getValue() + "&sole=" + targetNode.getValue());
        }
    };
    //删除子节点
    this.remove_child = function (targetNode)
    {
        targetNode = targetNode || self.getSelected();
        if (!targetNode) { return; }
        if (targetNode.getChildNodes().length == 0) { return; }
        if (window.confirm("确认要删除选中节点的所有子节点？"))
        {
            var a = new Ajax(self.requestUrl);
            a.onCom = function (r) { r == "true" && targetNode.clearChildNodes(); }
            a.start("at=remove_child&sole=" + targetNode.getValue());
        }
    };
    //删除单个节点及其子节点
    this.remove_all = function (targetNode)
    {
        targetNode = targetNode || self.getSelected();
        if (!targetNode) { return; }
        if (window.confirm("确认要删除选中节点及其所有子节点？"))
        {
            var a = new Ajax(self.requestUrl);
            a.onCom = function (r) { if (r == "true") { targetNode.clearChildNodes(); targetNode.remove(); } }
            a.start("at=remove_all&ps=" + targetNode.getParent().getValue() + "&sole=" + targetNode.getValue());
        }
    };
    //修改节点
    this.update = function (targetNode, text, value, index)
    {
        targetNode = targetNode || self.getSelected();
        if (!targetNode) { return; }
        text && targetNode.setText(text);
        value && targetNode.setValue(text);
        index && self.moveTo(null, index);
    };
    //增加节点 - 接口
    this.addNode_ajax = function (parentNode, newNode, onCom) { };
    //节点取消选中 - 接口
    this.deselect_ajax = function () { };

    /*——— 节点选中 ——————————————————————————————*/

    //得到选中节点的对象
    this.getSelected = function () { return self.treeview ? self.treeview.getSelectedNode() : null; };
    //得到选中节点上一个的对象
    this.getNodePre = function (targetNode) { var index = targetNode.getIndex() - 1; return index >= 0 ? (targetNode.getParent().getChildNodes()[index]) : null; };
    //得到选中节点下一个的对象
    this.getNodeNext = function (targetNode) { var index = targetNode.getIndex() - (-1); return index >= 0 ? (targetNode.getParent().getChildNodes()[index]) : null; };
    //选中的节点得到焦点
    this.setNodeFocus = function (targetNode) { targetNode = targetNode || self.getSelected(); if (self.treeview && targetNode) { var cn = $(targetNode.getID()); cn && cn.scrollIntoView(false); } };
    //将选中移至指定节点
    this.selectTo = function (oldNode, targetNode)
    {
        self.node_isSelect = true;
        oldNode.deselect();
        targetNode.select();
        self.setNodeFocus(targetNode);
        self.node_isSelect = false;
    };
    //返回上一个节点
    this.selectPre = function () { var targetNode = self.getSelected(); targetNode && targetNode.getIndex() > 0 && self.treeview && self.selectTo(targetNode, self.getNodePre(targetNode)); };
    //前进至下一个节点
    this.selectNext = function () { var targetNode = self.getSelected(); targetNode && targetNode.getLevel() > 0 && self.treeview && (targetNode.getIndex() < targetNode.getParent().getChildNodes().length - 1) && self.selectTo(targetNode, self.getNodeNext(targetNode)); };

    /*——— 节点移动 ——————————————————————————————*/

    //将节点向上移动
    this.moveUp = function (targetNode, count) { targetNode = targetNode || self.getSelected(); if (targetNode) { count = count || 1; self.moveTo(targetNode, targetNode.getIndex() - count); } };
    //将节点向下移动
    this.moveDown = function (targetNode, count) { targetNode = targetNode || self.getSelected(); if (targetNode) { count = count || 1; self.moveTo(targetNode, targetNode.getIndex() + count); } };
    //移动节点至最上
    this.moveFirst = function (targetNode) { self.moveTo(targetNode, 0); };
    //移动节点至最下
    this.moveLast = function (targetNode) { targetNode = targetNode || self.getSelected(); if (targetNode && targetNode.getParent() && targetNode.getParent().getChildNodes().length != 0) { var parentContainer = targetNode.getParent() ? targetNode.getParent() : targetNode.getTreeView(); self.moveTo(targetNode, parentContainer.getChildNodes().length - 1); } };
    //移动节点至指定位置
    this.moveTo = function (targetNode, place)
    {
        targetNode = targetNode || self.getSelected();
        place = place || 0;
        if (targetNode && targetNode.getParent() && targetNode.getParent().getChildNodes().length != 0)
        {
            var parentContainer = targetNode.getParent() ? targetNode.getParent() : targetNode.getTreeView();
            if (!parentContainer) return;
            place = place < 0 ? 0 : place;
            place = place >= parentContainer.getChildNodes().length ? parentContainer.getChildNodes().length - 1 : place;

            var a = new Ajax(self.requestUrl);
            a.onCom = function (r) { r == "true" && targetNode.moveTo(parentContainer, place); targetNode.select(); }
            a.start("at=setNodeIndex&ps=" + targetNode.getParent().getValue() + "&sole=" + targetNode.getValue() + "&index=" + targetNode.getIndex() + "&place=" + place);
        }
        self.selected(null, targetNode);
    };

    //设置节点排序 - 接口
    this.setNodeIndex_ajax = function (targetNode, index, place, onCom) { return true; };
    //设置节点等级 - 接口--测试
    this.setNodeLev_ajax = function (nodeValue, parent_old, parent_now, index, onCom) { return true; };

    /*——— 点击事件 ——————————————————————————————*/

    //checkBox点击
    this.checked = function (controlId, targetNode, eventType)
    {
        self.setChildrenCheckBox(targetNode, true);
        self.setParentCheckBox(targetNode, true);
        self.node_checked_ajax(targetNode);
    };
    //checkBox取消点击
    this.unchecked = function (controlId, targetNode, eventType)
    {
        self.setChildrenCheckBox(targetNode, false);
        self.setParentCheckBox(targetNode, false);
        self.node_unchecked_ajax(targetNode);
    };
    //文本点击
    this.selected = function (controlId, targetNode, eventType)
    {
        targetNode && self.node_click_ajax(
            { obj: targetNode, value: targetNode.getValue(), text: targetNode.getText(), lev: targetNode.getLevel() },
            function ()
            {
                self.checkedRecord_isClick = false;
            });
    };
    //文本取消点击
    this.diselected = function (controlId, targetNode, eventType) { };

    this.checkAll = function (is_check) { var nodes = self.treeview.getNodes(); for (var i in nodes) { nodes[i].setChecked(is_check); } }
    this.checkedAll = function () { }
    this.uncheckedAll = function () { }
    //设置子节点是否选择
    this.setChildrenCheckBox = function (targetNode, value) { var childNodes = targetNode.getChildNodes(); for (var i = 0; i < childNodes.length; i++) { var node = childNodes[i]; node.setChecked(value); self.setChildrenCheckBox(node, value); } };
    //设置父节点是否选择
    this.setParentCheckBox = function (targetNode, value) { var parentNode = targetNode.getParent(); if (parentNode != null) { (value || (!value && !self.allSiblingCheckedOne(targetNode))) && parentNode.setChecked(value); self.setParentCheckBox(parentNode, value); } };
    //检查同级节点是否全部选中
    this.allSiblingChecked = function (targetNode) { var nodes = targetNode.getSiblingNodes(); for (var i = 0; i < nodes.length; i++) { if (!nodes[i].getChecked()) return false; } return true; };
    //检查同级节点是否有一个
    this.allSiblingCheckedOne = function (targetNode) { var nodes = targetNode.getSiblingNodes(); for (var i = 0; i < nodes.length; i++) { if (nodes[i].getChecked()) return true; } return false; };
    //查找节点
    this.find = function (targetNode, fun)
    {
        targetNode = targetNode ? targetNode : self.treeview;
        return targetNode.findAll(fun);
    };
    //获取所有被选中节点
    this.getCheckedNodes = function (targetNode)
    {
        targetNode = targetNode ? targetNode : defaultTree.treeview;
        return targetNode.findAll(function (node) { return node.getChecked() == true; });
    };
    this.getCheckedTexts = function (targetNode)
    {
        var nodes = self.getCheckedNodes(targetNode), str = "";
        for (var i in nodes) { str += nodes[i].getText() + ","; }
        return str.substr(0, str.length - 1);
    };
    this.getCheckedValues = function (targetNode)
    {
        var nodes = self.getCheckedNodes(targetNode), str = "";
        for (var i in nodes) { str += nodes[i].getValue() + ","; }
        return str.substr(0, str.length - 1);
    };
    //显示节点信息 - 接口
    this.node_click_ajax = function (targetNode, onCom) { return true; };
    this.node_checked_ajax = function (targetNode, onCom) { return true; };
    this.node_unchecked_ajax = function (targetNode, onCom) { return true; };

    /*——— 外部事件接口 ——————————————————————————————*/

    //节点点击事件
    this.onNodeEventHandler = function (controlId, node, eventType)
    {
        if (self.node_isClick) return;
        self.node_isClick = true;
        switch (eventType)
        {
            case "unchecked": self.unchecked(controlId, node, eventType); break;
            case "checked": self.checked(controlId, node, eventType); break;
            case "diselected": self.diselected(controlId, node, eventType); break;
            case "selected": self.selected(controlId, node, eventType); break;
        }
        self.node_isClick = false;
    };
    //选中节点改变事件
    this.onSelectedNodeChangedHandler = function (controlId, oldNode, node) { };
    //右键菜单显示事件
    this.onContextMenuHandler = function (sender, node, event, contextMenu)
    {
        if (!self.contextMenu) self.contextMenu = contextMenu;
        if (self.contextMenu && node.getContextMenuID().length != 0)
        {
            var childNodesCount = node.getChildNodes().length;
            var items = self.contextMenu.getItems();
            for (var i = 0; i < items.length; i++)
            {
                switch (items[i].getCommandName())
                {
                    case "Expand": items[i].setDisabled(!(childNodesCount > 0 && !node.getExpanded())); break;
                    case "Collapse": items[i].setDisabled(!(childNodesCount > 0 && node.getExpanded())); break;
                }
            }
        }
    };
    //右键菜单项点击事件
    this.menuChecked = function (item, targetNode, type)
    {
        switch (type)
        {
            case "value": alert(targetNode.getValue()); break;
            case "text": alert(targetNode.getText()); break;
            case "open": targetNode.expand(); break;
            case "close": targetNode.collapse(); break;
            case "openAll": self.open(true, targetNode); break;
            case "closeAll": self.close(true, targetNode); break;
            case "up": self.moveUp(targetNode); break;
            case "down": self.moveDown(targetNode); break;
            case "first": self.moveFirst(targetNode); break;
            case "last": self.moveLast(targetNode); break;
            case "add": self.addNode(targetNode); break;
            //case "edit":    break;        
            case "del": self.remove_self(targetNode); break;

            case "plan_addDir": self.plan_addDir(targetNode); break;
            case "plan_addPage": self.plan_addPage(targetNode); break;
            case "plan_custom1": self.plan_addCustom1(targetNode); break;
            case "plan_editDir": self.plan_editDir(targetNode); break; //目录
            case "plan_editFile": self.plan_editFile(targetNode); break; //页面
            case "plan_editCustom1": self.plan_editCustom1(targetNode); break; //自定义
            case "plan_cut": self.plan_cut(targetNode); break;
            case "plan_copy": self.plan_copy(targetNode); break;
            case "plan_paste": self.plan_paste(targetNode); break;
            case "plan_delete": self.plan_delete(targetNode); break;
        }
    };
    this.plan_addDir = function (targetNode)
    {
        if (currentNode)
        {
            currentNode = targetNode;
            type = "addDir";
        }
        var isRoot = targetNode.getToolTip() == "root", value = targetNode.getValue();
        var param = "?oper=add&psole=" + (isRoot ? value : "") + "&ps=" + (isRoot ? "-1" : value) + "&lev=" + (targetNode.getLevel() + 1) + "&index=" + targetNode.getChildNodes().length;
        top.openWindows(window, "publish/plan/3plan_board_dir.aspx" + param, "添加目录");
    };
    this.plan_addPage = function (targetNode)
    {
        if (currentNode)
        {
            currentNode = targetNode;
            type = "addFile";
        }
        var isRoot = targetNode.getToolTip() == "root", value = targetNode.getValue();
        var param = "?oper=add&psole=" + (isRoot ? value : "") + "&ps=" + (isRoot ? "-1" : value) + "&lev=" + (targetNode.getLevel() + 1) + "&index=" + targetNode.getChildNodes().length;
        top.openWindows(window, "publish/plan/3plan_board_file.aspx" + param, "添加页面");
    };
    this.plan_addCustom1 = function (targetNode)
    {
        if (currentNode)
        {
            currentNode = targetNode;
            type = "plan_custom1";
        }
        var param = "?oper=add&ps=" + targetNode.getValue() + "&lev=" + (targetNode.getLevel() + 1) + "&index=" + targetNode.getChildNodes().length;
        top.openWindows(window, "publish/plan/3plan_board_custom1.aspx" + param, "添加自定义");
    };
    this.plan_editDir = function (targetNode)
    {
        if (currentNode)
        {
            currentNode = targetNode;
            type = "editDir";
        }
        top.openWindows(window, "publish/plan/3plan_board_" + targetNode.getToolTip() + ".aspx?oper=up&sole=" + targetNode.getValue(), "修改信息");
    };
    this.plan_editFile = function (targetNode)
    {
        if (currentNode)
        {
            currentNode = targetNode;
            type = "editFile";
        }
        top.openWindows(window, "publish/plan/3plan_board_" + targetNode.getToolTip() + ".aspx?oper=up&sole=" + targetNode.getValue(), "修改信息");
    };
    this.plan_editCustom1 = function (targetNode)
    {
        if (currentNode)
        {
            currentNode = targetNode;
            type = "editCustom1";
        }
        top.openWindows(window, "publish/plan/3plan_board_" + targetNode.getToolTip() + ".aspx?oper=up&sole=" + targetNode.getValue(), "修改信息");
    };
    this.plan_cut = function (targetNode)
    {
        hasPaste = true;
    };
    this.plan_copy = function (targetNode)
    {
        hasPaste = true;
    };
    this.plan_paste = function (targetNode)
    {
        hasPaste = false;
    };
    this.plan_delete = function (targetNode)
    {
        //alert("删除");
        self.remove_all(targetNode);
    };
    this.plan_addNode = function (currentNode, type, text, value, index)
    {
        switch (type)
        {
            case "addDir":
                {
                    /*添加目录*/
                    var newNode = self.createNode("<img style='width:14px;height:14px' src='/Admin/img/tree/tree_dir.gif'/> " + text, value);
                    newNode.setToolTip("dir");
                    currentNode.addNode(newNode);
                    /*设置位置*/
                    newNode.moveTo(currentNode, index);
                    /*打开节点*/
                    currentNode.expand();
                    break;
                }
            case "addFile":
                {
                    /*添加页面*/
                    var newNode = self.createNode("<img style='width:14px;height:14px' src='/Admin/img/tree/tree_file.gif'/> " + text, value);
                    newNode.setToolTip("file");
                    currentNode.addNode(newNode);
                    /*设置位置*/
                    newNode.moveTo(currentNode, index);
                    break;
                }
            default: { break; }
        }
    };
    this.plan_updateNode = function (currentNode, type, text, value, index)
    {
        switch (type)
        {
            case "editDir":
                {
                    /*修改目录*/
                    self.update(currentNode, "<img style='width:14px;height:14px' src='/Admin/img/tree/tree_dir.gif'/> " + text, null, index);
                    //currentNode.selected();
                    break;
                }
            case "editFile":
                {
                    /*修改页面*/
                    self.update(currentNode, "<img style='width:14px;height:14px' src='/Admin/img/tree/tree_file.gif'/> " + text, null, index);
                    break;
                }
            case "editCustom1":
                {
                    /*修改自定义*/
                    //self.update(currentNode, "<img style='width:14px;height:14px' src='/Admin/img/tree/tree_file.gif'/> " + text, null, index);
                    break;
                }
            default: { break; }
        }
    };

    var allNodes = [];  /*末节点集合*/
    this.nodeSelected = function (json)
    {
        /*首次查询时记录末节点集合*/
        if (allNodes.length == 0)
        {
            /*记录所有包含唯一编号的节点*/
            self.find(null, function (node) { if (node.getValue() != "") { allNodes.push({ node: node, text: node.getText(), value: node.getValue() }); }; }); // && node.getChildNodes().length == 0
            /*按照节点的sole进行排序*/
            allNodes.sort(function (a, b) { return a.value - b.value; });
        }
        self.checkAll(false);
        if (json == "" || json.length == 0) { return; }
        var checkedNodes = eval("(" + json + ")"), count = 0;
        for (var i in allNodes)
        {
            //alert("当前对比内容：sole=" + checkedNodes[count].sole + "，node=" + allNodes[i].value);
            if (count < checkedNodes.length && allNodes[i].value == checkedNodes[count].sole)
            {
                allNodes[i].node.setChecked(true);
                count++;
            }
            else { allNodes[i].node.setChecked(false); }
        }
    };
};