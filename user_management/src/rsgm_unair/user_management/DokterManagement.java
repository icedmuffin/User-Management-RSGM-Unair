package rsgm_unair.user_management;

import rsgm_unair.config.DatabaseConfig;
import rsgm_unair.shared.CouchHelper;
import rsgm_unair.shared.Utils;
import rsgm_unair.shared.Response;
import org.json.*;
import java.util.logging.*;
import radityopw.couchdbclient.*;
import java.util.*;

public class DokterManagement{
	

	public static JSONObject findDokter(String d) throws Exception{
		
		CouchdbClient usersClient = CouchHelper.createClient();
		
        String id = "dokter:"+d;

		JSONObject dokter = usersClient.getDoc(id);
		
		usersClient = null;
        
        if(!dokter.has("_id")){
            return null;
        }
		
		return dokter;
	}
	
	public static void removeDokter(String nama) throws Exception{
		CouchdbClient usersClient = CouchHelper.createClient();
		
		usersClient.delDoc(nama);
		
		usersClient = null;
	}
	
	public static Response CreateEditDokter(FormDokter fp) throws Exception{
		Response fr = new Response();
		fr.setKode(Response.ERROR);
		fr.setPesan("Ada field kosong");
		
		if(fp.getNama() != null && !fp.getNama().trim().equals("")){

           	if(fp.getUnit() != null && !fp.getUnit().trim().equals("")){

                if(fp.getJenis() != null && !fp.getJenis().trim().equals("")){
 
			        if(fp.getJadwal() != null && !fp.getJadwal().trim().equals("")){

                        
				
					
					CouchdbClient usersClient = CouchHelper.createClient();
                    
                    String id = "dokter:"+fp.getNama();
					
					JSONObject dokter = usersClient.getDoc(id);
                    
                    if(!dokter.has("_id")){
                        dokter = createNewDokter();
                    }
                    
                    dokter.put("nama",fp.getNama());
                    dokter.put("unit",fp.getUnit());
                    dokter.put("jenis",fp.getJenis());
                    dokter.put("jadwal",fp.getJadwal());
                    
                    
                    
                    usersClient.setDoc(id,dokter);				
					
					usersClient = null;
					
					fr.setKode(Response.OK);
					fr.setPesan("Data Telah Disimpan");
					
			
        }
    }
			
		}
        
        }
		return fr;
	}
	
	public static Paging getPagingDokter(InputPagingDokter ipp) throws Exception{
        
        Paging data = new Paging();
		
		CouchdbClient usersClient = CouchHelper.createClient();
        
        String param = "include_docs=true";
        
        param+="&limit="+ipp.getPerPage();
        
        param += "&skip="+ipp.getOffset();
        
        if(ipp.getSearchKey() != null){
            param += "&key=\"dokter:"+ipp.getSearchKey()+"\"";
        }
        
        JSONObject resultRaw = usersClient.view("dokter","all",param);
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
    
    public static JSONObject createNewDokter(){	
        JSONObject dokter = new JSONObject();
        dokter.put("nama","");
        dokter.put("unit","");
        dokter.put("jenis","");
        dokter.put("jadwal","");
       
        

        return dokter;
    }
}