<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String id = request.getParameter("nama");
JSONObject pasien = PasienManagement.findPasien(id);

String action = request.getParameter("action");

Response resp = null;


if(action != null && action.equals("add_edit_pasien")){
	
	FormPasien fp = new FormPasien();
	fp.setNama(request.getParameter("nama"));
    fp.setNohp(request.getParameter("no hp"));
    fp.setJeniskelamin(request.getParameter("jenis kelamin"));
	fp.setUmur(request.getParameter("umur"));
	fp.setKeluhan(request.getParameter("keluhan"));

	resp = PasienManagement.CreateEditPasien(fp);
	
}
%>
<div class="pure-g">
	<div class="pure-u-1-3" align="left">
		<form class="pure-form pure-form-aligned" method="post" action="?act=pasien">
		<input type="hidden" name="action" value="add_edit_pasien" />
		<fieldset>
			<div class="pure-control-group">
				<label for="aligned-nama">Nama</label>
				<input type="text" name="nama" id="aligned-nama" placeholder="Nama" value="<%=pasien.getString("nama")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-nohp">No HP</label>
				<input type="text" name="no hp" id="aligned-no hp" placeholder="No HP" value="<%=pasien.getString("no hp")%>" />
			</div>
			<div class="pure-control-group">
                <label for="aligned-jeniskelamin">Jenis Kelamin</label>
                <input type="text" name="jenis kelamin" id="aligned-jeniskelamin" placeholder="Jenis Kelamin" value="<%=pasien.getString("jenis kelamin")%>" />
                </select>
            </div>
			<div class="pure-control-group">
				<label for="aligned-umur">Umur</label>
				<input type="text" name="umur" id="aligned-umur" placeholder="Umur" value="<%=pasien.getString("umur")%>" />
			</div>
			<div class="pure-control-group">
                <label for="aligned-keluhan">Keluhan</label>
                <input type="text" name="keluhan" id="aligned-keluhan" placeholder="Keluhan" value="<%=pasien.getString("keluhan")%>" />
                </select>
            </div>

<div class="pure-controls">
    <input type="submit" class="pure-button pure-button-primary" value="Simpan">
</div>

</fieldset>
</form>
</div>
</div>

