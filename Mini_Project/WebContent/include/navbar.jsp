<%@page import="users.UsersDao"%>
<%@page import="users.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container">
	<!-- header -->
	<header class="blog-header py-3">
		<div class="row flex-nowrap justify-content-between align-items-center">
			<div class="col-4 pt-1">
				<a class="text-muted" href="https://github.com/jji3379/">Github</a>
			</div>
			<div class="col-4 text-center">
				<a class="blog-header-logo text-dark" href="${pageContext.request.contextPath }/index.jsp">Acorn</a>
			</div>
			<div class="col-4 d-flex justify-content-end align-items-center">
				<a class="text-muted" href="#" aria-label="Search">
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="mx-3" role="img" viewBox="0 0 24 24" focusable="false"><title>Search</title><circle cx="10.5" cy="10.5" r="7.5"/><path d="M21 21l-5.2-5.2"/></svg>
				</a>
				<a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath }/users/signup_form.jsp">Sign up</a>
			</div>
		</div>
	</header><!-- header END -->

	<div class="nav-scroller py-1 mb-2">
	<nav class="nav d-flex justify-content-between">
		<a class="p-2 text-muted" href="${pageContext.request.contextPath }/board/list.jsp">게시판</a>
		<a class="p-2 text-muted" href="${pageContext.request.contextPath }/reference/list.jsp">자료실</a>
		<a class="p-2 text-muted" href="#">Oracle</a>
		<a class="p-2 text-muted" href="#">HTML</a>
		<a class="p-2 text-muted" href="#">CSS</a>
		<a class="p-2 text-muted" href="#">Javascript</a>
		<a class="p-2 text-muted" href="#">Java</a>
		<a class="p-2 text-muted" href="#">Jsp</a>
		<a class="p-2 text-muted" href="#">Servlet</a>
		<a class="p-2 text-muted" href="#">BaekJoon</a>
		<a class="p-2 text-muted" href="#">MindMap</a>
		<a class="p-2 text-muted" href="#">Git</a>
	</nav>
	</div>

	<div class="jumbotron p-4 p-md-5 text-white rounded bg-dark">
		<div class="col-md-6 px-0">
			<h1 class="display-4 font-italic">Acorn Mini_Project</h1>
			<p class="lead my-3">Multiple lines of text that form the lede, informing new readers quickly and efficiently about what’s most interesting in this post’s contents.</p>
			<p class="lead mb-0"><a href="#" class="text-white font-weight-bold">Continue reading...</a></p>
		</div>
	</div>

	<div class="row mb-2">
		<div class="col-md-6">
			<div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
			   <div class="col p-4 d-flex flex-column position-static">
			    <strong class="d-inline-block mb-2 text-primary">World</strong>
			    <h3 class="mb-0">Featured post</h3>
			    <div class="mb-1 text-muted">Nov 12</div>
			    <p class="card-text mb-auto">This is a wider card with supporting text below as a natural lead-in to additional content.</p>
			    <a href="#" class="stretched-link">Continue reading</a>
			   </div>
			<div class="col-auto d-none d-lg-block">
				<svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
			</div>
			</div>
		</div>
	    <%
		  	//로그인된 아이디가 있는지 읽어와 본다.
			String id=(String)session.getAttribute("id");
	  		//2. 로그인된 아이디를 이용해서 DB 에서 가입정보를 불러온다.
			UsersDto dto=UsersDao.getInstance().getData(id);
	    %>
	    <%if(id==null){ %>
		<%
			//쿠키에 저장된 아이디와 비밀번호를 담을 변수
			String savedId="";
			String savedPwd="";
			//쿠키에 저장된 값을 위의 변수에 저장하는 코드를 작성해 보세요.
			Cookie[] cooks=request.getCookies();
			if(cooks!=null){
				//반복문 돌면서 쿠키객체를 하나씩 참조해서 
				for(Cookie tmp: cooks){
					//저장된 키값을 읽어온다.
					String key=tmp.getName();
					//만일 키값이 savedId 라면 
					if(key.equals("savedId")){
						//쿠키 value 값을 savedId 라는 지역변수에 저장
						savedId=tmp.getValue();
					}
					if(key.equals("savedPwd")){
						savedPwd=tmp.getValue();
					}
					
				}
			}
		%>
	    <!-- 로그인 안했을 경우 로그인 화면 -->
	    <div class="col-md-6">
		<div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
			<div class="col p-4 d-flex flex-column position-static">
				<!-- form Start -->
				<h1 class="h3 mb-3 font-weight-normal text-info" style="text-align:center">로 그 인</h1>
				<form class="form-signin" action="${pageContext.request.contextPath }/users/login.jsp" method="post" id="loginform">
					<!-- 아이디  -->
					<div>
						<input type="text" id="id" name="id" value="<%=savedId%>" class="form-control" 
						placeholder="아이디" required autofocus>
						<div class="invalid-feedback">사용할수 없는 아이디 입니다</div>
					</div><br />
					<!-- 비밀번호 -->
					<div>
						<input type="password" id="pwd" name="pwd" value="<%=savedPwd%>" placeholder="비밀번호" class="form-control" required>
						<div class="invalid-feedback">비밀번호를 확인 하세요</div>
						<label>
							<input type="checkbox" name="isSave" value="yes"/>
							로그인 상태 유지
						</label>
							<button style="float:right" class="btn-outline-info btn-sm" type="submit">로그인</button>
					</div><br />
				</form><!-- form END -->
			</div>
			<div class="col-auto d-none d-lg-block">
				<svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
			</div>
			</div>
	    </div><!-- col-md-6 END -->
	    <%}else{ %>
	    <!-- 로그인 했을 경우 회원 정보 출력 -->
	    <div class="col-md-6">
		<div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
			<div class="col p-4 d-flex flex-column position-static">
			<div class="row">
				<div style="top: 50%" class="col-5">
					<%if(dto.getProfile()==null){ %>
						<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
				  			<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
						</svg>
					<%}else{ %>
						<img src="${pageContext.request.contextPath}<%=dto.getProfile()%>" width="100" height="100" id="profileImage"/>
					<%} %>
				</div>
				<div style="top: 50%" class="col-7">
					 <p><strong style="font-size:20px"><%=dto.getId()%>님</strong> | <a style="color:black" href="${pageContext.request.contextPath }/users/private/info.jsp">내정보</a>
					 <%=dto.getEmail()%>					 
					 </p>
					 <a  class="btn btn-outline-secondary" href="${pageContext.request.contextPath }/users/logout.jsp">로그아웃</a>
				</div>
			</div>
			</div>
			<div class="col-auto d-none d-lg-block">
				<svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
			</div>
			<script>
				function deleteConfirm() {
					let isDelete=confirm("<%=id%> 회원님 탈퇴 하시겠습니까?");
					if(isDelete){
						location.href="delete.jsp";
					}
				}
			</script>
			</div>
			</div>
	    </div><!-- col-md-6 END -->
	    <%} %>
	</div><!-- row END -->
</div><!-- container END -->