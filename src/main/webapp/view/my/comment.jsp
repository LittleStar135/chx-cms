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
<title>今日头头条-我的文章</title>
<script type="text/javascript"src="/jquery/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="/bootstrap-4.4.1-dist/css/bootstrap.min.css" />
<script type="text/javascript" src="/jquery/jquery.validate.js"></script>
<script type="text/javascript"src="/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>



<table class="table table-bordered table-hover table-sm" style="text-align: center ;">
		<tr>
			<td>评论内容</td>
			<td>评论时间</td>
			<td>操作</td>
		</tr>
		<c:forEach items="${info.list }" var="comment" >
		<tr>
			<td >${comment.content }</td>
			<td>
				<fmt:formatDate value="${comment.created }" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
			<td>
				<button type="button" onclick="deleteComment(${comment.id})" class="btn btn-warning" >删除评论</button>
			</td>
		</tr>	
		</c:forEach>
</table>


 <hr/>
	<!--分页  -->
 	<jsp:include page="/view/common/pages.jsp"/>
</body>
<script type="text/javascript">
	
	
 	function deleteComment(id) {
		
		$.post(
				"/my/deleteComment",
				{id:id},
				function (flag) {
					if (flag) {
						alert("删除成功");
						location.reload();
					}
		})
		
		
	} 
	

	function goPage(page) {
		//在中间区域加载
		$("#center").load("/my/collect?page="+page);
		
	} 


</script>
</html>