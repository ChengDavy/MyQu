//
//  KBaseViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/5.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "KBaseViewController.h"

@interface KBaseViewController ()

@end

@implementation KBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // Do any additional setup after loading the view.
}
- (void)showHUDWithStr:(NSString *)str
{
    UIWindow *win=[[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:win animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.color=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = str;
    hud.labelFont=[UIFont systemFontOfSize:16];
    
    [hud hide:YES afterDelay:2];
    
}
- (void)showAlertViewStr:(NSString *)str
{
    UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    
    [alertView show];
}

//设置圆角
-(void)setlayercornerRadius:(UIView *)view Radius:(CGFloat)Radius{
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=Radius;
}

-(void)setlayercornerRadius:(UIView *)view Radius:(CGFloat)Radius Width:(CGFloat)width Color:(UIColor*)color{
    
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=Radius;
    view.layer.borderWidth=width;
    view.layer.borderColor=color.CGColor;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
