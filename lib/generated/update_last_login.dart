part of 'simogura_connector.dart';

class UpdateLastLoginVariablesBuilder {
  String id;
  Timestamp lastLoginAt;

  final FirebaseDataConnect _dataConnect;
  UpdateLastLoginVariablesBuilder(this._dataConnect, {required  this.id,required  this.lastLoginAt,});
  Deserializer<UpdateLastLoginData> dataDeserializer = (dynamic json)  => UpdateLastLoginData.fromJson(jsonDecode(json));
  Serializer<UpdateLastLoginVariables> varsSerializer = (UpdateLastLoginVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateLastLoginData, UpdateLastLoginVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateLastLoginData, UpdateLastLoginVariables> ref() {
    UpdateLastLoginVariables vars= UpdateLastLoginVariables(id: id,lastLoginAt: lastLoginAt,);
    return _dataConnect.mutation("UpdateLastLogin", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateLastLoginAccountUpdate {
  final String id;
  UpdateLastLoginAccountUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateLastLoginAccountUpdate otherTyped = other as UpdateLastLoginAccountUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateLastLoginAccountUpdate({
    required this.id,
  });
}

@immutable
class UpdateLastLoginData {
  final UpdateLastLoginAccountUpdate? account_update;
  UpdateLastLoginData.fromJson(dynamic json):
  
  account_update = json['account_update'] == null ? null : UpdateLastLoginAccountUpdate.fromJson(json['account_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateLastLoginData otherTyped = other as UpdateLastLoginData;
    return account_update == otherTyped.account_update;
    
  }
  @override
  int get hashCode => account_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (account_update != null) {
      json['account_update'] = account_update!.toJson();
    }
    return json;
  }

  UpdateLastLoginData({
    this.account_update,
  });
}

@immutable
class UpdateLastLoginVariables {
  final String id;
  final Timestamp lastLoginAt;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateLastLoginVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  lastLoginAt = Timestamp.fromJson(json['lastLoginAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateLastLoginVariables otherTyped = other as UpdateLastLoginVariables;
    return id == otherTyped.id && 
    lastLoginAt == otherTyped.lastLoginAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, lastLoginAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['lastLoginAt'] = lastLoginAt.toJson();
    return json;
  }

  UpdateLastLoginVariables({
    required this.id,
    required this.lastLoginAt,
  });
}

