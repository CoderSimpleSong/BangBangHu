#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "UIView+showToast.h"
#import "TestViewController.h"

@implementation AppDelegate
//final showHud = MethodChannel('samples.flutter.io/showHud');
//final showToast = MethodChannel('samples.flutter.io/showToast');
//final pushNew = MethodChannel('samples.flutter.io/pushNew');
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [GeneratedPluginRegistrant registerWithRegistry:self];

    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

    //初始化一个方法桥接,传入桥接名和处理消息发送接收的类 FlutterViewController
    FlutterMethodChannel *showHud = [FlutterMethodChannel methodChannelWithName:@"samples.flutter.io/lsyx" binaryMessenger:controller];
    
    [showHud setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([@"showHud" isEqualToString:call.method]) {
            [self showHud];
        }else if([@"showToast" isEqualToString:call.method]){
            [self showToast:call.arguments];
        }else if ([@"pushNewVC" isEqualToString:call.method]){
            TestViewController *vc = [[TestViewController alloc]init];
            vc.str = call.arguments;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            nav.navigationBar.translucent = NO;
            [nav.navigationBar setTintColor:[UIColor whiteColor]];
            [nav.navigationBar setBarTintColor:[UIColor colorWithRed:29/255.0 green:139/255.0 blue:241/255.0 alpha:1.0]];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [controller presentViewController:nav animated:YES completion:nil];
        }else{
            result(FlutterMethodNotImplemented);
        }
    }];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
-(void)showToast:(NSString *)str{
    [self.window showToast:str completion:nil];
}
-(void)showHud{
    [self.window showHUD];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(3.);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.window animated:YES];
        });
    });
}
- (int)getBatteryLevel:(NSArray *)args {
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i<args.count; i ++ ) {
        [str appendFormat:@"%@",[args objectAtIndex:i]];
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
  UIDevice* device = UIDevice.currentDevice;
  device.batteryMonitoringEnabled = YES;
  if (device.batteryState == UIDeviceBatteryStateUnknown) {
    return -1;
  } else {
    return (int)(device.batteryLevel * 100);
  }
}

@end
