package rsgm_unair.config;

public class DatabaseConfig{

	public static String username(){
		return "admin";
	}
	
	public static String password(){
		return "admin123";
	}
	
	public static String protocol(){
		return "http";
	}
	
	public static String port(){
		return "5984";
	}
	
	public static String host(){
		return "127.0.0.1";
	}
	
	public static String databaseName(){
		return "rsgm_unair";
	}
    
    public static String curl(){
        return "curl";
    }
}