<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 视窗 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<meta name="keywords" content="${article.keywords}">
<meta name="decription" content="${article.original}">
<title>${article.title }</title>
<link rel="stylesheet" type="text/css"href="/resource/index.css" />
<script type="text/javascript"src="/jquery/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="/bootstrap-4.4.1-dist/css/bootstrap.min.css" />
<script type="text/javascript" src="/jquery/jquery.validate.js"></script>
<script type="text/javascript"src="/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>

</head>
<body>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12" style="background-color:black; height: 34px" >
				
			</div>
		</div>
		<div class="row" style="margin-top: 10px">
			<div class="col-md-1"></div>
			<div class="col-md-7">
				<h2>${article.title }</h2>
				
				<p style="padding-top: 20px">
					${article.user.username} ·
					 <fmt:formatDate value="${article.created }"  pattern="yyyy-MM-dd HH:mm:ss"/>
				</p>
					<c:if test="${collect!=null}">
					 <button type="button" onclick="deleteCollect()" class="btn btn-link">★&nbsp;  取消收藏</button>
					</c:if>
					<c:if test="${collect==null}">
					     <button type="button" onclick="collect(1)" class="btn btn-link">☆ &nbsp;  未收藏</button>
					</c:if>
					<c:if test="${article.keywords !=null}">
					<P>关键字：${article.keywords }</P>
					</c:if>
					<c:if test="${article.original !=null}">
					<P>来源：${article.original}</P>
					</c:if>
					
				<hr>
					${article.content }
				<hr>
				
				<!--文章评论  -->
				<c:if test="${null!=sessionScope.user }">
				
				<div class="input-group mb-3">
				<input type="text" class="form-control" name="content" placeholder="请输入你的想法……"  >
				  <div class="input-group-append">
				    <button class="btn btn-outline-secondary btn btn-success" onclick="addComment()" type="button" id="button-addon2">
				    	<font style="color: white;">提交评论</font>
				    </button>
				  </div>
				</div>
				
				<!--方法2  -->
<!-- 			<div >
					<h5  class="font-weight-bold  text-danger" >文章评论：</h5>
					<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="content" ></textarea>
					
					<button style="float: right;" type="button" onclick="addComment()" class="btn btn-success">提交评论</button>
				</div> -->
				</c:if>
				
				<!--显示评论内容  -->
				<div style="padding-top: 50px">
					<c:forEach items="${info.list }" var="comment">
					
						<div class="form-group p-3 mb-2 bg-light text-dark">
						    <label class="font-weight-bold" for="exampleFormControlTextarea1">${comment.user.username} 评论于
									<fmt:formatDate value="${comment.created}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</label>
						    <textarea class="form-control" id="exampleFormControlTextarea1" rows="3">${comment.content }</textarea>
						</div>
				  		<hr>
					
					</c:forEach>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card" style="width: 18rem; margin-top: 5px ">
				<div class="header" style="background-color:black;color: white;" align="center">评论排行榜</div>
				<div class="card-body">
					<c:forEach items="${info2.list }" var="article" varStatus="i">
						<p><font size="2">${i.count }.   ${article.title }</font></p>
						
					</c:forEach>
				  </div>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
	
	
	//当页面加载时，向日志表插入数据
	$(function(){
		 var articleId ='${article.id}';
		 $.post("/insertLog",{articleId:articleId},function(){
			 
		 })
		
		
	})
	
		
		//取消收藏
		function deleteCollect() {
			var id='${collect.id}';
			$.post(
					"/deleteCollect",
					{id:id},
					function (flag) {
						if (flag) {
							alert("取消成功");
							window.location.reload();
						}else{
							alert("取消失败，需要登录后才能取消")
						}
					})
		}
		//增加收藏
		function collect() {
			//文章的标题
			var title='${article.title}';
			//文章的Url
			var url=location.href;
			$.post(
					"/collect",
					{text:title,url:url},
					function (flag) {
						if (flag) {
							alert("收藏成功");
							window.location.reload();
						}else{
							alert("收藏失败，需要登录后才能收藏")
						}
					})
		}
	
	
		//增加评论
		function addComment() {
			var articleId='${article.id}';
			var content=$("[name='content']").val();
			$.post(
					"/addComment",
					{articleId:articleId,content:content},
					function (flage) {
						if (flage) {
							alert("评论成功！");
							location.reload();
						}else {
							alert("请登录后评论")
						}
					}
					
				)
		}
	
	</script>
	
	
</body>
</html>