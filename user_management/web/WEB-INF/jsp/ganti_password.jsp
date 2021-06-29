<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>				
<%
String action = request.getParameter("action");
Response resp = null;
if(action != null && action.equals("ganti_password")){
	FormGantiPassword fg = new FormGantiPassword();
	fg.setUsername((String) session.getAttribute("username"));
	fg.setPasswordLama(request.getParameter("password_lama"));
	fg.setPasswordBaru(request.getParameter("password_baru"));
	fg.setPasswordKonfirmasi(request.getParameter("password_konfirmasi"));
	
	resp = UserManagement.gantiPassword(fg);
}
%>
		<div class="pure-g">
			<div class="pure-u-1-3"></div>
			<div class="pure-u-1-3">
				<% if(resp != null && resp.getKode() == Response.ERROR){ %>
					<h4 align="center" style="background-color:red;"><%=resp.getPesan()%></h4>
				<% }else if(resp != null && resp.getKode() == Response.OK){ %>
					<h4 align="center" style="background-color:blue;"><%=resp.getPesan()%></h4>
				<% } %>
				<h2>Ganti Password</h2>
				<form class="pure-form pure-form-aligned" action="?act=ganti_password" method="post">
				<input type="hidden" name="action" value="ganti_password">
				<fieldset>
					<div class="pure-control-group">
						<label for="aligned-password">Password Lama</label>
						<input type="password" id="aligned-password" name="password_lama" placeholder="Password Lama" />
					</div>
					<div class="pure-control-group">
						<label for="aligned-password2">Password Lama</label>
						<input type="password" id="aligned-password2" name="password_baru" placeholder="Password baru" />
					</div>
					<div class="pure-control-group">
						<label for="aligned-password3">Konfirmasi</label>
						<input type="password" id="aligned-password3" name="password_konfirmasi" placeholder="Konfirmasi Password baru" />
					</div>
					
					<div class="pure-controls">
						<input type="submit" class="pure-button pure-button-primary" value="ganti password" />
					</div>
				</fieldset>
				</form>
			</div>
			<div class="pure-u-1-3"></div>
		</div>