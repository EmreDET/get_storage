import 'package:get/state_manager.dart';

class ValueStorage<T> extends Value<T> {
  ValueStorage(super.value);

  Map<String, dynamic> changes = <String, dynamic>{};

  void changeValue(String key, value) {
    changes = {key: value};
    refresh();
  }
}
