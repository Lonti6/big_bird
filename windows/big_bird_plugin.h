#ifndef FLUTTER_PLUGIN_BIG_BIRD_PLUGIN_H_
#define FLUTTER_PLUGIN_BIG_BIRD_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace big_bird {

class BigBirdPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BigBirdPlugin();

  virtual ~BigBirdPlugin();

  // Disallow copy and assign.
  BigBirdPlugin(const BigBirdPlugin&) = delete;
  BigBirdPlugin& operator=(const BigBirdPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace big_bird

#endif  // FLUTTER_PLUGIN_BIG_BIRD_PLUGIN_H_
