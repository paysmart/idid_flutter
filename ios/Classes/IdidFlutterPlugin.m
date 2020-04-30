#import "IdidFlutterPlugin.h"
#if __has_include(<idid_flutter/idid_flutter-Swift.h>)
#import <idid_flutter/idid_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "idid_flutter-Swift.h"
#endif

@implementation IdidFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIdidFlutterPlugin registerWithRegistrar:registrar];
}
@end
