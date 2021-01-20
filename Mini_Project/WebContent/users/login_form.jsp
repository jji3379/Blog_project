<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
html,
body {
  height: 100%;
}

body {
  display: -ms-flexbox;
  display: flex;
  -ms-flex-align: center;
  align-items: center;
  padding-top: 40px;
  padding-bottom: 40px;
  background-color: #f5f5f5;
}
</style>
<title>로그인</title>
</head>
<body>
<div class="container">
	<!-- form Start -->
	<h1 class="h3 mb-3 font-weight-normal text-info" style="text-align:center">로 그 인</h1>
	<form class="form-signin" action="login.jsp" method="post" id="loginform">
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
		</div><br />
	<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
	<p class="mt-5 mb-3 text-muted">&copy; 2020-2021</p>
	</form><!-- form END -->
</div>
</body>
</html>