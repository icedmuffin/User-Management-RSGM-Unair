
<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject pembayaran = null;

if(action != null && action.equals("cari_pembayaran")){
	session.setAttribute("pembayaran_search_key",request.getParameter("pembayaran_search_key"));
}
String searchKey = (String) session.getAttribute("pembayaran_search_key");
if(searchKey == null){
	searchKey = "";
}


if(action != null && action.equals("add_edit_pembayaran")){
	
	FormPembayaran fp = new FormPembayaran();
	fp.setNoPembayaran(request.getParameter("noPembayaran"));
	fp.setKtp(request.getParameter("ktp"));
	fp.setTanggal(request.getParameter("tanggal"));
	fp.setKategori(request.getParameter("kategori"));
    fp.setNominal(request.getParameter("nominal"));

	resp = PembayaranManagement.CreateEditPembayaran(fp);
	
}

InputPagingPembayaran ipp = new InputPagingPembayaran();
ipp.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipp.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipp.setSearchKey(searchKey);
}

Paging pagePembayaran = PembayaranManagement.getPagingPembayaran(ipp);


if(pembayaran == null){
	pembayaran = PembayaranManagement.createNewPembayaran();
}

%>


	
<div> <h2 align="center">Modul Pembayaran RSGM UNAIR </h2></div>
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
		<p>menampilkan <%=pagePembayaran.getResultFrom()%> - <%=pagePembayaran.getResultTo()%> dari total <%=pagePembayaran.getTotalResults()%></p>
		<form action="?act=pembayaran" method="post" class="pure-form">
			<input type="hidden" name="action" value="cari_pembayaran" />
			<input type="text" name="pembayaran_search_key" class="" placeholder="NoPembayaran" value="<%=searchKey%>" />
			<input type="submit" class="pure-button pure-button-primary" value="cari" />
		</form>
		<br>
		<div>
			<a href="?act=tambah_pembayaran"class=" pure-button" >Masukan Pembayaran baru</a> 
		</div>
		<br>
		<p></p>									
		<table class="pure-table">
			<thead>
				<tr>
					<th>No</th>				
					<th>NoPembayaran</th>
					<th>Ktp</th>
					<th>Tanggal Lahir</th>
					<th>Kategori</th>
                    <th>Nominal</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<pagePembayaran.getResultList().size();i++){ 
					
				%>
				<tr>
					<td><%=(pagePembayaran.getResultFrom() + i)%></td>
					<td><%=pagePembayaran.getResultList().get(i).getString("noPembayaran")%></td>
					<td><%=pagePembayaran.getResultList().get(i).getString("ktp")%></td>
					<td><%=pagePembayaran.getResultList().get(i).getString("tanggal")%></td>
					<td><%=pagePembayaran.getResultList().get(i).getString("kategori")%></td>
                    <td><%=pagePembayaran.getResultList().get(i).getString("nominal")%></td>
					<td>
						<a class="pure-button-primary pure-button" href="?act=view_pembayaran&noPembayaran=<%=pagePembayaran.getResultList().get(i).getString("noPembayaran")%>">View</a>
						|
						<a class="pure-button-primary pure-button" href="?act=edit_pembayaran&noPembayaran=<%=pagePembayaran.getResultList().get(i).getString("noPembayaran")%>">Edit</a>
						|
						<a class="pure-button-primary pure-button" href="?act=delete_pembayaran&noPembayaran=<%=pagePembayaran.getResultList().get(i).getString("noPembayaran")%>">Delete</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
	
		
	</div>
	
</div>