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
	<div class="form-group form-inline " >
		 文章标题：<input type="text" name="title" class="form-control form-control-sm" value="${article.title }">
		  &nbsp;&nbsp;
		 审核状态：<select name="status" class="form-control form-control-sm col-sm-1">
				
				<option value="" >全部</option>
				
			    <option value="0" ${article.status=="0"?"selected":"" }>待审</option>
			    <option value="1" ${article.status=="1"?"selected":"" }>已审</option>
			    <option value="-1" ${article.status=="-1"?"selected":"" }>驳回</option>
			 	</select> 
			 	 &nbsp;&nbsp;
	 			<button type="button" onclick="query()" class="btn btn-warning btn-sm">查询</button>
	</div>	
	
 <hr>
 
	<table class="table table-bordered table-hover table-sm" style="text-align: center ;">
		<tr>
			<td>序号</td>
			<td>标题</td>
			<td>作者</td>
			<td>发布时间</td>
			<td>所属栏目</td>
			<td>所属分类</td>
			<td>是否热门</td>
			<td>是否审核</td>
			<td>点击量</td>
			<td>其他</td>
		</tr>
		<c:forEach items="${info.list }" var="article" varStatus="i">
			<tr>
				<td>${i.count }</td>
				<td width="350px">${article.title }</td>
				<td>${article.user.username }</td>
				<td><fmt:formatDate value="${article.created}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
				<td>${article.channel.name }</td>
				<td>${article.category.name }</td>
				<td>
				  <c:if test="${article.hot==0}">
				   <button type="button" class="btn btn-info btn-sm"   onclick="update(${article.id},this)">否</button>
				  </c:if>
				 <c:if test="${article.hot==1}">
				   <button type="button" class="btn btn-danger btn-sm"  onclick="update(${article.id},this)">是</button>
				  </c:if>

				</td>
				<td>
						<c:if test="${article.status==0}">
					   		<button type="button" class="btn btn-info btn-sm">待审</button>
					  	</c:if>
						<c:if test="${article.status==1}">
					   		<button type="button" class="btn btn-success btn-sm">通过</button>
					  	</c:if>
					 	<c:if test="${article.status==-1}">
					  		 <button type="button" class="btn btn-danger btn-sm">驳回</button>
					  	</c:if>
				</td>
				<td>${article.hits }</td>
				<td><button type="button" onclick="articleDetail(${article.id})" class="btn btn-link" data-toggle="modal" data-target="#exampleModalLong">详情</button></td>
			</tr>
		</c:forEach>
	</table>
	
	
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
	      <div class="modal-body" id="content">
	        
	      </div>
	      <div class="modal-footer">
	      	
	        <button type="button" class="btn btn-success" onclick="updateStates(1)">通过</button>
	        <button type="button" class="btn btn-danger"onclick="updateStates(-1)">驳回</button>
	        <button type="button" class="btn btn-warning"onclick="updateStates(0)">待定</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!--调取分页页面  -->
	 <jsp:include page="/view/common/pages.jsp"></jsp:include>
	 
	<script type="text/javascript">
	
			
			function updateStates(status) {

				$.post(
					"/admin/update",
					{id:articleId,status:status},
					function (flag) {
						if (flag) {
							location="/admin";
						}else {
							location="/admin";
						}
					}
				)
			}			
			
			var articleId;
			
			//文章详情
			function articleDetail(id) {
				
				articleId=id;
				
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
	
			//改变热门文章
			function update(id,obj) {
				var hot=$(obj).text()=="是"?0:1;
				
				$.post(
					"admin/update",
					{id:id,hot:hot},
					function (flag) {
						if (flag) {
							$(obj).text($(obj).text()=="是"?"否":"是")
							$(obj).attr("class",hot==0?"btn btn-info btn-sm":"btn btn-danger btn-sm");
						}
					}
				)
			}
		  // 查询状态
		  function query(){
			  var status=$("[name='status']").val();
			  var title=$("[name='title']").val();
			  $("#center").load("/admin/articles?status="+status+"&title="+title);
			  
		  }
		  
		  function goPage(page){
				//在中间区域加载
				$("#center").load("/admin/articles?page="+page);
			}
		  
	</script>
</body>
</html>