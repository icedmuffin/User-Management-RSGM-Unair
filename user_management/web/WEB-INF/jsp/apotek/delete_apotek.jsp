<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String id = request.getParameter("nama");
JSONObject apotek = ApotekManagement.findApotek(id);
if(apotek == null){
	apotek = ApotekManagement.createNewApotek();
}else{
	
	String isConfirm = request.getParameter("is_confirm");
	if(isConfirm != null && isConfirm.equals("yes")){
		ApotekManagement.removeApotek(apotek.getString("_id"));
%>
	<script>
		window.location.href="?act=apotek";
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
						<td><%=apotek.getString("nama")%></td>
					</tr>
					<tr>
						<td>Usia</td>
						<td>:</td>
						<td><%=apotek.getString("usia")%></td>
					</tr>
                    <tr>
						<td>Tanggal Lahir</td>
						<td>:</td>
						<td><%=apotek.getString("tanggal lahir")%></td>
					</tr>
					<tr>
						<td>Alamat</td>
						<td>:</td>
						<td><%=apotek.getString("alamat")%></td>
					</tr>
                    <tr>
						<td>Obat</td>
						<td>:</td>
						<td><%=apotek.getString("obat")%></td>
					</tr>
				</table>
				<form action="?act=delete_apotek&nama=<%=apotek.getString("nama")%>" method="post">
					<input type="hidden" name="is_confirm" value="yes" />
					<input type="submit" class="pure-button pure-button-danger" value="hapus" />
				</form>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>