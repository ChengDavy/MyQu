//
//  classViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/4/2.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "classViewController.h"
#import "QMlistTableViewCell.h"
#import "JKCoreDataManager.h"

@interface classViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray  * _ListArry;
    ClassModel * _editModel;    // 编辑model
    SchoolModel * _schoolModel;   // 学校model
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
@property (weak, nonatomic) IBOutlet UITableView *myTableview;

@end

@implementation classViewController

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
    _schoolModel = [[JKCoreDataManager shareInstance]efGetSchoolModelWithSchoolModelId :_schoolID];
    
    _ListArry = [[[JKCoreDataManager shareInstance]efGetAllClassModelWith:_schoolID] mutableCopy];
    [_myTableview reloadData];
}
- (void)clearEd{
    //清空编辑框
    
    _className.text = @"";
    _school.text = @"";
    _fuzer.text = @"";
    _notice.text = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)delete:(id)sender {
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除" preferredStyle:UIAlertControllerStyleAlert];
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [myalert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 
        [[JKCoreDataManager shareInstance]efDeleteClassModel:self-> _editModel];
        [self clearEd];
        self->_editBack.hidden=YES;
        self->_addID = @"";
        [self createData];
        [self.view endEditing:YES];
        [self showHUDWithStr:@"删除成功"];
        
    }]];
    [self
     presentViewController:myalert animated:YES completion:nil];
    
}

- (IBAction)updata:(id)sender {
    if (_className.text.length<1) {
        [self showHUDWithStr:@"班级不能为空"];
        return;
    }
    
    _editModel.name = _className.text;
    _editModel.manager = _fuzer.text;
    _editModel.notice = _notice.text;
    
    [[JKCoreDataManager shareInstance]efAddClassModel: _editModel];
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
- (IBAction)addClass:(id)sender {
    
    _editModel = [[JKCoreDataManager shareInstance]efCreateClassModel];
    _editModel.sID = _schoolID;
    _editModel.qID = [NSString getStrArc4randomWithSize:16];
    _editBack.hidden=NO;
    _addID = _editModel.qID;
    [self clearEd];
    
     _school.text = _schoolModel.qSName;
    [_className becomeFirstResponder];
    
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
    
    [addbutton setTitle:@"新增班级" forState:UIControlStateNormal];
    
    [addbutton setBackgroundColor:UIColorFromRGB(0x719c1c)];
    [self setlayercornerRadius:addbutton Radius:5];
    [addbutton addTarget:self action:@selector(addClass:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    ClassModel * model = [_ListArry objectAtIndex: indexPath.row];
    
    cell.tittle.text = model.name;
    cell.time.text = [NSString stringWithFormat:@"%@",_schoolModel.qSName];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ClassModel * model = [_ListArry objectAtIndex: indexPath.row];
    _className.text = model.name;
    _school.text = _schoolModel.qSName;
    _fuzer.text = model.manager;
    _notice.text = model.notice;
    _editModel = model;
    
    _editBack.hidden=NO;
}

- (IBAction)back:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
    
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
