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
<title>今日头条</title>
<link rel="stylesheet" type="text/css"href="/resource/index.css" />
<script type="text/javascript"src="/jquery/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="/bootstrap-4.4.1-dist/css/bootstrap.min.css" />
<script type="text/javascript" src="/jquery/jquery.validate.js"></script>
<script type="text/javascript"src="/jquery/popper.min.js"></script>
<script type="text/javascript"src="/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>


	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12" style="background-color:black; height: 34px" >
				<a href="https://app.toutiao.com/news_article/"><font color="white" size="2px" style="line-height: 2.5;margin-left: 10px">下载APP</font></a>
				<a href="https://mp.toutiao.com/auth/page/login/?redirect_url=JTJG"><font color="white" size="2px" style="line-height: 2;margin-left: 10px">注册头条号</font></a>
				<font color="white" size="2px"  style="line-height: 2;margin-left: 10px"> 商丘  晴   2°  /  18° </font>
				<font color="white" size="2px" style="line-height: 2;margin-left: 10px">∨</font>
				
				<div  style="float: right;">
					<!-- 从session获取当前有没有登录，如果已经登录，则不显示注册和登录按钮 -->
					<c:if test="${null==sessionScope.user }">
						<button  type="button" class="btn btn-link " onclick="reg()" data-toggle="modal" data-target="#exampleModal">
						 	<font size="2px" color="white" >注册</font>
						</button>
						<button  type="button" class="btn btn-link " onclick="login()" data-toggle="modal" data-target="#exampleModal">
						 	<font size="2px" color="white" >登录</font>
						</button>
					</c:if>
					<c:if test="${null!=sessionScope.user }">
						<div class="btn-group dropleft">
							<button type="button" class="btn btn-link dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">	<font color="white" size="2px">登录信息</font></button>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="#">${sessionScope.user.username }</a> 
								<a class="dropdown-item" href="/my">个人中心</a> 
								<a class="dropdown-item" href="/passport/logout">注销</a>
							</div>
						</div>
					</c:if>
				</div>
				
			</div>
		</div>
		<!-- 注册/登录模态框 -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel"><span id="title"></span></h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body" id="passport">
		        
		      </div>
		      
		    </div>
		  </div>
		</div>
		
		
		<div class="row">
			<div class="col-md-2" style="padding-top:10px">
				
				<ul>
					<li style="margin-bottom: 10px">
						<a href="/"  class="channel"> <img alt="" src="/resource/images/logo.png" style="width: 108px; height: 27px;"></a>
					</li>
					
					<li><a href="/?hot=1" class="channel-item ${article.channelId==null?"active":""}" >热点</a></li>
					
					<!-- <li class="channel-item active" style="color: #fff" ><a href="">推荐</a></li> -->
					<!--遍历所有栏目  -->
					<c:forEach items="${channels }" var="channel" >			
						<li>
							<a href="/?channelId=${channel.id }" class="channel-item ${article.channelId==channel.id?"active":"" }">${channel.name }</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="col-md-7">
				<!--如果栏目ID 为null 说明点击左侧的热点    轮播图广告 -->
				<c:if test="${article.channelId==null }">
					<div style="margin: 5px 5px 5px 5px">
						<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
						  <ol class="carousel-indicators">
						  	 <c:forEach items="${sildes }" var="silde" varStatus="i">
						    	<li data-target="#carouselExampleCaptions" data-slide-to="${i.index }" class="active"></li>
						    </c:forEach>
						  </ol>
						  <div class="carousel-inner">
						  <c:forEach items="${sildes }" var="silde" varStatus="i">
						  	<div class="carousel-item ${i.index==0?"active":"" } ">
						      <img src="/pic/${silde.url }" class="d-block w-100 rounded" alt="..." style="width: 350px; height: 280px">
						      <div class="carousel-caption d-none d-md-block">
						        <h5>广告1</h5>
						      </div>
						    </div>
						  </c:forEach>
						    
						  </div>
						  <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
						    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
						    <span class="sr-only">Previous</span>
						  </a>
						  <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
						    <span class="carousel-control-next-icon" aria-hidden="true"></span>
						    <span class="sr-only">Next</span>
						  </a>
						</div>
					</div>
				</c:if>
			
			
				<!-- 如果栏目ID 不为null 说明点击 左侧的栏目 -->
				<c:if test="${article.channelId!=null }">
					<div class="subchannel">
						<ul>
							<li class="sub-item ${article.categoryId==null?"sub-selected":"" }">
								<a href="/?channelId=${article.channelId }">全部</a>
							</li>
							<c:forEach items="${categorys }" var="category">
								<li class="sub-item ${article.categoryId==category.id?"sub-selected":"" }"">
									<a href="/?channelId=${article.channelId }&categoryId=${category.id}">${category.name }</a>
								</li>
							</c:forEach>	
						</ul>
						<hr>
					</div>
				</c:if>
				<!--分类下的文章  -->
				<div>
					<c:forEach items="${info.list }" var="article">
					<div class="media" >
						<img alt="..." src="/pic/${article.picture }" class="mr-3 rounded">
						<div>
							<h5 class="mt-0" style="padding-top: 20px">
								<a href="/articleDeatil?id=${article.id }" target="blank">${article.title }</a>
							</h5>
							<p style="padding-top: 20px">${article.user.username } · ${article.hits }浏览 · <fmt:formatDate value="${article.created }" 
							pattern="yyyy-MM-dd HH:mm:ss"/></p>
						</div>
						
					</div>
					<hr>
					</c:forEach>
					<!--调取分页页面  -->
 					<jsp:include page="/view/common/pages.jsp"></jsp:include> 
				</div> 
			</div>

			<!-- 右边框 -->
			<div class="col-md-3" >
			
			<!-- 显示10篇新文章 -->
				<div class="card" style="width: 18rem; margin-top: 5px ">
				<div class="header" style="background-color:black;color: white;" align="center">最新文章</div>
				<div class="card-body">
					<c:forEach items="${lastArticles.list }" var="lastArticle">
						<div class="media">
						  <img src="/pic/${lastArticle.picture }" class="mr-3 rounded" alt="..." style="width: 60px;height: 60px">
						  <div class="media-body">
						    <p ><a href="/articleDeatil?id=${lastArticle.id }" target="black">${lastArticle.title }</a></p>
						  </div>
						</div>
						<hr>
					</c:forEach>
				  </div>
				</div>
				
				<!--点击排行榜  -->
				<div class="card" style="width: 18rem; margin-top: 6px" >
					<div class="header" style="background-color:black;color: white;" align="center">点击排行榜</div>
					<div class="card-body">
						<!-- 点击量文章-->
						<c:forEach items="${topArticles}" var="tops" varStatus="i">
							<div class="media">
								<div class="media-body">
									<p>
										<span  style="color:${i.count==1?"red":i.count==2?"blue":i.count==3?"pink":"grey"} ">${i.count}</span>
										 &nbsp;${tops.title }<br>     <font size="2" style="float: right;" color="red">点击量：${tops.hits }</font>
									</p>
								</div>
							</div>
							<hr>
						</c:forEach>
					</div>
				</div>
				
			</div>
		</div>
		
		
	
	</div>
	
	<script type="text/javascript">
	
		
	
		function goPage(page) {
			
			var channelId='${article.channelId}';
			var categoryId='${article.categoryId}';
			var url="/?channelId="+channelId+"&page="+page;
			if (categoryId!="") {
				url=url+"&categoryId="+categoryId;
			}
			location.href=url;
			
		}
		
		/*注册  */
		function reg() {
			
			$("#title").empty();
			$("#title").append("用户注册");
			$("#passport").load("/passport/reg");
		}
		/*注册  */
		function login() {
			$("#title").empty();
			$("#title").append("用户登录");
			$("#passport").load("/passport/login");
		}
	
	
	</script>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
</body>
</html>