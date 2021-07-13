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

<div class="pure-g">
	<div class="pure-u-1-3" align="center">
		<h2>Tambah Obat Pasien</h2>
		<hr>
		
	</div>
	
</div>
<div class="pure-g">
	<div class="pure-u-1-3" align="center">
		<form class="pure-form pure-form-aligned" method="post" action="?act=apotek">
		<input type="hidden" name="action" value="add_edit_apotek" />
		<fieldset>
			<div class="pure-control-group">
				<label for="aligned-kodeObat">KodeObat</label>
				<input type="text" name="kodeObat" id="aligned-kodeObat" placeholder="KodeObat" value="<%=apotek.getString("kodeObat")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-namaObat">NamaObat</label>
				<input type="text" name="namaObat" id="aligned-namaObat" placeholder="namaObat" value="<%=apotek.getString("namaObat")%>" />
			</div>
			<div class="pure-control-group">
                <label for="aligned-tanggallahir">Harga</label>
                <input type="text" name="harga" id="aligned-tanggallahir" placeholder="Harga" value="<%=apotek.getString("harga")%>" />
                </select>
            </div>
			<div class="pure-control-group">
				<label for="aligned-stok">Stok</label>
				<input type="number" name="stok" id="aligned-stok" placeholder="Stok" value="<%=apotek.getString("stok")%>" />
			</div>

		
			<div class="pure-controls">
				
				<input type="submit" class="pure-button pure-button-primary" value="Simpan">
			</div>
		</fieldset>
	</form>
	</div>

   
    
		