<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fileManager.aspx.cs" Inherits="Admin_sys_other_fileManager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>在线FTP系统</title>
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="/Admin/css/ui/base.css" />
    <style type="text/css">
        html,body{height:auto}
        table{background:#fff;width:100%}
        table td{height:35px;line-height:35px;color:#666666;padding:3px 10px 2px 5px;font-size:14px}
        table td a{color:#000}
        html body .editMenuFTP li a{cursor:pointer;background:none;padding-left:0;color:#333333;font-size:12px;ine-height:20px}
        html body .editMenuFTP li a img{width:20px;height:20px;margin-right:5px;float:left}
        .editMenuFTP li a:hover{color:#41526c}
        .editMenuFTP li{float:left;border-right:1px solid #c4cbd8;border-left:1px solid #fff;margin-top:5px;padding:0 15px}
        .editMenuFTP{background:url(/Admin/images/userFun_bg.jpg) repeat-x bottom #fff;height:30px;border-bottom:1px solid #dde2e9}
        #GridView1{border-top:1px solid #dde2e9;width:100%;}
        #GridView1 tr th{background:#f2f4f6;color:#666;border-right:1px solid #dde2e9;border-left:1px solid #fff;border-bottom:1px solid #dde2e9;text-align:right;padding:0 15px;line-height:34px}
        #GridView1 tr td{border:0;border-bottom:1px solid #eeeeee;padding:0 15px}
        #GridView1 .Ghover{background:#cfecff}
        #GridView1 .Ghot{background:#ebeff4}
        .panels li{display:none;position:fixed;top:17%;left:50%;margin-left:-300px;width:500px;background:#eee;color:#333;border:1px solid #666;padding:12px}
        .jqmWindow{display:none;position:absolute;width:500px;background:#f2f4f6;color:#333;border:1px solid #9fa8b3}
        .jqmOverlay{background-color:#fff;display:block;position:absolute}
        .jqmWindow h3{background:#7187ae;display:block;width:100%;height:25px}
        .jqmWindow h3 span{display:block;float:left;font-size:13px;font-weight:bold;color:#FFFFFF;line-height:25px;text-indent:12px}
        .jqmWindow h3 a{display:block;float:right;height:15px;width:16px;background:#DC4835;color:#FFFFFF;margin:5px 5px 0 0;text-align:center;line-height:15px;font-size:11px;font-weight:bold;border:1px solid #A7190F}
        .jqmWindow h3 a:hover{background:#E67D6F}
        .jqmWindow_bottom{background:#E6EAF0;padding:10px 15px;text-align:right;border:3px solid #7187ae;border-top:0}
        .jqmWindow_bottom input{margin-left:10px}
        .jqmWindow_mid{padding:12px;border:3px solid #7187ae;border-bottom:0}
        .jqmWindow_mid table{background:none}
    </style>
    <script src="/Tools/fileManager/jquery.js" type="text/javascript"></script>
    <script src="/Tools/fileManager/fileManager.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function (){
            $("#GridView1").removeAttr("rules").removeAttr("style")
            $("#GridView1 tr th").eq(1).css("text-align", "left");
            //鼠标经过换色
            $("#GridView1 tr").hover(function (){$(this).addClass("Ghover") }, function (){$(this).removeClass("Ghover") })
            //选中换色
            $("#GridView1 tr td input:checkbox").click(function (){if ($(this).attr("checked") == true){$(this).parent("span").parent().parent().addClass("Ghot") } else{$(this).parent("span").parent().parent().removeClass("Ghot") } })
            //全选
            $("#GridView1 tr th input:checkbox").click(function (){if ($(this).attr("checked") == true){$("#GridView1 tr").addClass("Ghot") } else{$("#GridView1 tr").removeClass("Ghot") } })
            $(".input1").focus(function (){$(this).addClass("inputTextHover") })
            $(".input1").blur(function (){$(this).removeClass("inputTextHover") })
            //自动高度
            $(window.parent.parent.document).find("#iframe1").height($("body").height()+50);
			//alert($("body").height())
            /*弹窗*/
            //var WinHeight = $(window).height();
            var WinWidht = $(window).width();
            //var jqmHeight = $(".jqmWindow").height();
            //var jqmTop = (WinHeight-jqmHeight)/2-30;
            var jqmLeft = (WinWidht - 500) / 2 - 100;
            $(".jqmWindow").css({top:"220px", left:jqmLeft });
            $(window.parent.parent.document).find(".jqmOverlay").hide(0)
        })
    </script>
</head>
<body>
    <div class="breadcrumb-box">
        <ol class="breadcrumb">
        	<span>位置：</span>
			<%--<li><a>系统设置</a></li>--%>
			<%--<li><a>其他功能</a></li>--%>
			<%--<li class="active"><a>在线FTP系统</a></li>--%>
            <%=GetTitle() %>
            <div class="clear"></div>
		</ol>
    </div>
    <form id="form1" runat="server" style=" margin-top:40px">
        <ul id="opers" runat="server" class="editMenuFTP">
            <li style="border-left:none;"><a onclick="location.href=location.href"><img title="刷新" alt="刷新" src="/Tools/fileManager/images/ico/refresh.gif" />刷新</a></li>
            <span <%=GetEditorState() %>>
                <li><a id="createfile" onclick=""><img title="新建文件" alt="新建文件" src="/Tools/fileManager/images/ico/file_new.gif" />新建文件</a></li>
                <li><a id="create" onclick=""><img title="新建文件夹" alt="新建文件夹" src="/Tools/fileManager/images/ico/folder_new.gif" />新建文件夹</a></li>
                <li><a id="rename" onclick=""><img title="重命名" alt="重命名" src="/Tools/fileManager/images/ico/rename.gif" />重命名</a></li>
                <li><a id="cut" onclick=""><img title="剪切" alt="剪切" src="/Tools/fileManager/images/ico/cut.gif" />剪切</a></li>
                <li><a id="copy" onclick=""><img title="复制" alt="复制" src="/Tools/fileManager/images/ico/copy.gif" />复制</a></li>
                <li><a id="paste" onclick=""><img title="粘贴" alt="粘贴" src="/Tools/fileManager/images/ico/paste.gif" />粘贴</a></li>
                <li><a id="delete" onclick=""><img title="删除" alt="删除" src="/Tools/fileManager/images/ico/delete.gif" />删除</a></li>
                <li><a id="upload" onclick=""><img title="上传" alt="上传" src="/Tools/fileManager/images/ico/up.gif" />上传</a></li>
            </span>
            <div class="clear"></div>
        </ul>
        <div style="padding:5px 10px;background:#fff;<%=GetSavePathState() %>">
            <%--<b style="font-weight:bold;font-size:18px;color:Red">注意！这里为系统内的站点文件管理，类似于FTP，非管理员请勿操作！</b><br />--%>
            <b style="font-weight:bold">路径:</b><asp:Label ID="lblCurrentPath" runat="server" Font-Size="12px"></asp:Label>
        </div>
        <asp:GridView ID="GridView1" runat="server" Width="95%" AutoGenerateColumns="False" Font-Names="Verdana" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound" OnRowCreated="GridView1_RowCreated" BorderWidth="0px" EnableModelValidation="True">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" BorderWidth="0px" />
                        <asp:Image ID="Image1" runat="server" ImageUrl="/Tools/fileManager/images/up.gif" Visible="False" />
                    </ItemTemplate>
                    <HeaderTemplate>
                        <input type="checkbox" style="width:22px; border:none;" name="checkedAll" id="checkedAll" />
                    </HeaderTemplate>
                    <ItemStyle Width="3%" Wrap="False" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="名称">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("FullName") %>' Text='<%# Eval("Name") %>'></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle />
                </asp:TemplateField>
                <asp:BoundField DataField="CreationDate" HeaderText="创建日期">
                    <ItemStyle Width="150" Wrap="False" HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="大小">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Size") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("SizeM") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" Width="75" Wrap="False" />
                </asp:TemplateField>
                <asp:BoundField DataField="FolderCount" HeaderText="文件夹数量">
                    <ItemStyle HorizontalAlign="Right" Width="90" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="FileCount" HeaderText="文件数量">
                    <ItemStyle HorizontalAlign="Right" Width="80" Wrap="False" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="White" />
            <PagerStyle BackColor="White" HorizontalAlign="Left" />
            <SelectedRowStyle Font-Bold="True" ForeColor="White" />
            <HeaderStyle HorizontalAlign="Center" Height="25px" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
        <div>
            <div id="divCreate" class="jqmWindow" style="display:none;">
                <h3><span>新建文件夹</span><a class="jqmClose" href="javascript:;">X</a></h3>
                <div class="jqmWindow_mid">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>名称：<asp:TextBox ID="TextBox2" runat="server" CssClass="input1"></asp:TextBox></td>
                        </tr>
                    </table>
                </div>
                <div class="jqmWindow_bottom">
                    <asp:Button ID="btnCreateFolder" runat="server" Text="确定" OnClick="btnCreateFolder_Click" CssClass="inputBotton" />
                    <asp:Button ID="btnPanel2Cancel" runat="server" Text="取消" CssClass="inputBotton" />
                </div>
            </div>
            <div id="divCreateFile" class="jqmWindow" style="display:none;">
                <h3>新建文件</h3>
                名称1：
                <asp:TextBox ID="TextBox4" runat="server" Text="New File.txt"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" Text="确定" CssClass="inputBotton" OnClick="btnCreateFile_Click" />
                <asp:Button ID="Button4" runat="server" Text="取消" CssClass="inputBotton" />
            </div>
            <div id="divUpload" class="jqmWindow" style="display:none;">
                <h3><span>文件上传</span><a class="jqmClose" href="javascript:;">X</a></h3>
                <div class="jqmWindow_mid">
                    <div></div>
                    选择文件：
                    <asp:FileUpload ID="FileUpload1" runat="server" Width="285px" />
                </div>
                <div class="jqmWindow_bottom">
                    <asp:Button ID="btnUpload" runat="server" Text="确定" OnClick="btnUpload_Click" CssClass="inputBotton" />
                    <asp:Button ID="btnPanel3Cancel" runat="server" Text="取消" CssClass="inputBotton" />
                </div>
            </div>
            <div id="divRename" class="jqmWindow" style="display:none;">
                <h3>重命名</h3>
                新名称：
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                <asp:Button ID="btnRename" runat="server" Text="确定" CssClass="inputBotton" OnClick="btnRename_Click" />
                <asp:Button ID="btnPanel4Cancel" runat="server" Text="取消" CssClass="inputBotton" />
            </div>
            <div id="divDelete" class="jqmWindow" style="display:none;">
                <h3><span>删除文件</span><a class="jqmClose" href="javascript:;">X</a></h3>
                <div class="jqmWindow_mid">确定删除选中的文件或文件夹吗？</div>
                <div class="jqmWindow_bottom">
                    <asp:Button ID="btnDelete" runat="server" Text="确定" CssClass="inputBotton" OnClick="btnDelete_Click" />
                    <asp:Button ID="Button2" runat="server" Text="取消" CssClass="inputBotton" />
                </div>
            </div>
            <div id="divCopy" class="jqmWindow" style="display:none;">
                <h3>复制文件<a class="jqmClose" href="javascript:;">X</a></h3>
                <div class="jqmWindow_mid">确定复制选中的文件或文件夹吗？</div>
                <div class="jqmWindow_bottom">
                    <asp:Button ID="btnCopy" runat="server" Text="确定" CssClass="inputBotton" OnClick="btnCopy_Click" />
                    <asp:Button ID="Button3" runat="server" Text="取消" CssClass="inputBotton" />
                </div>
            </div>
            <div id="divPaste" class="jqmWindow" style="display:none;">
                <h3><span>粘贴文件</span><a class="jqmClose" href="javascript:;">X</a></h3>
                <div class="jqmWindow_mid"><span id="pasteTip" runat="server" style="color:Red;"></span>确定粘贴选中的文件或文件夹吗？</div>
                <div class="jqmWindow_bottom">
                    <asp:Button ID="btnPaste" runat="server" Text="确定" CssClass="inputBotton" OnClick="btnPaste_Click" />
                    <asp:Button ID="Button5" runat="server" Text="取消" CssClass="inputBotton" />
                </div>
            </div>
            <div id="divCut" class="jqmWindow" style="display:none;">
                <h3><span>剪切文件</span><a class="jqmClose" href="javascript:;">X</a></h3>
                <div class="jqmWindow_mid">确定剪切选中的文件或文件夹吗？</div>
                <div class="jqmWindow_bottom">
                    <asp:Button ID="btnCut" runat="server" Text="确定" CssClass="inputBotton" OnClick="btnCut_Click" />
                    <asp:Button ID="Button7" runat="server" Text="取消" CssClass="inputBotton" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>