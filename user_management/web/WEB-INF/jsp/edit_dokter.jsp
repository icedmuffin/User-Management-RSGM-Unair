<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String id = request.getParameter("nama");
JSONObject dokter = DokterManagement.findDokter(id);

String action = request.getParameter("action");

Response resp = null;


if(action != null && action.equals("add_edit_dokter")){
	
	FormDokter fp = new FormDokter();
	fp.setNama(request.getParameter("nama"));
    fp.setUnit(request.getParameter("unit"));
    fp.setJenis(request.getParameter("jenis"));
	fp.setJadwal(request.getParameter("jadwal"));

	resp = DokterManagement.CreateEditDokter(fp);
	
}
%>
<div class="pure-g">
	<div class="pure-u-1-3" align="left">
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
				<label for="aligned-alamat">Jadwal</label>
				<input type="text" name="jadwal" id="aligned-jadwal" placeholder="Jadwal" value="<%=dokter.getString("jadwal")%>" />
			</div>

<div class="pure-controls">
    <input type="submit" class="pure-button pure-button-primary" value="Simpan">
</div>

</fieldset>
</form>
</div>
</div>

