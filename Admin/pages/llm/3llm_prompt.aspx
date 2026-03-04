<%@ Page Language="C#" MasterPageFile="../../master/table.master" AutoEventWireup="true" CodeFile="3llm_prompt.aspx.cs" Inherits="Admin_pages_llm_3llm_prompt" %>

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
        <a href="../../../main.aspx">首页</a> &gt; <a href="1llm.aspx">大模型管理</a> &gt; <a href="3llm_prompt.aspx">Prompt管理</a>
    </div>
    <div class="frame">
        <div class="frame-title">
            <h3>Prompt管理</h3>
        </div>
        <div class="frame-content">
            <div class="button-group">
                <a href="3llm_prompt_ad.aspx" class="btn">添加Prompt</a>
            </div>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>名称</th>
                            <th>类型</th>
                            <th>内容</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="promptTable">
                        <!-- 数据将通过JavaScript动态加载 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function loadPrompts() {
            $.ajax({
                type: "POST",
                url: "3llm_prompt.aspx/GetPrompts",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    if (response.d) {
                        var prompts = JSON.parse(response.d);
                        var tableBody = $("#promptTable");
                        tableBody.empty();
                        
                        $.each(prompts, function(index, prompt) {
                            var row = $('<tr>');
                            row.append($('<td>').text(prompt.id));
                            row.append($('<td>').text(prompt.name));
                            row.append($('<td>').text(prompt.type));
                            row.append($('<td>').text(prompt.content.substring(0, 50) + '...'));
                            row.append($('<td>').html(
                                '<a href="3llm_prompt_ad.aspx?id=' + prompt.id + '" class="btn">编辑</a> ' +
                                '<button class="btn btn-danger" onclick="deletePrompt(' + prompt.id + ')">删除</button>'
                            ));
                            tableBody.append(row);
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error loading prompts: " + error);
                }
            });
        }
        
        function deletePrompt(id) {
            if (confirm("确定要删除这个Prompt吗？")) {
                $.ajax({
                    type: "POST",
                    url: "3llm_prompt.aspx/DeletePrompt",
                    data: JSON.stringify({id: id}),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(response) {
                        if (response.d) {
                            alert("删除成功");
                            loadPrompts();
                        } else {
                            alert("删除失败");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Error deleting prompt: " + error);
                    }
                });
            }
        }
        
        $(document).ready(function() {
            // 加载Prompt列表
            loadPrompts();
        });
    </script>
</asp:Content>