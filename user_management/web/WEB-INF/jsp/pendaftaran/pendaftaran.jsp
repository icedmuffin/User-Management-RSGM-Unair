<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject pendaftaran = null;

if(action != null && action.equals("cari_pendaftaran")){
	session.setAttribute("pendaftaran_search_key",request.getParameter("pendaftaran_search_key"));
}
String searchKey = (String) session.getAttribute("pendaftaran_search_key");
if(searchKey == null){
	searchKey = "";
}


if(action != null && action.equals("add_edit_pendaftaran")){
	
	FormPendaftaran fp = new FormPendaftaran();
	fp.setNama(request.getParameter("nama"));
	fp.setUsia(request.getParameter("usia"));
	fp.setTanggallahir(request.getParameter("tanggal lahir"));
	fp.setAlamat(request.getParameter("alamat"));

	resp = PendaftaranManagement.CreateEditPendaftaran(fp);
	
}

InputPagingPendaftaran ipp = new InputPagingPendaftaran();
ipp.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipp.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipp.setSearchKey(searchKey);
}

Paging pagePendaftaran = PendaftaranManagement.getPagingPendaftaran(ipp);


if(pendaftaran == null){
	pendaftaran = PendaftaranManagement.createNewPendaftaran();
}

%>


	
<div> <h2 align="center">Daftar Pasien</h2></div>
<% if(resp != null && resp.getKode() == Response.ERROR){ %>
	<h4 align="center" style="background-color:red;"><%=resp.getPesan()%></h4>
<% }else if(resp != null && resp.getKode() == Response.OK){ %>
	<h4 align="center" style="background-color:lightgreen;"><%=resp.getPesan()%></h4>
<% } %>

		
	

<div>
    <style scoped="">

    </style>
</div>

	<div class="pure-u-2-3" align="center">
		<p>menampilkan <%=pagePendaftaran.getResultFrom()%> - <%=pagePendaftaran.getResultTo()%> dari total <%=pagePendaftaran.getTotalResults()%></p>
		<form action="?act=pendaftaran" method="post" class="pure-form pure-form-aligned">
			<input type="hidden" name="action" value="cari_pendaftaran" />
			<input type="text" name="pendaftaran_search_key" class="" placeholder="Nama pasien" value="<%=searchKey%>" />
			<input type="submit" class="pure-button pure-button-primary" value="cari" />
		</form>
		<br>
		<div>
			<a href="?act=tambah_pendaftaran"class="pure-button" >Tambah Pasien</a> 
		</div>
		<br>
		<p></p>									
		<table class="pure-table">
			<thead>
				<tr>
					<th>No</th>					
					<th>Nama</th>
					<th>Usia</th>
					<th>Tanggal Lahir</th>
					<th>Alamat</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<pagePendaftaran.getResultList().size();i++){ 
					
				%>
				<tr>
					<td><%=(pagePendaftaran.getResultFrom() + i)%></td>
					<td><%=pagePendaftaran.getResultList().get(i).getString("nama")%></td>
					<td><%=pagePendaftaran.getResultList().get(i).getString("usia")%></td>
					<td><%=pagePendaftaran.getResultList().get(i).getString("tanggal lahir")%></td>
					<td><%=pagePendaftaran.getResultList().get(i).getString("alamat")%></td>
					<td>
						<a class="pure-button pure-button-primary" href="?act=view_pendaftaran&nama=<%=pagePendaftaran.getResultList().get(i).getString("nama")%>">View</a>
						|
						<a class="pure-button pure-button-primary" href="?act=edit_pendaftaran&nama=<%=pagePendaftaran.getResultList().get(i).getString("nama")%>">Edit</a>
						|
						<a class="pure-button pure-button-primary" href="?act=delete_pendaftaran&nama=<%=pagePendaftaran.getResultList().get(i).getString("nama")%>">Delete</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
	
		
	</div>
	
</div>