import '../use_state_utils.dart';

extension UseStateExt<T> on UseStateScene<T>? {
  void onNotNull(Function(T value) callback) {
    if (this != null) {
      onNotNull(callback(this as T));
    }
  }
}
