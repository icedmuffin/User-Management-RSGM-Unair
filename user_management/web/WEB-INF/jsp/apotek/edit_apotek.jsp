<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String id = request.getParameter("nama");
JSONObject apotek = ApotekManagement.findApotek(id);

String action = request.getParameter("action");

Response resp = null;


if(action != null && action.equals("add_edit_apotek")){
	
	FormApotek fp = new FormApotek();
	fp.setNama(request.getParameter("nama"));
    fp.setUsia(request.getParameter("usia"));
    fp.setTanggallahir(request.getParameter("tanggal lahir"));
	fp.setAlamat(request.getParameter("alamat"));

	resp = ApotekManagement.CreateEditApotek(fp);
	
}
%>
<div class="pure-g">
	<div class="pure-u-1-3" align="left">
		<form class="pure-form pure-form-aligned" method="post" action="?act=apotek">
		<input type="hidden" name="action" value="add_edit_apotek" />
		<fieldset>
			<div class="pure-control-group">
				<label for="aligned-nama">Nama</label>
				<input type="text" name="nama" id="aligned-nama" placeholder="Nama" value="<%=apotek.getString("nama")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-usia">Usia</label>
				<input type="number" name="usia" id="aligned-usia" placeholder="usia" value="<%=apotek.getString("usia")%>" />
			</div>
			<div class="pure-control-group">
                <label for="aligned-tanggallahir">Tanggal Lahir</label>
                <input type="datetime" name="tanggal lahir" id="aligned-tanggallahir" placeholder="Tanggal Lahir" value="<%=apotek.getString("tanggal lahir")%>" />
                </select>
            </div>
			<div class="pure-control-group">
				<label for="aligned-alamat">Alamat</label>
				<input type="text" name="alamat" id="aligned-alamat" placeholder="Alamat" value="<%=apotek.getString("alamat")%>" />
			</div>
            <div class="pure-control-group">
				<label for="aligned-obat">Obat</label>
				<input type="text" name="obat" id="aligned-obat" placeholder="Obat" value="<%=apotek.getString("obat")%>" />
			</div>

<div class="pure-controls">
    <input type="submit" class="pure-button pure-button-primary" value="Simpan">
</div>

</fieldset>
</form>
</div>
</div>

