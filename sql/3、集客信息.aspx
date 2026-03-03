<%@ Page Language="C#" AutoEventWireup="true" CodeFile="3、集客信息.aspx.cs" Inherits="sql_3集客信息" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>集客数据导入</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="position:absolute;top:200px;left:200px">
            <asp:Button ID="Button1" runat="server" Text="1、产品信息" onclick="Button1_Click" /><br /><br /><br />  
            <asp:Button ID="Button2" runat="server" Text="2、场景信息" onclick="Button2_Click" /><br /><br /><br />  
            <asp:Button ID="Button3" runat="server" Text="3、客户画像信息" onclick="Button3_Click" /><br /><br /><br />  
            <asp:Button ID="Button4" runat="server" Text="4、问候对话池" onclick="Button4_Click" /><br /><br /><br />  
            <%--<asp:Button ID="Button5" runat="server" Text="5、关怀对话池" onclick="Button5_Click" /><br /><br /><br />  --%>
            <asp:Button ID="Button7" runat="server" Text="5、关怀对话池 - 新" onclick="Button7_Click" /><br /><br /><br />  
            <asp:Button ID="Button6" runat="server" Text="6、销售对话池" onclick="Button6_Click" />
        </div>
    </form>
</body>
</html>
