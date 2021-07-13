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

<div class="pure-g">
	<div class="pure-u-1-3" align="center">
		<h2>Tambah Pasien RSGM UNAIR</h2>
		<hr>
		
	</div>
	
</div>
<div class="pure-g">
	<div class="pure-u-1-3" align="center">
		<form class="pure-form pure-form-aligned" method="post" action="?act=pendaftaran">
		<input type="hidden" name="action" value="add_edit_pendaftaran" />
		<fieldset>
			<div class="pure-control-group">
				<label for="aligned-nama">Nama</label>
				<input type="text" name="nama" id="aligned-nama" placeholder="Nama" value="<%=pendaftaran.getString("nama")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-usia">Usia</label>
				<input type="number" name="usia" id="aligned-usia" placeholder="usia" value="<%=pendaftaran.getString("usia")%>" />
			</div>
			<div class="pure-control-group">
                <label for="aligned-tanggallahir">Tanggal Lahir</label>
                <input type="text" name="tanggal lahir" id="aligned-tanggallahir" placeholder="Tanggal Lahir" value="<%=pendaftaran.getString("tanggal lahir")%>" />
                </select>
            </div>
			<div class="pure-control-group">
				<label for="aligned-alamat">Alamat</label>
				<input type="text" name="alamat" id="aligned-alamat" placeholder="Alamat" value="<%=pendaftaran.getString("alamat")%>" />
			</div>
		
			<div class="pure-controls">
				
				<input type="submit" class="pure-button pure-button-primary" value="Simpan">
			</div>
		</fieldset>
	</form>
	</div>

   
    
		