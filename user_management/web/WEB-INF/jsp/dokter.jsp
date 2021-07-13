<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject dokter = null;

if(action != null && action.equals("cari_dokter")){
	session.setAttribute("dokter_search_key",request.getParameter("dokter_search_key"));
}
String searchKey = (String) session.getAttribute("dokter_search_key");
if(searchKey == null){
	searchKey = "";
}


if(action != null && action.equals("add_edit_dokter")){
	
	FormDokter fp = new FormDokter();
	fp.setNama(request.getParameter("nama"));
	fp.setUnit(request.getParameter("unit"));
	fp.setJenis(request.getParameter("jenis"));
	fp.setJadwal(request.getParameter("jadwal"));
	
   
    

	resp = DokterManagement.CreateEditDokter(fp);
	
}

InputPagingDokter ipp = new InputPagingDokter();
ipp.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipp.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipp.setSearchKey(searchKey);
}

Paging pageDokter = DokterManagement.getPagingDokter(ipp);


if(dokter  == null){
	dokter  = DokterManagement.createNewDokter ();
}

%>


<div> <h2 align="center">Daftar Pasien RSGM UNAIR </h2></div>
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
		<p>menampilkan <%=pageDokter.getResultFrom()%> - <%=pageDokter.getResultTo()%> dari total <%=pageDokter.getTotalResults()%></p>
		<form action="?act=dokter" method="post" class="pure-form">
			<input type="hidden" name="action" value="cari_dokter" />
			<input type="text" name="dokter_search_key" class="pure-input-rounded" placeholder="Nama" value="<%=searchKey%>" />
			<input type="submit" class="pure-button pure-button-primary" value="cari" />
		</form>
		<p></p>									
		<table class="pure-table">
			<thead>
				<tr>
					<th>No</th>					
					<th>Nama</th>
					<th>Unit</th>
					<th>Jenis</th>
					<th>Jadwal</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<pageDokter.getResultList().size();i++){ 
                
					
				%>
				<tr>
					<td><%=(pageDokter.getResultFrom() + i)%></td>
					<td><%=pageDokter.getResultList().get(i).getString("nama")%></td>
					<td><%=pageDokter.getResultList().get(i).getString("unit")%></td>
					<td><%=pageDokter.getResultList().get(i).getString("jenis")%></td>
					<td><%=pageDokter.getResultList().get(i).getString("jadwal")%></td>
                    <td>
						<a class="button-secondary pure-button" href="?act=view_dokter&nama=<%=pageDokter.getResultList().get(i).getString("nama")%>">View</a>
						|
						<a class="button-warning pure-button" href="?act=edit_dokter&nama=<%=pageDokter.getResultList().get(i).getString("nama")%>">Edit</a>
						|
						<a class="button-error pure-button" href="?act=delete_dokter&nama=<%=pageDokter.getResultList().get(i).getString("nama")%>">Delete</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
		
		<a href="?act=tambah_dokter"class="button-success pure-button" >Tambah Dokter</a>
		
	
	</div> 
	
</div>