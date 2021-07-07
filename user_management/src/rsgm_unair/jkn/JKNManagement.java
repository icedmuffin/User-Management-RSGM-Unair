package rsgm_unair.user_management;

import rsgm_unair.config.DatabaseConfig;
import rsgm_unair.shared.CouchHelper;
import rsgm_unair.shared.Utils;
import rsgm_unair.shared.Response;
import org.json.*;
import java.util.logging.*;
import radityopw.couchdbclient.*;
import java.util.*;

public class JKNManagement{

	public static JSONObject findJKN(String nik) throws Exception{
		
		nik = "nik:"+nik.trim().toLowerCase();
		
		CouchdbClient jknClient = CouchHelper.createClient();
		
		JSONObject jkn = jknClient.getDoc(nik);
		
		jknClient = null;
        
        if(!jkn.has("_id")){
            return null;
        }
		
		return jkn;
	}
	
	public static void removeJKN(String nik) throws Exception{
		CouchdbClient jknClient = CouchHelper.createClient();
		
		jknClient.delDoc("nik:"+nik);
		
		jknClient = null;
	}
	
	public static Response CreateEditJKN(FormJKN fj) throws Exception{
		Response fr = new Response();
		fr.setKode(Response.ERROR);
		fr.setPesan("ada field kosong");
		
		if(fj.getNik() != null && !fj.getNik().trim().equals("")){
			
			if(fj.getNama() != null && !fj.getNama().trim().equals("")){
				
				if(fj.getTtl() != null && !fj.getTtl().trim().equals("")){
					
					if(fj.getAlamat() != null && !fj.getAlamat().trim().equals("")){
						
						if(fj.getNoHP() != null && !fj.getNoHP().trim().equals("")){
							
							if(fj.getEmail() != null && !fj.getEmail().trim().equals("")){
								
								if(fj.getFaskesTingkatI() != null && !fj.getFaskesTingkatI().trim().equals("")){
					
								CouchdbClient jknClient = CouchHelper.createClient();
                    
								String id = "nik:"+fj.getNik();
					
								JSONObject jkn = jknClient.getDoc(id);
                    
								if(!jkn.has("_id")){
								jkn = createNewJKN();
								}
                    
								jkn.put("nik",fj.getNik());
								jkn.put("nama",fj.getNama());
								jkn.put("ttl",fj.getTtl());
								jkn.put("alamat",fj.getAlamat());
								jkn.put("noHP",fj.getNoHP());
								jkn.put("email",fj.getEmail());
								jkn.put("faskesTingkatI",fj.getFaskesTingkatI());
                    
								jknClient.setDoc(id,jkn);
					
								jknClient = null;
					
								fr.setKode(Response.OK);
								fr.setPesan("Data Telah Disimpan");
								}
								
							}
						
						}
					
					}
					
				}
				
			}
			
		}
		
		return fr;
	}
	
	public static Paging getPagingJKN(InputPagingJKN ipj) throws Exception{
        
        Paging doc = new Paging();
		
		CouchdbClient jknClient = CouchHelper.createClient();
        
        String param = "include_docs=true";
        
        param+="&limit="+ipj.getPerPage();
        
        param += "&skip="+ipj.getOffset();
        
        if(ipj.getSearchJKN() != null){
            param += "&key=\"nik:"+ipj.getSearchJKN()+"\"";
        }
        
        JSONObject resultRaw = jknClient.view("jkn","all",param);
        JSONArray result = resultRaw.getJSONArray("rows");
        
        List<JSONObject> resultDoc = new ArrayList<JSONObject>();
        
        for(int i=0;i<result.length();i++){
            JSONObject objj = result.getJSONObject(i);
            resultDoc.add(objj.getJSONObject("doc"));
        }
        
        doc.setResultList(resultDoc);
        int totalRows = resultRaw.getInt("total_rows");
        doc.setTotalResults(totalRows);
        int resultFrom = ipj.getOffset() + 1;
        int resultTo = resultFrom + ipj.getPerPage();
        doc.setResultFrom(resultFrom);
        doc.setResultTo(resultTo);
        boolean hasNext = true;
        boolean hasPrev = true;
        if(resultFrom <= ipj.getPerPage()){
            hasPrev = false;
        }
        if(resultTo >= totalRows ){
            hasNext = false;
        }
        doc.setHasNext(hasNext);
        doc.setHasPrevious(hasPrev);
        
        int prevOffset = ipj.getOffset() - ipj.getPerPage();
        int nextOffset = ipj.getOffset() + ipj.getPerPage();
        
        doc.setPreviousOffset(prevOffset);
        doc.setNextOffset(nextOffset);
        
		jknClient = null;
		
		return doc;
	}
	
	public static JSONObject createNewJKN(){
        JSONObject jkn = new JSONObject();
        jkn.put("nik","");
		jkn.put("nama","");
		jkn.put("ttl","");
		jkn.put("alamat","");
		jkn.put("noHP","");
		jkn.put("email","");
		jkn.put("faskesTingkatI","");
			
        return jkn;
    }	
	
}