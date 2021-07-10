<%@ page import="rsgm_unair.jkn.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject jkn = null;

if(action != null && action.equals("cari_jkn")){
	session.setAttribute("jkn_search_key",request.getParameter("jkn_search_key"));
}
String searchKey = (String) session.getAttribute("jkn_search_key");
if(searchKey == null){
	searchKey = "";
}


if(action != null && action.equals("add_edit_jkn")){
	
	FormJKN fj = new FormJKN();
	fj.setNik(request.getParameter("nik"));
	fj.setNama(request.getParameter("nama"));
	fj.setTtl(request.getParameter("ttl"));
	fj.setAlamat(request.getParameter("alamat"));
	fj.setNoHP(request.getParameter("noHP"));
	fj.setEmail(request.getParameter("email"));
	fj.setFaskesTingkatI(request.getParameter("faskesTingkatI"));
	
	resp = JKNManagement.CreateEditJKN(fj);
	
}

InputPagingJKN ipj = new InputPagingJKN();
ipj.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipj.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipj.setSearchJKN(searchKey);
}

Paging pageJKN = JKNManagement.getPagingJKN(ipj);

String nik = request.getParameter("nik");
if(nik != null && !nik.trim().equals("")){
	jkn = JKNManagement.findJKN(nik);
}

if(jkn == null){
	jkn = JKNManagement.createNewJKN();
}

%>

<div class="pure-g">
	<div class="pure-u-1-1" align="center">
		<h2>Jaminan Kesehatan Nasional</h2>
		<hr>
		<% if(resp != null && resp.getKode() == Response.ERROR){ %>
			<h4 align="center" style="background-color:red;"><%=resp.getPesan()%></h4>
		<% }else if(resp != null && resp.getKode() == Response.OK){ %>
			<h4 align="center" style="background-color:blue;"><%=resp.getPesan()%></h4>
		<% } %>
	</div>
	<div class="pure-u-1-1"></div>
	<div class="pure-u-1-1" align="center">
		<p>Menampilkan <%=pageJKN.getResultFrom()%> - <%=pageJKN.getResultTo()%> dari total <%=pageJKN.getTotalResults()%> data pasien Jaminan Kesehatan Nasional</p>
		<form action="?act=jkn" method="post" class="pure-form">
			<input type="hidden" name="action" value="cari_jkn" />
			<input type="text" name="jkn_search_key" class="pure-input-rounded" placeholder="NIK" value="<%=searchKey%>" />
			<input type="submit" class="pure-button pure-button-primary" value="Cari" />
		</form>
		<p></p>
		<table class="pure-table">
			<thead>
				<tr>
					<th>#</th>
					<th>NIK</th>
					<th>Nama</th>
					<th>Tempat Tanggal Lahir</th>
					<th>Alamat</th>
					<th>Nomor Handphone</th>
					<th>Email</th>
					<th>Faskes Tingkat I</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<pageJKN.getResultList().size();i++){ 
					
				%>
				<tr>
					<td><%=(pageJKN.getResultFrom() + i)%></td>
					<td><%=pageJKN.getResultList().get(i).getString("nik")%></td>
					<td><%=pageJKN.getResultList().get(i).getString("nama")%></td>
					<td><%=pageJKN.getResultList().get(i).getString("ttl")%></td>
					<td><%=pageJKN.getResultList().get(i).getString("alamat")%></td>
					<td><%=pageJKN.getResultList().get(i).getString("noHP")%></td>
					<td><%=pageJKN.getResultList().get(i).getString("email")%></td>
					<td><%=pageJKN.getResultList().get(i).getString("faskesTingkatI")%></td>
					<td>
						<a href="?act=edit_jkn&nik=<%=pageJKN.getResultList().get(i).getString("nik")%>">Edit</a>
						|
						<a href="?act=delete_jkn&nik=<%=pageJKN.getResultList().get(i).getString("nik")%>">Delete</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
		
		<p>
			<% if(pageJKN.isHasPrevious()){ %>
			<a href="?act=jkn&offset=<%=pageJKN.getPreviousOffset()%>"> Previous </a>
			<% } %>
			&nbsp;&nbsp;&nbsp; 
			<% if(pageJKN.isHasNext()){ %>
			<a href="?act=jkn&offset=<%=pageJKN.getNextOffset()%>"> Next </a>
			<% } %>
		</p>
	</div>
	
</div>