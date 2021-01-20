<%@page import="java.net.URLEncoder"%>
<%@page import="board.BoardDao"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=10;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;
	
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum=Integer.parseInt(strPageNum);
	}
	
	/*
		[ 검색 키워드에 관련된 처리]
		-검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.
	*/
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	//만일 키워드가 넘어오지 않는다면
	if(keyword==null){
		//키워드와 검색 조건에 빈 문자열을 넣어준다.
		//클라이언트 웹브라우저에 출력할 때 "null" 을 출력되지 않게 하기 위해서
		keyword="";
		condition="";
	}
	
	//특수기호를 인코딩한 키워드를 미리 준비한다.
	String encodedK=URLEncoder.encode(keyword);
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	//startRowNum 과 endRowNum  을 CafeDto 객체에 담고
	BoardDto dto=new BoardDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
	List<BoardDto> list=null;
	//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
	int totalRow=0;
	//만일 검색 키워드가 넘어온다면
	if(!keyword.equals("")){
		//검색 조건이 무엇이냐에 따라 분기 하기
		if(condition.equals("title")){//제목 검색인 경우
			dto.setTitle(keyword);
			list=BoardDao.getInstance().getListT(dto);
			totalRow=BoardDao.getInstance().getCountT(dto);
			
		}else if(condition.equals("writer")){//작성자 검색인 경우
			dto.setWriter(keyword);
			list=BoardDao.getInstance().getListW(dto);
			totalRow=BoardDao.getInstance().getCountW(dto);
		
		}//다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가하면 된다.
	}else{//검색 키워드가 넘어오지 않는다면
		//키워드가 없을 때 호출하는 메소드를 이용해서 파일 목록을 얻어온다.
		list=BoardDao.getInstance().getList(dto);
		//키워드가 없을 때 호출하는 메소드를 이용해서 전체 row 의 개수를 얻어온다.
		totalRow=BoardDao.getInstance().getCount();
	}
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	
	//전체 페이지의 갯수 구하기
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해 준다. 
	}
	List<BoardDto> list2=BoardDao.getInstance().getList(dto);
	//로그인된 아이디가 있는지 읽어와본다 (로그인을 하지 않았으면 null 이다)
	String id=(String)session.getAttribute("id");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/Board/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<main role="main" class="container">
	<div class="row">
		<div class="col-md-9 blog-main">
			<h3 class="pb-4 mb-4 font-italic border-bottom">
				Free bulletin board
			</h3>
			<div class="blog-post">
				<div class="container">
					<div>
						<a class="btn btn-secondary" href="private/insertform.jsp">글작성</a>
						<!-- 검색창 -->
						<form action="list.jsp" method="get" style="display:inline-block; float:right;">
							<select name="condition" id="condition">
								<option value="title" <%=condition.equals("title")? "selected":"" %>>제목</option>
								<option value="writer" <%=condition.equals("writer")? "selected":"" %>>작성자</option>
							</select>
							<input type="text" name="keyword" value="<%=keyword%>"/>
							<button style="margin-bottom:4px;" class="btn btn-outline-dark btn-sm" type="submit">검색</button>
						</form><!-- 검색창 END -->
					</div><br />			
					<p style="border-bottom:double;"></p>
					<table class="table">
						<thead class="thead-dark">
							<tr style="display:none">
								<th style="display:none">글번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>등록일</th>
								<th>조회수</th>
							</tr>
							
						</thead>
						<tbody>
						<%for(BoardDto tmp:list){ %>
							<tr>
								<td style="display:none"><%=tmp.getNum() %></td>
								<td style="width:50%"><a style="color:black; font-size:1.1rem" href="detail.jsp?num=<%=tmp.getNum()%>"><%=tmp.getTitle() %></a></td>
								<td style="width:15%"><%=tmp.getWriter() %></td>
								<td style="width:30%"><%=tmp.getRegdate() %></td>
								<td style="width:5%"><%=tmp.getViewCount() %></td>
							</tr>
						<%} %>
						</tbody>
					</table>
					<nav>
						<ul class="pagination justify-content-center">
							<%if(startPageNum != 1){ %>
								<li class="page-item">
									<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>">Prev</a>
								</li>
							<%}else{ %>
								<li class="page-item disabled">
									<a class="page-link" href="javascript:">Prev</a>
								</li>
							<%} %>
							<%for(int i=startPageNum; i<=endPageNum; i++) {%>
								<%if(i==pageNum){ %>
									<li class="page-item active">
										<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
									</li>
								<%}else{ %>
									<li class="page-item">
										<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
									</li>
								<%} %>
							<%} %>
							<%if(endPageNum < totalPageCount){ %>
								<li class="page-item">
									<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>">Next</a>
								</li>
							<%}else{ %>
								<li class="page-item disabled">
									<a class="page-link" href="javascript:">Next</a>
								</li>
							<%} %>
						</ul>
					</nav>
					<%if(!keyword.equals("")){ %>
						<div class="alert alert-success">
							<strong><%=totalRow %></strong> 개의 자료가 검색되었습니다.
						</div>
					<%} %>
				</div>
			</div><!-- /.blog-post -->
		</div><!-- /.blog-main -->
		<!-- 오른쪽 배너 -->
		<jsp:include page="../include/right.jsp"></jsp:include>
	</div><!-- /.row -->
</main><!-- /.container -->
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>