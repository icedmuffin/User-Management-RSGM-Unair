package rsgm_unair.shared;

import rsgm_unair.config.DatabaseConfig;

import radityopw.couchdbclient.*;

public class CouchHelper{

	public static CouchdbClient createClient(){
		CouchdbClientConfig config = new CouchdbClientConfig();
        config.setDatabase(DatabaseConfig.databaseName());
        config.setCurl(DatabaseConfig.curl());
        config.setProtocol(DatabaseConfig.protocol());
        config.setHost(DatabaseConfig.host());
        config.setPort(DatabaseConfig.port());
        config.setUsername(DatabaseConfig.username());
        config.setPassword(DatabaseConfig.password());
        
        CouchdbClient client = new CouchdbClient(config);
        
        return client;
	}

}