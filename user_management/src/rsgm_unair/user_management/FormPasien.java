package rsgm_unair.user_management;

import lombok.AccessLevel;
import lombok.Setter;
import lombok.Data;
import lombok.ToString;


@Data public class FormPasien{

	private String username;
	private String name;
	private String sex;
	private String age;
	private String address;
	private String complaint;

}