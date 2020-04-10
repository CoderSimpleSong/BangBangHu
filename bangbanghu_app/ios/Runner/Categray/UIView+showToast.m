//
//  UIView+showToast.m
//  Recycling
//
//  Created by jzd on 2018/5/18.
//  Copyright © 2018年 宋佳. All rights reserved.
//

#import "UIView+showToast.h"
#import "UIView+SDAutoLayout.h"

#define SJScreenW [UIScreen mainScreen].bounds.size.width
#define SJScreenH [UIScreen mainScreen].bounds.size.height
//状态栏高度
#define statsBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define tabbarHeight ((statsBarHeight == 44)?83:49)

@implementation UIView (showToast)
-(void)showToast:(NSString *)toast completion:(void(^)(BOOL didTap))completion{
    CGFloat bottomH = (statsBarHeight != 20)?83:49;
    CSToastStyle *style = [[CSToastStyle alloc]initWithDefaultStyle];
    style.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    if (!toast  || [toast isKindOfClass:[NSNull class]]) {
        return;
    }
    [self makeToast:toast duration:1.0 position:[NSValue valueWithCGPoint:CGPointMake(SJScreenW*0.5, self.height-bottomH-50)] title:nil image:nil style:style completion:completion];
}
-(void)showHUD{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.label.text = @"请稍后...";
    hud.backgroundColor = [UIColor clearColor];
    hud.backgroundView.backgroundColor = [UIColor clearColor];
    hud.contentColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
}
@end
