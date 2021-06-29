package rsgm_unair.user_management;

import lombok.AccessLevel;
import lombok.Setter;
import lombok.Data;
import lombok.ToString;

@Data public class InputPagingUser{

	private int perPage = 10;
	private int offset = 0;
	private String searchKey;

}