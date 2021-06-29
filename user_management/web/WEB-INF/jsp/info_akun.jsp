<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String username = (String) session.getAttribute("username");
JSONObject user = UserManagement.findUser(username);
%>		
		<div class="pure-g">
			<div class="pure-u-1-5">
			</div>
			<div class="pure-u-3-5">
				<h2> Informasi Akun </h2>
			</div>
			<div class="pure-u-1-5">
			</div>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-5">
			</div>
			<div class="pure-u-3-5">
				<p>Username : <%=user.getString("username")%></p>
			</div>
			<div class="pure-u-1-5">
			</div>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-5">
			</div>
			<div class="pure-u-3-5">
				<p>Role : <%=user.getString("role")%></p>
			</div>
			<div class="pure-u-1-5">
			</div>
		</div>