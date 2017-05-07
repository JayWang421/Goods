<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="cn.mldn.util.factory.*" %>
<%@ page import="cn.mldn.service.*" %>
<%@ page import="cn.mldn.service.impl.*" %>
<%@ page import="cn.mldn.vo.*" %>
<html>
<head>
<%
	String basePath = request.getScheme() + "://" + 
		request.getServerName() + ":" + request.getServerPort() + 
		request.getContextPath() + "/" ;
%>
<base href="<%=basePath%>"/>
<title>商品管理</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<script type="text/javascript" src="jquery/jquery.min.js"></script>
<script type="text/javascript" src="js/back/admin/goods/goods_add.js"></script>
<script type="text/javascript" src="js/common/mldn_util.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
</head>
<%!
	public static final String GOODS_LIST_URL = "pages/back/admin/goods/goods_list.jsp" ;
%>	

<%
	request.setCharacterEncoding("UTF-8") ;
	String ids=request.getParameter("ids") ;
	Set<Integer> gidSet=new HashSet<Integer>() ;
	Set<String> photoSet=new HashSet<String>() ;
	String result [] =ids.split(",") ;
	for(int x=0 ; x<result.length ; x++){
		String temp [] =result[x].split(":") ;
		gidSet.add(Integer.parseInt(temp[0])) ;
		photoSet.add(temp[1]) ;
	}
	
	String msg="商品信息删除失败" ;
	IGoodsService goodsService=Factory.getServiceInstance("goods.service") ;
	if(goodsService.delete(gidSet)){
		msg="商品信息删除成功 "; 
		Iterator<String> iter=photoSet.iterator() ;
		while(iter.hasNext()){
			String filePath=getServletContext().getRealPath("/upload/goods/"+iter.next()) ; ;
			new File(filePath).delete() ;
		}
	}
%>
<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<jsp:include page="/pages/plugins/forward.jsp">
					<jsp:param value="<%=GOODS_LIST_URL%>" name="url"/>
					<jsp:param value="<%=msg %>" name="msg"/>
				</jsp:include>
			</div>
		</div>
	</div>
</body>
</html>