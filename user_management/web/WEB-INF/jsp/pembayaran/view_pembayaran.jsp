<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String noPembayaran = request.getParameter("noPembayaran");
JSONObject pembayaran = PembayaranManagement.findPembayaran(noPembayaran);
%>

		<div class="pure-g">
			<div class="pure-u-1-3">
			</div>
			<div class="pure-u-1-3">
				<p style="background-color:navajowhite;">Informasi lengkap Pasien</p>
				
				<table border="0">
					<tr>
						<td>Nama</td>
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
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>