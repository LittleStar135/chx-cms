<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 视窗 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>今日头头条-个人中心</title>
<%-- <link href="<%=request.getContextPath()%>/css/index3.css" rel="stylesheet">  --%>
<script type="text/javascript"src="<%=request.getContextPath()%>/js/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css"href="/bootstrap-4.4.1-dist/css/bootstrap.min.css" />
<script type="text/javascript"src="/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>
<script type="text/javascript"src="<%=request.getContextPath()%>/js/jquery.validate.js"></script>
</head>
<body>


<div>
		<nav aria-label="Page navigation example">
		<ul class="pagination">
			<c:if test="${info.total==0 }">
				<i><font color="red">暂无数据</font></i>
			</c:if>
			<c:if test="${info.total!=0 }">
			<li class="page-item"><a class="page-link" href="javascript:goPage(${info.prePage==0?1:info.prePage })"
				aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
			</a></li>
			<c:forEach items="${info.navigatepageNums}" var="n">
				<li class="page-item ${n==info.pageNum?"active":""}"><a class="page-link" href="javascript:goPage(${n})">${n}</a></li>
			</c:forEach>

			<li class="page-item"><a class="page-link" href="javascript:goPage(${info.nextPage ==0?info.pages:info.nextPage})"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span>
			</a></li>
			</c:if>
		</ul>
	</nav>

</div>
	
</body>
</html>