package rsgm_unair.shared;

public class Response{

	public static final int OK = 0;
	public static final int ERROR = -1;
	
	private int kode;
	private String pesan;
	
	public void setKode(int a){
		kode = a;
	}
	
	public void setPesan(String a){
		pesan = a;
	}
	
	public int getKode(){
		return kode;
	}
	
	public String getPesan(){
		return pesan;
	}

}