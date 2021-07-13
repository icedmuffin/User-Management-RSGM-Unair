<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String nama = request.getParameter("nama");
JSONObject apotek = ApotekManagement.findApotek(nama);
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
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>