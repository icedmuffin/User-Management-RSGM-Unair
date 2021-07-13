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
	fp.setKodeObat(request.getParameter("kodeObat"));
	fp.setNamaObat(request.getParameter("namaObat"));
	fp.setHarga(request.getParameter("harga"));
	fp.setStok(request.getParameter("stok"));


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
			<input type="text" name="apotek_search_key" class="" placeholder="KodeObat" value="<%=searchKey%>" />
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
					<th>KodeObat</th>
					<th>NamaObat</th>
					<th>Harga</th>
					<th>Stok</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<pageApotek.getResultList().size();i++){ 
					
				%>
				<tr>
					<td><%=(pageApotek.getResultFrom() + i)%></td>
					<td><%=pageApotek.getResultList().get(i).getString("kodeObat")%></td>
					<td><%=pageApotek.getResultList().get(i).getString("namaObat")%></td>
					<td><%=pageApotek.getResultList().get(i).getString("harga")%></td>
					<td><%=pageApotek.getResultList().get(i).getString("stok")%></td>
					<td>
						<a class="pure-button-primary pure-button" href="?act=view_apotek&kodeObat=<%=pageApotek.getResultList().get(i).getString("kodeObat")%>">View</a>
						|
						<a class="pure-button-primary pure-button" href="?act=edit_apotek&kodeObat=<%=pageApotek.getResultList().get(i).getString("kodeObat")%>">Edit</a>
						|
						<a class="pure-button-primary pure-button" href="?act=delete_apotek&kodeObat=<%=pageApotek.getResultList().get(i).getString("kodeObat")%>">Delete</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
	

	
</div>