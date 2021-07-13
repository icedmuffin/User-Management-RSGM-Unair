<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String kodeObat = request.getParameter("kodeObat");
JSONObject apotek = ApotekManagement.findApotek(kodeObat);
%>

		<div class="pure-g">
			<div class="pure-u-1-3">
			</div>
			<div class="pure-u-1-3">
				<p style="background-color:navajowhite;">Informasi lengkap Obat</p>
				
				<table border="0">
					<tr>
						<td>Nama</td>
						<td>:</td>
						<td><%=apotek.getString("kodeObat")%></td>
					</tr>
					<tr>
						<td>Usia</td>
						<td>:</td>
						<td><%=apotek.getString("namaObat")%></td>
					</tr>
                    <tr>
						<td>Tanggal Lahir</td>
						<td>:</td>
						<td><%=apotek.getString("harga")%></td>
					</tr>
					<tr>
						<td>Alamat</td>
						<td>:</td>
						<td><%=apotek.getString("stok")%></td>
					</tr>
                    
				</table>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>