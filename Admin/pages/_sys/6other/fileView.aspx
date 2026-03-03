<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fileView.aspx.cs" Inherits="Admin_sys_other_fileView" %>
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
    </style>
    <script src="/Tools/fileManager/jquery.js" type="text/javascript"></script>
    <script src="/Tools/fileManager/fileManager.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function ()
        {
            $("#GridView1").removeAttr("rules").removeAttr("style")
            $("#GridView1 tr th").eq(1).css("text-align", "left");
            //鼠标经过换色
            $("#GridView1 tr").hover(function () { $(this).addClass("Ghover") }, function () { $(this).removeClass("Ghover") })
            //选中换色
            $("#GridView1 tr td input:checkbox").click(function () { if ($(this).attr("checked") == true) { $(this).parent("span").parent().parent().addClass("Ghot") } else { $(this).parent("span").parent().parent().removeClass("Ghot") } })
            //全选
            $("#GridView1 tr th input:checkbox").click(function () { if ($(this).attr("checked") == true) { $("#GridView1 tr").addClass("Ghot") } else { $("#GridView1 tr").removeClass("Ghot") } })
            $(".input1").focus(function () { $(this).addClass("inputTextHover") })
            $(".input1").blur(function () { $(this).removeClass("inputTextHover") })
            //自动高度
            $(window.parent.parent.document).find("#iframe1").height($("body").height() + 50);
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ul id="opers" runat="server" class="editMenuFTP">
            <li style="border-left:none;"><a onclick="location.href=location.href"><img title="刷新" alt="刷新" src="/Tools/fileManager/images/ico/refresh.gif" />刷新</a></li>
            <div class="clear"></div>
        </ul>
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
    </form>
</body>
</html>