package rsgm_unair.user_management;

import lombok.AccessLevel;
import lombok.Setter;
import lombok.Data;
import lombok.ToString;


@Data public class FormPasien{

	private String nama;
	private String nohp;
	private String jeniskelamin;
	private String umur;
	private String keluhan;
}