//
//  QeditAViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "QeditAViewController.h"
#import "JKCoreDataManager.h"
#import "choiceTableViewCell.h"

@interface QeditAViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * _ListArry;
    QtittleModel * _QtittleModel;
    QanswerModel * _editmodel;
    NSString * _editId;
}
@property (weak, nonatomic) IBOutlet UIView *back1;
@property (weak, nonatomic) IBOutlet UIView *edBack;
@property (weak, nonatomic) IBOutlet UITextView *qTextF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segB;
@property (weak, nonatomic) IBOutlet UIButton *addBu;
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (weak, nonatomic) IBOutlet UITextView *mytextView;
@property (weak, nonatomic) IBOutlet UIButton *enterAn;
@property (weak, nonatomic) IBOutlet UIButton *clear;
@property (weak, nonatomic) IBOutlet UIButton *cancelBU;

@end

@implementation QeditAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"id %@",_ID);
    
    [self createView];
    [self createData];
}
- (void)createData{
    
    NSLog(@"id %@",_ID);
    
    _QtittleModel = [[JKCoreDataManager shareInstance] efGetQtittleModelWithQtittleModelId:_ID];
    
    _qTextF.text = _QtittleModel.qTittle;

       NSLog(@"_QtittleModel.qTittle   %@",_QtittleModel.qTittle);
    
    if (_QtittleModel.qBOOL) {
        _segB.selectedSegmentIndex = 1;
    }else{
        _segB.selectedSegmentIndex = 0;
    }
    
    [self createTListData];
    
}
- (void)createTListData{
    
    _ListArry = [[[JKCoreDataManager shareInstance]efGetAllQanswerModelWith:_ID]mutableCopy];
    
    NSLog(@"id  %@  _listarry  %@",_ID,_ListArry);
    
    [_mytableView reloadData];
}
- (void)createView{
    
    _edBack.hidden=YES;
    
    [self setlayercornerRadius:_back1 Radius:10];
    [self setlayercornerRadius:_addBu Radius:5];
    [self setlayercornerRadius:_mytableView Radius:10];
    [self setlayercornerRadius:_enterAn Radius:5];
    [self setlayercornerRadius:_cancelBU Radius:5];
    [self setlayercornerRadius:_clear Radius:5];
    [self setlayercornerRadius:_mytextView Radius:10];
    [self setlayercornerRadius:_qTextF Radius:5];
    
      [_mytableView registerNib:[UINib nibWithNibName:@"choiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"choiceTableViewCell"];
    
}
- (IBAction)updata:(id)sender {
    
    if ( _qTextF.text.length ==0) {
        
        UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"题目不能为空,请输入题目,否则该题将无法保存" preferredStyle:UIAlertControllerStyleAlert];
        
        [myAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        
        [myAlert addAction:[UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_qTextF becomeFirstResponder];
        }]];
        
        [self presentViewController:myAlert animated:YES completion:nil];
        
        return;
        
    }else{
        _QtittleModel.qTittle = _qTextF.text;
        if (_segB.selectedSegmentIndex>0) {
            _QtittleModel.qBOOL=YES;
        }else{
            _QtittleModel.qBOOL=NO;
        }
        
        [[JKCoreDataManager shareInstance]efAddQtittleModel:_QtittleModel];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
}
- (IBAction)back:(id)sender {
    //判断题目为空
    if ( _qTextF.text.length ==0) {
        
        UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"题目不能为空,请输入题目,否则该题将无法保存" preferredStyle:UIAlertControllerStyleAlert];
        
        [myAlert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[JKCoreDataManager shareInstance]efDeleteQtittleModel: _QtittleModel];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }]];
        [myAlert addAction:[UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_qTextF becomeFirstResponder];
        }]];
        
        [self presentViewController:myAlert animated:YES completion:nil];
        
        return;
    }else{
        _QtittleModel.qTittle = _qTextF.text;
    }
    
    if (_segB.selectedSegmentIndex>0) {
        _QtittleModel.qBOOL=YES;
    }else{
        _QtittleModel.qBOOL=NO;
    }
    
    [[JKCoreDataManager shareInstance]efAddQtittleModel:_QtittleModel];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)selectBool:(id)sender {
    NSLog(@"%ld",_segB.selectedSegmentIndex);
    
}
- (IBAction)addAN:(id)sender {
    
    _editmodel = [[JKCoreDataManager shareInstance]efCreateQanswerModel];
    _editmodel.qID = [NSString getStrArc4randomWithSize:14];
    _editmodel.qTittleID=_ID;
    _editmodel.qIndex = (int)_ListArry.count+1;
    _editId = _editmodel.qID;
    
    _mytextView.text = @"";
    _edBack.hidden=NO;
    
}
- (IBAction)cancel:(id)sender {
    
    if (_mytextView.text.length<1) {
        
        UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"选项内容不能为空,否则该选项将无法保存" preferredStyle:UIAlertControllerStyleAlert];
        
        [myAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
             [[JKCoreDataManager shareInstance]efDeleteQanswerModel:_editmodel];
            
        }]];
        
        [myAlert addAction:[UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_mytextView becomeFirstResponder];
        }]];
        
        [self presentViewController:myAlert animated:YES completion:nil];
        
        return;
        
    }else{
        
        _editmodel.qMessage = _mytextView.text;
        [[JKCoreDataManager shareInstance]efAddQanswerModel:_editmodel];
        [self createTListData];
        [self.view endEditing:YES];
        _edBack.hidden = YES;
    }
}
- (IBAction)clear:(id)sender {
    _mytextView.text = @"";
}
- (IBAction)enterAnswer:(id)sender {
    
    if (_mytextView.text.length<1) {
        
        UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"选项内容不能为空,否则该选项将无法保存" preferredStyle:UIAlertControllerStyleAlert];
        
        [myAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        
        [myAlert addAction:[UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_mytextView becomeFirstResponder];
        }]];
        
        [self presentViewController:myAlert animated:YES completion:nil];
        
        return;
        
    }else{
    _editmodel.qMessage = _mytextView.text;
    [[JKCoreDataManager shareInstance]efAddQanswerModel:_editmodel];
    [self createTListData];
    [self.view endEditing:YES];
    _edBack.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    addbutton.frame = CGRectMake(175, 10, 368, 60);
    
    [addbutton setTitle:@"新增选项" forState:UIControlStateNormal];
    
    [addbutton setBackgroundColor:UIColorFromRGB(0x719c1c)];
    [self setlayercornerRadius:addbutton Radius:5];
    [addbutton addTarget:self action:@selector(addAN:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:addbutton];
    return  view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    choiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"choiceTableViewCell"];
    if (cell== nil) {
        cell = [[choiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"choiceTableViewCell"];
    }
    
    QanswerModel * model = [_ListArry objectAtIndex: indexPath.row];
    
    cell.name.text = [NSString stringWithFormat:@"%C : %@",(unichar)(65+indexPath.row),model.qMessage];
    
//    cell.time.text = [NSString stringWithFormat:@" %d",model.qIndex];
    
    cell.up.tag = indexPath.row + 1000;
    
    [cell.up addTarget:self action:@selector(up:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.down.tag = indexPath.row + 100;
    
    [cell.down addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.deleteBu.tag = indexPath.row + 10;
    
    [cell.deleteBu addTarget:self action:@selector(deleBU:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPath.row == 0) {
        cell.up.hidden=YES;
    }else{
        cell.up.hidden=NO;
    }
    if (indexPath.row+1 == _ListArry.count) {
        
        cell.down.hidden = YES;
    }else{
        cell.down.hidden = NO;
        
    }
    
    return cell;
    
}

- (void)deleBU:(UIButton*)bu{
    
    QanswerModel * model = [_ListArry objectAtIndex: bu.tag-10];
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"确认删除:%@",model.qMessage] preferredStyle:UIAlertControllerStyleAlert];
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [myalert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[JKCoreDataManager shareInstance]efDeleteQanswerModel:model];
        
        [self showHUDWithStr:@"删除成功"];
        
        _ListArry = [[[JKCoreDataManager shareInstance]efGetAllQanswerModelWith:_ID]mutableCopy];
        
        for (int i = 0; i < _ListArry.count; i++) {
            
            QanswerModel * model = [_ListArry objectAtIndex: i ];
            
            model.qIndex = i + 1;
            
            [[JKCoreDataManager shareInstance] efAddQanswerModel:model];
        }
        [self createData];
        
    }]];
    
    [self presentViewController:myalert animated:YES completion:nil];
    
}

- (void)up:(UIButton*)bu{
    
    QanswerModel * model1 = [_ListArry objectAtIndex:bu.tag - 1000];
    
    QanswerModel * model2 = [_ListArry objectAtIndex:bu.tag - 1001];
    
    model1.qIndex = (int)bu.tag - 1000;
    
    model2.qIndex = (int)bu.tag - 999;
    
    [[JKCoreDataManager shareInstance]efAddQanswerModel:model1];
    [[JKCoreDataManager shareInstance]efAddQanswerModel:model2];
    
    [self createData];
    
    
}

- (void)down:(UIButton*)bu{
    
    QanswerModel * model1 = [_ListArry objectAtIndex:bu.tag - 100];
    
    QanswerModel * model2 = [_ListArry objectAtIndex:bu.tag - 99];
    
    model1.qIndex = (int)bu.tag - 99;
    
    model2.qIndex = (int)bu.tag - 98;
    
    [[JKCoreDataManager shareInstance]efAddQanswerModel:model1];
    [[JKCoreDataManager shareInstance]efAddQanswerModel:model2];
    
    [self createData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _editmodel = [_ListArry objectAtIndex: indexPath.row];

    _editId = _editmodel.qID;
    _mytextView.text = _editmodel.qMessage;
    _edBack.hidden=NO;
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
