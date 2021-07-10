<%@ page import="rsgm_unair.jkn.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject jkn = null;

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

if(jkn == null){
	jkn = JKNManagement.createNewJKN();
}

%>

<div class="pure-g">
	<div class="pure-u-1-1" align="center">
		<h2>Edit Data Pasien</h2>
		<form class="pure-form pure-form-aligned" method="post" action="?act=jkn">
		<input type="hidden" name="action" value="add_edit_jkn" />
		<fieldset>
			<div class="pure-control-group">
				<label for="aligned-name">NIK</label>
				<input type="text" name="nik" id="aligned-name" placeholder="NIK" value="<%=jkn.getString("nik")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-name">Nama</label>
				<input type="text" name="nama" id="aligned-name" placeholder="Nama" value="<%=jkn.getString("nama")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-name">Tempat Tanggal Lahir</label>
				<input type="text" name="ttl" id="aligned-name" placeholder="Tempat Tanggal Lahir" value="<%=jkn.getString("ttl")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-name">Alamat</label>
				<input type="text" name="alamat" id="aligned-name" placeholder="Alamat" value="<%=jkn.getString("alamat")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-name">Nomor Handphone</label>
				<input type="text" name="noHP" id="aligned-name" placeholder="Nomor Handphone" value="<%=jkn.getString("noHP")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-name">Email</label>
				<input type="text" name="email" id="aligned-name" placeholder="Email" value="<%=jkn.getString("email")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-name">Faskes Tingkat I</label>
				<input type="text" name="faskesTingkatI" id="aligned-name" placeholder="Faskes Tingkat I" value="<%=jkn.getString("faskesTingkatI")%>" />
			</div>
			
			<div class="pure-controls">
				
				<input type="submit" class="pure-button pure-button-primary" value="Simpan">
			</div>
