library simogura;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'get_account_by_username.dart';

part 'update_last_login.dart';







class SimoguraConnectorConnector {
  
  
  GetAccountByUsernameVariablesBuilder getAccountByUsername ({required String username, }) {
    return GetAccountByUsernameVariablesBuilder(dataConnect, username: username,);
  }
  
  
  UpdateLastLoginVariablesBuilder updateLastLogin ({required String id, required Timestamp lastLoginAt, }) {
    return UpdateLastLoginVariablesBuilder(dataConnect, id: id,lastLoginAt: lastLoginAt,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-east4',
    'simogura_connector',
    'simogura',
  );

  SimoguraConnectorConnector({required this.dataConnect});
  static SimoguraConnectorConnector get instance {
    
    return SimoguraConnectorConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
