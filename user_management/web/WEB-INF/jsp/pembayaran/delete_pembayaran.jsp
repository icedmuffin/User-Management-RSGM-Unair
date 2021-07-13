<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String id = request.getParameter("noPembayaran");
JSONObject pembayaran = PembayaranManagement.findPembayaran(id);
if(pembayaran == null){
	pembayaran = PembayaranManagement.createNewPembayaran();
}else{
	
	String isConfirm = request.getParameter("is_confirm");
	if(isConfirm != null && isConfirm.equals("yes")){
		PembayaranManagement.removePembayaran(pembayaran.getString("_id"));
%>
	<script>
		window.location.href="?act=pembayaran";
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
						<td>noPembayaran</td>
						<td>:</td>
						<td><%=pembayaran.getString("noPembayaran")%></td>
					</tr>
					<tr>
						<td>ktp</td>
						<td>:</td>
						<td><%=pembayaran.getString("ktp")%></td>
					</tr>
                    <tr>
						<td>tanggal</td>
						<td>:</td>
						<td><%=pembayaran.getString("tanggal")%></td>
					</tr>
					<tr>
						<td>kategori</td>
						<td>:</td>
						<td><%=pembayaran.getString("kategori")%></td>
					</tr>
                    <tr>
						<td>nominal</td>
						<td>:</td>
						<td><%=pembayaran.getString("nominal")%></td>
					</tr>
                    
				</table>
				<form action="?act=delete_pembayaran&noPembayaran=<%=pembayaran.getString("noPembayaran")%>" method="post">
					<input type="hidden" name="is_confirm" value="yes" />
					<input type="submit" class="pure-button pure-button-danger" value="hapus" />
				</form>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>