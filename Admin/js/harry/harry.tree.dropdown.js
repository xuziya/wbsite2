if (!Ajax) { var Ajax = function(r, p, m) { var s = this; var x; this.r = r || location.href.substr(location.href.lastIndexOf("/") + 1); this.p = p || ""; this.m = m || "post"; this.onCom = function() { }; this.start = function(p) { try { if (!x) { if (window.ActiveXObject) { try { x = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { x = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } } else if (window.XMLHttpRequest) { x = new XMLHttpRequest(); if (x.overrideMimeType) { x.overrideMimeType("text/xml"); } } if (!x) { alert("不能创建XMLHttpRequest对象实例"); } } s.p = (p ? p : s.p) + "&" + new Date().getTime(); x.open(s.m, s.r + (s.r.indexOf("?") > -1 ? "&" : "?") + s.p, true); if (s.m.toLowerCase() == "get") { x.send(null); } else if (s.m.toLowerCase() == "post") { x.setRequestHeader('Content-type', 'application/x-www-form-urlencoded'); x.send(s.p); } else { alert("无效的请求方式 [ " + s.m + " ] "); return; } x.onreadystatechange = function() { if (x.readyState == 4 && x.status == 200) { var t = x.responseText; if (t.indexOf("rror") == 1) { alert(t); } else if (t.indexOf("eload") == 1) { alert(t); top.location.assign('../login.aspx'); } else { s.onCom(t); } } }; } catch (e) { } }; } };
/*-------  树形下拉列表  --------
| author : harry                |
| date   : 2009-04-16           |
| version: 1.2                  |
------------  param  ------------
| panel  ：容器(默认当前页)     |
| top    ：上边距               |
| left   ：左边距               |
-------------------------------*/
function TreeDropDown(treePanellID, textID, valueID)
{
    var self = this;
    this.treeview;
    this.treePanel = typeof (treePanellID) == "object" ? treePanellID : document.getElementById(treePanellID);
    this.txt_text = typeof (textID) == "object" ? textID : document.getElementById(textID);
    this.txt_value = typeof (valueID) == "object" ? valueID : document.getElementById(valueID);
    //this.width = self.txt_text.offsetWidth - 4;
    //this.path = path || "../../";

    this.init = function ()
    {
        self.treePanel.style.display = "none";
        self.treePanel.style.zIndex = "9999";
        self.treePanel.style.position = "absolute";
        self.txt_text.className += " dropdownTree";
        self.txt_text.style.cursor = "pointer";
        self.txt_text.onmousedown = function ()
        {
            self.treePanel.style.display == "none" ? self.open() : self.close();
            //$(document.body).on("click", function () { alert(); });
            //document.body.onclick = function ()
            //{ 
            //    alert();
            //}
        }
    }
    this.clicked = function() { };
    this.onSelectedNodeChangedHandler = function (controlId, oldNode, node, type)
    {
        var node = self.treeview.getSelectedNode();
        if (!node.getPopulateNodesOnDemand() && node.getChildNodes().length == 0)
        {
            if (type && node.getToolTip() != type) { }
            else
            {
                self.txt_text.value = self.treeview.getSelectedNode().getText().replace(/<\/?.+?>/g, "").trim();
                self.txt_value.value = self.treeview.getSelectedNode().getValue();
            }
            self.close();
            self.clicked();
        }
    }
    this.open = function (ev)
    {
        ev = ev ? ev : window.event;
        ev && (ev.cancelBubble = true);
        var pos = $(self.txt_text).offset(); //harry.offset(self.txt_text);
        self.treePanel.style.top = pos.top - -self.txt_text.offsetHeight + "px";
        self.treePanel.style.left = (pos.left - -1) + "px";
//        self.treePanel.style.width = self.width + "px";
        self.treePanel.style.display = "block";
        document.onmousedown = function (ev)
        {
            var eventSrc = ev && ev.target ? ev.target : event.srcElement;
            var treeviewElement = document.getElementById(self.treeview.toString());
            //while (eventSrc)
            //{
            //    if (eventSrc == treeviewElement) return;
            //    eventSrc = eventSrc.parentNode;
            //}
            self.treeview.close();
            document.onmousedown = null;
        }
    }
    //查找节点
    this.find = function(targetNode, fun)
    {
        targetNode = targetNode ? targetNode : self.treeview;
        return targetNode.findAll(fun);
    };
    ///*以value查找节点后展开并选中*/
    //this.focus = function (value)
    //{
    //    if (value == "") { return; }
    //    alert(value);
    //    self.find(null, function (node)
    //    {
    //        alert();
    //        return node.getValue() == value1;
    //    });
    //};
    this.close = function() { self.treePanel.style.display = "none"; }
    this.is_show = function () { return self.treePanel.style.display == "block"; }
    self.init();
}