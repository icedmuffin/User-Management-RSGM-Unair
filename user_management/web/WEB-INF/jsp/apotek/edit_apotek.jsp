<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String id = request.getParameter("kodeObat");
JSONObject apotek = ApotekManagement.findApotek(id);

String action = request.getParameter("action");

Response resp = null;


if(action != null && action.equals("add_edit_apotek")){
	
	FormApotek fp = new FormApotek();
	fp.setKodeObat(request.getParameter("kodeObat"));
    fp.setNamaObat(request.getParameter("namaObat"));
    fp.setHarga(request.getParameter("harga"));
	fp.setStok(request.getParameter("stok"));

	resp = ApotekManagement.CreateEditApotek(fp);
	
}
%>
<div class="pure-g">
	<div class="pure-u-1-3" align="left">
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
                <label for="aligned-harga">Harga</label>
                <input type="text" name="harga" id="aligned-harga" placeholder="Harga" value="<%=apotek.getString("harga")%>" />
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
</div>

