<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String id = request.getParameter("nama");
JSONObject rekammedik = RekammedikManagement.findRekammedik(id);
if(rekammedik == null){
	rekammedik = RekammedikManagement.createNewRekammedik();
}else{
	
	String isConfirm = request.getParameter("is_confirm");
	if(isConfirm != null && isConfirm.equals("yes")){
		RekammedikManagement.removeRekammedik(rekammedik.getString("_id"));
%>
	<script>
		window.location.href="?act=rekammedik";
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
						<td><%=rekammedik.getString("nama")%></td>
					</tr>
					<tr>
						<td>Ktp</td>
						<td>:</td>
						<td><%=rekammedik.getString("ktp")%></td>
					</tr>
					<tr>
						<td>Tanggal</td>
						<td>:</td>
						<td><%=rekammedik.getString("tanggal")%></td>
					</tr>
					<tr>
						<td>Keluhan dan Gejala</td>
						<td>:</td>
						<td><%=rekammedik.getString("keluhangejala")%></td>
					</tr>
                    <tr>
						<td>Diagnosa</td>
						<td>:</td>
						<td><%=rekammedik.getString("diagnosa")%></td>
					</tr>
					<tr>
						<td>Obat</td>
						<td>:</td>
						<td><%=rekammedik.getString("obat")%></td>
					</tr>
				</table>
				<form action="?act=delete_rekammedik&nama=<%=rekammedik.getString("nama")%>" method="post">
					<input type="hidden" name="is_confirm" value="yes" />
					<input type="submit" class="pure-button pure-button-danger" value="hapus" />
				</form>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>