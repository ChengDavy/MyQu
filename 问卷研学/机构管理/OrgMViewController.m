//
//  OrgMViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/7.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "OrgMViewController.h"
#import "SchoolMViewController.h"
#import "BaseMViewController.h"

@interface OrgMViewController ()
@property (weak, nonatomic) IBOutlet UIButton *schoolM;

@property (weak, nonatomic) IBOutlet UIButton *pointM;
@end

@implementation OrgMViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createView];
}

- (void)createView{
    [self setlayercornerRadius:_pointM Radius:10];
    [self setlayercornerRadius:_schoolM Radius:10];
    
}
//返回
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//学校管理
- (IBAction)schoolM:(id)sender {
    SchoolMViewController * schoolM = [[SchoolMViewController alloc]init];
    
    [self presentViewController:schoolM animated:YES completion:nil];
    
}
//基地管理
- (IBAction)pointM:(id)sender {
    BaseMViewController * BaseM = [[BaseMViewController alloc]init];
    
    [self presentViewController:BaseM animated:YES completion:nil];
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
