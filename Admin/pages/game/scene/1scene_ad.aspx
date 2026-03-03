<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/form.master" AutoEventWireup="true" CodeFile="1scene_ad.aspx.cs" Inherits="Admin_pages_game_scene_1scene_ad" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th width="170">场景名称<span class="form-red">*</span></th>
                <td><asp:TextBox ID="name" runat="server" class="form-input" style="width:300px" MaxLength="30" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>场景类型</th>
                <td>
                    <asp:DropDownList ID="type" runat="server" class="form-select" style="width:300px">
                        <asp:ListItem Value="简单">个人场景</asp:ListItem>
                        <asp:ListItem Value="家庭">家庭场景</asp:ListItem>
                        <asp:ListItem Value="集团">集团场景</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>场景难度</th>
                <td>
                    <asp:DropDownList ID="lev" runat="server" class="form-select" style="width:300px">
                        <asp:ListItem Value="简单">简单 (10分)</asp:ListItem>
                        <asp:ListItem Value="中等">中等 (15分)</asp:ListItem>
                        <asp:ListItem Value="困难">困难 (20分)</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>排序</th>
                <td><asp:DropDownList ID="index1" runat="server" class="form-select" style="width:300px"></asp:DropDownList></td>
            </tr>
            <tr>
                <th width="170">场景简介</th>
                <td><asp:TextBox ID="intro" runat="server" class="form-input" style="width:300px" MaxLength="300" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>头像<br /><span class="form-tip">图片格式：JPG</span></th>
                <td>
                    
                    <asp:FileUpload ID="FileUpload1" runat="server" class="form-input"/>
                    <asp:Label ID="path1" runat="server" ToolTip="点击下载文件"></asp:Label><br />
                    <asp:Image ID="Image1" runat="server" style="width:300px" />
                </td>
            </tr>
            <tr>
                <th>上半身像<br /><span class="form-tip">图片格式：JPG</span></th>
                <td>
                    
                    <asp:FileUpload ID="FileUpload2" runat="server" class="form-input"/>
                    <asp:Label ID="path2" runat="server" ToolTip="点击下载文件"></asp:Label><br />
                    <asp:Image ID="Image2" runat="server" style="width:300px" />
                </td>
            </tr>
            <tr>
                <th>半身像<br /><span class="form-tip">图片格式：JPG</span></th>
                <td>
                    
                    <asp:FileUpload ID="FileUpload3" runat="server" class="form-input"/>
                    <asp:Label ID="path3" runat="server" ToolTip="点击下载文件"></asp:Label><br />
                    <asp:Image ID="Image3" runat="server" style="width:300px" />
                </td>
            </tr>
            <tr>
                <th>场景标题图像（彩色）<br /><span class="form-tip">图片格式：JPG</span></th>
                <td>
                    
                    <asp:FileUpload ID="FileUpload4" runat="server" class="form-input"/>
                    <asp:Label ID="path4" runat="server" ToolTip="点击下载文件"></asp:Label><br />
                    <asp:Image ID="Image4" runat="server" style="width:300px" />
                </td>
            </tr>
            <tr>
                <th>场景标题图像（黑白）<br /><span class="form-tip">图片格式：JPG</span></th>
                <td>
                    
                    <asp:FileUpload ID="FileUpload5" runat="server" class="form-input"/>
                    <asp:Label ID="path5" runat="server" ToolTip="点击下载文件"></asp:Label><br />
                    <asp:Image ID="Image5" runat="server" style="width:300px" />
                </td>
            </tr>
            <tr><td colspan="2" style='text-align:center;background:green;color:#fff'>关联客户画像</td></tr>
            <tr>
                <td colspan="2" id="member_html" runat="server" style="padding:0">
                    <%--<table class='table table-bordered table-hover'>
                        <tr><td colspan='13' style='text-align:center;background:green;color:#fff'>个人客户</td></tr>
                        <tr>									
                            <th>排序</th>
                            <th>编号</th>
                            <th>姓名</th>
                            <th>合约</th>
                            <th>价值</th>
                            <th>年龄</th>
                            <th>流量</th>
                            <th>资费</th>
                            <th>融合</th>
                            <th>视频</th>
                            <th>权益</th>
                            <th>职业</th>
                            <th>地域</th>
                        </tr>
                        <tbody></tbody>
                    </table>--%>
                    <%--<table class='table table-bordered table-hover'>
                        <tr><td colspan='6' style='text-align:center;background:green;color:#fff'>家庭客户</td></tr>
                        <tr>									
                            <th>排序</th>
                            <th>编号</th>
                            <th>姓名</th>
                            <th>有宽带客户</th>
                            <th>有家庭网客户</th>
                            <th>有宽带有家庭网</th>
                        </tr>
                        <tbody></tbody>
                    </table>--%>
                    <%--<table class='table table-bordered table-hover'>
                        <tr><td colspan='13' style='text-align:center;background:green;color:#fff'>集团客户</td></tr>
                        <tr>									
                            <th>排序</th>
                            <th>编号</th>
                            <th>姓名</th>
                            <th>合约</th>
                            <th>价值</th>
                            <th>年龄</th>
                            <th>流量</th>
                            <th>资费</th>
                            <th>融合</th>
                            <th>权益</th>
                            <th>家庭</th>
                            <th>集团属性（ABCD）</th>
                            <th>集团星级</th>
                            <th>集团等级</th>
                            <th>集团份额</th>
                            <th>集团成员数</th>
                            <th>保拓优先级</th>
                        </tr>
                        <tbody></tbody>
                    </table>--%>
                </td>
            </tr>
            <tr><td colspan="2" style='text-align:center;background:green;color:#fff'>关联产品信息</td></tr>
            <tr>
                <td colspan="2" id="produce_html" runat="server" style="padding:0">
                    <%--<table class='table table-bordered table-hover'>
                        <tr><td colspan='13' style='text-align:center;background:green;color:#fff'>产品信息</td></tr>
                        <tr><th>排序</th><th>编号</th><th>名称</th><th>档位</th><th>简介</th></tr>
                        <tbody></tbody>
                    </table>--%>
                </td>
            </tr>
            <tr>
                <th></th>
                <td><label><input type="checkbox" id="isUsed" class="form-checkbox" runat="server" lay-skin="primary"/> 正常使用</label></td>
            </tr>
            <tr>
                <th>备注</th>
                <td><asp:TextBox ID="note" runat="server" class="form-input" MaxLength="200" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="padding:20px 200px" colspan="2">
                    <asp:Button id="Button1" runat="server" class="btn btn-primary" Text="确&nbsp;&nbsp;认" OnClick="Button1_Click"/>
                    <button type="button" class="btn btn-primary" onclick="location.href=location.href">重&nbsp;&nbsp;置</button>
                    <button type="button" class="btn btn-primary" onclick="parent.layer.close(parent.layer.getFrameIndex(window.name));">关&nbsp;&nbsp;闭</button>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>