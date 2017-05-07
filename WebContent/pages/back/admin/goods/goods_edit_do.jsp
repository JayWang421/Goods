<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.jspsmart.*" %>
<%@ page import="com.jspsmart.upload.*" %>
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
	SmartUpload smart=new SmartUpload() ;
	smart.initialize(config, request, response) ;
	smart.upload() ;
	Goods vo=new Goods() ;
	vo.setGid(Integer.parseInt(smart.getRequest().getParameter("gid"))) ;
	vo.setName(smart.getRequest().getParameter("name")) ;
	vo.setPrice(Double.parseDouble(smart.getRequest().getParameter("price"))) ;
	vo.setIid(Integer.parseInt(smart.getRequest().getParameter("item"))) ;
	String tags [] =smart.getRequest().getParameterValues("tag") ;
	Set<Integer> tagSet=new HashSet<Integer>() ;
	for(int x=0 ; x<tags.length ; x++ ){
		tagSet.add(Integer.parseInt(tags[x])) ;
	}
	String msg="商品信息编辑失败" ;
	IGoodsService goodsService=Factory.getServiceInstance("goods.service") ;
	if(goodsService.edit(vo, tagSet)){
		msg="商品信息编辑成功 "; 
		if(smart.getFiles().getSize()>0){
			String filePath=getServletContext().getRealPath("/upload/goods/"+smart.getRequest().getParameter("oldphoto")) ;
			smart.getFiles().getFile(0).saveAs(filePath) ;
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