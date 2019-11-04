#import "FlutterDashboardPlugin.h"
#import <flutter_dashboard/flutter_dashboard-Swift.h>

@implementation FlutterDashboardPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterDashboardPlugin registerWithRegistrar:registrar];
}
@end
