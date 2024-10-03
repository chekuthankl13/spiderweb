import 'dart:developer';

import 'package:mssql_connection/mssql_connection.dart';

class DbConnection {
  
 static final db = MssqlConnection.getInstance();

  Future<bool> connect()async{
   var res = await db.connect(ip: "65.1.22.155",
     port: "1433",
      databaseName: "dev-db",
       username: "test",
        password: "Test@12345678" );
        log("database connection status -> $res");
        return res;
   }
   
}


// //  * Database URL: jdbc:sqlserver://:;databaseName=CompanyDB;
// //     * Host: 65.1.22.155
// //     * Username: test
// //     * Password: Test@12345678
// //     * Database Name: dev-db 