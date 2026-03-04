<%@ Page Language="C#" MasterPageFile="../../master/table.master" AutoEventWireup="true" CodeFile="2llm_log_detail.aspx.cs" Inherits="Admin_pages_llm_2llm_log_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
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
        .btn-back {
            background-color: #f1f1f1;
            color: black;
        }
        .btn-back:hover {
            background-color: #ddd;
        }
        .dialog-content {
            white-space: pre-wrap;
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
            margin: 10px 0;
            border-left: 4px solid #4CAF50;
        }
        .score-box {
            background-color: #e3f2fd;
            padding: 15px;
            border-radius: 4px;
            margin: 10px 0;
        }
        .score-value {
            font-size: 24px;
            font-weight: bold;
            color: #1976d2;
        }
        .evaluation-box {
            background-color: #f3e5f5;
            padding: 15px;
            border-radius: 4px;
            margin: 10px 0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="location">
        <a href="../../../main.aspx">首页</a> &gt; <a href="1llm.aspx">大模型管理</a> &gt; <a href="2llm_log.aspx">对话记录</a> &gt; 对话详情
    </div>
    <div class="frame">
        <div class="frame-title">
            <h3>对话详情</h3>
        </div>
        <div class="frame-content">
            <div class="button-group">
                <a href="2llm_log.aspx" class="btn btn-back">返回</a>
            </div>
            <div class="form-group">
                <label>学员名称：</label>
                <span id="studentName" runat="server"></span>
            </div>
            <div class="form-group">
                <label>对话时间：</label>
                <span id="dialogTime" runat="server"></span>
            </div>
            <div class="form-group">
                <label>对话内容：</label>
                <div id="dialogContent" runat="server" class="dialog-content"></div>
            </div>
            <div class="score-box">
                <h4>智能评分</h4>
                <p>评分：<span id="score" runat="server" class="score-value"></span></p>
            </div>
            <div class="evaluation-box">
                <h4>评估详情</h4>
                <div id="evaluation" runat="server"></div>
            </div>
        </div>
    </div>
</asp:Content>