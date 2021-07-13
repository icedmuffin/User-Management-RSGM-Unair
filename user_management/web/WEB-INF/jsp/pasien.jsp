<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject pasien = null;

if(action != null && action.equals("cari_pasien")){
	session.setAttribute("pasien_search_key",request.getParameter("pasien_search_key"));
}
String searchKey = (String) session.getAttribute("pasien_search_key");
if(searchKey == null){
	searchKey = "";
}


if(action != null && action.equals("add_edit_pasien")){
	
	FormPasien fp = new FormPasien();
	fp.setNama(request.getParameter("nama"));
	fp.setNohp(request.getParameter("no hp"));
	fp.setJeniskelamin(request.getParameter("jenis kelamin"));
	fp.setUmur(request.getParameter("umur"));
	fp.setKeluhan(request.getParameter("keluhan"));

	resp = PasienManagement.CreateEditPasien(fp);
	
}

InputPagingPasien ipp = new InputPagingPasien();
ipp.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipp.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipp.setSearchKey(searchKey);
}

Paging pagePasien = PasienManagement.getPagingPasien(ipp);


if(pasien == null){
	pasien = PasienManagement.createNewPasien();
}

%>

<div class="pure-g">
	<div class="pure-u-1-3" align="center">
		<h2>Data Pasien</h2>
		<hr>
		<% if(resp != null && resp.getKode() == Response.ERROR){ %>
			<h4 align="center" style="background-color:red;"><%=resp.getPesan()%></h4>
		<% }else if(resp != null && resp.getKode() == Response.OK){ %>
			<h4 align="center" style="background-color:lightgreen;"><%=resp.getPesan()%></h4>
		<% } %>
	</div>
	<div class="pure-u-2-3"></div>
</div>

<div class="pure-g">
	<div class="pure-u-1-3" align="left">
		<form class="pure-form pure-form-aligned" method="post" action="?act=pasien">
		<input type="hidden" name="action" value="add_edit_pasien" />
		<fieldset>
			<div class="pure-control-group">
				<label for="aligned-nama">Nama</label>
				<input type="text" name="nama" id="aligned-nama" placeholder="Nama" value="<%=pasien.getString("nama")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-nohp">No HP</label>
				<input type="text" name="no hp" id="aligned-no hp" placeholder="No HP" value="<%=pasien.getString("no hp")%>" />
			</div>
			<div class="pure-control-group">
                <label for="aligned-jeniskelamin">Jenis Kelamin</label>
                <input type="text" name="jenis kelamin" id="aligned-jeniskelamin" placeholder="Jenis Kelamin" value="<%=pasien.getString("jenis kelamin")%>" />
                </select>
            </div>
			<div class="pure-control-group">
				<label for="aligned-umur">Umur</label>
				<input type="text" name="umur" id="aligned-umur" placeholder="Umur" value="<%=pasien.getString("umur")%>" />
			</div>
			<div class="pure-control-group">
                <label for="aligned-keluhan">Keluhan</label>
                <input type="text" name="keluhan" id="aligned-keluhan" placeholder="Keluhan" value="<%=pasien.getString("keluhan")%>" />
                </select>
            </div>
			<div class="pure-controls">
				
				<input type="submit" class="pure-button pure-button-primary" value="Simpan">
			</div>
		</fieldset>
	</form>
	</div>
	<div class="pure-u-2-3" align="left">
		<p>menampilkan <%=pagePasien.getResultFrom()%> - <%=pagePasien.getResultTo()%> dari total <%=pagePasien.getTotalResults()%></p>
		<form action="?act=pasien" method="post" class="pure-form">
			<input type="hidden" name="action" value="cari_pasien" />
			<input type="text" name="pasien_search_key" class="pure-input-rounded" placeholder="Nama" value="<%=searchKey%>" />
			<input type="submit" class="pure-button pure-button-primary" value="cari" />
		</form>
		<p></p>									
		<table class="pure-table">
			<thead>
				<tr>
					<th>No</th>					
					<th>Nama</th>
					<th>No HP</th>
					<th>Jenis Kelamin</th>
					<th>Umur</th>
					<th>Keluhan</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<pagePasien.getResultList().size();i++){ 
					
				%>
				<tr>
					<td><%=(pagePasien.getResultFrom() + i)%></td>
					<td><%=pagePasien.getResultList().get(i).getString("nama")%></td>
					<td><%=pagePasien.getResultList().get(i).getString("no hp")%></td>
					<td><%=pagePasien.getResultList().get(i).getString("jenis kelamin")%></td>
					<td><%=pagePasien.getResultList().get(i).getString("umur")%></td>
                    <td><%=pagePasien.getResultList().get(i).getString("keluhan")%></td>
					<td>
						<a href="?act=view_pasien&nama=<%=pagePasien.getResultList().get(i).getString("nama")%>">View</a>
						<a href="?act=edit_pasien&nama=<%=pagePasien.getResultList().get(i).getString("nama")%>">Edit</a>
						<a href="?act=delete_pasien&nama=<%=pagePasien.getResultList().get(i).getString("nama")%>">Delete</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
		
		<p>
			<% if(pagePasien.isHasPrevious()){ %>
			<a href="?act=pasien&offset=<%=pagePasien.getPreviousOffset()%>"> Previous </a>
			<% } %>
			&nbsp;&nbsp;&nbsp; 
			<% if(pagePasien.isHasNext()){ %>
			<a href="?act=pasien&offset=<%=pagePasien.getNextOffset()%>"> Next </a>
			<% } %>
		</p>
	</div>
	
</div>