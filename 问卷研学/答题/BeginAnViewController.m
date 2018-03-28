//
//  BeginAnViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/3/9.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "BeginAnViewController.h"
#import "JKCoreDataManager.h"
#import "BaseMViewController.h"
#import "SchoolMViewController.h"
#import "QMListViewController.h"
#import "TestingViewController.h"

@interface BeginAnViewController ()<UIActionSheetDelegate>{
    NSMutableArray * _baseArry;

    NSMutableArray * _schoolArry;

    NSMutableArray * _quArry;

    NSString * _baseID;
    
    NSString * _schoolID;
    
    NSString * _quID;
    
    
}
@property (weak, nonatomic) IBOutlet UIView *yyyy;
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UIView *back2;
@property (weak, nonatomic) IBOutlet UIView *back3;
@property (weak, nonatomic) IBOutlet UIView *back4;
@property (weak, nonatomic) IBOutlet UIView *back5;
@property (weak, nonatomic) IBOutlet UIButton *beginBu;
@property (weak, nonatomic) IBOutlet UIButton *baseBU;
@property (weak, nonatomic) IBOutlet UIButton *schoolBU;
@property (weak, nonatomic) IBOutlet UIButton *qubu;
@property (weak, nonatomic) IBOutlet UILabel *baseLa;
@property (weak, nonatomic) IBOutlet UILabel *schoolLa;
@property (weak, nonatomic) IBOutlet UILabel *quLa;
@property (weak, nonatomic) IBOutlet UITextField *classLa;
@property (weak, nonatomic) IBOutlet UITextField *nameLa;

@end

@implementation BeginAnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _baseArry = [[NSMutableArray alloc]init];
//    _baseNameArry = [[NSMutableArray alloc]init];
    _schoolArry = [[NSMutableArray alloc]init];
//    _schoolNameArry = [[NSMutableArray alloc]init];
    _quArry = [[NSMutableArray alloc]init];
//    _quNameArry = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    [self crateView];
    [self createData];
}
-(void)viewWillAppear:(BOOL)animated{
    [self createData];
}
- (void)crateView{
    [self setlayercornerRadius:_back Radius:10];
    [self setlayercornerRadius:_back2 Radius:10];
    [self setlayercornerRadius:_back3 Radius:10];
    [self setlayercornerRadius:_back4 Radius:10];
    [self setlayercornerRadius:_back5 Radius:10];
    [self setlayercornerRadius:_schoolBU Radius:5];
    [self setlayercornerRadius:_beginBu Radius:5];
    [self setlayercornerRadius:_baseBU Radius:5];
    [self setlayercornerRadius:_qubu Radius:5];
    
}
- (void)createData{
    _baseArry = [[[JKCoreDataManager shareInstance]efGetAllJKbase]mutableCopy];

    _schoolArry = [[JKCoreDataManager shareInstance]efGetAllSchoolModel];
    
    _quArry = [[JKCoreDataManager shareInstance]efGetAllQlistModel];

}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//选择基点
- (IBAction)selectbase:(id)sender {

    UIActionSheet * myAction = [[UIActionSheet alloc]initWithTitle:@"选择基地" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"新增基地" otherButtonTitles:nil];
    
    for (JKbase * baseModel in _baseArry) {
        NSString * name = baseModel.baseName;
        [myAction addButtonWithTitle:name];
    }
    myAction.tag = 1111;
    
    myAction.delegate =self;
    [myAction showInView:self.view];
    
}
//选择学校
- (IBAction)selectSchool:(id)sender {
    UIActionSheet * myAction = [[UIActionSheet alloc]initWithTitle:@"选择学校" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"新增学校" otherButtonTitles:nil];
    
    for (SchoolModel * Model in _schoolArry) {
        NSString * name = Model.qSName;
        [myAction addButtonWithTitle:name];
    }

    myAction.tag = 2222;
    myAction.delegate =self;
    [myAction showInView:self.view];
    
}
//选择试题
- (IBAction)selectQu:(id)sender {
    
    UIActionSheet * myAction = [[UIActionSheet alloc]initWithTitle:@"选择学校" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"新增学校" otherButtonTitles:nil];
    
    for (QlistModel * Model in _quArry) {
        NSString * name = Model.qTittle;
        [myAction addButtonWithTitle:name];
    }

    myAction.tag = 3333;
    myAction.delegate =self;
    [myAction showInView:self.view];
    
}
//开始测试
- (IBAction)beginTest:(id)sender {
    if (_baseLa.text.length<1) {
//        [self showHUDWithStr:@"请选择基地"];
        [self selectbase:nil];
        return;
    }
    if (_schoolLa.text.length<1) {
//        [self showHUDWithStr:@"请选择学校"];
        [self selectSchool:nil];
        return;
    }
    if (_quLa.text.length<1) {
//        [self showHUDWithStr:@"请选择问卷"];
        [self selectQu:nil];
        return;
    }
    if (_classLa.text.length<1) {
        [self showHUDWithStr:@"请填写院系"];
        [_classLa becomeFirstResponder];
        return;
    }
    if (_nameLa.text.length<1) {
        [self showHUDWithStr:@"请填写姓名"];
        [_nameLa becomeFirstResponder];
        return;
    }
    
    
    
    UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"开始测试" preferredStyle:UIAlertControllerStyleAlert];
    [myAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }]];
    [myAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
        
        [self showHUDWithStr:@"问卷处理中...."];
        
        ResListModel * model = [[JKCoreDataManager shareInstance]efCreateResListModel];
        
        model.qID = [NSString getStrArc4randomWithSize:16];
        
        model.qSchoolID = _schoolID;
        model.qSchoolTittle = _schoolLa.text;
        model.qBaseID = _baseID;
        model.qBaseName = _baseLa.text;
        model.qQuID = _quID;
        model.qQuTittle = _quLa.text;
        model.qClassID = _classLa.text;
        model.qName = _nameLa.text;
        model.qTime = [NSDate date];
        [[JKCoreDataManager shareInstance]efAddResListModel:model];
        
        [self createUserResWithId:model.qID];
        
        TestingViewController * testView = [[TestingViewController alloc]init];
        testView.testId = model.qID;
       
        [self presentViewController:testView animated:YES completion:nil];
        
        
    }]];
    [self presentViewController:myAlert animated:YES completion:nil];
    
}
- (void)createUserResWithId:(NSString *)testId{
    
    //创建用户问卷
    
    NSArray * tittleA = [[JKCoreDataManager shareInstance]efGetAllQtittleModelWith:_quID];
    for (QtittleModel * model in tittleA) {
//        NSLog(@"model.qTittlemodel.qTittlemodel.qTittle %@",model.qTittle);
        RestittleModel *resModel = [[JKCoreDataManager shareInstance]efCreateRestittleModel];
        
        resModel.qID = [NSString getStrArc4randomWithSize:16];
        resModel.qOldID = model.qID;
        resModel.qTittle = model.qTittle;
        resModel.qBOOL = model.qBOOL;
        resModel.qNumber = model.qNumber;
        resModel.qListID = testId;
        resModel.qOldlistID = _quID;
        resModel.qHidden = model.qHidden;
        
        [[JKCoreDataManager shareInstance]efAddRestittleModel:resModel];
        
        NSArray * ansArry = [[JKCoreDataManager shareInstance]efGetAllQanswerModelWith:model.qID];
        
        for (QanswerModel * anModel in ansArry) {
            ResAnswerModel * resAnModel = [[JKCoreDataManager shareInstance]efCreateResAnswerModel];
            
            resAnModel.qID = [NSString getStrArc4randomWithSize:16];
            
//            NSLog(@"resAnModel.qIDresAnModel.qIDresAnModel.qID %@",resAnModel.qID);
            resAnModel.qOldlistID = _quID;
            resAnModel.qListID = testId;
            resAnModel.qIndex = anModel.qIndex;
            resAnModel.qTittleID = resModel.qID;
            resAnModel.qMessage = anModel.qMessage;
            resAnModel.qSelect = NO;
            [[JKCoreDataManager shareInstance]efAddResAnswerModel:resAnModel];
            
        }

    }
    
    
    
}
- (IBAction)endEd:(id)sender {
    [self.view endEditing:YES];
}

//action
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex   %ld",buttonIndex);
    
    if (actionSheet.tag==1111) {
        if (buttonIndex==0) {
        
            BaseMViewController * baseM =[[BaseMViewController alloc]init];
            [self presentViewController:baseM animated:YES completion:nil];
            
        }else{
            
            JKbase * model = [_baseArry objectAtIndexWithSafety:buttonIndex-2];
            _baseLa.text = model.baseName;
            _baseID = model.qID;
        }
        
    }else if (actionSheet.tag ==2222 ){
        if (buttonIndex==0) {
            
            SchoolMViewController * schoolM =[[SchoolMViewController alloc]init];
            [self presentViewController:schoolM animated:YES completion:nil];
            
        }else{
            
            SchoolModel * model = [_schoolArry objectAtIndexWithSafety:buttonIndex-2];
            _schoolLa.text = model.qSName;
            _schoolID = model.qID;
            
        }
  
    }else if (actionSheet.tag ==3333 ){
        if (buttonIndex==0) {
            
            QMListViewController * qM =[[QMListViewController alloc]init];
            [self presentViewController:qM animated:YES completion:nil];
            
        }else{
            
            QlistModel * model = [_quArry objectAtIndexWithSafety:buttonIndex-2];
            _quLa.text = model.qTittle;
            _quID = model.qID;
            
        }
        
    }
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
