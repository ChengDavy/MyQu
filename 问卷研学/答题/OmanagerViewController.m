//
//  OmanagerViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/4/3.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "OmanagerViewController.h"
#import "objectTableViewCell.h"
#import "JKCoreDataManager.h"
#import "OeditViewController.h"

@interface OmanagerViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray  * _ListArry;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableview;


@end

@implementation OmanagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];_ListArry = [[NSMutableArray alloc]init];
    
    [self createView];
    [self createData];
    // Do any additional setup after loading the view from its nib.
}
- (void)createView{
    
    [_myTableview registerNib:[UINib nibWithNibName:@"objectTableViewCell" bundle:nil] forCellReuseIdentifier:@"objectTableViewCell"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self createData];
    
}

- (void)createData{
    
    _ListArry = [[[JKCoreDataManager shareInstance]efGetAllQobjectModelWithDelete:NO] mutableCopy];
    
    [_myTableview reloadData];
    
}
- (IBAction)addObject:(id)sender {
    
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
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

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
    [addbutton addTarget:self action:@selector(addObject:) forControlEvents:UIControlEventTouchUpInside];
    
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
    cell.timela.text = [NSString stringWithFormat:@"%@",model.qtime];
    cell.classname.text = [NSString stringWithFormat:@"%@ %@ %@",model.qCName,model.qCName1,model.qCName2];
    cell.qname.text = model.qQName;
    
    
    
    [cell.beginbu setTitle:@"删除项目" forState:UIControlStateNormal];
    cell.beginbu.tag = indexPath.row+10;
    [cell.beginbu addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [cell.beginbu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    if (model.qHidden) {
        [cell.hiddenb setTitle:@"显示项目" forState:UIControlStateNormal];
        cell.hiddenb.tag = indexPath.row+100;
        [cell.hiddenb setBackgroundColor:[UIColor grayColor]];
        [cell.hiddenb addTarget:self action:@selector(hidden:) forControlEvents:UIControlEventTouchUpInside];

    }else{
        
        [cell.hiddenb setTitle:@"隐藏项目" forState:UIControlStateNormal];
        cell.hiddenb.tag = indexPath.row+100;
        [cell.hiddenb addTarget:self action:@selector(hidden:) forControlEvents:UIControlEventTouchUpInside];
        [cell.hiddenb setBackgroundColor:[UIColor orangeColor]];
 
    }
    
    [self setlayercornerRadius:cell.backView Radius:10];
     [self setlayercornerRadius:cell.hiddenb Radius:5];
     [self setlayercornerRadius:cell.beginbu Radius:5];

    return cell;
    
}

- (void)hidden:(UIButton*)sender{
    
    
    QobjectModel * model = [self->_ListArry objectAtIndex:sender.tag - 100];
    
    model.qHidden = !model.qHidden;
    
    if (model.qHidden) {
        [self showHUDWithStr:@"已隐藏"];
    }else{
        [self showHUDWithStr:@"已显示"];
    }
    
    [[JKCoreDataManager shareInstance]efAddQobjectModel:model];
    
    [self createData];
    
}
- (void)delete:(UIButton*)sender{
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除该项目" preferredStyle:UIAlertControllerStyleAlert];
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [myalert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        QobjectModel * model = [self->_ListArry objectAtIndex:sender.tag - 10];
        
        model.qHidden = YES;
        model.qDelete = YES;
        
        [[JKCoreDataManager shareInstance]efAddQobjectModel:model];

        [self createData];
        
    }]];
    [self presentViewController:myalert animated:YES completion:nil];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QobjectModel * model = [_ListArry objectAtIndexWithSafety:indexPath.row];

    [[JKCoreDataManager shareInstance]efAddQobjectModel:model];
    OeditViewController * oEdit = [[OeditViewController alloc]init];
    oEdit.oID = model.qID;
    oEdit.isADD = NO;
    
    [self presentViewController:oEdit animated:YES completion:nil];

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
