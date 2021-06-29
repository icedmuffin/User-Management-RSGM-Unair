package rsgm_unair.user_management;

import rsgm_unair.config.DatabaseConfig;
import rsgm_unair.shared.CouchHelper;
import rsgm_unair.shared.Utils;
import rsgm_unair.shared.Response;
import org.json.*;
import java.util.logging.*;
import radityopw.couchdbclient.*;
import java.util.*;

public class PasienManagement{

	public static JSONObject findPasien(String username) throws Exception{
		
		username = "pasien:"+username.trim().toLowerCase();
		
		CouchdbClient pasienClient = CouchHelper.createClient();
		
		JSONObject pasien = pasienClient.getDoc(username);
		
		pasienClient = null;
        
        if(!pasien.has("_id")){
            return null;
        }
		
		return pasien;
	}
	
	public static void removePasien(String username) throws Exception{
		CouchdbClient pasienClient = CouchHelper.createClient();
		
		pasienClient.delDoc("pasien:"+username);
		
		pasienClient = null;
	}
	
	public static Response CreateEditPasien(FormPasien fp) throws Exception{
		Response fr = new Response();
		fr.setKode(Response.ERROR);
		fr.setPesan("ada field kosong");
		
		if(fp.getUsername() != null && !fp.getUsername().trim().equals("")){
			
			if(fp.getName() != null && !fp.getName().trim().equals("")){
				
				if(fp.getSex() != null && !fp.getSex().trim().equals("")){
					
					if(fp.getAge() != null && !fp.getAge().trim().equals("")){
						
						if(fp.getAddress() != null && !fp.getAddress().trim().equals("")){
							
							if(fp.getComplaint() != null && !fp.getComplaint().trim().equals("")){
					
							CouchdbClient pasienClient = CouchHelper.createClient();
                    
							String id = "pasien:"+fp.getUsername();
					
							JSONObject pasien = pasienClient.getDoc(id);
                    
							if(!pasien.has("_id")){
							pasien = createNewPasien();
							}
                    
							pasien.put("username",fp.getUsername());
							pasien.put("name",fp.getName());
							pasien.put("sex",fp.getSex());
							pasien.put("age",fp.getAge());
							pasien.put("address",fp.getAddress());
							pasien.put("complaint",fp.getComplaint());
                    
							pasienClient.setDoc(id,pasien);				
					
							pasienClient = null;
					
							fr.setKode(Response.OK);
							fr.setPesan("Data Telah Disimpan");
							}
						
						}
					
					}
					
				}
				
			}
			
		}
		
		return fr;
	}
	
	public static Paging getPagingPasien(InputPagingPasien ipp) throws Exception{
        
        Paging doc = new Paging();
		
		CouchdbClient pasienClient = CouchHelper.createClient();
        
        String param = "include_docs=true";
        
        param+="&limit="+ipp.getPerPage();
        
        param += "&skip="+ipp.getOffset();
        
        if(ipp.getSearchPasien() != null){
            param += "&key=\"pasien:"+ipp.getSearchPasien()+"\"";
        }
        
        JSONObject resultRaw = pasienClient.view("pasien","all",param);
        JSONArray result = resultRaw.getJSONArray("rows");
        
        List<JSONObject> resultDoc = new ArrayList<JSONObject>();
        
        for(int i=0;i<result.length();i++){
            JSONObject obja = result.getJSONObject(i);
            resultDoc.add(obja.getJSONObject("doc"));
        }
        
        doc.setResultList(resultDoc);
        int totalRows = resultRaw.getInt("total_rows");
        doc.setTotalResults(totalRows);
        int resultFrom = ipp.getOffset() + 1;
        int resultTo = resultFrom + ipp.getPerPage();
        doc.setResultFrom(resultFrom);
        doc.setResultTo(resultTo);
        boolean hasNext = true;
        boolean hasPrev = true;
        if(resultFrom <= ipp.getPerPage()){
            hasPrev = false;
        }
        if(resultTo >= totalRows ){
            hasNext = false;
        }
        doc.setHasNext(hasNext);
        doc.setHasPrevious(hasPrev);
        
        int prevOffset = ipp.getOffset() - ipp.getPerPage();
        int nextOffset = ipp.getOffset() + ipp.getPerPage();
        
        doc.setPreviousOffset(prevOffset);
        doc.setNextOffset(nextOffset);
        
		pasienClient = null;
		
		return doc;
	}
	
	public static JSONObject createNewPasien(){
        JSONObject pasien = new JSONObject();
        pasien.put("username","");
        pasien.put("name","");
        pasien.put("sex","");
		pasien.put("age","");
		pasien.put("address","");
		pasien.put("complaint","");
			
        return pasien;
    }	
	
}