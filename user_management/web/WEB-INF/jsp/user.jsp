<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject user = null;

if(action != null && action.equals("cari_user")){
	session.setAttribute("user_search_key",request.getParameter("user_search_key"));
}
String searchKey = (String) session.getAttribute("user_search_key");
if(searchKey == null){
	searchKey = "";
}


if(action != null && action.equals("add_edit_user")){
	
	FormUser fu = new FormUser();
	fu.setUsername(request.getParameter("username"));
	fu.setPassword(request.getParameter("password"));
	fu.setRole(request.getParameter("role"));
	
	resp = UserManagement.CreateEditUser(fu);
	
}

InputPagingUser ipu = new InputPagingUser();
ipu.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipu.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipu.setSearchKey(searchKey);
}

Paging pageUser = UserManagement.getPagingUsers(ipu);

String username = request.getParameter("username");
if(username != null && !username.trim().equals("")){
	user = UserManagement.findUser(username);
}

if(user == null){
	user = UserManagement.createNewUser();
}

%>

<div class="pure-g">
	<div class="pure-u-1-3" align="left">
		<h2>Manajemen User</h2>
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
		<form class="pure-form pure-form-aligned" method="post" action="?act=user">
		<input type="hidden" name="action" value="add_edit_user" />
		<fieldset>
			<div class="pure-control-group">
				<label for="aligned-name">Username</label>
				<input type="text" name="username" id="aligned-name" placeholder="Username" value="<%=user.getString("username")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-password">Password</label>
				<input type="password" name="password" id="aligned-password" placeholder="Password" />
			</div>
			<div class="pure-control-group">
                <label for="multi-state">Role</label>
                <select id="multi-state" name="role">
                    <option <% if(user.getString("role").equals("admin")){ %> selected="selected" <% } %>>admin</option>
                    <option <% if(user.getString("role").equals("dokter")){ %> selected="selected" <% } %>>dokter</option>
                    <option <% if(user.getString("role").equals("mahasiswa")){ %> selected="selected" <% } %>>mahasiswa</option>
                    <option <% if(user.getString("role").equals("keuangan")){ %> selected="selected" <% } %>>keuangan</option>
                </select>
            </div>
			
			<div class="pure-controls">
				
				<input type="submit" class="pure-button pure-button-primary" value="Simpan">
			</div>
		</fieldset>
	</form>
	</div>
	<div class="pure-u-2-3" align="left">
		<p>menampilkan <%=pageUser.getResultFrom()%> - <%=pageUser.getResultTo()%> dari total <%=pageUser.getTotalResults()%></p>
		<form action="?act=user" method="post" class="pure-form">
			<input type="hidden" name="action" value="cari_user" />
			<input type="text" name="user_search_key" class="pure-input-rounded" placeholder="Username" value="<%=searchKey%>" />
			<input type="submit" class="pure-button pure-button-primary" value="cari" />
		</form>
		<p></p>
		<table class="pure-table">
			<thead>
				<tr>
					<th>#</th>
					<th>Username</th>
					<th>Role</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<pageUser.getResultList().size();i++){ 
					
				%>
				<tr>
					<td><%=(pageUser.getResultFrom() + i)%></td>
					<td><%=pageUser.getResultList().get(i).getString("username")%></td>
					<td><%=pageUser.getResultList().get(i).getString("role")%></td>
					<td>
						<a href="?act=user&username=<%=pageUser.getResultList().get(i).getString("username")%>">Edit</a>
						|
						<a href="?act=delete_user&username=<%=pageUser.getResultList().get(i).getString("username")%>">Delete</a>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
		
		<p>
			<% if(pageUser.isHasPrevious()){ %>
			<a href="?act=user&offset=<%=pageUser.getPreviousOffset()%>"> Previous </a>
			<% } %>
			&nbsp;&nbsp;&nbsp; 
			<% if(pageUser.isHasNext()){ %>
			<a href="?act=user&offset=<%=pageUser.getNextOffset()%>"> Next </a>
			<% } %>
		</p>
	</div>
	
</div>