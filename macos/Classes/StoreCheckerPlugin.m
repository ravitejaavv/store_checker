#import "StoreCheckerPlugin.h"
#if __has_include(<store_checker/store_checker-Swift.h>)
#import <store_checker/store_checker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "store_checker-Swift.h"
#endif

@implementation StoreCheckerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftStoreCheckerPlugin registerWithRegistrar:registrar];
}
@end
