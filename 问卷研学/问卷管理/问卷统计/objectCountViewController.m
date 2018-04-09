//
//  objectCountViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/4/9.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "objectCountViewController.h"
#import "JKCoreDataManager.h"
#import "MCTableViewCell.h"

@interface objectCountViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray  * _ListArry;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableview;

@end

@implementation objectCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _ListArry = [[NSMutableArray alloc]init];
    
    [self createView];
    [self createData];
    
}
- (void)createView{
    
[_myTableview registerNib:[UINib nibWithNibName:@"MCTableViewCell" bundle:nil] forCellReuseIdentifier:@"MCTableViewCell"];
    
}
- (void)createData{
    
    _ListArry = [[JKCoreDataManager shareInstance]efGetAllQobjectModelWithClassId:_cID];
    
//    [[[JKCoreDataManager shareInstance]efSearchAllResListModelWithBaseID:@"" SchoolID:@"" ClassID:_cID ObjectID:@""] mutableCopy];
    
    [_myTableview reloadData];
    
}
- (IBAction)back:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _ListArry.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    QobjectModel * model = [_ListArry objectAtIndexWithSafety:section];
    
    NSArray * modelArry = [[JKCoreDataManager shareInstance]efSearchAllResListModelWithBaseID:@"" SchoolID:@"" ClassID:_cID ObjectID:model.qID];
    
    return modelArry.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 50)];
    
    QobjectModel * model = [_ListArry objectAtIndexWithSafety:section];
    
    ClassModel * classmodel = [[JKCoreDataManager shareInstance]efGetClassModelWithClassModelId:_cID];
    
    view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 368, 30)];
    
    label.text = [NSString stringWithFormat:@"项目: %@ 班级 %@",model.qName ,classmodel.name];
    
    [view addSubview:label];
    
    return  view;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 80)];
    
    UIButton * addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addbutton.frame = CGRectMake(200, 10, 368, 60);
    
    [addbutton setTitle:@"没有更多" forState:UIControlStateNormal];
    
    [addbutton setBackgroundColor:UIColorFromRGB(0x719c1c)];
    [self setlayercornerRadius:addbutton Radius:5];
    
    //    [addbutton addTarget:self action:@selector(addClass:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    QobjectModel * qmodel = [_ListArry objectAtIndexWithSafety:indexPath.section];
    
    NSArray * modelArry = [[JKCoreDataManager shareInstance]efSearchAllResListModelWithBaseID:@"" SchoolID:@"" ClassID:_cID ObjectID:qmodel.qID];
    
    ResListModel * model = [modelArry objectAtIndexWithSafety:indexPath.row];
    
    cell.name.text = model.qName;
    cell.object.text = model.qObjectName;
    //    cell.score.text = model.qName;
    cell.schoolName.text = model.qSchoolTittle;
    cell.className.text = model.qClassName;
    cell.quName.text = model.qQuTittle;
    cell.base.text = model.qBaseName;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SchoolModel * model = [_ListArry objectAtIndexWithSafety:indexPath.section];
    
    NSArray * modelArry = [[JKCoreDataManager shareInstance]efGetAllClassModelWith:model.qID];
    
    ClassModel * classmodel = [modelArry objectAtIndexWithSafety:indexPath.row];
    
    objectCountViewController * object = [[objectCountViewController alloc]init];
    
    object.cID = classmodel.qID;
    
    [self presentViewController:object animated:YES completion:nil];
    
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
