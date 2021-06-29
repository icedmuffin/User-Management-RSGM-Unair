<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String username = request.getParameter("username");
JSONObject pasien = PasienManagement.findPasien(username);
if(pasien == null){
	pasien = PasienManagement.createNewPasien();
}else{
	
	String isConfirm = request.getParameter("is_confirm");
	if(isConfirm != null && isConfirm.equals("yes")){
		PasienManagement.removePasien(pasien.getString("username"));
%>
	<script>
		window.location.href="?act=pasien";
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
						<td><%=pasien.getString("username")%></td>
					</tr>
					<tr>
						<td>Complaint</td>
						<td>:</td>
						<td><%=pasien.getString("complaint")%></td>
					</tr>
				</table>
				<form action="?act=delete_pasien" method="post">
					<input type="hidden" name="username" value="<%=pasien.getString("username")%>" />
					<input type="hidden" name="is_confirm" value="yes" />
					<input type="submit" class="pure-button pure-button-danger" value="hapus" />
				</form>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>