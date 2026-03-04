<%@ Page Language="C#" MasterPageFile="../../master/table.master" AutoEventWireup="true" CodeFile="1llm.aspx.cs" Inherits="Admin_pages_llm_1llm" %>

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
        .form-group input, .form-group textarea {
            width: 400px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-group textarea {
            height: 150px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="location">
        <a href="../../../main.aspx">首页</a> &gt; <a href="1llm.aspx">大模型管理</a>
    </div>
    <div class="frame">
        <div class="frame-title">
            <h3>大模型管理</h3>
        </div>
        <div class="frame-content">
            <div class="button-group">
                <a href="1llm_ad.aspx" class="btn">添加大模型配置</a>
            </div>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>模型名称</th>
                            <th>API地址</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="llmTable">
                        <!-- 数据将通过JavaScript动态加载 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function loadLLMConfigs() {
            $.ajax({
                type: "POST",
                url: "1llm.aspx/GetLLMConfigs",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    if (response.d) {
                        var configs = JSON.parse(response.d);
                        var tableBody = $("#llmTable");
                        tableBody.empty();
                        
                        $.each(configs, function(index, config) {
                            var row = $('<tr>');
                            row.append($('<td>').text(config.id));
                            row.append($('<td>').text(config.name));
                            row.append($('<td>').text(config.apiUrl));
                            row.append($('<td>').text(config.status ? '启用' : '禁用'));
                            row.append($('<td>').html(
                                '<a href="1llm_ad.aspx?id=' + config.id + '" class="btn">编辑</a> ' +
                                '<button class="btn btn-danger" onclick="deleteLLM(' + config.id + ')">删除</button>'
                            ));
                            tableBody.append(row);
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error loading LLM configs: " + error);
                }
            });
        }
        
        function deleteLLM(id) {
            if (confirm("确定要删除这个大模型配置吗？")) {
                $.ajax({
                    type: "POST",
                    url: "1llm.aspx/DeleteLLM",
                    data: JSON.stringify({id: id}),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(response) {
                        if (response.d) {
                            alert("删除成功");
                            loadLLMConfigs();
                        } else {
                            alert("删除失败");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Error deleting LLM config: " + error);
                    }
                });
            }
        }
        
        $(document).ready(function() {
            // 加载大模型配置列表
            loadLLMConfigs();
        });
    </script>
</asp:Content>