//
//  BaseMViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/7.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "BaseMViewController.h"
#import "JKCoreDataManager.h"
#import "QMlistTableViewCell.h"

@interface BaseMViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray  * _ListArry;
    JKbase * _editModel;    // 编辑model
    NSString * _addID;

}
@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (weak, nonatomic) IBOutlet UIView *edView;
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UIView *back2;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *notice;
@property (weak, nonatomic) IBOutlet UIButton *deBu;
@property (weak, nonatomic) IBOutlet UIButton *enterBu;

@end

@implementation BaseMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _edView.hidden=YES;
    _ListArry = [[NSMutableArray alloc]init];
    
    [self createView];
    [self createData];
}
- (void)createView{
    [self setlayercornerRadius:_back Radius:10];
    [self setlayercornerRadius:_back2 Radius:10];
    [self setlayercornerRadius:_enterBu Radius:5];
    [self setlayercornerRadius:_deBu Radius:5];
      [_myTableview registerNib:[UINib nibWithNibName:@"QMlistTableViewCell" bundle:nil] forCellReuseIdentifier:@"QMlistTableViewCell"];
}
- (void)createData{
    _ListArry = [[[JKCoreDataManager shareInstance]efGetAllJKbase] mutableCopy];
    [_myTableview reloadData];
    
}
- (void)clearEd{
    //清空编辑框
    
    _name.text = @"";
    _notice.text = @"";
    
}
- (IBAction)back:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addbu:(id)sender {
    _editModel = [[JKCoreDataManager shareInstance]efCreateJKbase];
    _editModel.qID = [NSString getStrArc4randomWithSize:16];
    _edView.hidden=NO;
    _addID = _editModel.qID;
    [self clearEd];
    [_name becomeFirstResponder];
}
- (IBAction)delete:(id)sender {
    [[JKCoreDataManager shareInstance]efDeleteJKbase:_editModel];
    [self clearEd];
    _edView.hidden=YES;
    _addID = @"";
    
    [self createData];
    [self.view endEditing:YES];

}
- (IBAction)updata:(id)sender {
    if (_name.text.length<1) {
        [self showHUDWithStr:@"基地名不能为空"];
        return;
    }

    _editModel.baseName = _name.text;
    _editModel.baseNotice = _notice.text;
    
    [[JKCoreDataManager shareInstance]efAddJKbase:_editModel];
    _edView.hidden =YES;
    _addID = @"";
    [self clearEd];
    [self createData];
    [self.view endEditing:YES];
}
- (IBAction)cancel:(id)sender {
    if ([_addID isEqualToString:_editModel.qID]) {
        [self delete:nil];
    }else{
        [self clearEd];
        _edView.hidden=YES;
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
    
    [addbutton setTitle:@"新增基地" forState:UIControlStateNormal];
    
    [addbutton setBackgroundColor:UIColorFromRGB(0x719c1c)];
    [self setlayercornerRadius:addbutton Radius:5];
    [addbutton addTarget:self action:@selector(addbu:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:addbutton];
    return  view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QMlistTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QMlistTableViewCell"];
    if (cell== nil) {
        cell = [[QMlistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QMlistTableViewCell"];
    }
    JKbase * model = [_ListArry objectAtIndex: indexPath.row];
    cell.tittle.text = model.baseName;
    cell.time.text = model.baseNotice;
    //    cell.qNumber.text = model.qQu;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JKbase * model = [_ListArry objectAtIndex: indexPath.row];
    _name.text = model.baseName;
    _notice.text = model.baseNotice;
    _editModel = model;
    
    _edView.hidden=NO;
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
