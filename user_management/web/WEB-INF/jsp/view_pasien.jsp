<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String nama = request.getParameter("nama");
JSONObject pasien = PasienManagement.findPasien(nama);
%>

		<div class="pure-g">
			<div class="pure-u-1-3">
			</div>
			<div class="pure-u-1-3">
				<p style="background-color:navajowhite;">Informasi lengkap pasien</p>
				
				<table border="0">
					<tr>
						<td>Nama</td>
						<td>:</td>
						<td><%=pasien.getString("nama")%></td>
					</tr>
					<tr>
						<td>No HP</td>
						<td>:</td>
						<td><%=pasien.getString("no hp")%></td>
					</tr>
                    <tr>
						<td>Jenis Kelamin</td>
						<td>:</td>
						<td><%=pasien.getString("jenis kelamin")%></td>
					</tr>
					<tr>
						<td>Umur</td>
						<td>:</td>
						<td><%=pasien.getString("umur")%></td>
					</tr>
					<tr>
						<td>Keluhan</td>
						<td>:</td>
						<td><%=pasien.getString("keluhan")%></td>
					</tr>
				</table>
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>