//
//  TestViewController.m
//  Runner
//
//  Created by 宋佳 on 2020/4/8.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "TestViewController.h"
#import <Flutter/Flutter.h>

@interface TestViewController ()<FlutterStreamHandler>

/**flutter传如的参数**/
@property(strong,nonatomic) UILabel *showLab;
/**按钮**/
@property(strong,nonatomic) UIButton *nextFlutter;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"原生页面";
    
    [self setUpNav];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = self.str;
    lab.textColor = [UIColor orangeColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    self.showLab = lab;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"原生调用flutter" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(pushNextFlutter:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 10;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    self.nextFlutter = btn;
    
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.showLab.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 40);
    self.nextFlutter.frame = CGRectMake(40, 180, [UIScreen mainScreen].bounds.size.width - 80, 50);
}
-(void)setUpNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backOnClick:)];
}
-(void)backOnClick:(UIBarButtonItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pushNextFlutter:(UIButton *)btn{
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    flutterViewController.navigationItem.title = @"flutter界面";
    [flutterViewController setInitialRoute:@"showStr"];
    // 要与main.dart中一致
    NSString *channelName = @"samples.flutter.io/pushFlutterWidget";
    
    FlutterEventChannel *evenChannal = [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:flutterViewController];
    // 代理FlutterStreamHandler
    [evenChannal setStreamHandler:self];
    
    [self.navigationController pushViewController:flutterViewController animated:YES];
}
#pragma mark - <FlutterStreamHandler>
// // 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    if (events) {
        events(@"iOS-flutter");
    }
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    // arguments flutter给native的参数
    NSLog(@"%@", arguments);
    return nil;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
@end
