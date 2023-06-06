import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';

class DoubleRowString extends StatelessWidget {
  final String str;
  final String? dateString;
  const DoubleRowString({
    super.key,
    required this.str,
    required this.dateString,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            str,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        SizedBox(
          child: Text(
            dateString ?? NewsStringConst.today,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
