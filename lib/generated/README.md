# simogura SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
SimoguraConnectorConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetAccountByUsername
#### Required Arguments
```dart
String username = ...;
SimoguraConnectorConnector.instance.getAccountByUsername(
  username: username,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetAccountByUsernameData, GetAccountByUsernameVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await SimoguraConnectorConnector.instance.getAccountByUsername(
  username: username,
);
GetAccountByUsernameData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String username = ...;

final ref = SimoguraConnectorConnector.instance.getAccountByUsername(
  username: username,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### UpdateLastLogin
#### Required Arguments
```dart
String id = ...;
Timestamp lastLoginAt = ...;
SimoguraConnectorConnector.instance.updateLastLogin(
  id: id,
  lastLoginAt: lastLoginAt,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateLastLoginData, UpdateLastLoginVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await SimoguraConnectorConnector.instance.updateLastLogin(
  id: id,
  lastLoginAt: lastLoginAt,
);
UpdateLastLoginData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
Timestamp lastLoginAt = ...;

final ref = SimoguraConnectorConnector.instance.updateLastLogin(
  id: id,
  lastLoginAt: lastLoginAt,
).ref();
ref.execute();
```

