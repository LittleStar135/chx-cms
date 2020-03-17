<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 视窗 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>今日头条-管理员登录</title>

<script type="text/javascript"src="/jquery/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="/bootstrap-4.4.1-dist/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/jquery/screen.css" />
<script type="text/javascript" src="/jquery/jquery.validate.js"></script>
<script type="text/javascript"src="/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>

</head>
<body>
	
	<div class="container" style="width: 450px;padding-top: 10px">
		
		<span style="color:red" >${msg }</span>
		<form  id="form1">
			
			<div  class="form-group">
				<label for="username">用户名</label>
				<input type="text" id="username" class="form-control" name="username">
			</div>
			
			<div  class="form-group">
				<label for="password">密码</label>
				<input type="password" id="password" class="form-control" name="password">
			</div>
			
			
			<div class="form-group">
				<button type="submit" class="btn btn-info">登录</button>
				<button type="reset" class="btn btn-warning">重置</button>
				<span id="msg"></span>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
		$(function () {
			
			$("#form1").validate({
				  //1 .定义规则
				  rules:{
					 username:{
						 required:true,//用户名不能为空
						 
					 }, 
					 password:{
						 required:true,//密码不能为空
						 
					 }, 
				  },
				  //2.定义消息提示
				  messages:{
					username:{
						 required:"用户名不能为空",
						
					} , 
					 password:{
						 required:"密码不能为空",
						
					 }, 
				 },
				 //3.提交
				 submitHandler:function(flag){
					 //如果校验通过，则执行注册
					 $.post(
							 "/passport/login",
							 $("#form1").serialize(),
							 function(result){
								 if(result.code==200){
									 location.href="/admin";//刷新回到首页
								 }else {
									 $("#msg").html("<font color='red'>"+result.msg+"</font")
								}
					 		})
					 }  
			  })
		  })
	
	</script>
	
	
</body>
</html>