package rsgm_unair.user_management;

import lombok.AccessLevel;
import lombok.Setter;
import lombok.Data;
import lombok.ToString;


@Data public class FormLogin{
	//sebenarnya ada setter dan getter disini, tapi udah pake project lombok
	
	private String username;
	private String password;

}