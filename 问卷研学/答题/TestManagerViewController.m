//
//  TestManagerViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/4/2.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "TestManagerViewController.h"
#import "objectTableViewCell.h"
#import "JKCoreDataManager.h"
#import "OmanagerViewController.h"
#import "OeditViewController.h"
#import "studentSetViewController.h"

@interface TestManagerViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray  * _ListArry;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableview;

@end

@implementation TestManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ListArry = [[NSMutableArray alloc]init];
    
    [self createView];
    [self createData];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{

    [self createData];
}
- (void)createView{
    
     [_myTableview registerNib:[UINib nibWithNibName:@"objectTableViewCell" bundle:nil] forCellReuseIdentifier:@"objectTableViewCell"];
    
}
- (void)createData{
    
    _ListArry = [[[JKCoreDataManager shareInstance]efGetAllQobjectModelWithHidden:NO] mutableCopy];
    
    [_myTableview reloadData];
    
}

- (IBAction)objectM:(id)sender {
    
    OmanagerViewController * oManger = [[OmanagerViewController alloc]init];
    
    [self presentViewController:oManger animated:YES completion:nil];
    
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)addClass:(id)sender {
    
    QobjectModel * model = [[JKCoreDataManager shareInstance]efCreateQobjectModel];
    model.qID = [NSString getStrArc4randomWithSize:16];
    model.qHidden=YES;
    model.qUSE = NO;
    model.qDelete =YES;
    
    [[JKCoreDataManager shareInstance]efAddQobjectModel:model];
    OeditViewController * oEdit = [[OeditViewController alloc]init];
    oEdit.oID = model.qID;
    oEdit.isADD = YES;
    
    
    [self presentViewController:oEdit animated:YES completion:nil];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ListArry.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 80)];
    
    UIButton * addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addbutton.frame = CGRectMake(200, 10, 368, 60);
    
    [addbutton setTitle:@"新增项目" forState:UIControlStateNormal];
    
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
    
    objectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"objectTableViewCell"];
    if (cell== nil) {
        cell = [[objectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"objectTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    QobjectModel * model = [_ListArry objectAtIndexWithSafety:indexPath.row];
    cell.name.text = model.qName;
    cell.schoolname.text = model.qSName;
    cell.basemane.text = model.qBName;
    cell.qname.text = model.qQName;
    cell.timela.text = [NSString stringWithFormat:@"%@ %@",model.qtime,model.qtime1];
    cell.classname.text = [NSString stringWithFormat:@"%@ %@ %@",model.qCName,model.qCName1,model.qCName2];
    
    [self setlayercornerRadius:cell.backView Radius:10];
    [self setlayercornerRadius:cell.hiddenb Radius:5];
    [self setlayercornerRadius:cell.beginbu Radius:5];
    
    cell.hiddenb.tag = indexPath.row + 100;
    cell.beginbu.tag = indexPath.row + 10;
    
    [cell.hiddenb addTarget:self action:@selector(hidden:) forControlEvents:UIControlEventTouchUpInside];
    [cell.beginbu addTarget:self action:@selector(beginTest:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    cell
    
    return cell;
}
- (void)beginTest:(UIButton*)bu{
    
    QobjectModel * model = [self->_ListArry objectAtIndex:bu.tag - 10];
    
    studentSetViewController * begin = [[studentSetViewController alloc]init];
    
    begin.oID = model.qID;
    
    [self presentViewController:begin animated:YES completion:nil];
    
    
}

- (void)hidden:(UIButton*)sender{
    
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认隐藏,隐藏后该项目将不会在该页显示,可在项目管理中设置显示" preferredStyle:UIAlertControllerStyleAlert];
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        QobjectModel * model = [self->_ListArry objectAtIndex:sender.tag - 100];
        
        model.qHidden = YES;
        
            [self showHUDWithStr:@"已隐藏"];

        [[JKCoreDataManager shareInstance]efAddQobjectModel:model];
        
        [self createData];
 
    }]];
    [self presentViewController:myalert animated:YES completion:nil];
    
  
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QobjectModel * model = [self->_ListArry objectAtIndex:indexPath.row];
    
    studentSetViewController * begin = [[studentSetViewController alloc]init];
    
    begin.oID = model.qID;
    
    [self presentViewController:begin animated:YES completion:nil];
    
    
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
