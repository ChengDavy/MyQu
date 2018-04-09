//
//  studentSetViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/4/8.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "studentSetViewController.h"
#import "JKCoreDataManager.h"
#import "TestingViewController.h"
@interface studentSetViewController (){
    NSString * _classID;
    NSString * _className;
    QobjectModel * _objectMode;
}

@property (weak, nonatomic) IBOutlet UIView *back1;
@property (weak, nonatomic) IBOutlet UIView *back2;
@property (weak, nonatomic) IBOutlet UIView *back3;
@property (weak, nonatomic) IBOutlet UIView *back4;
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UIView *back5;
@property (weak, nonatomic) IBOutlet UIButton *upbu;
@property (weak, nonatomic) IBOutlet UIButton *classseleBu;
@property (weak, nonatomic) IBOutlet UILabel *objectLa;
@property (weak, nonatomic) IBOutlet UILabel *baseLa;
@property (weak, nonatomic) IBOutlet UILabel *quLa;
@property (weak, nonatomic) IBOutlet UILabel *schoolLa;
@property (weak, nonatomic) IBOutlet UILabel *classLa;
@property (weak, nonatomic) IBOutlet UITextField *nameTextf;


@end

@implementation studentSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createView];
    [self createData];
}
- (void)createData{
    
    _objectMode = [[JKCoreDataManager shareInstance]efGetQobjectModelWithQobjectModelId:_oID];
    
    _objectLa.text = _objectMode.qName;
    _baseLa.text   = _objectMode.qBName;
    _schoolLa.text = _objectMode.qSName;
    _quLa.text     = _objectMode.qQName;
    _classLa.text  = _objectMode.qCName;
    // 设置默认班级ID
    
    _classID = _objectMode.qCID;
    _className = _objectMode.qCName;
    
    if (_objectMode.qCName1.length<1 && _objectMode.qCName2.length<1) {
        _classseleBu.hidden = YES;
    }
}

- (void)createView{
    
    [self setlayercornerRadius:_back Radius:10];
    [self setlayercornerRadius:_back1 Radius:10];
    [self setlayercornerRadius:_back2 Radius:10];
    [self setlayercornerRadius:_back3 Radius:10];
    [self setlayercornerRadius:_back4 Radius:10];
    [self setlayercornerRadius:_back5 Radius:10];
    
    [self setlayercornerRadius:_upbu Radius:5];
    [self setlayercornerRadius:_classseleBu Radius:5];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)selectClass:(id)sender {
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"班级选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    if (_objectMode.qCName.length>1) {
        [myalert addAction:[UIAlertAction actionWithTitle:_objectMode.qCName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self->_className = self->_objectMode.qCName;
            self->_classLa.text = self->_objectMode.qCName;
            self->_classID = self->_objectMode.qCID;
 
        }]];
    }
    if (_objectMode.qCName1.length>1) {
        [myalert addAction:[UIAlertAction actionWithTitle:_objectMode.qCName1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_className = self->_objectMode.qCName1;
            self->_classLa.text = self->_objectMode.qCName1;
            self->_classID = self->_objectMode.qCID1;
        }]];
    }
    if (_objectMode.qCName2.length>1) {
        [myalert addAction:[UIAlertAction actionWithTitle:_objectMode.qCName2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_className = self->_objectMode.qCName2;
            self->_classLa.text = self->_objectMode.qCName2;
            self->_classID = self->_objectMode.qCID2;
        }]];
    }
    
    [self presentViewController:myalert animated:YES completion:nil];
    
}
- (IBAction)endEdit:(id)sender {
    
    [self.view endEditing:YES];
  
}
- (IBAction)beginTest:(id)sender {
    
    UIAlertController * myAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"开始测试" preferredStyle:UIAlertControllerStyleAlert];
    [myAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }]];
    [myAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
        
        [self showHUDWithStr:@"问卷处理中...."];
        
        ResListModel * model = [[JKCoreDataManager shareInstance]efCreateResListModel];
        
        model.qID = [NSString getStrArc4randomWithSize:16];
        model.qSchoolID = self->_objectMode.qSID;
        model.qSchoolTittle = self->_objectMode.qSName;
        model.qBaseID = self->_objectMode.qBID;
        model.qBaseName = self->_objectMode.qBName;
        model.qQuID = self->_objectMode.qQID;
        model.qQuTittle = self->_objectMode.qQName;
        model.qClassID = self->_classID;
        model.qClassName = self->_className;
        model.qObjectID = self-> _objectMode.qID;
        model.qObjectName = self-> _objectMode.qName;
        model.qName = self->_nameTextf.text;
        model.qTime = [NSDate date];
        [[JKCoreDataManager shareInstance]efAddResListModel:model];
        
        [self createUserResWithId:model.qID QuID:model.qQuID];
        
        TestingViewController * testView = [[TestingViewController alloc]init];
        testView.testId = model.qID;
        
        [self presentViewController:testView animated:YES completion:nil];
        
        
    }]];
    [self presentViewController:myAlert animated:YES completion:nil];
    
}
- (void)createUserResWithId:(NSString *)testId QuID:(NSString*)quID{
    
    //创建用户问卷
    
    NSArray * tittleA = [[JKCoreDataManager shareInstance]efGetAllQtittleModelWith:quID];
    for (QtittleModel * model in tittleA) {
        //        NSLog(@"model.qTittlemodel.qTittlemodel.qTittle %@",model.qTittle);
        RestittleModel *resModel = [[JKCoreDataManager shareInstance]efCreateRestittleModel];
        
        resModel.qID = [NSString getStrArc4randomWithSize:16];
        resModel.qOldID = model.qID;
        resModel.qTittle = model.qTittle;
        resModel.qBOOL = model.qBOOL;
        resModel.qNumber = model.qNumber;
        resModel.qListID = testId;
        resModel.qOldlistID = quID;
        resModel.qHidden = model.qHidden;
        
        [[JKCoreDataManager shareInstance]efAddRestittleModel:resModel];
        
        NSArray * ansArry = [[JKCoreDataManager shareInstance]efGetAllQanswerModelWith:model.qID];
        
        for (QanswerModel * anModel in ansArry) {
            ResAnswerModel * resAnModel = [[JKCoreDataManager shareInstance]efCreateResAnswerModel];
            
            resAnModel.qID = [NSString getStrArc4randomWithSize:16];
            
            //            NSLog(@"resAnModel.qIDresAnModel.qIDresAnModel.qID %@",resAnModel.qID);
            resAnModel.qOldlistID = quID;
            resAnModel.qListID = testId;
            resAnModel.qIndex = anModel.qIndex;
            resAnModel.qTittleID = resModel.qID;
            resAnModel.qMessage = anModel.qMessage;
            resAnModel.qSelect = NO;
            [[JKCoreDataManager shareInstance]efAddResAnswerModel:resAnModel];
            
        }
        
    }
    
    
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
