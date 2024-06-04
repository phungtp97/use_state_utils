#ifndef FLUTTER_PLUGIN_USE_STATE_UTILS_PLUGIN_H_
#define FLUTTER_PLUGIN_USE_STATE_UTILS_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _UseStateUtilsPlugin UseStateUtilsPlugin;
typedef struct {
  GObjectClass parent_class;
} UseStateUtilsPluginClass;

FLUTTER_PLUGIN_EXPORT GType use_state_utils_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void use_state_utils_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // FLUTTER_PLUGIN_USE_STATE_UTILS_PLUGIN_H_
