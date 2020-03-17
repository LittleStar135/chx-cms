<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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


<c:forEach items="${info.list}" var="article">

<div class="media">
  <img src="/pic/${article.picture }" style="width: 168px;height: 109.64px" class="mr-3 rounded" alt="...">
  <div class="media-body">
    <h5 class="mt-0">${article.title }</h5>
       <div style="float: right;padding-top: 60px">
     	 <!-- Button trigger modal -->
		<button type="button" onclick="articleDetail(${article.id})" class="btn btn-link" data-toggle="modal" data-target="#exampleModalLong">详情</button>
  	   </div>
  </div>
</div>

 <hr/>
</c:forEach>	
	<!--分页  -->
 	<jsp:include page="/view/common/pages.jsp"/>
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModalLong"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content" >
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle"><span id="title"></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body" id="content" name="content">
	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
<script type="text/javascript">
	//文章详情
	function articleDetail(id) {
		//清空原有详情
		$("#content").empty();
		//清空原有标题
		$("#title").empty();
		//查询单个文章，模态框赋值
		$.get(
			"/my/articleDetail",
			{id:id},
			function (article) {
				
				$("#title").append(article.title);
				$("#content").append(article.content);
			}
		)
	}

	function goPage(page) {
		//在中间区域加载
		$("#center").load("/my/articles?page="+page);
		
	} 


</script>
</html>