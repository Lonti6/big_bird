#include "big_bird_plugin.h"

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

#include <windows.h>
#include <winspool.h>
#include <iostream>
#include <vector>

using namespace std;

namespace big_bird {

// static
void BigBirdPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "big_bird",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<BigBirdPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

BigBirdPlugin::BigBirdPlugin() {}

BigBirdPlugin::~BigBirdPlugin() {}

void BigBirdPlugin::HandleMethodCall(

  const flutter::MethodCall<flutter::EncodableValue> &method_call,

  std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {



  if (method_call.method_name().compare("getPlatformVersion") == 0) {
    std::ostringstream version_stream;

    version_stream << "Windows ";
    version_stream << method_call.method_name();
    result->Success(flutter::EncodableValue(version_stream.str()));

  } else {
    result->NotImplemented();
  }
}

}  // namespace big_bird
