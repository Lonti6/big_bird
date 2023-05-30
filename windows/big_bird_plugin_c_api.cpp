#include "include/big_bird/big_bird_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "big_bird_plugin.h"

void BigBirdPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  big_bird::BigBirdPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
