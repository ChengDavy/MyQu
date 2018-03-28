//
//  KBaseViewController.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/5.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBaseViewController : UIViewController

//设置圆角
-(void)setlayercornerRadius:(UIView *)view Radius:(CGFloat)Radius;
//设置圆角,边线,颜色
-(void)setlayercornerRadius:(UIView *)view Radius:(CGFloat)Radius Width:(CGFloat)width Color:(UIColor*)color;
//自动弹窗
- (void)showHUDWithStr:(NSString *)str;
//弹窗确认
- (void)showAlertViewStr:(NSString *)str;
@end
