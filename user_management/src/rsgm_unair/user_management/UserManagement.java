package rsgm_unair.user_management;

import rsgm_unair.config.DatabaseConfig;
import rsgm_unair.shared.CouchHelper;
import rsgm_unair.shared.Utils;
import rsgm_unair.shared.Response;
import org.json.*;
import java.util.logging.*;
import radityopw.couchdbclient.*;
import java.util.*;

public class UserManagement{
	
	public static void populateDefaultUser() throws Exception{
		
		System.out.println("running populateDefaultUser");
		
		CouchdbClient usersClient = CouchHelper.createClient();
		
		JSONObject user = usersClient.getDoc("user:admin");
        
        // jika belum ditemukan maka ditambah
        
        if(!user.has("_id")){
            
            user = createNewUser();
        
            user.put("username","admin");
            user.put("password",Utils.getMd5("admin123"));
            user.put("role","admin");
            
            usersClient.setDoc("user:admin",user);
        }
        
		usersClient = null;
		
	}

	public static Response auth(FormLogin fl) throws Exception{
		String username = fl.getUsername();
		String password = fl.getPassword();
		
		Response ar = new Response();
		ar.setKode(Response.ERROR);
		ar.setPesan("username tidak boleh kosong");
		
		if(username != null && !username.trim().equals("")){
		
			username = "user:"+username.trim().toLowerCase();
			password = password.trim().toLowerCase();
			
			String passwordHashed = Utils.getMd5(password);
			
			CouchdbClient usersClient = CouchHelper.createClient();
			
			JSONObject user = usersClient.getDoc(username);
			
            boolean found = false;
            
            if(user.has("_id")){
                found = true;
            }
			
			if(found){
				ar.setPesan("Password Keliru");
				
				if(passwordHashed.equals(user.getString("password"))){
					ar.setPesan("");
					ar.setKode(Response.OK);
				}
			}else{
				ar.setPesan("username tidak ditemukan");
			}
			
			usersClient = null;
			
		}
		
		return ar;
	}
	
	public static JSONObject findUser(String username) throws Exception{
		
		username = "user:"+username.trim().toLowerCase();
		
		CouchdbClient usersClient = CouchHelper.createClient();
		
		JSONObject user = usersClient.getDoc(username);
		
		usersClient = null;
        
        if(!user.has("_id")){
            return null;
        }
		
		return user;
	}
	
	public static void removeUser(String username) throws Exception{
		CouchdbClient usersClient = CouchHelper.createClient();
		
		usersClient.delDoc("user:"+username);
		
		usersClient = null;
	}
	
	public static Response gantiPassword(FormGantiPassword fg) throws Exception{
		Response gr = new Response();
		gr.setKode(Response.ERROR);
		gr.setPesan("Semua Password Field harus terisi");
		
		if(fg.getPasswordLama() != null && !fg.getPasswordLama().trim().equals("")){
			if(fg.getPasswordBaru() != null && !fg.getPasswordBaru().trim().equals("")){
				if(fg.getPasswordKonfirmasi() != null && !fg.getPasswordKonfirmasi().trim().equals("")){
					CouchdbClient usersClient = CouchHelper.createClient();
					
					gr.setPesan("password lama keliru!");
                    
                    String id = "user:"+fg.getUsername();
					
					JSONObject user = usersClient.getDoc(id);
                    
                    if(!user.has("_id")){
                        user = createNewUser();
                    }
					
                    String passwordLamaHashed = Utils.getMd5(fg.getPasswordLama());
					
					if(passwordLamaHashed.equals(user.getString("password"))){
						
						gr.setPesan("password baru tidak terkonfirmasi!");
						
						if(fg.getPasswordBaru().equals(fg.getPasswordKonfirmasi())){
							
							gr.setPesan("password telah berhasil diubah");
							gr.setKode(Response.OK);
                            
                            user.put("password",Utils.getMd5(fg.getPasswordBaru()));
							
							usersClient.setDoc(id,user);
						}
					}
						
					
					usersClient = null;
				}
			}
		}
		return gr;
	}
	
	public static Response CreateEditUser(FormUser fu) throws Exception{
		Response fr = new Response();
		fr.setKode(Response.ERROR);
		fr.setPesan("ada field kosong");
		
		if(fu.getUsername() != null && !fu.getUsername().trim().equals("")){
			
			if(fu.getPassword() != null && !fu.getPassword().trim().equals("")){
				
				if(fu.getRole() != null && !fu.getRole().trim().equals("")){
					
					CouchdbClient usersClient = CouchHelper.createClient();
                    
                    String id = "user:"+fu.getUsername();
					
					JSONObject user = usersClient.getDoc(id);
                    
                    if(!user.has("_id")){
                        user = createNewUser();
                    }
                    
                    user.put("username",fu.getUsername());
                    user.put("password",Utils.getMd5(fu.getPassword()));
                    user.put("role",fu.getRole());
                    
                    usersClient.setDoc(id,user);				
					
					usersClient = null;
					
					fr.setKode(Response.OK);
					fr.setPesan("Data Telah Disimpan");
					
				}
				
			}
			
		}
		
		return fr;
	}
	
	public static Paging getPagingUsers(InputPagingUser ipu) throws Exception{
        
        Paging data = new Paging();
		
		CouchdbClient usersClient = CouchHelper.createClient();
        
        String param = "include_docs=true";
        
        param+="&limit="+ipu.getPerPage();
        
        param += "&skip="+ipu.getOffset();
        
        if(ipu.getSearchKey() != null){
            param += "&key=\"user:"+ipu.getSearchKey()+"\"";
        }
        
        JSONObject resultRaw = usersClient.view("user","all",param);
        JSONArray result = resultRaw.getJSONArray("rows");
        
        List<JSONObject> resultData = new ArrayList<JSONObject>();
        
        for(int i=0;i<result.length();i++){
            JSONObject obj1 = result.getJSONObject(i);
            resultData.add(obj1.getJSONObject("doc"));
        }
        
        data.setResultList(resultData);
        int totalRows = resultRaw.getInt("total_rows");
        data.setTotalResults(totalRows);
        int resultFrom = ipu.getOffset() + 1;
        int resultTo = resultFrom + ipu.getPerPage();
        data.setResultFrom(resultFrom);
        data.setResultTo(resultTo);
        boolean hasNext = true;
        boolean hasPrev = true;
        if(resultFrom <= ipu.getPerPage()){
            hasPrev = false;
        }
        if(resultTo >= totalRows ){
            hasNext = false;
        }
        data.setHasNext(hasNext);
        data.setHasPrevious(hasPrev);
        
        int prevOffset = ipu.getOffset() - ipu.getPerPage();
        int nextOffset = ipu.getOffset() + ipu.getPerPage();
        
        data.setPreviousOffset(prevOffset);
        data.setNextOffset(nextOffset);
        
		usersClient = null;
		
		return data;
	}
    
    public static JSONObject createNewUser(){
        JSONObject user = new JSONObject();
        user.put("username","");
        user.put("password","");
        user.put("role","");
        
        return user;
    }
	
}