<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/insertfomr.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<main role="main" class="container">
	<div class="row">
		<div class="col-md-9 blog-main">
			<h3 class="pb-4 mb-4 font-italic border-bottom">
				Free bulletin board
			</h3>
		
			<div class="blog-post">
				<form action="insert.jsp" method="post">
					<div class="form-group">
						<label for="title">제목</label>
						<input class="form-control" type="text" name="title" id="title" placeholder="제목을 입력해주세요."/>
					</div>
					<div>
						<label for="content">내용</label>
						<textarea class="form-control" name="content" id="content"/></textarea>
					</div>
					<div style="float:right">
						<button style="float:auto; margin-top:5px;" class="btn btn-primary btn-sm" type="submit" onclick="submitContents(this)">작성</button>
						<a style="margin-top:5px;" class="btn btn-secondary btn-sm" href="${pageContext.request.contextPath }/board/list.jsp">취소</a>
					</div>
				</form>
			</div><!-- /.blog-post -->
		</div><!-- /.blog-main -->
		<!-- 오른쪽 배너 -->
		<jsp:include page="../../include/right.jsp"></jsp:include>
	</div><!-- /.row -->
</main><!-- /.container -->
<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
<!-- SmartEditor 에서 필요한 javascript 로딩  -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>
    var oEditors = [];
    
    //추가 글꼴 목록
    //var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
    
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "content",
        sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",    
        htParams : {
            bUseToolbar : true,                // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,        // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            //aAdditionalFontList : aAdditionalFontSet,        // 추가 글꼴 목록
            fOnBeforeUnload : function(){
                //alert("완료!");
            }
        }, //boolean
        fOnAppLoad : function(){
            //예제 코드
            //oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
        },
        fCreator: "createSEditor2"
    });
    
    function pasteHTML() {
        var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
        oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
    }
    
    function showHTML() {
        var sHTML = oEditors.getById["content"].getIR();
        alert(sHTML);
    }
        
    function submitContents(elClickedObj) {
        oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);    // 에디터의 내용이 textarea에 적용됩니다.
        
        // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
        
        try {
            elClickedObj.form.submit();
        } catch(e) {}
    }
    
    function setDefaultFont() {
        var sDefaultFont = '궁서';
        var nFontSize = 24;
        oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
    }
</script>
</html>