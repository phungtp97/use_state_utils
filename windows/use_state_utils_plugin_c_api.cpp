#include "include/use_state_utils/use_state_utils_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "use_state_utils_plugin.h"

void UseStateUtilsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  use_state_utils::UseStateUtilsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
