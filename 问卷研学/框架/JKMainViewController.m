
//
//  JKMainViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/5.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "JKMainViewController.h"
#import "QManagerViewController.h"
#import "OrgMViewController.h"
#import "BeginAnViewController.h"
#import "TestManagerViewController.h"

@interface JKMainViewController ()

@end

@implementation JKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //白色状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // Do any additional setup after loading the view from its nib.
}
//开始测试
- (IBAction)begin:(id)sender {
    
//    BeginAnViewController * beginAn = [[BeginAnViewController alloc]init];
    
    TestManagerViewController * beginAn = [[TestManagerViewController alloc]init];
    
    [self presentViewController:beginAn animated:YES completion:nil];
    
}
//问卷管理
- (IBAction)questionSet:(id)sender {
    
    QManagerViewController * QManager = [[QManagerViewController alloc]init];
    
    [self presentViewController:QManager animated:YES completion:nil];
    
}
//测试组织管理
- (IBAction)orgSet:(id)sender {
    OrgMViewController * OrgManager = [[OrgMViewController alloc]init];
    [self presentViewController:OrgManager animated:YES completion:nil];
}
- (IBAction)about:(id)sender {
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
