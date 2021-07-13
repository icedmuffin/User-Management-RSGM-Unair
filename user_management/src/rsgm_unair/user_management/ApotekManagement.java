package rsgm_unair.user_management;

import rsgm_unair.config.DatabaseConfig;
import rsgm_unair.shared.CouchHelper;
import rsgm_unair.shared.Utils;
import rsgm_unair.shared.Response;
import org.json.*;
import java.util.logging.*;
import radityopw.couchdbclient.*;
import java.util.*;

public class ApotekManagement{
	

	public static JSONObject findApotek(String d) throws Exception{
		
		CouchdbClient usersClient = CouchHelper.createClient();
		
        String id = "apotek:"+d;

		JSONObject apotek = usersClient.getDoc(id);
		
		usersClient = null;
        
        if(!apotek.has("_id")){
            return null;
        }
		
		return apotek;
	}
	
	public static void removeApotek(String nama) throws Exception{
		CouchdbClient usersClient = CouchHelper.createClient();
		
		usersClient.delDoc(nama);
		
		usersClient = null;
	}
	
	public static Response CreateEditApotek(FormApotek fp) throws Exception{
		Response fr = new Response();
		fr.setKode(Response.ERROR);
		fr.setPesan("Ada field kosong");
		
		if(fp.getNama() != null && !fp.getNama().trim().equals("")){

           	if(fp.getUsia() != null && !fp.getUsia().trim().equals("")){

                if(fp.getTanggallahir() != null && !fp.getTanggallahir().trim().equals("")){
 
			        if(fp.getAlamat() != null && !fp.getAlamat().trim().equals("")){

                        if(fp.getObat() != null && !fp.getObat().trim().equals("")){
				
					
					CouchdbClient usersClient = CouchHelper.createClient();
                    
                    String id = "apotek:"+fp.getNama();
					
					JSONObject apotek = usersClient.getDoc(id);
                    
                    if(!apotek.has("_id")){
                        apotek = createNewApotek();
                    }
                    
                    apotek.put("nama",fp.getNama());
                    apotek.put("usia",fp.getUsia());
                    apotek.put("tanggal lahir",fp.getTanggallahir());
                    apotek.put("alamat",fp.getAlamat());
                    apotek.put("obat",fp.getObat());
                    
                    
                    usersClient.setDoc(id,apotek);				
					
					usersClient = null;
					
					fr.setKode(Response.OK);
					fr.setPesan("Data Telah Disimpan");
					
				}
            }
				
                }	
			
		}
        
        }
		return fr;
	}
	
	public static Paging getPagingApotek(InputPagingApotek ipp) throws Exception{
        
        Paging data = new Paging();
		
		CouchdbClient usersClient = CouchHelper.createClient();
        
        String param = "include_docs=true";
        
        param+="&limit="+ipp.getPerPage();
        
        param += "&skip="+ipp.getOffset();
        
        if(ipp.getSearchKey() != null){
            param += "&key=\"apotek:"+ipp.getSearchKey()+"\"";
        }
        
        JSONObject resultRaw = usersClient.view("apotek","all",param);
        JSONArray result = resultRaw.getJSONArray("rows");
        
        List<JSONObject> resultData = new ArrayList<JSONObject>();
        
        for(int i=0;i<result.length();i++){
            JSONObject obj1 = result.getJSONObject(i);
            resultData.add(obj1.getJSONObject("doc"));
        }
        
        data.setResultList(resultData);
        int totalRows = resultRaw.getInt("total_rows");
        data.setTotalResults(totalRows);
        int resultFrom = ipp.getOffset() + 1;
        int resultTo = resultFrom + ipp.getPerPage();
        data.setResultFrom(resultFrom);
        data.setResultTo(resultTo);
        boolean hasNext = true;
        boolean hasPrev = true;
        if(resultFrom <= ipp.getPerPage()){
            hasPrev = false;
        }
        if(resultTo >= totalRows ){
            hasNext = false;
        }
        data.setHasNext(hasNext);
        data.setHasPrevious(hasPrev);
        
        int prevOffset = ipp.getOffset() - ipp.getPerPage();
        int nextOffset = ipp.getOffset() + ipp.getPerPage();
        
        data.setPreviousOffset(prevOffset);
        data.setNextOffset(nextOffset);
        
		usersClient = null;
		
		return data;
	}
    
    public static JSONObject createNewApotek(){	
        JSONObject apotek = new JSONObject();
        apotek.put("nama","");
        apotek.put("usia","");
        apotek.put("tanggal lahir","");
        apotek.put("alamat","");
        apotek.put("obat","");
        

        return apotek;
    }
}