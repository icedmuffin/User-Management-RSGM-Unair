<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String action = request.getParameter("action");

Response resp = null;
JSONObject dokter = null;

if(action != null && action.equals("cari_dokter")){
	session.setAttribute("dokter_search_key",request.getParameter("dokter_search_key"));
}
String searchKey = (String) session.getAttribute("dokter_search_key");
if(searchKey == null){
	searchKey = "";
}


if(action != null && action.equals("add_edit_dokter")){
	
	FormDokter fp = new FormDokter();
	fp.setNama(request.getParameter("nama"));
	fp.setUnit(request.getParameter("unit"));
	fp.setJenis(request.getParameter("jenis"));
	fp.setJadwal(request.getParameter("jadwal"));
	
   
    

	resp = DokterManagement.CreateEditDokter(fp);
	
}

InputPagingDokter ipp = new InputPagingDokter();
ipp.setPerPage(10);

if(request.getParameter("offset") != null && !request.getParameter("offset").trim().equals("")){
    ipp.setOffset( Integer.parseInt(request.getParameter("offset")));
}
if(searchKey != null && !searchKey.trim().equals("")){
	ipp.setSearchKey(searchKey);
}

Paging pageDokter = DokterManagement.getPagingDokter(ipp);


if(dokter  == null){
	dokter  = DokterManagement.createNewDokter ();
}

%>

<div class="pure-g">
	<div class="pure-u-1-3" align="center">
		<h2>Tambah Dokter RSGM UNAIR</h2>
		<hr>
		
	</div>
	
</div>
<div class="pure-g">
	<div class="pure-u-1-3" align="center">
		<form class="pure-form pure-form-aligned" method="post" action="?act=dokter">
		<input type="hidden" name="action" value="add_edit_dokter" />
		<fieldset>
			<div class="pure-control-group">
				<label for="aligned-nama">Nama</label>
				<input type="text" name="nama" id="aligned-nama" placeholder="Nama" value="<%=dokter.getString("nama")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-unit">Unit</label>
				<input type="text" name="unit" id="aligned-unit" placeholder="Unit" value="<%=dokter.getString("unit")%>" />
			</div>
			<div class="pure-control-group">
                <label for="aligned-jenis">Jenis</label>
                <input type="text" name="jenis" id="aligned-jenis" placeholder="Jenis" value="<%=dokter.getString("jenis")%>" />
                </select>
            </div>
			<div class="pure-control-group">
				<label for="aligned-jadwal">Jadwal</label>
				<input type="text" name="jadwal" id="aligned-jadwal" placeholder="Jadwal" value="<%=dokter.getString("jadwal")%>" />
			</div>
		
			<div class="pure-controls">
				
				<input type="submit" class="pure-button pure-button-primary" value="Simpan">
			</div>
		</fieldset>
	</form>
	</div>
