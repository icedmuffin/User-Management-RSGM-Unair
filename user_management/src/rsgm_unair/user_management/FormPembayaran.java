package rsgm_unair.user_management;

import lombok.AccessLevel;
import lombok.Setter;
import lombok.Data;
import lombok.ToString;


@Data public class FormPembayaran{

	private String noPembayaran;
	private String ktp;
	private String tanggal;
	private String kategori;
    private String nominal;
	

}