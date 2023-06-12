import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChipStateNotier extends StateNotifier<int> {
  ChipStateNotier() : super(0);
  void setIndex(int index) {
    state = index;
  }
}
