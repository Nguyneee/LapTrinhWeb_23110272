package nguyen01.configs;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectSQL {
    private final String serverName = "localhost";
    private final String portNumber = "1433";
    private final String dbName = "MyDatabase";
    private final String userID = "sa";
    private final String password = "123";
    private final String instance ="";


    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber 
                   + "\\\\" + instance + ";databaseName=" + dbName 
                   + ";user=" + userID + ";password=" + password 
                   + ";encrypt=false;trustServerCertificate=true";

        if (instance == null || instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber 
                + ";databaseName=" + dbName 
                + ";user=" + userID + ";password=" + password 
                + ";encrypt=false;trustServerCertificate=true";
        }

        return DriverManager.getConnection(url);
    }

    public static void main(String[] args) {
        try {
            System.out.println(new DBConnectSQL().getConnection());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}