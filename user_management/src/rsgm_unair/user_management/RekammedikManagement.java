package rsgm_unair.user_management;

import rsgm_unair.config.DatabaseConfig;
import rsgm_unair.shared.CouchHelper;
import rsgm_unair.shared.Utils;
import rsgm_unair.shared.Response;
import org.json.*;
import java.util.logging.*;
import radityopw.couchdbclient.*;
import java.util.*;

public class RekammedikManagement{
	

	public static JSONObject findRekammedik(String d) throws Exception{
		
		CouchdbClient usersClient = CouchHelper.createClient();
		
        String id = "rekammedik:"+d;

		JSONObject rekammedik = usersClient.getDoc(id);
		
		usersClient = null;
        
        if(!rekammedik.has("_id")){
            return null;
        }
		
		return rekammedik;
	}
	
	public static void removeRekammedik(String nama) throws Exception{
		CouchdbClient usersClient = CouchHelper.createClient();
		
		usersClient.delDoc(nama);
		
		usersClient = null;
	}
	
	public static Response CreateEditRekammedik(FormRekammedik fp) throws Exception{
		Response fr = new Response();
		fr.setKode(Response.ERROR);
		fr.setPesan("Ada field kosong");
		
		if(fp.getNama() != null && !fp.getNama().trim().equals("")){

           	if(fp.getKtp() != null && !fp.getKtp().trim().equals("")){

                if(fp.getTanggal() != null && !fp.getTanggal().trim().equals("")){
 
			        if(fp.getKeluhangejala() != null && !fp.getKeluhangejala().trim().equals("")){

                        if(fp.getDiagnosa() != null && !fp.getDiagnosa().trim().equals("")){

                            if(fp.getObat() != null && !fp.getObat().trim().equals("")){
             
                               
					
					CouchdbClient usersClient = CouchHelper.createClient();
                    
                    String id = "rekammedik:"+fp.getNama();
					
					JSONObject rekammedik = usersClient.getDoc(id);
                    
                    if(!rekammedik.has("_id")){
                        rekammedik = createNewRekammedik();
                    }
                    
                    rekammedik.put("nama",fp.getNama());
                    rekammedik.put("ktp",fp.getKtp());
                    rekammedik.put("tanggal",fp.getTanggal());
                    rekammedik.put("keluhangejala",fp.getKeluhangejala());
                    rekammedik.put("diagnosa",fp.getDiagnosa());
                    rekammedik.put("obat",fp.getObat());
                    
                    
                    
                    usersClient.setDoc(id,rekammedik);				
					
					usersClient = null;
					
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
	
	public static Paging getPagingRekammedik(InputPagingRekammedik ipp) throws Exception{
        
        Paging data = new Paging();
		
		CouchdbClient usersClient = CouchHelper.createClient();
        
        String param = "include_docs=true";
        
        param+="&limit="+ipp.getPerPage();
        
        param += "&skip="+ipp.getOffset();
        
        if(ipp.getSearchKey() != null){
            param += "&key=\"rekammedik:"+ipp.getSearchKey()+"\"";
        }
        
        JSONObject resultRaw = usersClient.view("rekammedik","all",param);
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
    
    public static JSONObject createNewRekammedik(){	
        JSONObject rekammedik = new JSONObject();
        rekammedik.put("nama","");
        rekammedik.put("ktp","");
        rekammedik.put("tanggal","");
        rekammedik.put("keluhangejala","");
        rekammedik.put("diagnosa","");
        rekammedik.put("obat","");
 
        

        return rekammedik;
    }
}