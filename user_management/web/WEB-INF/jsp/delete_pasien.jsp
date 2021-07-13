<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String id = request.getParameter("nama");
JSONObject pasien = PasienManagement.findPasien(id);
if(pasien == null){
	pasien = PasienManagement.createNewPasien();
}else{
	
	String isConfirm = request.getParameter("is_confirm");
	if(isConfirm != null && isConfirm.equals("yes")){
		PasienManagement.removePasien(pasien.getString("_id"));
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
				<p style="background-color:red;">Apakah Anda Yakin Ingin Menghapus?</p>
				
				<table border="0">
					<tr>
						<td>Nama</td>
						<td>:</td>
						<td><%=pasien.getString("nama")%></td>
					</tr>
					<tr>
						<td>No HP</td>
						<td>:</td>
						<td><%=pasien.getString("no hp")%></td>
					</tr>
					<tr>
						<td>Jenis Kelamin</td>
						<td>:</td>
						<td><%=pasien.getString("jenis kelamin")%></td>
					</tr>
					<tr>
						<td>Umur</td>
						<td>:</td>
						<td><%=pasien.getString("umur")%></td>
					</tr>
					<tr>
						<td>Keluhan</td>
						<td>:</td>
						<td><%=pasien.getString("keluhan")%></td>
					</tr>
				</table>
				<form action="?act=delete_pasien&nama=<%=pasien.getString("nama")%>" method="post">
					<input type="hidden" name="is_confirm" value="yes" />
					<input type="submit" class="pure-button pure-button-danger" value="hapus" />
				</form>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>