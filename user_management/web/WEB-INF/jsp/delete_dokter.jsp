<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String id = request.getParameter("nama");
JSONObject dokter = DokterManagement.findDokter(id);
if(dokter == null){
	dokter = DokterManagement.createNewDokter();
}else{
	
	String isConfirm = request.getParameter("is_confirm");
	if(isConfirm != null && isConfirm.equals("yes")){
		DokterManagement.removeDokter(dokter.getString("_id"));
%>
	<script>
		window.location.href="?act=dokter";
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
						<td><%=dokter.getString("nama")%></td>
					</tr>
					<tr>
						<td>Unit</td>
						<td>:</td>
						<td><%=dokter.getString("unit")%></td>
					</tr>
					<tr>
						<td>Jenis</td>
						<td>:</td>
						<td><%=dokter.getString("jenis")%></td>
					</tr>
					<tr>
						<td>Alamat</td>
						<td>:</td>
						<td><%=dokter.getString("jadwal")%></td>
					</tr>
				</table>
				<form action="?act=delete_dokter&nama=<%=dokter.getString("nama")%>" method="post">
					<input type="hidden" name="is_confirm" value="yes" />
					<input type="submit" class="pure-button pure-button-danger" value="hapus" />
				</form>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>