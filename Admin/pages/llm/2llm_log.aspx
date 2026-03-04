<%@ Page Language="C#" MasterPageFile="../../master/table.master" AutoEventWireup="true" CodeFile="2llm_log.aspx.cs" Inherits="Admin_pages_llm_2llm_log" %>

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
        .btn-danger {
            background-color: #f44336;
        }
        .btn-danger:hover {
            background-color: #da190b;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: inline-block;
            width: 100px;
            font-weight: bold;
        }
        .form-group input {
            width: 200px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .dialog-content {
            white-space: pre-wrap;
            background-color: #f9f9f9;
            padding: 10px;
            border-radius: 4px;
            margin: 5px 0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="location">
        <a href="../../../main.aspx">首页</a> &gt; <a href="1llm.aspx">大模型管理</a> &gt; <a href="2llm_log.aspx">对话记录</a>
    </div>
    <div class="frame">
        <div class="frame-title">
            <h3>对话记录管理</h3>
        </div>
        <div class="frame-content">
            <div class="form-group">
                <label for="txtSearch">搜索：</label>
                <input type="text" id="txtSearch" placeholder="输入学员名称或对话内容" />
                <button class="btn" onclick="searchLogs()">搜索</button>
            </div>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>学员名称</th>
                            <th>对话时间</th>
                            <th>对话内容</th>
                            <th>评分</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="logTable">
                        <!-- 数据将通过JavaScript动态加载 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function loadLogs() {
            $.ajax({
                type: "POST",
                url: "2llm_log.aspx/GetLLMLogs",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    if (response.d) {
                        var logs = JSON.parse(response.d);
                        var tableBody = $("#logTable");
                        tableBody.empty();
                        
                        $.each(logs, function(index, log) {
                            var row = $('<tr>');
                            row.append($('<td>').text(log.id));
                            row.append($('<td>').text(log.studentName));
                            row.append($('<td>').text(log.dialogTime));
                            row.append($('<td>').html('<div class="dialog-content">' + log.dialogContent.substring(0, 100) + '...</div>'));
                            row.append($('<td>').text(log.score));
                            row.append($('<td>').html(
                                '<button class="btn" onclick="viewLog(' + log.id + ')">查看详情</button> ' +
                                '<button class="btn btn-danger" onclick="deleteLog(' + log.id + ')">删除</button>'
                            ));
                            tableBody.append(row);
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error loading logs: " + error);
                }
            });
        }
        
        function searchLogs() {
            var searchText = $("#txtSearch").val();
            $.ajax({
                type: "POST",
                url: "2llm_log.aspx/SearchLLMLogs",
                data: JSON.stringify({searchText: searchText}),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    if (response.d) {
                        var logs = JSON.parse(response.d);
                        var tableBody = $("#logTable");
                        tableBody.empty();
                        
                        $.each(logs, function(index, log) {
                            var row = $('<tr>');
                            row.append($('<td>').text(log.id));
                            row.append($('<td>').text(log.studentName));
                            row.append($('<td>').text(log.dialogTime));
                            row.append($('<td>').html('<div class="dialog-content">' + log.dialogContent.substring(0, 100) + '...</div>'));
                            row.append($('<td>').text(log.score));
                            row.append($('<td>').html(
                                '<button class="btn" onclick="viewLog(' + log.id + ')">查看详情</button> ' +
                                '<button class="btn btn-danger" onclick="deleteLog(' + log.id + ')">删除</button>'
                            ));
                            tableBody.append(row);
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error searching logs: " + error);
                }
            });
        }
        
        function viewLog(id) {
            // 查看对话详情
            if (window.parent && window.parent.document.getElementById('iframe')) {
                // 在iframe中加载详情页面
                window.parent.document.getElementById('iframe').src = "pages/llm/2llm_log_detail.aspx?id=" + id;
            } else {
                // 直接跳转
                window.location.href = "2llm_log_detail.aspx?id=" + id;
            }
        }
        
        function deleteLog(id) {
            if (confirm("确定要删除这个对话记录吗？")) {
                $.ajax({
                    type: "POST",
                    url: "2llm_log.aspx/DeleteLLMLog",
                    data: JSON.stringify({id: id}),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(response) {
                        if (response.d) {
                            alert("删除成功");
                            loadLogs();
                        } else {
                            alert("删除失败");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Error deleting log: " + error);
                    }
                });
            }
        }
        
        $(document).ready(function() {
            // 加载对话记录列表
            loadLogs();
        });
    </script>
</asp:Content>