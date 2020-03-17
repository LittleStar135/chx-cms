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
<title>今日头头条-注册</title>

<script type="text/javascript"src="<%=request.getContextPath()%>/js/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="/bootstrap-4.4.1-dist/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/jquery/screen.css" />
<script type="text/javascript" src="/jquery/jquery.validate.js"></script>
<script type="text/javascript"src="/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>

</head>
<body>

	<div class="container">
		<form  id="form1">
		
			<div  class="form-group">
				<label for="username">用户名</label>
				<input type="text" id="username" class="form-control" name="username">
			</div>
			
			<div  class="form-group">
				<label for="password">密码</label>
				<input type="password" id="password" class="form-control" name="password">
			</div>
			
			<div  class="form-group">
				<label for="repassword">确认密码</label>
				<input type="password" id="repassword" class="form-control" name="repassword">
			</div>
			
			<div class="form-group form-inline">
				<label for="gender">性别：</label>
				<input type="radio" id="gender" class="form-check-input" name="gender" value="1" checked>男
				<input type="radio" id="gender" class="form-check-input" name="gender" value="0">女
			</div>
			
			<div class="form-group">
				<button type="submit" class="btn btn-info">注册</button>
				<button type="reset" class="btn btn-warning">重置</button>
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
						 rangelength:[2,10],//用户名长度在2-10之间
						 remote:{//校验用户名是否已经存在
							 type:"post",
							 data:{
								 username:function(){
									 return $("#username").val();
								 }
							 },
							 url:"/passport/checkName",
						 },
					 }, 
					 password:{
						 required:true,//密码不能为空
						 rangelength:[6,10],//密码长度在6-10之间
					 }, 
					 repassword:{//确认密码和密码一致
						 equalTo:"#password"
					 }, 
				  },
				  //2.定义消息提示
				  messages:{
					username:{
						 required:"用户名不能为空",
						 rangelength:"用户名长度在2-10之间",
						 remote:"用户已经被注册",
					} , 
					 password:{
						 required:"密码不能为空",
						 rangelength:"密码长度在6-10之间"
					 }, 
					 repassword:{
						 equalTo:"两次密码不一致",
					 }, 
					 remote:{
						 
					 }
				 },
				 //3.提交
				 submitHandler:function(flag){
					 //如果校验通过，则执行注册
					 $.post(
							 "/passport/reg",
							 $("#form1").serialize(),
							 function(result){
								 if(result.code==200){
									 $("#title").html("<font color='red'>恭喜,注册成功,请登录</font>")
									 $("#passport").load("/passport/login")//注册成功  转到登录
								 }else {
									alert(result.msg)
								}
					 		})
					 }  
			  })
		  })
	
	</script>
	
</body>
</html>









