<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
<%!
	public static final String GOODS_ADD_URL = "pages/back/admin/goods/goods_add.jsp" ;
	public static final String GOODS_DELETE_URL = "pages/back/admin/goods/goods_delete_do.jsp" ;
	public static final String GOODS_EDIT_URL = "pages/back/admin/goods/goods_edit.jsp" ;
	public static final String GOODS_LIST_URL = "pages/back/admin/goods/goods_list.jsp" ;
%>
<base href="<%=basePath%>"/>
<title>商品管理</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<script type="text/javascript" src="js/common/mldn_util.js"></script>
<script type="text/javascript" src="js/back/admin/goods/goods_list.js"></script>
<script type="text/javascript" src="jquery/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	jsDeleteUrl = "<%=basePath + GOODS_DELETE_URL%>" ;
</script>
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
</head>
<%
	request.setCharacterEncoding("UTF-8") ;
	int currentPage = 1 ;	// 当前所在的页面，默认是在第1页
	int lineSize = 5;	// 表示每页显示的数据行数
	int allRecorders = 0 ;	// 保存总记录的统计结果
	String columnData = "商品名称:name" ;
	String column = request.getParameter("col") ;
	String keyWord = request.getParameter("kw") ;
%>
<%	// cp表示的是currentPage参数的内容，接收的都是String，需要将其强制转换为int
	try {
		currentPage = Integer.parseInt(request.getParameter("cp")) ;
	} catch (Exception e) {}	// 分页的参数不正确，就出错
	try {
		lineSize = Integer.parseInt(request.getParameter("ls")) ;
	} catch (Exception e) {}
%>
<%
	IGoodsService goodsService=Factory.getServiceInstance("goods.service") ;
	Map<String,Object> map=goodsService.list(currentPage, lineSize, column, keyWord) ;
	List<Goods> allGoodss=(List<Goods>)map.get("allGoodss") ;
	allRecorders=(Integer)map.get("goodsCount") ;
	Map<Integer,String> itemMap=(Map<Integer,String>) map.get("allItems") ;
	
%>
<body>
	<div class="container">
		<div class="row">
			<div class="h1"><strong><span class="glyphicon glyphicon-th-list"></span>&nbsp;商品信息列表</strong></div>
		</div>
		<div class="row">
			<jsp:include page="/pages/plugins/split_plugin_search_bar.jsp">
				<jsp:param name="url" value="<%=GOODS_LIST_URL%>"/>
				<jsp:param name="column" value="<%=column%>"/>
				<jsp:param name="allRecorders" value="<%=allRecorders%>"/>
				<jsp:param name="columnData" value="<%=columnData%>"/>
				<jsp:param name="keyWord" value="<%=keyWord%>"/>
			</jsp:include> 
			<table class="table table-striped table-bordered table-hover">
				<tr>
					<td style="width:5%"><input type="checkbox" id="selectall"/></td>
					<td>商品名称</td>
					<td>商品单价</td>
					<td>商品分类</td>
					<td>操作</td>
				</tr>
				<%
					Iterator<Goods> iter=allGoodss.iterator() ;
					while(iter.hasNext()){
						Goods vo=iter.next() ;
				%>
				
				<tr>
					<td><input type="checkbox" id="gid" value="<%=vo.getGid()%>:<%=vo.getPhoto()%>"/></td>
					<td><%=vo.getName() %></td>
					<td><%=vo.getPrice() %></td>
					<td><%=itemMap.get(vo.getIid()) %></td>
					<td><a href="<%=GOODS_EDIT_URL%>?gid=<%=vo.getGid()%>" class="btn btn-warning btn-xs">
						<span class="glyphicon glyphicon-pencil"></span>&nbsp;编辑</a></td>
				</tr>
				<%		
					}
				%>
			</table>
			<jsp:include page="/pages/plugins/split_plugin_page_bar.jsp">
				<jsp:param name="url" value="<%=GOODS_LIST_URL%>"/>
				<jsp:param name="currentPage" value="<%=currentPage%>"/>
				<jsp:param name="lineSize" value="<%=lineSize%>"/>
				<jsp:param name="allRecorders" value="<%=allRecorders%>"/>
				<jsp:param name="column" value="<%=column%>"/>
				<jsp:param name="keyWord" value="<%=keyWord%>"/>
			</jsp:include> 
			<button id="deleteBtn" class="btn btn-danger btn-lg">
				<span class="glyphicon glyphicon-trash"></span>&nbsp;删除选中部信息
			</button>
		</div>
	</div>
</body>
</html>