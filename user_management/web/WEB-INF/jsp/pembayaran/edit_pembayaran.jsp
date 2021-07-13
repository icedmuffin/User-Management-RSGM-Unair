<%@ page import="rsgm_unair.user_management.*" %>
<%@ page import="rsgm_unair.shared.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%
String id = request.getParameter("noPembayaran");
JSONObject pembayaran = PembayaranManagement.findPembayaran(id);

String action = request.getParameter("action");

Response resp = null;


if(action != null && action.equals("add_edit_pembayaran")){
	
	FormPembayaran fp = new FormPembayaran();
	fp.setNoPembayaran(request.getParameter("noPembayaran"));
    fp.setKtp(request.getParameter("ktp"));
    fp.setTanggal(request.getParameter("tanggal"));
	fp.setKategori(request.getParameter("kategori"));
    fp.setNominal(request.getParameter("nominal"));

	resp = PembayaranManagement.CreateEditPembayaran(fp);
	
}
%>
<div class="pure-g">
	<div class="pure-u-1-3" align="center">
		<form class="pure-form pure-form-aligned" method="post" action="?act=pembayaran">
		<input type="hidden" name="action" value="add_edit_pembayaran" />
		<fieldset>
			<div class="pure-control-group">
				<label for="aligned-noPembayaran">NoPembayaran</label>
				<input type="text" name="noPembayaran" id="aligned-noPembayaran" placeholder="NoPembayaran" value="<%=pembayaran.getString("noPembayaran")%>" />
			</div>
			<div class="pure-control-group">
				<label for="aligned-ktp">Ktp</label>
				<input type="text" name="ktp" id="aligned-ktp" placeholder="ktp" value="<%=pembayaran.getString("ktp")%>" />
			</div>
			<div class="pure-control-group">
                <label for="aligned-tanggal">Tanggal</label>
                <input type="text" name="tanggal" id="aligned-tanggal" placeholder="Tanggal" value="<%=pembayaran.getString("tanggal")%>" />
                </select>
            </div>
            <div class="select">

                <label for="cars">Kategori</label>
                <select name="kategori" id="aligned-kategori">
                <option value="reguler">reguler</option>
                <option value="asuransi">asuransi</option>
                </select>
    
            </div>

            <div class="pure-control-group">
				<label for="aligned-nominal">Nominal</label>
				<input type="text" name="nominal" id="aligned-nominal" placeholder="Nominal" value="<%=pembayaran.getString("nominal")%>" />
			</div>
		

<div class="pure-controls">
    <input type="submit" class="pure-button pure-button-primary" value="Simpan">
</div>

</fieldset>
</form>
</div>
</div>

