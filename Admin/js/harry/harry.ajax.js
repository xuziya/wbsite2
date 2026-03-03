/*-----------  Ajax  ------------
| author : harry                |
| date   : 2005-11-08           |
| version: 1.12                 |
------------  param  ------------
| url    ：请求页面(默认当前页) |
| params ：请求参数             |
| method ：请求方式(默认post)   |
-------------------------------*/
if (!Ajax)
{
    function Ajax(url, params, method)
    {
        var self = this;    /*自身引用*/
        var xmlhttp;        /*ajax请求对象*/
        this.url = url || location.href.substr(location.href.lastIndexOf("/") + 1);  /*请求地址*/
        this.params = params || "";         /*参数集合*/
        this.method = method || "post";     /*请求类型*/
        this.onLoading = function () { };   /*读取时事件*/
        this.onLoaded = function () { };    /*读取完毕事件*/
        this.onSending = function () { };   /*发送中事件*/
        this.onCom = function () { };       /*结果返回事件*/
        /*创建XMLHttpRequest对象*/
        this.create = function ()
        {
            /*IE浏览器*/
            if (window.ActiveXObject)
            {
                try { xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); }
                catch (e)
                {
                    try { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
                    catch (e) { }
                }
            }
            /*创建XMLHttpRequest实例*/
            else if (window.XMLHttpRequest)
            {
                /*Mozilla浏览器*/
                xmlhttp = new XMLHttpRequest();
                /*设置MiME类别*/
                if (xmlhttp.overrideMimeType) { xmlhttp.overrideMimeType("text/xml"); }
            }
            /*异常,创建对象实例失败.不能创建XMLHttpRequest对象实例*/
            if (!xmlhttp) { window.alert("不能创建XMLHttpRequest对象实例.."); }
        };
        /*发送请求*/
        this.start = function (params)
        {
            try
            {
                if (!xmlhttp) { self.create(); }
                /*附加随机参数防止页面被缓存*/
                self.params = (params ? params : self.params) + "&" + new Date().getTime() + "=";
                /*设置参数*/
                xmlhttp.open(self.method, self.url + (self.url.indexOf("?") > -1 ? "&" : "?") + self.params, true);
                if (self.method == "get") { xmlhttp.send(null); }
                else if (self.method == "post") { xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded'); xmlhttp.send(self.params); }
                else { alert("method错误：当前method为 [ " + self.method + " ]"); return; }
                /*setRequestHeader("If-Modified-Since", "0");*/
                /*判断请求状态*/
                xmlhttp.onreadystatechange = function ()
                {
                    switch (xmlhttp.readyState)
                    {
                        case 1: self.onLoading(); break;
                        case 2: self.onLoaded(); break;
                        case 3: self.onSending(); break;
                        case 4:
                            {
                                if (xmlhttp.status == 200)
                                {
                                    /*self.responseXML = xmlhttp.responseXML;*/
                                    var text = xmlhttp.responseText;
                                    if (text.indexOf("rror") == 1) { alert(text); }
                                    else if (text.indexOf("eload") == 1) { alert(text); top.location.assign('/login.aspx'); }
                                    else { self.onCom(text); }
                                }
                                break;
                            }
                    }
                };
            }
            catch (e) { }
        };
    }
}