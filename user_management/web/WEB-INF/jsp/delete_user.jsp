<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String username = request.getParameter("username");
JSONObject user = UserManagement.findUser(username);
if(user == null){
	user = UserManagement.createNewUser();
}else{
	
	String isConfirm = request.getParameter("is_confirm");
	if(isConfirm != null && isConfirm.equals("yes")){
		UserManagement.removeUser(user.getString("username"));
%>
	<script>
		window.location.href="?act=user";
	</script>
<%
		return;
	}
}
%>
		
		<div class="pure-g">
			<div class="pure-u-1-3">
			</div>
			<div class="pure-u-1-3">
				<p style="background-color:yellow;">Apakah Anda Yakin Ingin Menghapus ?</p>
				
				<table border="0">
					<tr>
						<td>Username</td>
						<td>:</td>
						<td><%=user.getString("username")%></td>
					</tr>
					<tr>
						<td>Role</td>
						<td>:</td>
						<td><%=user.getString("role")%></td>
					</tr>
				</table>
				<form action="?act=delete_user" method="post">
					<input type="hidden" name="username" value="<%=user.getString("username")%>" />
					<input type="hidden" name="is_confirm" value="yes" />
					<input type="submit" class="pure-button pure-button-danger" value="hapus" />
				</form>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>