//
//  countViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/27.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "countViewController.h"
#import "JKCoreDataManager.h"
#import "MCTableViewCell.h"
#import "schoolCountViewController.h"
#import "objectCountViewController.h"

@interface countViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray  * _ListArry;
    
    NSString * _BaseID;
    
    NSString * _SchoolID;
    
    NSString * _ClassID;
    
    NSString * _ObjectID;
    
}

@property (weak, nonatomic) IBOutlet UIButton *objectBu;
@property (weak, nonatomic) IBOutlet UIButton *classBase;
@property (weak, nonatomic) IBOutlet UIButton *schoolBu;
@property (weak, nonatomic) IBOutlet UIButton *baseBu;
@property (weak, nonatomic) IBOutlet UITableView *myTableview;

@end

@implementation countViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    _ClassID = @"";
    _BaseID = @"";
    _SchoolID = @"";
    _ObjectID = @"";
    [self createView];
    [self createData];
}

- (void)createView{
    
    [_myTableview registerNib:[UINib nibWithNibName:@"MCTableViewCell" bundle:nil] forCellReuseIdentifier:@"MCTableViewCell"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)createData{
    
//    _ListArry = [[[JKCoreDataManager shareInstance]efGetAllResListModel] mutableCopy];
    
    _ListArry = [[[JKCoreDataManager shareInstance]efSearchAllResListModelWithBaseID:_BaseID SchoolID:_SchoolID ClassID:_ClassID ObjectID:_ObjectID] mutableCopy];
    
    [_myTableview reloadData];
    
}

//选择分类
- (IBAction)selectMenu:(id)sender {
    
    schoolCountViewController * schoolC = [[schoolCountViewController alloc]init];
    
    [self presentViewController:schoolC animated:YES completion:nil];
    
//    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"分类选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
//
//    [myalert addAction:[UIAlertAction actionWithTitle:@"学校/班级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        schoolCountViewController * schoolC = [[schoolCountViewController alloc]init];
//
//        [self presentViewController:schoolC animated:YES completion:nil];
//
//
//    }]];
//    [myalert addAction:[UIAlertAction actionWithTitle:@"项目/班级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        objectCountViewController * objectC = [[objectCountViewController alloc]init];
//
//        [self presentViewController:objectC animated:YES completion:nil];
//
//    }]];
//    [myalert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }]];
//    [self presentViewController:myalert animated:YES completion:nil];
    
}
//返回
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//基地筛选
- (IBAction)baseS:(id)sender {
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"选择基地" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSArray * BaseArry = [[JKCoreDataManager shareInstance]efGetAllJKbase];
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"全部" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self->_BaseID = @"";
        [self->_baseBu setTitle:@"全部" forState:UIControlStateNormal];
        [self createData];
        
    }]];
    
    for (JKbase * model in BaseArry) {
        [myalert addAction:[UIAlertAction actionWithTitle:model.baseName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_BaseID = model.qID;
            [self->_baseBu setTitle:model.baseName forState:UIControlStateNormal];
            [self createData];
            
        }]];
    }
    
    [self presentViewController:myalert animated:YES completion:nil];
    
    
    
}
//学校筛选
- (IBAction)shcoolS:(id)sender {
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"选择基地" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSArray * BaseArry = [[JKCoreDataManager shareInstance]efGetAllSchoolModel];
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"全部" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self->_SchoolID = @"";
        [self->_schoolBu setTitle:@"全部" forState:UIControlStateNormal];
        self->_ClassID = @"";
        [self->_classBase setTitle:@"全部" forState:UIControlStateNormal];
        [self createData];
        
    }]];
    
    for (SchoolModel * model in BaseArry) {
        [myalert addAction:[UIAlertAction actionWithTitle:model.qSName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_SchoolID = model.qID;
            [self->_schoolBu setTitle:model.qSName forState:UIControlStateNormal];
            self->_ClassID = @"";
            [self->_classBase setTitle:@"全部" forState:UIControlStateNormal];
            
            [self createData];
            
        }]];
    }
    
    [self presentViewController:myalert animated:YES completion:nil];
    
}
//班级筛选
- (IBAction)classS:(id)sender {
    
    if (_SchoolID.length<1) {
        [self showHUDWithStr:@"先进行学校选择"];
        [self shcoolS:nil];
        return;
    }
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"选择班级" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSArray * BaseArry = [[JKCoreDataManager shareInstance]efGetAllClassModelWith:_SchoolID];
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"全部" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self->_ClassID = @"";
        [self->_classBase setTitle:@"全部" forState:UIControlStateNormal];
        [self createData];
        
    }]];
    
    for (ClassModel * model in BaseArry) {
        [myalert addAction:[UIAlertAction actionWithTitle:model.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_ClassID = model.qID;
            [self->_classBase setTitle:model.name forState:UIControlStateNormal];
            [self createData];
            
        }]];
    }
    
    [self presentViewController:myalert animated:YES completion:nil];
    
}
//项目筛选
- (IBAction)objectS:(id)sender {
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"选择项目" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSArray * BaseArry = [[JKCoreDataManager shareInstance]efGetAllQobjectModel];
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"全部" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self->_ObjectID = @"";
        [self->_objectBu setTitle:@"全部" forState:UIControlStateNormal];
        [self createData];
        
    }]];
    
    for (QobjectModel * model in BaseArry) {
        [myalert addAction:[UIAlertAction actionWithTitle:model.qName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_ObjectID = model.qID;
            [self->_objectBu setTitle:model.qName forState:UIControlStateNormal];
            [self createData];
            
        }]];
    }
    
    [self presentViewController:myalert animated:YES completion:nil];
    
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
    
    
    [addbutton setTitle:@"暂无更多" forState:UIControlStateNormal];
    
    [addbutton setBackgroundColor:UIColorFromRGB(0x719c1c)];
    [self setlayercornerRadius:addbutton Radius:5];
//    [addbutton addTarget:self action:@selector(addObject:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:addbutton];
    
    return  view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MCTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MCTableViewCell"];
    if (cell== nil) {
        cell = [[MCTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MCTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setlayercornerRadius:cell.back  Radius:5];
    
    ResListModel * model = [_ListArry objectAtIndexWithSafety:indexPath.row];
    
    cell.name.text = model.qName;
    cell.object.text = model.qObjectName;
//    cell.score.text = model.qName;
    cell.schoolName.text = model.qSchoolTittle;
    cell.className.text = model.qClassName;
    cell.quName.text = model.qQuTittle;
    cell.base.text = model.qBaseName;
    
//    cell.textLabel.text = [NSString stringWithFormat:@"hahahaha %@ %@  %@  %@",model.qBaseName,model.qSchoolTittle,model.qClassName,model.qObjectName];
   
    return cell;
    
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
