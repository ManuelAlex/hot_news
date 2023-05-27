import 'package:flutter/foundation.dart' show immutable;

@immutable
class ErrorStringConst {
  const ErrorStringConst._();
  static const networkError = 'No Network\n please check your connection';
  static const nullResult = 'Unable to retrieve data';
}
