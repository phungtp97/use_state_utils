//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <use_state_utils/use_state_utils_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) use_state_utils_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UseStateUtilsPlugin");
  use_state_utils_plugin_register_with_registrar(use_state_utils_registrar);
}
