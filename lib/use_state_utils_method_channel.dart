import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'use_state_utils_platform_interface.dart';

/// An implementation of [UseStateUtilsPlatform] that uses method channels.
class MethodChannelUseStateUtils extends UseStateUtilsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('use_state_utils');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
