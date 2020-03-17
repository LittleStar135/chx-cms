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
			<td>标题</td>
			<td>时间</td>
			<td>操作</td>
		</tr>
		<c:forEach items="${info.list }" var="collect" >
		<tr>
			<td >${collect.text }</td>
			<td>
				<fmt:formatDate value="${collect.created }" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
			<td>
				<button type="button" onclick="deleteCollect(${collect.id})" class="btn btn-warning" >取消收藏</button>
			</td>
		</tr>	
		</c:forEach>
</table>


<%-- <div class="media">
  <div class="media-body">
  		
    <h5 class="mt-0">${collect.text }</h5>
       <div style="float: right;">
		<button type="button" onclick="deleteCollect(${collect.id})" class="btn btn-warning" >取消收藏</button>
  	   </div>
  </div>
</div> --%>

 <hr/>
	<!--分页  -->
 	<jsp:include page="/view/common/pages.jsp"/>
</body>
<script type="text/javascript">
	
	
	function deleteCollect(id) {
		
		$.post(
				"/my/deleteCollect",
				{id:id},
				function (flag) {
					if (flag) {
						alert("取消成功");
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