package rsgm_unair.user_management;

import rsgm_unair.config.DatabaseConfig;
import rsgm_unair.shared.CouchHelper;
import rsgm_unair.shared.Utils;
import rsgm_unair.shared.Response;
import org.json.*;
import java.util.logging.*;
import radityopw.couchdbclient.*;
import java.util.*;

public class PendaftaranManagement{
	

	public static JSONObject findPendaftaran(String nama) throws Exception{
		
        nama = "pendaftaran:"+nama.trim().toLowerCase();
		
		CouchdbClient pendaftaranClient = CouchHelper.createClient();
		
		JSONObject pendaftaran = pendaftaranClient.getDoc(nama);
		
		pendaftaranClient = null;
        
        if(!pendaftaran.has("_id")){
            return null;
        }
		
		return pendaftaran;
	}

	
	public static void removePendaftaran(String nama) throws Exception{
		CouchdbClient usersClient = CouchHelper.createClient();
		
		usersClient.delDoc(nama);
		
		usersClient = null;
	}
	
	public static Response CreateEditPendaftaran(FormPendaftaran fp) throws Exception{
		Response fr = new Response();
		fr.setKode(Response.ERROR);
		fr.setPesan("Ada field kosong");
		
		if(fp.getNama() != null && !fp.getNama().trim().equals("")){

           	if(fp.getUsia() != null && !fp.getUsia().trim().equals("")){

                if(fp.getTanggallahir() != null && !fp.getTanggallahir().trim().equals("")){
 
			        if(fp.getAlamat() != null && !fp.getAlamat().trim().equals("")){
				
					
					CouchdbClient usersClient = CouchHelper.createClient();
                    
                    String id = "pendaftaran:"+fp.getNama();
					
					JSONObject pendaftaran = usersClient.getDoc(id);
                    
                    if(!pendaftaran.has("_id")){
                        pendaftaran = createNewPendaftaran();
                    }
                    
                    pendaftaran.put("nama",fp.getNama());
                    pendaftaran.put("usia",fp.getUsia());
                    pendaftaran.put("tanggal lahir",fp.getTanggallahir());
                    pendaftaran.put("alamat",fp.getAlamat());
                    
                    
                    
                    usersClient.setDoc(id,pendaftaran);				
					
					usersClient = null;
					
					fr.setKode(Response.OK);
					fr.setPesan("Data Telah Disimpan");
					
				}
            }
				
			
			
		}
        
        }
		return fr;
	}
	
	public static Paging getPagingPendaftaran(InputPagingPendaftaran ipp) throws Exception{
        
        Paging data = new Paging();
		
		CouchdbClient usersClient = CouchHelper.createClient();
        
        String param = "include_docs=true";
        
        param+="&limit="+ipp.getPerPage();
        
        param += "&skip="+ipp.getOffset();
        
        if(ipp.getSearchKey() != null){
            param += "&key=\"pendaftaran:"+ipp.getSearchKey()+"\"";
        }
        
        JSONObject resultRaw = usersClient.view("pendaftaran","all",param);
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
    
    public static JSONObject createNewPendaftaran(){	
        JSONObject pendaftaran = new JSONObject();
        pendaftaran.put("nama","");
        pendaftaran.put("usia","");
        pendaftaran.put("tanggal lahir","");
        pendaftaran.put("alamat","");
        

        return pendaftaran;
    }
}