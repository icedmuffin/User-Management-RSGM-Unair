<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject rekammedik = null;

if(action != null && action.equals("cari_rekammedik")){
	session.setAttribute("rekammedik_search_key",request.getParameter("rekammedik_search_key"));
}
String searchKey = (String) session.getAttribute("rekammedik_search_key");
if(searchKey == null){
	searchKey = "";
}


if(action != null && action.equals("add_edit_rekammedik")){
	
	FormRekammedik fp = new FormRekammedik();
	fp.setNama(request.getParameter("nama"));
	fp.setKtp(request.getParameter("ktp"));
	fp.setTanggal(request.getParameter("tanggal"));
	fp.setKeluhangejala(request.getParameter("keluhangejala"));
    fp.setDiagnosa(request.getParameter("diagnosa"));
	fp.setObat(request.getParameter("obat"));


	resp = RekammedikManagement.CreateEditRekammedik(fp);
	
}

InputPagingRekammedik ipp = new InputPagingRekammedik();
ipp.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipp.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipp.setSearchKey(searchKey);
}

Paging pageRekammedik = RekammedikManagement.getPagingRekammedik(ipp);


if(rekammedik == null){
	rekammedik = RekammedikManagement.createNewRekammedik();
}

%>

<div class="pure-g">
	<div class="pure-u-1-3" align="center">
		<h2>Tambah Rekam Medik</h2>
		<hr>
		
	</div>
	
</div>
<div class="pure-g">
	<div class="pure-u-1-3" align="center">
		<form class="pure-form pure-form-aligned" method="post" action="?act=rekammedik">
		<input type="hidden" name="action" value="add_edit_rekammedik" />
		<fieldset>
			<div class="pure-control-group">
				<label for="aligned-nama">Nama</label>
				<input type="text" name="nama" id="aligned-nama" placeholder="Nama" value="<%=rekammedik.getString("nama")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-ktp">KTP</label>
				<input type="number" name="ktp" id="aligned-ktp" placeholder="KTP" value="<%=rekammedik.getString("ktp")%>" />
			</div>
			<div class="pure-control-group">
                <label for="aligned-tanggal">Tanggal</label>
                <input type="datetime-local" name="tanggal" id="aligned-tanggal" placeholder="Tanggal" value="<%=rekammedik.getString("tanggal")%>" />
                </select>
            </div>
			<div class="pure-control-group">
				<label for="aligned-keluhangejala">Keluhan dan Gejala</label>
				<input type="text" name="keluhangejala" id="aligned-keluhangejala" placeholder="Keluhan dan Gejala" value="<%=rekammedik.getString("keluhangejala")%>" />
			</div>
            <div class="pure-control-group">
				<label for="aligned-diagnosa">Diagnosa</label>
				<input type="text" name="diagnosa" id="aligned-diagnosa" placeholder="Diagnosa" value="<%=rekammedik.getString("diagnosa")%>" />
			</div>
            
			<div class="pure-control-group">
				<label for="aligned-obat">Obat</label>
				<input type="text" name="obat" id="aligned-obat" placeholder="Obat" value="<%=rekammedik.getString("obat")%>" />
			</div>
	
			<div class="pure-controls">
				
				<input type="submit" class="pure-button pure-button-primary" value="Simpan">
			</div>
		</fieldset>
	</form>
	</div>

   
    
		