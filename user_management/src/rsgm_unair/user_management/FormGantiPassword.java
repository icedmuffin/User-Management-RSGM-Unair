package rsgm_unair.user_management;

import lombok.AccessLevel;
import lombok.Setter;
import lombok.Data;
import lombok.ToString;


@Data public class FormGantiPassword{

	private String passwordLama;
	private String passwordBaru;
	private String passwordKonfirmasi;
	private String username;
}