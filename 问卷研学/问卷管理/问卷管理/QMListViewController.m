//
//  QMListViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "QMListViewController.h"
#import "QCreateViewController.h"

#import "QMlistTableViewCell.h"


//数据库管理
#import "JKCoreDataManager.h"

@interface QMListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * _ListArry;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation QMListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ListArry =[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    [self createView];
    [self getdata];
}
- (void)viewWillAppear:(BOOL)animated{
    [self getdata];
}

- (void)getdata{
    
    //获取题目列表
    
    _ListArry = [[[JKCoreDataManager shareInstance]efGetAllQlistModel]mutableCopy];
    NSLog(@"%@",_ListArry);
    [_myTableView reloadData];
    
}
- (void)createView{
    
    [_myTableView registerNib:[UINib nibWithNibName:@"QMlistTableViewCell" bundle:nil] forCellReuseIdentifier:@"QMlistTableViewCell"];
    
}
//返回
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//新增问卷
- (IBAction)addQ:(id)sender {
    
//    新建问卷表
    QlistModel * model = [[JKCoreDataManager shareInstance]efCreateQlistModel];
    model.qID = [NSString getStrArc4randomWithSize:16];
    model.qTittle = @"";
    model.qDate = [NSString getYearMouthDay:@"-"];
    model.qNumber = @"0";
//    跳转编辑页
    [[JKCoreDataManager shareInstance]efAddQlistModel:model];
    
    QCreateViewController * QCView = [[QCreateViewController alloc]init];
//    传入ID
    QCView.ID = model.qID;
    [self presentViewController:QCView animated:YES completion:nil];
    
//
//    [self getdata];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ListArry.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 80)];
    
    UIButton * addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addbutton.frame = CGRectMake(200, 10, 368, 60);
    
    [addbutton setTitle:@"新增问卷" forState:UIControlStateNormal];
    
    [addbutton setBackgroundColor:UIColorFromRGB(0x719c1c)];
    [self setlayercornerRadius:addbutton Radius:5];
    [addbutton addTarget:self action:@selector(addQ:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:addbutton];
    
    return  view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QMlistTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QMlistTableViewCell"];
    if (cell== nil) {
        cell = [[QMlistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QMlistTableViewCell"];
    }
    QlistModel * model = [_ListArry objectAtIndex: indexPath.row];
    cell.tittle.text = model.qTittle;
    cell.time.text = [NSString stringWithFormat:@"时间:%@",model.qDate];
    NSArray * qArry = [[JKCoreDataManager shareInstance]efGetAllQtittleModelWith:model.qID];
    cell.qNumber.text =[NSString stringWithFormat:@"共 %ld 题",qArry.count];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QlistModel * model = [_ListArry objectAtIndex: indexPath.row];
    
    QCreateViewController * QCView = [[QCreateViewController alloc]init];
    //    传入ID
    QCView.ID = model.qID;
    [self presentViewController:QCView animated:YES completion:nil];
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
