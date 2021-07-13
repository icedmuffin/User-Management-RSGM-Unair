package rsgm_unair.user_management;

import rsgm_unair.config.DatabaseConfig;
import rsgm_unair.shared.CouchHelper;
import rsgm_unair.shared.Utils;
import rsgm_unair.shared.Response;
import org.json.*;
import java.util.logging.*;
import radityopw.couchdbclient.*;
import java.util.*;

public class PembayaranManagement{
	

	public static JSONObject findPembayaran(String d) throws Exception{
		
		CouchdbClient usersClient = CouchHelper.createClient();
		
        String id = "pembayaran:"+d;

		JSONObject pembayaran = usersClient.getDoc(id);
		
		usersClient = null;
        
        if(!pembayaran.has("_id")){
            return null;
        }
		
		return pembayaran;
	}
	
	public static void removePembayaran(String noPembayaran) throws Exception{
		CouchdbClient usersClient = CouchHelper.createClient();
		
		usersClient.delDoc(noPembayaran);
		
		usersClient = null;
	}
	
	public static Response CreateEditPembayaran(FormPembayaran fp) throws Exception{
		Response fr = new Response();
		fr.setKode(Response.ERROR);
		fr.setPesan("Ada field kosong");
		
		if(fp.getNoPembayaran() != null && !fp.getNoPembayaran().trim().equals("")){

           	if(fp.getKtp() != null && !fp.getKtp().trim().equals("")){

                if(fp.getTanggal() != null && !fp.getTanggal().trim().equals("")){
 
			        if(fp.getKategori() != null && !fp.getKategori().trim().equals("")){

                        if(fp.getNominal() != null && !fp.getNominal().trim().equals("")){
				
					
					CouchdbClient usersClient = CouchHelper.createClient();
                    
                    String id = "pembayaran:"+fp.getNoPembayaran();
					
					JSONObject pembayaran = usersClient.getDoc(id);
                    
                    if(!pembayaran.has("_id")){
                        pembayaran = createNewPembayaran();
                    }
                    
                    pembayaran.put("noPembayaran",fp.getNoPembayaran());
                    pembayaran.put("ktp",fp.getKtp());
                    pembayaran.put("tanggal",fp.getTanggal());
                    pembayaran.put("kategori",fp.getKategori());
                    pembayaran.put("nominal",fp.getNominal());
                    
                    
                    usersClient.setDoc(id,pembayaran);				
					
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
	
	public static Paging getPagingPembayaran(InputPagingPembayaran ipp) throws Exception{
        
        Paging data = new Paging();
		
		CouchdbClient usersClient = CouchHelper.createClient();
        
        String param = "include_docs=true";
        
        param+="&limit="+ipp.getPerPage();
        
        param += "&skip="+ipp.getOffset();
        
        if(ipp.getSearchKey() != null){
            param += "&key=\"pembayaran:"+ipp.getSearchKey()+"\"";
        }
        
        JSONObject resultRaw = usersClient.view("pembayaran","all",param);
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
    
    public static JSONObject createNewPembayaran(){	
        JSONObject pembayaran = new JSONObject();
        pembayaran.put("noPembayaran","");
        pembayaran.put("ktp","");
        pembayaran.put("tanggal","");
        pembayaran.put("kategori","");
        pembayaran.put("nominal","");
        

        return pembayaran;
    }
}