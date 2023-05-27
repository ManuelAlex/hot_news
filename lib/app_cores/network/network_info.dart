import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetWorkInfo {
  Future<bool> get isConnected;
}

class NetWorkInfoImpl implements NetWorkInfo {
  final DataConnectionChecker dataConnectionChecker;
  NetWorkInfoImpl({
    required this.dataConnectionChecker,
  });

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
