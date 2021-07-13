<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String nama = request.getParameter("nama");
JSONObject dokter = DokterManagement.findDokter(nama);
%>

		<div class="pure-g">
			<div class="pure-u-1-3">
			</div>
			<div class="pure-u-1-3">
				<p style="background-color:navajowhite;">Informasi lengkap Dokter</p>
				
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
						<td>Jadwal</td>
						<td>:</td>
						<td><%=dokter.getString("jadwal")%></td>
					</tr>
					<tr>
						<td>Jenis</td>
						<td>:</td>
						<td><%=dokter.getString("jenis")%></td>
					</tr>
				</table>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>