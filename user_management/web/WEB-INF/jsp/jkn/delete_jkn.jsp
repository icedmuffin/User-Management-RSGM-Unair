<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String nik = request.getParameter("nik");
JSONObject jkn = JKNManagement.findJKN(nik);
if(jkn == null){
	jkn = JKNManagement.createNewJKN();
}else{
	
	String isConfirm = request.getParameter("is_confirm");
	if(isConfirm != null && isConfirm.equals("yes")){
		JKNManagement.removeJKN(jkn.getString("nik"));
%>
	<script>
		window.location.href="?act=jkn";
	</script>
<%
		return;
	}
}
%>
		
		<div class="pure-g">
			<div class="pure-u-1-1">
			</div>
			<div class="pure-u-1-1">
				<p style="background-color:yellow;">Apakah Anda Yakin Ingin Menghapus ?</p>
				
				<table border="0">
					<tr>
						<td>NIK</td>
						<td>:</td>
						<td><%=jkn.getString("nik")%></td>
					</tr>
					<tr>
						<td>Nama</td>
						<td>:</td>
						<td><%=jkn.getString("nama")%></td>
					</tr>
				</table>
				<form action="?act=delete_jkn" method="post">
					<input type="hidden" name="nik" value="<%=jkn.getString("nik")%>" />
					<input type="hidden" name="is_confirm" value="yes" />
					<input type="submit" class="pure-button pure-button-danger" value="Hapus" />
				</form>
			</div>
			<div class="pure-u-1-1">
			</div>
		</div>