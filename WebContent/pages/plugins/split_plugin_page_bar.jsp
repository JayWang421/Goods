<%@ page pageEncoding="UTF-8"%>
<%--
<jsp:include page="split_plugin_page_bar.jsp">
	<jsp:param name="url" value="<%=URL%>"/>
	<jsp:param name="currentPage" value="<%=currentPage%>"/>
	<jsp:param name="lineSize" value="<%=lineSize%>"/>
	<jsp:param name="allRecorders" value="<%=allRecorders%>"/>
	<jsp:param name="column" value="<%=column%>"/>
	<jsp:param name="keyWord" value="<%=keyWord%>"/>
</jsp:include>
--%>
<%
	request.setCharacterEncoding("UTF-8") ;
	String url = request.getParameter("url") ;	// 提交路径
	int currentPage = 1 ;	// 当前所在的页面，默认是在第1页
	int lineSize = 1 ;	// 表示每页显示的数据行数
	int allRecorders = 0 ;	// 保存总记录的统计结果
	int pageSize = 1 ;	// 总页数
	String column = request.getParameter("column") ;
	String keyWord = request.getParameter("keyWord") ;
%>
<%
	try {
		currentPage = Integer.parseInt(request.getParameter("currentPage")) ;
	} catch (Exception e) {}
	try {
		lineSize = Integer.parseInt(request.getParameter("lineSize")) ;
	} catch (Exception e) {}
	try {
		allRecorders = Integer.parseInt(request.getParameter("allRecorders")) ;
	} catch (Exception e) {}
	if ("null".equals(column) || column == null || "".equals(column)) {
		column = "" ;
	}
	if ("null".equals(keyWord) || keyWord == null || "".equals(keyWord)) {
		keyWord = "" ;
	}
%>
<%
	int seed = 2 ;	// 定义一个种子数，用于判断是否会有“.”
	if (allRecorders > 0) {
		pageSize = (allRecorders + lineSize - 1) / lineSize ;
	}
%>
<div id="pageCtl">
	<ul class="pagination"> 
		<li class="<%=currentPage == 1? "active" : ""%>">
		<%
			if (currentPage == 1) {
		%>
				<span>1</span>
		<%
			} else {
		%>
			<a href="<%=url%>?cp=<%=1%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>">1</a></li>
		<%
			}
		%>
<%
	if (pageSize > (seed-1) * 2) {	// 数据量很大，需要进行省略号的出现
		if (currentPage <= seed * 2) {
			int startPage = 2 ;	// 从第2页开始显示
			int endPage = currentPage + seed * 2  ;	
			if (endPage >= pageSize)  {
				endPage = pageSize - 1 ;
			}
			for (int x = startPage ; x <= endPage ; x ++) {
%>
			<li class="<%=currentPage == x ? "active" : ""%>"><a href="<%=url%>?cp=<%=x%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>"><%=x%></a></li>
<%
			}
			if ((currentPage + seed * 2) < pageSize -1) {
%> 
				<li class="disabled"><span>...</span></li>
<%
			}
		} else {	// 需要分两段显示了
%>
			<li class="disabled"><span>...</span></li>
<%
			int startPage = currentPage - seed ;	
			int endPage = currentPage + seed ;
			if (endPage >= pageSize) {
				endPage = pageSize - 1 ;
			}
			for (int x = startPage ; x <= endPage ; x ++) {
%>
			<li class="<%=currentPage == x ? "active" : ""%>"><a href="<%=url%>?cp=<%=x%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>"><%=x%></a></li>
<%
			}
			if ((currentPage + seed * 2) < pageSize) {	// 后面还有很多页
%>
			<li class="disabled"><span>...</span></li>
<%
			} else {	// 后续的页码需要出现
				for (int x = currentPage + seed +1  ; x < pageSize ; x ++ ) {
%>
			<li class="<%=currentPage == x ? "active" : ""%>"><a href="<%=url%>?cp=<%=x%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>"><%=x%></a></li>
<%
				}
			}
		}
	}
%>
<%
	if (pageSize != 1) {
%>
		<li class="<%=currentPage == pageSize ? "active" : ""%>">
		<%
			if (currentPage == pageSize) {
		%>
				<span><%=pageSize%></li>
		<%
			} else {
		%>
				<a href="<%=url%>?cp=<%=pageSize%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>"><%=pageSize%></a>
		<%
			}
		%>
		</li>
<%
	}
%>
	</ul>
</div>