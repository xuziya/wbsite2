<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/Master/base.master" CodeFile="main.aspx.cs" Inherits="Admin_main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<link type="text/css" rel="stylesheet" href="/Admin/css/ui/index.css"/>
	<link type="text/css" rel="stylesheet" href="/Admin/css/ui/fonts/font-awesome.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
     <div class="breadcrumb-box">
        <ol class="breadcrumb">
        	<span>位置：</span>
			<li class="active"><a href="main.aspx">首页</a></li>
            <div class="clear"></div>
		</ol>
    </div>
    <div style="height:40px"></div>  
    <div class="container-fluid">  
    	<div class="row row-col-space15">
    		<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
    			<div class="row row-col-space15">
    				<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
    					<div class="card card-left1">
    						<div class="card-header">
    							<p>学习资料</p>
    							<a class="more" href="#"><i class="fa fa-angle-double-right"></i></a>
    							<div class="clear"></div>
    						</div>
							<div class="card-body">
								<ul class="list">
								    <%--<li class=" active">
								    	<p><a href="#">这里是测试的消息1</a></p>
								    	<small class="list-small">2022-3-19</small><a class="more" href="#"><i class="fa fa-ellipsis-v"></i></a>
								    	<div class="clearfix"></div>
								    </li>--%>
                                    <%=GetLearn()%>
								</ul>
							</div>
    					</div>
    				</div>
    				<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
    					<div class="card card-left1">
    						<div class="card-header">
    							<p>通知栏</p>
    							<a class="more" href="#"><i class="fa fa-angle-double-right"></i></a>
    							<div class="clear"></div>
    						</div>
    						<div class="card-body">
    							<ul class="list">
								    <%--<li class=" active">
								    	<p><a href="#">这里是测试的消息1</a></p>
								    	<small class="list-small">2022-3-19</small><a class="more" href="#"><i class="fa fa-ellipsis-v"></i></a>
								    	<div class="clearfix"></div>
								    </li>--%>
                                    <%=GetNews() %>
								</ul>
    						</div>
    					</div>
    				</div>
    				<%--<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
    					<div class="card">
    						<div class="card-header">
    							<p>企业增长趋势 - 月</p>
    							<a class="more" href="#"><i class="fa fa-angle-double-right"></i></a>
    							<div class="clear"></div>
    						</div>
					        <div class="card-body"><iframe id="iframe1" width="100%" frameborder="0" scrolling="no" src="/Admin/pages/statistics/company/32bar.aspx" onload="this.style.height=this.contentWindow.document.body.scrollHeight+'px'"></iframe></div>
    					</div>
    				</div>--%>
    			</div>        					        				
    		</div>
    		<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                <div class="card">
		            <div class="card-header">
			            <p>用户信息</p>
			            <a class="more" href="#"><i class="fa fa-angle-double-right"></i></a>
			            <div class="clear"></div>
		            </div>
		            <div class="card-body"><iframe src="pages/_sys/1self/2msg.aspx" width="100%" frameborder="0" onload="this.style.height=this.contentWindow.document.body.scrollHeight+'px'"></iframe></div>
                </div>
			</div>
            <%--<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
				<div class="card ">
					<div class="card-header">
						<p>企业分类 - 行业</p>
						<a class="more" href="#"><i class="fa fa-angle-double-right"></i></a>
						<div class="clear"></div>
					</div>
					<div class="card-body"><iframe id="iframepage" width="100%" height="400px" frameborder="0" scrolling="no" src="/Admin/pages/statistics/company/22pie1.aspx" ></iframe></div>
				</div> 							        					        			
    		</div>--%>
    	</div>
    </div>
</asp:Content>