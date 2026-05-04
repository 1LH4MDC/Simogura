part of 'simogura_connector.dart';

class GetAccountByUsernameVariablesBuilder {
  String username;

  final FirebaseDataConnect _dataConnect;
  GetAccountByUsernameVariablesBuilder(this._dataConnect, {required  this.username,});
  Deserializer<GetAccountByUsernameData> dataDeserializer = (dynamic json)  => GetAccountByUsernameData.fromJson(jsonDecode(json));
  Serializer<GetAccountByUsernameVariables> varsSerializer = (GetAccountByUsernameVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetAccountByUsernameData, GetAccountByUsernameVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetAccountByUsernameData, GetAccountByUsernameVariables> ref() {
    GetAccountByUsernameVariables vars= GetAccountByUsernameVariables(username: username,);
    return _dataConnect.query("GetAccountByUsername", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetAccountByUsernameAccounts {
  final String id;
  final String username;
  final String passwordHash;
  final String role;
  GetAccountByUsernameAccounts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  username = nativeFromJson<String>(json['username']),
  passwordHash = nativeFromJson<String>(json['passwordHash']),
  role = nativeFromJson<String>(json['role']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAccountByUsernameAccounts otherTyped = other as GetAccountByUsernameAccounts;
    return id == otherTyped.id && 
    username == otherTyped.username && 
    passwordHash == otherTyped.passwordHash && 
    role == otherTyped.role;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, username.hashCode, passwordHash.hashCode, role.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['username'] = nativeToJson<String>(username);
    json['passwordHash'] = nativeToJson<String>(passwordHash);
    json['role'] = nativeToJson<String>(role);
    return json;
  }

  GetAccountByUsernameAccounts({
    required this.id,
    required this.username,
    required this.passwordHash,
    required this.role,
  });
}

@immutable
class GetAccountByUsernameData {
  final List<GetAccountByUsernameAccounts> accounts;
  GetAccountByUsernameData.fromJson(dynamic json):
  
  accounts = (json['accounts'] as List<dynamic>)
        .map((e) => GetAccountByUsernameAccounts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAccountByUsernameData otherTyped = other as GetAccountByUsernameData;
    return accounts == otherTyped.accounts;
    
  }
  @override
  int get hashCode => accounts.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['accounts'] = accounts.map((e) => e.toJson()).toList();
    return json;
  }

  GetAccountByUsernameData({
    required this.accounts,
  });
}

@immutable
class GetAccountByUsernameVariables {
  final String username;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetAccountByUsernameVariables.fromJson(Map<String, dynamic> json):
  
  username = nativeFromJson<String>(json['username']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAccountByUsernameVariables otherTyped = other as GetAccountByUsernameVariables;
    return username == otherTyped.username;
    
  }
  @override
  int get hashCode => username.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['username'] = nativeToJson<String>(username);
    return json;
  }

  GetAccountByUsernameVariables({
    required this.username,
  });
}

