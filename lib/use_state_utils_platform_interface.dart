import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'use_state_utils_method_channel.dart';

abstract class UseStateUtilsPlatform extends PlatformInterface {
  /// Constructs a UseStateUtilsPlatform.
  UseStateUtilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static UseStateUtilsPlatform _instance = MethodChannelUseStateUtils();

  /// The default instance of [UseStateUtilsPlatform] to use.
  ///
  /// Defaults to [MethodChannelUseStateUtils].
  static UseStateUtilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UseStateUtilsPlatform] when
  /// they register themselves.
  static set instance(UseStateUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
