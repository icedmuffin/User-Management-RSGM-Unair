<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String id = request.getParameter("nama");
JSONObject pendaftaran = PendaftaranManagement.findPendaftaran(id);
if(pendaftaran == null){
	pendaftaran = PendaftaranManagement.createNewPendaftaran();
}else{
	
	String isConfirm = request.getParameter("is_confirm");
	if(isConfirm != null && isConfirm.equals("yes")){
		PendaftaranManagement.removePendaftaran(pendaftaran.getString("_id"));
%>
	<script>
		window.location.href="?act=pendaftaran";
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
						<td><%=pendaftaran.getString("nama")%></td>
					</tr>
					<tr>
						<td>Usia</td>
						<td>:</td>
						<td><%=pendaftaran.getString("usia")%></td>
					</tr>
					<tr>
						<td>Tanggal Lahir</td>
						<td>:</td>
						<td><%=pendaftaran.getString("tanggal lahir")%></td>
					</tr>
					<tr>
						<td>Alamat</td>
						<td>:</td>
						<td><%=pendaftaran.getString("alamat")%></td>
					</tr>
				</table>
				<form action="?act=delete_pendaftaran&nama=<%=pendaftaran.getString("nama")%>" method="post">
					<input type="hidden" name="is_confirm" value="yes" />
					<input type="submit" class="pure-button pure-button-danger" value="hapus" />
				</form>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>