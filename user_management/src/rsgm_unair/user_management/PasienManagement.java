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
	

	public static JSONObject findPasien(String d) throws Exception{
		
		CouchdbClient usersClient = CouchHelper.createClient();
		
        String id = "pasien:"+d;

		JSONObject pasien = usersClient.getDoc(id);
		
		usersClient = null;
        
        if(!pasien.has("_id")){
            return null;
        }
		
		return pasien;
	}
	
	public static void removePasien(String nama) throws Exception{
		CouchdbClient usersClient = CouchHelper.createClient();
		
		usersClient.delDoc(nama);
		
		usersClient = null;
	}
	
	public static Response CreateEditPasien(FormPasien fp) throws Exception{
		Response fr = new Response();
		fr.setKode(Response.ERROR);
		fr.setPesan("Ada field kosong");
		
		if(fp.getNama() != null && !fp.getNama().trim().equals("")){

           	if(fp.getNohp() != null && !fp.getNohp().trim().equals("")){

                if(fp.getJeniskelamin() != null && !fp.getJeniskelamin().trim().equals("")){
 
			        if(fp.getUmur() != null && !fp.getUmur().trim().equals("")){
				
				        if(fp.getKeluhan() != null && !fp.getKeluhan().trim().equals("")){
					
					CouchdbClient usersClient = CouchHelper.createClient();
                    
                    String id = "pasien:"+fp.getNama();
					
					JSONObject pasien = usersClient.getDoc(id);
                    
                    if(!pasien.has("_id")){
                        pasien = createNewPasien();
                    }
                    
                    pasien.put("nama",fp.getNama());
                    pasien.put("no hp",fp.getNohp());
                    pasien.put("jenis kelamin",fp.getJeniskelamin());
                    pasien.put("umur",fp.getUmur());
                    pasien.put("keluhan",fp.getKeluhan());
                    
                    usersClient.setDoc(id,pasien);				
					
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
	
	public static Paging getPagingPasien(InputPagingPasien ipp) throws Exception{
        
        Paging data = new Paging();
		
		CouchdbClient usersClient = CouchHelper.createClient();
        
        String param = "include_docs=true";
        
        param+="&limit="+ipp.getPerPage();
        
        param += "&skip="+ipp.getOffset();
        
        if(ipp.getSearchKey() != null){
            param += "&key=\"pasien:"+ipp.getSearchKey()+"\"";
        }
        
        JSONObject resultRaw = usersClient.view("pasien","all",param);
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
    
    public static JSONObject createNewPasien(){	
        JSONObject pasien = new JSONObject();
        pasien.put("nama","");
        pasien.put("no hp","");
        pasien.put("jenis kelamin","");
        pasien.put("umur","");
        pasien.put("keluhan","");

        return pasien;
    }
}