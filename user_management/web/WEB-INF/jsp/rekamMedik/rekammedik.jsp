<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject rekammedik = null;

if(action != null && action.equals("cari_rekammedik")){
	session.setAttribute("rekammedik_search_key",request.getParameter("rekammedik_search_key"));
}
String searchKey = (String) session.getAttribute("rekammedik_search_key");
if(searchKey == null){
	searchKey = "";
}


if(action != null && action.equals("add_edit_rekammedik")){
	
	FormRekammedik fp = new FormRekammedik();
	fp.setNama(request.getParameter("nama"));
	fp.setKtp(request.getParameter("ktp"));
	fp.setTanggal(request.getParameter("tanggal"));
	fp.setKeluhangejala(request.getParameter("keluhangejala"));
    fp.setDiagnosa(request.getParameter("diagnosa"));
	fp.setObat(request.getParameter("obat"));


	resp = RekammedikManagement.CreateEditRekammedik(fp);
	
}

InputPagingRekammedik ipp = new InputPagingRekammedik();
ipp.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipp.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipp.setSearchKey(searchKey);
}

Paging pageRekammedik = RekammedikManagement.getPagingRekammedik(ipp);


if(rekammedik == null){
	rekammedik = RekammedikManagement.createNewRekammedik();
}

%>


	
<div> <h2 align="center">Daftar Pasien IGD RSGM UNAIR </h2></div>
<% if(resp != null && resp.getKode() == Response.ERROR){ %>
	<h4 align="center" style="background-color:red;"><%=resp.getPesan()%></h4>
<% }else if(resp != null && resp.getKode() == Response.OK){ %>
	<h4 align="center" style="background-color:lightgreen;"><%=resp.getPesan()%></h4>
<% } %>

		
	

<div>
    <style scoped="">
        .button-success {
            background: rgb(28, 184, 65);
            /* this is a green */
        }

        .button-error {
            background: rgb(202, 60, 60);
            /* this is a maroon */
        }

        .button-warning {
            background: rgb(223, 117, 20);
            /* this is an orange */
        }
        .button-secondary {
            background: rgb(66, 184, 221);
            /* this is a light blue */
        }
    </style>
</div>

	<div class="pure-u-2-3" align="center">
		<p>menampilkan <%=pageRekammedik.getResultFrom()%> - <%=pageRekammedik.getResultTo()%> dari total <%=pageRekammedik.getTotalResults()%></p>
		<form action="?act=rekammedik" method="post" class="pure-form">
			<input type="hidden" name="action" value="cari_rekammedik" />
			<input type="text" name="rekammedik_search_key" class="pure-input-rounded" placeholder="Nama" value="<%=searchKey%>" />
			<input type="submit" class="pure-button pure-button-primary" value="cari" />
		</form>
		<p></p>									
		<table class="pure-table">
			<thead>
				<tr>
					<th>No</th>					
					<th>Nama</th>
					<th>Ktp</th>
					<th>Tanggal</th>
					<th>Keluhan dan Gejala</th>
                    <th>Diagnosa</th>
					<th>Obat</th>
			
					<th></th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<pageRekammedik.getResultList().size();i++){ 
					
				%>
				<tr>
					<td><%=(pageRekammedik.getResultFrom() + i)%></td>
					<td><%=pageRekammedik.getResultList().get(i).getString("nama")%></td>
					<td><%=pageRekammedik.getResultList().get(i).getString("ktp")%></td>
					<td><%=pageRekammedik.getResultList().get(i).getString("tanggal")%></td>
					<td><%=pageRekammedik.getResultList().get(i).getString("keluhangejala")%></td>
                    <td><%=pageRekammedik.getResultList().get(i).getString("diagnosa")%></td>
					<td><%=pageRekammedik.getResultList().get(i).getString("obat")%></td>
					
					<td>
						<a class="button-secondary pure-button" href="?act=view_rekammedik&nama=<%=pageRekammedik.getResultList().get(i).getString("nama")%>">View</a>
						<a class="button-warning pure-button" href="?act=edit_rekammedik&nama=<%=pageRekammedik.getResultList().get(i).getString("nama")%>">Edit</a>
						<a class="button-error pure-button" href="?act=delete_rekammedik&nama=<%=pageRekammedik.getResultList().get(i).getString("nama")%>">Delete</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
	
		<div>
			<a href="?act=tambah_rekammedik"class="button-success pure-button" >Tambah Rekam Medis </a> 
		</div>
	</div>
	
</div>