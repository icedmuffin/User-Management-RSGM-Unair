<%@ page import="rsgm_unair.user_management.UserManagement" %>
<%@ page import="rsgm_unair.user_management.FormLogin" %>
<%@ page import="rsgm_unair.shared.Response" %>
<%
String errorMessage = null;

String isLogin = (String) session.getAttribute("is_login");
if(isLogin != null && isLogin.equals("1")){
	response.sendRedirect("home.jsp");
	return;
}

String act = request.getParameter("act");

if( act != null && act.equals("login")){
	
	FormLogin fl = new FormLogin();
	
	fl.setUsername(request.getParameter("username"));
	fl.setPassword(request.getParameter("password"));
		
	Response ar = UserManagement.auth(fl);
	
	if(ar.getKode() == Response.OK){
		
		session.setAttribute("is_login","1");
		session.setAttribute("username",fl.getUsername());
		
		response.sendRedirect("home.jsp");
		return;
	}else{
		errorMessage = ar.getPesan();
	}
	
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
			<div class="pure-u-1-3"></div>
			<div class="pure-u-1-3">
				<div class="pure-g">
					<div class="pure-u-1-3">
						<img class="pure-img" width="100" src="img/logo.png">
					</div>
					<div class="pure-u-2-3"><h1 align="center">Rumah Sakit Gigi Dan Mulut</h1></div>
					
				</div>
				
			</div>
			<div class="pure-u-1-3"></div>
		</div>
		
		<div class="pure-g">
			<div class="pure-u-1-3"></div>
			<div class="pure-u-1-3">
				<hr>
			</div>
			<div class="pure-u-1-3"></div>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-3"></div>
			<div class="pure-u-1-3">
				<% if(errorMessage != null){ %>
					<h4 align="center" style="background-color:red;"><%=errorMessage%></h4>
				<% } %>
				<form class="pure-form pure-form-aligned" action="login.jsp" method="post">
					<input type="hidden" name="act" value="login" />
					<fieldset>
						<div class="pure-control-group">
							<label for="aligned-username">Username</label>
							<input type="text" id="aligned-username" placeholder="Username" name="username" />
							
						</div>
						<div class="pure-control-group">
							<label for="aligned-password">Password</label>
							<input type="password" id="aligned-password" name="password" placeholder="Password" />
						</div>
						<div class="pure-controls">
							<input class="pure-button pure-button-primary" type="submit" value="login" />
						</div>
					</fieldset>
				</form>
			</div>
			<div class="pure-u-1-3"></div>
		</div>
	</body>
</html>