<%@ page import="rsgm_unair.user_management.UserManagement" %>
<%
String act = request.getParameter("act");
if(act == null || act.trim().equals("")){
	act = "default";
}

String isLogin = (String) session.getAttribute("is_login");
if(isLogin == null || !isLogin.equals("1")){
	response.sendRedirect("index.jsp");
	return;
}

%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="css/pure-min.css"/>
    </head>
	<body>
		<div class="pure-g">
			<div class="pure-u-1" align="center">
				<div class="pure-menu pure-menu-horizontal" >
					<a href="home.jsp" class="pure-menu-heading pure-menu-link"><img class="pure-img" width="100" src="img/logo.png"></a>
					<ul class="pure-menu-list">
						<li class="pure-menu-item">
							<a href="?act=pendaftaran" class="pure-menu-link">Pendaftaran</a>
						</li>
						<li class="pure-menu-item">
							<a href="?act=apotek" class="pure-menu-link">Apotek</a>
						</li>

						<li class="pure-menu-item">
							<a href="?act=pembayaran" class="pure-menu-link">Pembayaran</a>
						</li>

						<li class="pure-menu-item">
							<a href="?act=jkn" class="pure-menu-link">jkn</a>
						</li>

						<li class="pure-menu-item">
							<a href="?act=rekammedik" class="pure-menu-link">Rekam Medik</a>
						   </li>

						<li class="pure-menu-item pure-menu-has-children pure-menu-allow-hover">
							<a href="#" class="pure-menu-link">Akun</a>
							<ul class="pure-menu-children">
								<li class="pure-menu-item">
									<a href="?act=info_akun" class="pure-menu-link">Info Akun</a>
								</li>
								<li class="pure-menu-item">
									<a href="?act=ganti_password" class="pure-menu-link">Ganti Password</a>
								</li>
							</ul>
						</li>
						<li class="pure-menu-item">
							<a href="?act=logout" class="pure-menu-link">logout</a>
						</li>
					</ul>	
				</div>
			</div>
		</div>
		<div class="pure-g">
			<div class="pure-u-1" align="center">
				<hr>
			</div>
		</div>
		<div class="pure-g">
			<div class="pure-u-1" align="center">
			<% if(act.equals("default")){ %>
			<h3> Silakan memilih menu </h3>
			<% }else if(act.equals("logout")){ %>
			<jsp:include page="WEB-INF/jsp/konfirmasi_logout.jsp"/>
			<% }else if(act.equals("info_akun")){ %>
			<jsp:include page="WEB-INF/jsp/info_akun.jsp"/>
			<% }else if(act.equals("ganti_password")){ %>
			<jsp:include page="WEB-INF/jsp/ganti_password.jsp"/>
			<% }else if(act.equals("user")){ %>
			<jsp:include page="WEB-INF/jsp/user.jsp"/>
			<% }else if(act.equals("pasien")){ %>
			<jsp:include page="WEB-INF/jsp/pasien.jsp"/>
			<% }else if(act.equals("delete_user")){ %>
			<jsp:include page="WEB-INF/jsp/delete_user.jsp"/>
			<% }else if(act.equals("delete_pasien")){ %>
			<jsp:include page="WEB-INF/jsp/delete_pasien.jsp"/>
			<% }else if(act.equals("edit_pasien")){ %>
			<jsp:include page="WEB-INF/jsp/edit_pasien.jsp"/>
			<% }else if(act.equals("view_pasien")){ %>
			<jsp:include page="WEB-INF/jsp/view_pasien.jsp"/>
				
				<% }else if(act.equals("pendaftaran")){ %>
				<jsp:include page="WEB-INF/jsp/pendaftaran/pendaftaran.jsp"/>
				<% }else if(act.equals("delete_pendaftaran")){ %>
				<jsp:include page="WEB-INF/jsp/pendaftaran/delete_pendaftaran.jsp"/>
				<% }else if(act.equals("edit_pendaftaran")){ %>
				<jsp:include page="WEB-INF/jsp/pendaftaran/edit_pendaftaran.jsp"/>
				<% }else if(act.equals("view_pendaftaran")){ %>
				<jsp:include page="WEB-INF/jsp/pendaftaran/view_pendaftaran.jsp"/>
				<% }else if(act.equals("tambah_pendaftaran")){ %>
				<jsp:include page="WEB-INF/jsp/pendaftaran/tambah_pendaftaran.jsp"/>
					
						<% }else if(act.equals("dokter")){ %>
						<jsp:include page="WEB-INF/jsp/dokter.jsp"/>
						<% }else if(act.equals("delete_dokter")){ %>
						<jsp:include page="WEB-INF/jsp/delete_dokter.jsp"/>
						<% }else if(act.equals("edit_dokter")){ %>
						<jsp:include page="WEB-INF/jsp/edit_dokter.jsp"/>
						<% }else if(act.equals("view_dokter")){ %>
						<jsp:include page="WEB-INF/jsp/view_dokter.jsp"/>
						<% }else if(act.equals("tambah_dokter")){ %>
						<jsp:include page="WEB-INF/jsp/tambah_dokter.jsp"/>
							
								<% }else if(act.equals("apotek")){ %>
								<jsp:include page="WEB-INF/jsp/apotek/apotek.jsp"/>
								<% }else if(act.equals("delete_apotek")){ %>
								<jsp:include page="WEB-INF/jsp/apotek/delete_apotek.jsp"/>
								<% }else if(act.equals("edit_apotek")){ %>
								<jsp:include page="WEB-INF/jsp/apotek/edit_apotek.jsp"/>
								<% }else if(act.equals("view_apotek")){ %>
								<jsp:include page="WEB-INF/jsp/apotek/view_apotek.jsp"/>
								<% }else if(act.equals("tambah_apotek")){ %>
								<jsp:include page="WEB-INF/jsp/apotek/tambah_apotek.jsp"/>


									<% }else if(act.equals("rekammedik")){ %>
									<jsp:include page="WEB-INF/jsp/rekamMedik/rekammedik.jsp"/>
									<% }else if(act.equals("delete_rekammedik")){ %>
									<jsp:include page="WEB-INF/jsp/rekamMedik/delete_rekammedik.jsp"/>
									<% }else if(act.equals("edit_rekammedik")){ %>
									<jsp:include page="WEB-INF/jsp/rekamMedik/edit_rekammedik.jsp"/>
									<% }else if(act.equals("view_rekammedik")){ %>
									<jsp:include page="WEB-INF/jsp/rekamMedik/view_rekammedik.jsp"/>
									<% }else if(act.equals("tambah_rekammedik")){ %>
									<jsp:include page="WEB-INF/jsp/rekamMedik/tambah_rekammedik.jsp"/>
								

									<% }else if(act.equals("pembayaran")){ %>
										<jsp:include page="WEB-INF/jsp/pembayaran/pembayaran.jsp"/>
									<% }else if(act.equals("tambah_pembayaran")){ %>
										<jsp:include page="WEB-INF/jsp/pembayaran/tambah_pembayaran.jsp"/>	
									<% }else if(act.equals("view_pembayaran")){ %>
										<jsp:include page="WEB-INF/jsp/pembayaran/view_pembayaran.jsp"/>
									<% }else if(act.equals("edit_pembayaran")){ %>
										<jsp:include page="WEB-INF/jsp/pembayaran/edit_pembayaran.jsp"/>
									<% }else if(act.equals("delete_pembayaran")){ %>
										<jsp:include page="WEB-INF/jsp/pembayaran/delete_pembayaran.jsp"/>


									<% }else if(act.equals("jkn")){ %>
									<jsp:include page="WEB-INF/jsp/jkn/menu_jkn.jsp"/>
									<% }else if(act.equals("buat_jkn")){ %>
									<jsp:include page="WEB-INF/jsp/jkn/buat_jkn.jsp"/>	
									<% }else if(act.equals("edit_jkn")){ %>
									<jsp:include page="WEB-INF/jsp/jkn/edit_jkn.jsp"/>
									<% }else if(act.equals("delete_jkn")){ %>
									<jsp:include page="WEB-INF/jsp/jkn/delete_jkn.jsp"/>
									
										
									
					
						 
				 	
			<% } %>
			</div>
		</div>
	
		
	</body>
</html>