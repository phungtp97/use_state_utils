import 'package:flutter_test/flutter_test.dart';
import 'package:use_state_utils/use_state_utils_platform_interface.dart';
import 'package:use_state_utils/use_state_utils_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUseStateUtilsPlatform
    with MockPlatformInterfaceMixin
    implements UseStateUtilsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UseStateUtilsPlatform initialPlatform = UseStateUtilsPlatform.instance;

  test('$MethodChannelUseStateUtils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUseStateUtils>());
  });

  test('getPlatformVersion', () async {});
}
