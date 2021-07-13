<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="org.json.*" %>
<%
String nama = request.getParameter("nama");
JSONObject rekammedik = RekammedikManagement.findRekammedik(nama);
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
			</div>
			<div class="pure-u-1-3">
			</div>
		</div>