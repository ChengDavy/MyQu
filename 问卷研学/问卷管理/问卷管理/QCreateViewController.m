//
//  QCreateViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "QCreateViewController.h"
#import "QMlistTableViewCell.h"
#import "QeditAViewController.h"
#import "JKCoreDataManager.h"
#import "choiceTableViewCell.h"

@interface QCreateViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _QTlistArry;
    QlistModel * _listModel;
}

@property (weak, nonatomic) IBOutlet UIView *back1;
@property (weak, nonatomic) IBOutlet UIView *back2;
@property (weak, nonatomic) IBOutlet UIView *back3;
@property (weak, nonatomic) IBOutlet UITextField *tittle;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;


@end

@implementation QCreateViewController

-(void)viewWillAppear:(BOOL)animated{
    [self createTListData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _QTlistArry = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    [self createView];
    [self createData];
}
- (void)createView{
    
    [self setlayercornerRadius:_back1 Radius:10];
    [self setlayercornerRadius:_back2 Radius:10];
    [self setlayercornerRadius:_back3 Radius:10];
    [self setlayercornerRadius:_addButton Radius:10];
    [self setlayercornerRadius:_mytableView Radius:10];
    
    [_mytableView registerNib:[UINib nibWithNibName:@"choiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"choiceTableViewCell"];
}
- (void)createData{
    
    NSLog(@"id %@",_ID);
    
    _listModel = [[JKCoreDataManager shareInstance] efGetQlistModelWithQlistModelId:_ID];
    
    _tittle.text = _listModel.qTittle;
    _message.text = _listModel.qMessage;
    _time.text = _listModel.qDate;
    
    [self createTListData];
    
}
- (void)createTListData{
    
    _QTlistArry = [[[JKCoreDataManager shareInstance]efGetAllQtittleModelWith:_ID]mutableCopy];
    
//    NSLog(@"_QTlistArry  %@",_QTlistArry);
    
    [_mytableView reloadData];
    
    
}
- (IBAction)back:(id)sender {
    
    if (_tittle.text.length==0) {
        
        UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"问卷名不能为空,请输入问卷名,否则该问卷将无法保存" preferredStyle:UIAlertControllerStyleAlert];
        
        [myAlert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[JKCoreDataManager shareInstance]efDeleteQlistModel:self->_listModel];
            [self dismissViewControllerAnimated:YES completion:nil];
       
        }]];
        
        [myAlert addAction:[UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self->_tittle becomeFirstResponder];
        }]];
        
        [self presentViewController:myAlert animated:YES completion:nil];
        
        return;
        
    }else{
        _listModel.qTittle = _tittle.text;
        _listModel.qMessage = _message.text;
        _listModel.qNumber = [NSString stringWithFormat:@"%ld",_QTlistArry.count];
        [[JKCoreDataManager shareInstance]efAddQlistModel:_listModel];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
}
- (IBAction)updata:(id)sender {
    
    if (_tittle.text.length==0) {
        
        UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"问卷名不能为空,该问卷无法保存,请输入问卷名" preferredStyle:UIAlertControllerStyleAlert];
        [myAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        }]];
        [myAlert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self->_tittle becomeFirstResponder];
        }]];
        
        [self presentViewController:myAlert animated:YES completion:nil];
        
        return;
        
    }else{
      _listModel.qTittle = _tittle.text;
      _listModel.qMessage = _message.text;
      _listModel.qNumber = [NSString stringWithFormat:@"%ld",_QTlistArry.count];
       [[JKCoreDataManager shareInstance]efAddQlistModel:_listModel];
        
      [self dismissViewControllerAnimated:YES completion:nil];

    }
    
}
//新增问题
- (IBAction)addQ:(id)sender {
    
    QtittleModel * model = [[JKCoreDataManager shareInstance]efCreateQtittleModel];
    model.qID = [NSString getStrArc4randomWithSize:15];
    model.qListID = _ID;
    model.qTittle=@"";
    model.qBOOL=NO;
    model.qHidden=NO;
    model.qNumber= (int)_QTlistArry.count+1;

    [[JKCoreDataManager shareInstance]efAddQtittleModel:model];

    QeditAViewController * QeView = [[QeditAViewController alloc]init];
    QeView.ID = model.qID;

    [self presentViewController:QeView animated:YES completion:nil];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _QTlistArry.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 80)];
    
    UIButton * addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addbutton.frame = CGRectMake(200, 10, 368, 60);
    
    [addbutton setTitle:@"新增题目" forState:UIControlStateNormal];
    
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
    
    choiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"choiceTableViewCell"];
    if (cell== nil) {
        cell = [[choiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"choiceTableViewCell"];
    }
    
    QtittleModel * model = [_QTlistArry objectAtIndex: indexPath.row];
    cell.name.text = [NSString stringWithFormat:@"%ld : %@",indexPath.row+1,model.qTittle];
    cell.time.text = [NSString stringWithFormat:@"%@",model.qBOOL?@"多选题":@"单选题"];
    
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
    if (indexPath.row+1 == _QTlistArry.count) {
        
        cell.down.hidden = YES;
    }else{
        cell.down.hidden = NO;
        
    }
    
    
//    NSLog(@"model.qTittle  %@",model.qTittle);
    
    return cell;
    
}

- (void)deleBU:(UIButton*)bu{
    
    QtittleModel * model = [_QTlistArry objectAtIndex: bu.tag-10];
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"确认删除:%@",model.qTittle] preferredStyle:UIAlertControllerStyleAlert];
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [myalert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[JKCoreDataManager shareInstance]efDeleteQtittleModel:model];
        
        [self showHUDWithStr:@"删除成功"];
        
        self->_QTlistArry = [[[JKCoreDataManager shareInstance]efGetAllQtittleModelWith:self->_ID]mutableCopy];
        
        for (int i = 0; i < self->_QTlistArry.count; i++) {
            
            QtittleModel * model = [self->_QTlistArry objectAtIndex: i ];
            
            model.qNumber = i + 1;
            
            [[JKCoreDataManager shareInstance] efAddQtittleModel:model];
        }
        [self createData];
        
    }]];
    [self presentViewController:myalert animated:YES completion:nil];
    
   
    
}

- (void)up:(UIButton*)bu{
    
    QtittleModel * model1 = [_QTlistArry objectAtIndex:bu.tag - 1000];
    
    QtittleModel * model2 = [_QTlistArry objectAtIndex:bu.tag - 1001];
    
    model1.qNumber = (int)bu.tag - 1000;
    
    model2.qNumber = (int)bu.tag - 999;
    
    [[JKCoreDataManager shareInstance]efAddQtittleModel:model1];
    [[JKCoreDataManager shareInstance]efAddQtittleModel:model2];
    
    [self createData];
    
    
}

- (void)down:(UIButton*)bu{
    
    QtittleModel * model1 = [_QTlistArry objectAtIndex:bu.tag - 100];
    
    QtittleModel * model2 = [_QTlistArry objectAtIndex:bu.tag - 99];
    
    model1.qNumber = (int)bu.tag - 99;
    
    model2.qNumber = (int)bu.tag - 98;
    
    [[JKCoreDataManager shareInstance]efAddQtittleModel:model1];
    [[JKCoreDataManager shareInstance]efAddQtittleModel:model2];
    
    [self createData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QtittleModel * model = [_QTlistArry objectAtIndex: indexPath.row];
    
    QeditAViewController * QeView = [[QeditAViewController alloc]init];
    
    QeView.ID = model.qID;
    
    [self presentViewController:QeView animated:YES completion:nil];
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
