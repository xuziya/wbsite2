/*-------  测试信息模块  --------
| author : harry                |
| date   : 2019-05-02           |
| version: 1.0                  |
------------  param  ------------
| panel  ：容器(默认当前页)     |
| top    ：上边距               |
| left   ：左边距               |
-------------------------------*/
function Test(panel, top, left)
{
    var self = this;
    var msg = [];           /*信息记录*/
    this.element;           /*控件引用*/
    this.top = top || 40;   /*显示区域上边距*/
    this.left = left || 0;  /*显示区域左边距*/
    this.width = 400;       /*显示区域宽*/
    this.height = 800;      /*显示区域高*/
    /*分隔符*/
    this.split = "——————————————————————————————————————————————————".substr(0, Math.floor(self.width / 15));
    this.length = function () { return msg.length; }
    /*添加*/
    this.add = function (m)
    {
        msg.push(msg.length + 1 + "、" + m);
        self.view();
    };
    /*显示*/
    this.view = function ()
    {
        msg.sort(function (v1, v2)
        {
            var value1 = v1.split("、")[0] - 0, value2 = v2.split("、")[0] - 0;
            if (value1 > value2) { return -1; }
            else if (value1 < value2) { return 1; }
            else { return 0; }
        });
        self.element.val(msg.join("\r\n" + self.split + "\r\n"));
    };
    /*清理*/
    this.clear = function () { msg = []; self.view(); };
    /*初始化*/
    (this.init = function ()
    {
        $(panel || (window.parent || window).document.body).append(self.element = $("<textarea style='top:" + self.top + "px;left:" + self.left + "px;width:" + self.width + "px;height:" + self.height + "px;position:absolute;zIndex:9999'></textarea>"));
    })();
};
/*-------  错误信息模块  --------
| author : harry                |
| date   : 2019-05-02           |
| version: 1.0                  |
------------  param  ------------
| panel  ：容器(默认当前页)     |
| top    ：上边距               |
| left   ：左边距               |
-------------------------------*/
function Error(panel, top, left)
{
    var self = this;
    var msg = [];           /*信息记录*/
    this.element;           /*控件引用*/
    this.top = top || 565;  /*显示区域上边距*/
    this.left = left || 252;/*显示区域左边距*/
    this.width = 785;       /*显示区域宽*/
    this.height = 240;      /*显示区域高*/
    /*分隔符*/
    this.split = "——————————————————————————————————————————————————".substr(0, Math.floor(self.width / 15));
    this.length = function () { return msg.length; }
    /*添加*/
    this.add = function (m) { msg.push(msg.length + "、" + m); };
    /*显示*/
    this.view = function ()
    {
        msg.sort(function (v1, v2)
        {
            var value1 = v1.split("、")[0] - 0, value2 = v2.split("、")[0] - 0;
            if (value1 > value2) { return -1; }
            else if (value1 < value2) { return 1; }
            else { return 0; }
        });
        self.element.val(msg.join("\r\n" + self.split + "\r\n"));
    };
    /*清理*/
    this.clear = function () { msg = []; };
    /*初始化*/
    (this.init = function ()
    {
        $(panel || (window.parent || window).document.body).append(self.element = $("<textarea style='top:" + self.top + "px;left:" + self.left + "px;width:" + self.width + "px;height:" + self.height + "px;position:absolute'></textarea>"));
    })();
};