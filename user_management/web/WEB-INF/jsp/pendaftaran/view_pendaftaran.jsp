<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String nama = request.getParameter("nama");
JSONObject pendaftaran = PendaftaranManagement.findPendaftaran(nama);
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
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>