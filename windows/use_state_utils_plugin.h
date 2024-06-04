#ifndef FLUTTER_PLUGIN_USE_STATE_UTILS_PLUGIN_H_
#define FLUTTER_PLUGIN_USE_STATE_UTILS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace use_state_utils {

class UseStateUtilsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  UseStateUtilsPlugin();

  virtual ~UseStateUtilsPlugin();

  // Disallow copy and assign.
  UseStateUtilsPlugin(const UseStateUtilsPlugin&) = delete;
  UseStateUtilsPlugin& operator=(const UseStateUtilsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace use_state_utils

#endif  // FLUTTER_PLUGIN_USE_STATE_UTILS_PLUGIN_H_
