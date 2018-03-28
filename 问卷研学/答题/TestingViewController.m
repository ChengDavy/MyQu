//
//  TestingViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/12.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "TestingViewController.h"
#import "JKCoreDataManager.h"
#import "TestTableViewCell.h"

@interface TestingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * _listArry ;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableview;

@end

@implementation TestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _listArry =[[NSMutableArray alloc]init];
    [self createView];
    [self createData];
    // Do any additional setup after loading the view from its nib.
}
- (void)createData{
    
    _listArry = [[[JKCoreDataManager shareInstance]efGetAllRestittleModelWith:_testId] mutableCopy] ;
    
    [_myTableview reloadData];
    
}
- (void)createView{
    [_myTableview registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil] forCellReuseIdentifier:@"TestTableViewCell"];
    
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)updata:(id)sender {
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _listArry.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_listArry.count>0) {
        
        RestittleModel * tittleModel = [_listArry objectAtIndex:section];
        
        NSArray * arry = [[JKCoreDataManager shareInstance]efGetAllResAnswerModelWith:tittleModel.qID];
        return  arry.count;
    }else{
        return 0;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 80)];
    
    UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 700, 50)];
    label.numberOfLines=2;
//    view.backgroundColor = [UIColor clearColor];
    view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    
    [view addSubview:label];
    if (_listArry.count > 0)
    {
    
    RestittleModel * model = [_listArry objectAtIndex:section];
        
        label.font = [UIFont systemFontOfSize:20];
        
        label.text = [NSString stringWithFormat:@"%ld. %@(%@)",section+1,model.qTittle,model.qBOOL?@"多选题":@"单选题"];

    }
    
    return view;
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell"];
    if (cell == nil) {
        cell = [[TestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TestTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RestittleModel * tittleModel = [_listArry objectAtIndex:indexPath.section];
    
    NSArray * arry = [[JKCoreDataManager shareInstance]efGetAllResAnswerModelWith:tittleModel.qID];
    
    ResAnswerModel * anModel = [arry objectAtIndexWithSafety:indexPath.row];
    
    [self setlayercornerRadius:cell.backView Radius:3];
    if (anModel.qSelect) {
        cell.backView.backgroundColor = UIColorFromRGB(0x719c1c);
    }else{
        cell.backView.backgroundColor = UIColorFromRGB(0xffffff);
    }
    cell.index.text = [NSString stringWithFormat:@"%C.",(unichar)(indexPath.row+65)];
    cell.messageLa.text = anModel.qMessage;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RestittleModel * tittleModel = [_listArry objectAtIndex:indexPath.section];
    
    NSArray * arry = [[JKCoreDataManager shareInstance]efGetAllResAnswerModelWith:tittleModel.qID];
    
    ResAnswerModel * anModel = [arry objectAtIndexWithSafety:indexPath.row];
    
    if (tittleModel.qBOOL) {
        anModel.qSelect = !anModel.qSelect;
        
        [[JKCoreDataManager shareInstance]efAddResAnswerModel:anModel];
        
    }else{
        for (ResAnswerModel * Model in arry) {
            if (Model==anModel) {
                Model.qSelect = !Model.qSelect;
                 [[JKCoreDataManager shareInstance]efAddResAnswerModel:Model];
            }else{
                Model.qSelect = NO;
                  [[JKCoreDataManager shareInstance]efAddResAnswerModel:Model];
            }
            
        }
  
    }
//    [_myTableview reloadData];
    
    [_myTableview reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:NO];

    
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
