<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject apotek = null;

if(action != null && action.equals("cari_apotek")){
	session.setAttribute("apotek_search_key",request.getParameter("apotek_search_key"));
}
String searchKey = (String) session.getAttribute("apotek_search_key");
if(searchKey == null){
	searchKey = "";
}


if(action != null && action.equals("add_edit_apotek")){
	
	FormApotek fp = new FormApotek();
	fp.setNama(request.getParameter("nama"));
	fp.setUsia(request.getParameter("usia"));
	fp.setTanggallahir(request.getParameter("tanggal lahir"));
	fp.setAlamat(request.getParameter("alamat"));
    fp.setObat(request.getParameter("obat"));

	resp = ApotekManagement.CreateEditApotek(fp);
	
}

InputPagingApotek ipp = new InputPagingApotek();
ipp.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipp.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipp.setSearchKey(searchKey);
}

Paging pageApotek = ApotekManagement.getPagingApotek(ipp);


if(apotek == null){
	apotek = ApotekManagement.createNewApotek();
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

    </style>
</div>

	<div class="pure-u-2-3" align="center">
		<p>menampilkan <%=pageApotek.getResultFrom()%> - <%=pageApotek.getResultTo()%> dari total <%=pageApotek.getTotalResults()%></p>
		<form action="?act=apotek" method="post" class="pure-form">
			<input type="hidden" name="action" value="cari_apotek" />
			<input type="text" name="apotek_search_key" class="" placeholder="Nama" value="<%=searchKey%>" />
			<input type="submit" class="pure-button pure-button-primary" value="cari" />
		</form>
		<br>
		<div>
			<a href="?act=tambah_apotek"class=" pure-button" >Tambah Obat</a> 
		</div>
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
                    <th>Obat</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<pageApotek.getResultList().size();i++){ 
					
				%>
				<tr>
					<td><%=(pageApotek.getResultFrom() + i)%></td>
					<td><%=pageApotek.getResultList().get(i).getString("nama")%></td>
					<td><%=pageApotek.getResultList().get(i).getString("usia")%></td>
					<td><%=pageApotek.getResultList().get(i).getString("tanggal lahir")%></td>
					<td><%=pageApotek.getResultList().get(i).getString("alamat")%></td>
                    <td><%=pageApotek.getResultList().get(i).getString("obat")%></td>
					<td>
						<a class="pure-button-primary pure-button" href="?act=view_apotek&nama=<%=pageApotek.getResultList().get(i).getString("nama")%>">View</a>
						|
						<a class="pure-button-primary pure-button" href="?act=edit_apotek&nama=<%=pageApotek.getResultList().get(i).getString("nama")%>">Edit</a>
						|
						<a class="pure-button-primary pure-button" href="?act=delete_apotek&nama=<%=pageApotek.getResultList().get(i).getString("nama")%>">Delete</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
	

	
</div>