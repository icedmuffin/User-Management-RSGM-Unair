<%@ page import="rsgm_unair.user_management.UserManagement" %>
<%
String act = request.getParameter("act");
if(act == null || act.trim().equals("")){
	act = "default";
}

String isLogin = (String) session.getAttribute("is_login");
if(isLogin == null || !isLogin.equals("1")){
	response.sendRedirect("index.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="css/pure-min.css"/>
    </head>
	<body>
		<div class="pure-g">
			<div class="pure-u-1" align="center">
				<div class="pure-menu pure-menu-horizontal" >
					<a href="home.jsp" class="pure-menu-heading pure-menu-link"><img class="pure-img" width="100" src="img/logo.png"></a>
					<ul class="pure-menu-list">
						<li class="pure-menu-item">
							<a href="?act=user" class="pure-menu-link">user</a>
						</li>
						<li class="pure-menu-item">
							<a href="?act=pasien" class="pure-menu-link">pasien</a>
						</li>
						<li class="pure-menu-item">
							<a href="?act=jkn" class="pure-menu-link">jkn</a>
						</li>
						<li class="pure-menu-item pure-menu-has-children pure-menu-allow-hover">
							<a href="#" class="pure-menu-link">akun</a>
							<ul class="pure-menu-children">
								<li class="pure-menu-item">
									<a href="?act=info_akun" class="pure-menu-link">info akun</a>
								</li>
								<li class="pure-menu-item">
									<a href="?act=ganti_password" class="pure-menu-link">ganti password</a>
								</li>
							</ul>
						</li>
						<li class="pure-menu-item">
							<a href="?act=logout" class="pure-menu-link">logout</a>
						</li>
					</ul>	
				</div>
			</div>
		</div>
		<div class="pure-g">
			<div class="pure-u-1" align="center">
				<hr>
			</div>
		</div>
		<div class="pure-g">
			<div class="pure-u-1" align="center">
			<% if(act.equals("default")){ %>
			<h3> Silakan memilih menu </h3>
			<% }else if(act.equals("logout")){ %>
			<jsp:include page="WEB-INF/jsp/konfirmasi_logout.jsp"/>
			<% }else if(act.equals("info_akun")){ %>
			<jsp:include page="WEB-INF/jsp/info_akun.jsp"/>
			<% }else if(act.equals("ganti_password")){ %>
			<jsp:include page="WEB-INF/jsp/ganti_password.jsp"/>
			<% }else if(act.equals("user")){ %>
			<jsp:include page="WEB-INF/jsp/user.jsp"/>
			<% }else if(act.equals("delete_user")){ %>
			<jsp:include page="WEB-INF/jsp/delete_user.jsp"/>
			<% }else if(act.equals("pasien")){ %>
			<jsp:include page="WEB-INF/jsp/pasien.jsp"/>
			<% }else if(act.equals("delete_pasien")){ %>
			<jsp:include page="WEB-INF/jsp/delete_pasien.jsp"/>
			<% }else if(act.equals("jkn")){ %>
			<jsp:include page="WEB-INF/jsp/jkn/menu_jkn.jsp"/>
			<% }else if(act.equals("delete_jkn")){ %>
			<jsp:include page="WEB-INF/jsp/jkn/delete_jkn.jsp"/>
			<% } %>
			</div>
		</div>
	
		
	</body>
</html>