//
//  UIView+showToast.h
//  Recycling
//
//  Created by jzd on 2018/5/18.
//  Copyright © 2018年 宋佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Toast.h"
#import "MBProgressHUD.h"

@interface UIView (showToast)
-(void)showToast:(NSString *)toast completion:(void(^)(BOOL didTap))completion;

-(void)showHUD;
@end
