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
	fp.setUsername(request.getParameter("username"));
	fp.setName(request.getParameter("name"));
	fp.setSex(request.getParameter("sex"));
	fp.setAge(request.getParameter("age"));
	fp.setAddress(request.getParameter("address"));
	fp.setComplaint(request.getParameter("complaint"));
	
	resp = PasienManagement.CreateEditPasien(fp);
	
}

InputPagingPasien ipp = new InputPagingPasien();
ipp.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipp.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipp.setSearchPasien(searchKey);
}

Paging pagePasien = PasienManagement.getPagingPasien(ipp);

String username = request.getParameter("username");
if(username != null && !username.trim().equals("")){
	pasien = PasienManagement.findPasien(username);
}

if(pasien == null){
	pasien = PasienManagement.createNewPasien();
}

%>

<div class="pure-g">
	<div class="pure-u-1-3" align="left">
		<h2>Zaidan Ganteng</h2>
		<hr>
		<% if(resp != null && resp.getKode() == Response.ERROR){ %>
			<h4 align="center" style="background-color:red;"><%=resp.getPesan()%></h4>
		<% }else if(resp != null && resp.getKode() == Response.OK){ %>
			<h4 align="center" style="background-color:blue;"><%=resp.getPesan()%></h4>
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
				<label for="aligned-name">Username</label>
				<input type="text" name="username" id="aligned-name" placeholder="Username" value="<%=pasien.getString("username")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-name">Name</label>
				<input type="text" name="name" id="aligned-name" placeholder="Name" value="<%=pasien.getString("name")%>" />
			</div>
			<div class="pure-control-group">
                <label for="multi-state">Sex</label>
                <select id="multi-state" name="sex">
                    <option <% if(pasien.getString("sex").equals("Laki-laki")){ %> selected="selected" <% } %>>Laki-laki</option>
                    <option <% if(pasien.getString("sex").equals("Perempuan")){ %> selected="selected" <% } %>>Perempuan</option>
                </select>
            </div>
			<div class="pure-control-group">
                <label for="multi-state">Age</label>
                <input type="text" name="age" id="aligned-name" placeholder="Age" value="<%=pasien.getString("age")%>" />
            </div>
			<div class="pure-control-group">
                <label for="aligned-name">Address</label>
                <input type="text" name="address" id="aligned-name" placeholder="Address" value="<%=pasien.getString("address")%>" />
            </div>
			
			<div class="pure-control-group">
				<label for="aligned-name">Complaint</label>
				<input type="text" name="complaint" id="aligned-name" placeholder="Complaint" value="<%=pasien.getString("complaint")%>" />
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
			<input type="text" name="pasien_search_key" class="pure-input-rounded" placeholder="Username" value="<%=searchKey%>" />
			<input type="submit" class="pure-button pure-button-primary" value="cari" />
		</form>
		<p></p>
		<table class="pure-table">
			<thead>
				<tr>
					<th>#</th>
					<th>Username</th>
					<th>Name</th>
					<th>Sex</th>
					<th>Age</th>
					<th>Address</th>
					<th>Complaint</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<pagePasien.getResultList().size();i++){ 
					
				%>
				<tr>
					<td><%=(pagePasien.getResultFrom() + i)%></td>
					<td><%=pagePasien.getResultList().get(i).getString("username")%></td>
					<td><%=pagePasien.getResultList().get(i).getString("name")%></td>
					<td><%=pagePasien.getResultList().get(i).getString("sex")%></td>
					<td><%=pagePasien.getResultList().get(i).getString("age")%></td>
					<td><%=pagePasien.getResultList().get(i).getString("address")%></td>
					<td><%=pagePasien.getResultList().get(i).getString("complaint")%></td>
					<td>
						<a href="?act=pasien&username=<%=pagePasien.getResultList().get(i).getString("username")%>">Edit</a>
						|
						<a href="?act=delete_pasien&username=<%=pagePasien.getResultList().get(i).getString("username")%>">Delete</a>
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