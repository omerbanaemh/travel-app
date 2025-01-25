import 'package:internet_connection_checker/internet_connection_checker.dart';

//network informations interface
//get the network connection informations
abstract class NetworkInfo {
  factory NetworkInfo(InternetConnectionChecker checker) =
      NetworkInfoImplementer;

//check if there is network connection
  Future<bool> get isConnected;
}

//network informations interface implementer
class NetworkInfoImplementer implements NetworkInfo {
  final InternetConnectionChecker _checker;

  NetworkInfoImplementer(this._checker);

  @override
  Future<bool> get isConnected => _checker.hasConnection;
}
