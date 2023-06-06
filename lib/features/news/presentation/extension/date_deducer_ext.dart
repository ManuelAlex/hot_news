import 'package:intl/intl.dart' show DateFormat;

extension GetDateTime on String {
  String getDateTime() => DateFormat('M E-d').format(
        DateTime.parse(
          this,
        ),
      );
}
