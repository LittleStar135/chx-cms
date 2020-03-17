<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 视窗 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>今日头条-管理员中心</title>
<script type="text/javascript"src="/jquery/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="/bootstrap-4.4.1-dist/css/bootstrap.min.css" />
<script type="text/javascript" src="/jquery/jquery.validate.js"></script>
<script type="text/javascript"src="/jquery/popper.min.js"></script>
<script type="text/javascript"src="/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container-fluid">
		<!--头  -->
		<div class="row" style="background-color: #009FD9; height: 60px">
			<div class="col-md-12">
				<!-- <img alt="" src="/resource/images/tou.jpg" style="height: 55px; padding-top: 2px; padding-left: 2px">  -->
				<img alt="" src="/resource/images/tou.jpg" style="height: 60px;"> 
				<font style="color: white;">今日头条-管理员中心</font>
				
				<div class="btn-group dropleft" style="float: right;">
						<button type="button" class="btn btn-link dropdown-toggle"
							data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false">	<font color="white" size="2px">登录信息</font>
						</button>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="#">${sessionScope.user.username }</a> 
							<a class="dropdown-item" href="/passport/logout">注销</a>
						</div>
				</div>
						
			</div>
		</div>
		<!--内容  -->
		<div class="row" style="padding-top: 10px;height: 700px">
			<!--左侧菜单  -->
			<div class="col-md-2 rounded" style="background-color: #ccc; text-align: center;margin-left: 10px;padding-top: 10px">
			
			  <nav class="nav flex-column">
					<a class="list-group-item active" href="#" data="/admin/articles">文章审核</a> 
					<a class="list-group-item" href="#" data="/admin/users">用户管理</a> 
					<a class="list-group-item" href="#">栏目管理</a>
					<a class="list-group-item" href="#">分类管理</a> 
					<a class="list-group-item" href="#" data="/admin/settings">系统设置</a>
				</nav>
			</div>
			<!-- 右侧具体内容 -->
			<div class="col-md-9" id="center">
			
			</div>
		</div>
	</div>
	
<script type="text/javascript">
	//点击样式的切换
	 //为a 添加点击事件
	$(function(){
		//默认显示我的文章
		$("#center").load("/admin/articles")
		$("a").click(function(){
			var url = $(this).attr("data");
			//alert(url)
		 //去除样式
		    $("a").removeClass("active");
		   //让当前点击的li 添加选中样式
			 $(this).addClass("list-group-item active")
			//在中间区域显示url的内容
			$("#center").load(url);
		})
		
	})

</script>
</body>
</html>