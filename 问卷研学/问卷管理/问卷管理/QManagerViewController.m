//
//  QManagerViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "QManagerViewController.h"
#import "QMListViewController.h"
#import "countViewController.h"

@interface QManagerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mButton;
@property (weak, nonatomic) IBOutlet UIButton *cButton;

@end

@implementation QManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createView];
    
}
- (void)createView{
    [self setlayercornerRadius:_mButton Radius:10];
    [self setlayercornerRadius:_cButton Radius:10];
    
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//问卷管理
- (IBAction)qManager:(id)sender {
    
    QMListViewController * QMListView = [[QMListViewController alloc]init];
    
    [self presentViewController:QMListView animated:YES completion:nil];
    
}
//问卷统计
- (IBAction)qChecker:(id)sender {
    countViewController * count = [[countViewController alloc]init];
    
    [self presentViewController:count animated:YES completion:nil];
    
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
