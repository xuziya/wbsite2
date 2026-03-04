<%@ Page Language="C#" MasterPageFile="../../master/table.master" AutoEventWireup="true" CodeFile="3llm_prompt_ad.aspx.cs" Inherits="Admin_pages_llm_3llm_prompt_ad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: inline-block;
            width: 100px;
            font-weight: bold;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 400px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-group textarea {
            height: 150px;
        }
        .btn {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-cancel {
            background-color: #f1f1f1;
            color: black;
        }
        .btn-cancel:hover {
            background-color: #ddd;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="location">
        <a href="../../../main.aspx">首页</a> &gt; <a href="1llm.aspx">大模型管理</a> &gt; <a href="3llm_prompt.aspx">Prompt管理</a> &gt; <asp:Label ID="lblTitle" runat="server" Text="添加Prompt"></asp:Label>
    </div>
    <div class="frame">
        <div class="frame-title">
            <h3><asp:Label ID="lblFrameTitle" runat="server" Text="添加Prompt"></asp:Label></h3>
        </div>
        <div class="frame-content">
                <input type="hidden" id="hdnId" runat="server" />
                <div class="form-group">
                    <label for="txtName">名称：</label>
                    <asp:TextBox ID="txtName" runat="server" Width="400px"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="ddlType">类型：</label>
                    <asp:DropDownList ID="ddlType" runat="server" Width="400px">
                        <asp:ListItem Value="客户模拟">客户模拟</asp:ListItem>
                        <asp:ListItem Value="评分标准">评分标准</asp:ListItem>
                        <asp:ListItem Value="其他">其他</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="txtContent">内容：</label>
                    <asp:TextBox ID="txtContent" runat="server" Width="400px" TextMode="MultiLine" Rows="5"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="取消" CssClass="btn btn-cancel" OnClick="btnCancel_Click" />
                </div>
        </div>
    </div>
</asp:Content>