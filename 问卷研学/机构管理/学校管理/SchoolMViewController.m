//
//  SchoolMViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/7.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "SchoolMViewController.h"
#import "QMlistTableViewCell.h"
#import "JKCoreDataManager.h"

@interface SchoolMViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray  * _ListArry;
    SchoolModel * _editModel;    // 编辑model
    NSString * _addID;
    
}
@property (weak, nonatomic) IBOutlet UIView *editBack;
@property (weak, nonatomic) IBOutlet UIView *back1;
@property (weak, nonatomic) IBOutlet UIView *back2;
@property (weak, nonatomic) IBOutlet UIView *back3;
@property (weak, nonatomic) IBOutlet UIView *back4;
@property (weak, nonatomic) IBOutlet UIButton *deBu;
@property (weak, nonatomic) IBOutlet UIButton *enBU;
@property (weak, nonatomic) IBOutlet UIButton *cancelBU;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *sheng;
@property (weak, nonatomic) IBOutlet UITextField *shi;
@property (weak, nonatomic) IBOutlet UITextField *notice;
@property (weak, nonatomic) IBOutlet UITableView *myTableview;

@end

@implementation SchoolMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _editBack.hidden=YES;
    _ListArry = [[NSMutableArray alloc]init];
    
    [self createView];
    [self createData];
}
- (void)createView{
    [self setlayercornerRadius:_back1 Radius:10];
    [self setlayercornerRadius:_back2 Radius:10];
    [self setlayercornerRadius:_back3 Radius:10];
    [self setlayercornerRadius:_enBU Radius:5];
    [self setlayercornerRadius:_deBu Radius:5];
    [self setlayercornerRadius:_back4 Radius:10];
    
    [_myTableview registerNib:[UINib nibWithNibName:@"QMlistTableViewCell" bundle:nil] forCellReuseIdentifier:@"QMlistTableViewCell"];
}
- (void)createData{
    _ListArry = [[[JKCoreDataManager shareInstance]efGetAllSchoolModel] mutableCopy];
    [_myTableview reloadData];
}
- (void)clearEd{
    //清空编辑框
    
    _name.text = @"";
    _sheng.text = @"";
    _shi.text = @"";
    _notice.text = @"";
    
}
- (IBAction)add:(id)sender {
    
    _editModel = [[JKCoreDataManager shareInstance]efCreateSchoolModel];
    _editModel.qID = [NSString getStrArc4randomWithSize:16];
    _editBack.hidden=NO;
    _addID = _editModel.qID;
    [self clearEd];
    [_name becomeFirstResponder];
    
}
- (IBAction)back:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)delete:(id)sender {
    [[JKCoreDataManager shareInstance]efDeleteSchoolModel:_editModel];
    [self clearEd];
    _editBack.hidden=YES;
    _addID = @"";
    
     [self createData];
     [self.view endEditing:YES];
    
}
- (IBAction)upload:(id)sender {
    if (_name.text.length<1) {
        [self showHUDWithStr:@"学校不能为空"];
        return;
    }
    if (_sheng.text.length<1) {
        [self showHUDWithStr:@"省份不能为空"];
        return;
        
    }
    if (_shi.text.length<1) {
        [self showHUDWithStr:@"城市不能为空"];
        return;
    }
    
    _editModel.qSName = _name.text;
    _editModel.qShen = _sheng.text;
    _editModel.qShi = _shi.text;
    _editModel.qQu = _notice.text;
    
    [[JKCoreDataManager shareInstance]efAddSchoolModel:_editModel];
    _editBack.hidden =YES;
    _addID = @"";
    [self clearEd];
    [self createData];
    [self showHUDWithStr:@"保存成功"];
    [self.view endEditing:YES];
    
}
- (IBAction)cancel:(id)sender {
    if ([_addID isEqualToString:_editModel.qID]) {
        [self delete:nil];
    }else{
    [self clearEd];
    _editBack.hidden=YES;
    }
     [self.view endEditing:YES];
}
- (IBAction)tapenEdit:(id)sender {
    [self.view endEditing:YES];
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
    
    [addbutton setTitle:@"新增学校" forState:UIControlStateNormal];
    
    [addbutton setBackgroundColor:UIColorFromRGB(0x719c1c)];
    [self setlayercornerRadius:addbutton Radius:5];
    [addbutton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
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
    SchoolModel * model = [_ListArry objectAtIndex: indexPath.row];
    cell.tittle.text = model.qSName;
    cell.time.text = [NSString stringWithFormat:@"%@%@",model.qShen,model.qShi];
//    cell.qNumber.text = model.qQu;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SchoolModel * model = [_ListArry objectAtIndex: indexPath.row];
    _name.text = model.qSName;
    _sheng.text = model.qShen;
    _shi.text = model.qShi;
    _notice.text = model.qQu;
    _editModel = model;
    
    _editBack.hidden=NO;
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
