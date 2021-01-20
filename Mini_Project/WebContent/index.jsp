<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="./include/resource.jsp"></jsp:include>
<title>메인 페이지</title>
</head>
<body>
<jsp:include page="./include/navbar.jsp"></jsp:include>
<main role="main" class="container">
	<div class="row">
		<div class="col-md-9 blog-main">
			<h3 class="pb-4 mb-4 font-italic border-bottom">
			  index
			</h3>
		
			<div class="blog-post">
				<h2 class="blog-post-title">Sample blog post</h2>
					<p class="blog-post-meta">January 1, 2014 by <a href="#">Mark</a></p>
					<p>This blog post shows a few different types of content that’s supported and styled with Bootstrap. Basic typography, images, and code are all supported.</p>
					<hr>
					
					<p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>
					<blockquote>
					<p>Curabitur blandit tempus porttitor. <strong>Nullam quis risus eget urna mollis</strong> ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
					</blockquote>
					<p>Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>
				
				<h2>Heading</h2>
					<p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>
				<h3>Sub-heading</h3>
					<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>
					<pre><code>Example code block</code></pre>
					<p>Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa.</p>
					purus sit amet fermentum. Sed posuere consectetur est at lobortis.</p>
			</div><!-- /.blog-post -->
		</div><!-- /.blog-main -->
		<!-- 오른쪽 배너 -->
		<jsp:include page="./include/right.jsp"></jsp:include>
	</div><!-- /.row -->
</main><!-- /.container -->
<jsp:include page="./include/footer.jsp"></jsp:include>
</body>
</html>