//
//  OeditViewController.m
//  问卷研学
//
//  Created by 程党威 on 2018/4/3.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "OeditViewController.h"
#import "JKCoreDataManager.h"
#import "BaseMViewController.h"
#import "SchoolMViewController.h"
#import "classViewController.h"
#import "QMListViewController.h"

@interface OeditViewController (){
    
    NSString * _baseID;
    
    NSString * _schoolID;
    
    NSString * _quID;
    
    QobjectModel * _editModel;
    
}

@property (weak, nonatomic) IBOutlet UIView *back0;
@property (weak, nonatomic) IBOutlet UIView *back1;
@property (weak, nonatomic) IBOutlet UIView *back2;
@property (weak, nonatomic) IBOutlet UIView *back3;
@property (weak, nonatomic) IBOutlet UIView *back4;
@property (weak, nonatomic) IBOutlet UIView *back5;
@property (weak, nonatomic) IBOutlet UIView *back6;
@property (weak, nonatomic) IBOutlet UIView *back7;
@property (weak, nonatomic) IBOutlet UIView *back8;



@property (weak, nonatomic) IBOutlet UIButton *beginBu;

@property (weak, nonatomic) IBOutlet UIButton *baseBU;
@property (weak, nonatomic) IBOutlet UIButton *schoolBU;
@property (weak, nonatomic) IBOutlet UIButton *qubu;
@property (weak, nonatomic) IBOutlet UIButton *classBu1;
@property (weak, nonatomic) IBOutlet UIButton *classBu2;
@property (weak, nonatomic) IBOutlet UIButton *classBu3;
@property (weak, nonatomic) IBOutlet UIButton *timeB1;
@property (weak, nonatomic) IBOutlet UIButton *timeB2;


@property (weak, nonatomic) IBOutlet UILabel *baseLa;
@property (weak, nonatomic) IBOutlet UILabel *schoolLa;
@property (weak, nonatomic) IBOutlet UILabel *quLa;
@property (weak, nonatomic) IBOutlet UILabel *class1;
@property (weak, nonatomic) IBOutlet UILabel *class2;
@property (weak, nonatomic) IBOutlet UILabel *class3;
@property (weak, nonatomic) IBOutlet UILabel *beginT;
@property (weak, nonatomic) IBOutlet UILabel *endT;

@property (weak, nonatomic) IBOutlet UITextField *nameLa;

@property (weak, nonatomic) IBOutlet UIView *timeBack;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIView *backT;
@property (weak, nonatomic) IBOutlet UIButton *dealBU;

@end

@implementation OeditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self crateView];
    [self createData];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self createData];
    [self cancelTime:nil];
    
}
- (void)crateView{
    [self setlayercornerRadius:_back1 Radius:10];
    [self setlayercornerRadius:_back2 Radius:10];
    [self setlayercornerRadius:_back3 Radius:10];
    [self setlayercornerRadius:_back4 Radius:10];
    [self setlayercornerRadius:_back5 Radius:10];
    [self setlayercornerRadius:_back6 Radius:10];
    [self setlayercornerRadius:_back7 Radius:10];
    [self setlayercornerRadius:_back8 Radius:10];
    [self setlayercornerRadius:_back0 Radius:10];
    [self setlayercornerRadius:_backT Radius:10];
    
    [self setlayercornerRadius:_schoolBU Radius:5];
    [self setlayercornerRadius:_beginBu Radius:5];
    [self setlayercornerRadius:_baseBU Radius:5];
    [self setlayercornerRadius:_qubu Radius:5];
    
    [self setlayercornerRadius:_timeB1 Radius:5];
    [self setlayercornerRadius:_timeB2 Radius:5];
    [self setlayercornerRadius:_classBu1 Radius:5];
    [self setlayercornerRadius:_classBu2 Radius:5];
    [self setlayercornerRadius:_classBu3 Radius:5];
    [self setlayercornerRadius:_dealBU Radius:5];
    
}
- (void)createData{

    _editModel = [[JKCoreDataManager shareInstance]efGetQobjectModelWithQobjectModelId:_oID];
    
    _nameLa.text = _editModel.qName;
    _schoolLa.text = _editModel.qSName;
    _baseLa.text = _editModel.qBName;
    _quLa.text = _editModel.qQName;
    _class1.text = _editModel.qCName;
    _class2.text = _editModel.qCName1;
    _class3.text = _editModel.qCName2;
    _beginT.text = _editModel.qtime;
    _endT.text = _editModel.qtime1;

}

- (IBAction)back:(id)sender {
    
    if (_isADD) {
        
        QobjectModel * model = [[JKCoreDataManager shareInstance]efGetQobjectModelWithQobjectModelId:_oID];
        [[JKCoreDataManager shareInstance]efDeleteQobjectModel:model];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//选择基点
- (IBAction)selectbase:(id)sender {
    
    [self .view endEditing:YES];
    
    NSArray * BaseArry = [[JKCoreDataManager shareInstance]efGetAllJKbase];
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"基地选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    for (JKbase * model in BaseArry) {
        
        [myalert addAction:[UIAlertAction actionWithTitle:model.baseName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"%@",model.baseName);
            
            self->_baseLa.text = model.baseName;
            self->_editModel.qBID = model.qID;
            self->_editModel.qBName = model.baseName;
            
        }]];
    }
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"添加基地" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"添加基地");
        
        BaseMViewController * baseView = [[BaseMViewController alloc]init];
        
        [self presentViewController:baseView animated:YES completion:nil];
        
    }]];

    [self presentViewController:myalert animated:YES completion:nil];
    
}

//选择学校
- (IBAction)selectSchool:(id)sender {
     [self .view endEditing:YES];
    
    NSArray * SchoolArry = [[JKCoreDataManager shareInstance]efGetAllSchoolModel];
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"学校选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    for (SchoolModel * model in SchoolArry) {
        
        [myalert addAction:[UIAlertAction actionWithTitle:model.qSName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"%@",model.qSName);
            
            self->_schoolLa.text = model.qSName;
            self->_editModel.qSID = model.qID;
            self->_editModel.qSName = model.qSName;
            
            self->_class1.text = @"";
            self->_class2.text = @"";
            self->_class3.text = @"";
            
            self->_editModel.qCID = @"";
            self->_editModel.qCID1 = @"";
            self->_editModel.qCID2 = @"";
            
            self->_editModel.qCName = @"";
            self->_editModel.qCName1 = @"";
            self->_editModel.qCName2 = @"";
            
        }]];
    }
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"添加学校" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"添加学校");
        
        SchoolMViewController * schoolView = [[SchoolMViewController alloc]init];
        
        [self presentViewController:schoolView animated:YES completion:nil];
        
    }]];
    
    [self presentViewController:myalert animated:YES completion:nil];

}
//选择试题
- (IBAction)selectQu:(id)sender {
     [self .view endEditing:YES];
    
    NSArray * QuArry = [[JKCoreDataManager shareInstance]efGetAllQlistModel];
    
    UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"问卷选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    for (QlistModel * model in QuArry) {
        
        [myalert addAction:[UIAlertAction actionWithTitle:model.qTittle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"%@",model.qTittle);
            
            self->_quLa.text = model.qTittle;
            self->_editModel.qQID = model.qID;
            self->_editModel.qQName = model.qTittle;

            
        }]];
    }
    
    [myalert addAction:[UIAlertAction actionWithTitle:@"添加问卷" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"添加问卷");
        
        QMListViewController * QMListView = [[QMListViewController alloc]init];
        
        [self presentViewController:QMListView animated:YES completion:nil];
        
    }]];
    
    [self presentViewController:myalert animated:YES completion:nil];

    
}
//班级1
- (IBAction)Class1:(id)sender {
     [self .view endEditing:YES];
    
    if (_schoolLa.text.length<1) {
        
        //学校为空 选择学校
        
        [self selectSchool:nil];
        
    }else{
        
        NSArray *ClassArry = [[JKCoreDataManager shareInstance]efGetAllClassModelWith:_editModel.qSID];
        
        UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"班级选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        for (ClassModel * model in ClassArry) {
            
            [myalert addAction:[UIAlertAction actionWithTitle:model.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"%@",model.name);
                
                self->_class1.text = model.name;
                self->_editModel.qCID = model.qID;
                self->_editModel.qCName = model.name;
                
                
            }]];
        }
        
        [myalert addAction:[UIAlertAction actionWithTitle:@"添加班级" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"添加班级");
            
            classViewController * ClassView = [[classViewController alloc]init];
            
            ClassView.schoolID = self->_editModel.qSID;
            
            [self presentViewController:ClassView animated:YES completion:nil];
            
        }]];
        
        [self presentViewController:myalert animated:YES completion:nil];

    }
    
    
    
}
//班级2
- (IBAction)Class2:(id)sender {
    if (_schoolLa.text.length<1) {
        
        //学校为空 选择学校
        
        [self selectSchool:nil];
        
    }else{
        
        NSArray *ClassArry = [[JKCoreDataManager shareInstance]efGetAllClassModelWith:_editModel.qSID];
        
        UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"班级选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        for (ClassModel * model in ClassArry) {
            
            [myalert addAction:[UIAlertAction actionWithTitle:model.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"%@",model.name);
                
                if (self->_class1.text.length<1) {
                    self->_class1.text = model.name;
                    self->_editModel.qCID = model.qID;
                    self->_editModel.qCName = model.name;
                }else{
                
                self->_class2.text = model.name;
                self->_editModel.qCID1 = model.qID;
                self->_editModel.qCName1 = model.name;
                }
                
                
            }]];
        }
        
        [myalert addAction:[UIAlertAction actionWithTitle:@"添加班级" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"添加班级");
            
            classViewController * ClassView = [[classViewController alloc]init];
            
            ClassView.schoolID = self->_editModel.qSID;
            
            [self presentViewController:ClassView animated:YES completion:nil];
            
        }]];
        
        [self presentViewController:myalert animated:YES completion:nil];
        
    }

    
}
//班级3
- (IBAction)Class3:(id)sender {
    if (_schoolLa.text.length<1) {
        
        //学校为空 选择学校
        
        [self selectSchool:nil];
        
    }else{
        
        NSArray *ClassArry = [[JKCoreDataManager shareInstance]efGetAllClassModelWith:_editModel.qSID];
        
        UIAlertController * myalert = [UIAlertController alertControllerWithTitle:@"班级选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        for (ClassModel * model in ClassArry) {
            
            [myalert addAction:[UIAlertAction actionWithTitle:model.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"%@",model.name);
                if (self->_class1.text.length<1) {
                    self->_class1.text = model.name;
                    self->_editModel.qCID = model.qID;
                    self->_editModel.qCName = model.name;
                }else{

                self->_class3.text = model.name;
                self->_editModel.qCID2 = model.qID;
                self->_editModel.qCName2 = model.name;
                }
                
            }]];
        }
        
        [myalert addAction:[UIAlertAction actionWithTitle:@"添加班级" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"添加班级");
            
            classViewController * ClassView = [[classViewController alloc]init];
            
            ClassView.schoolID = self->_editModel.qSID;
            
            [self presentViewController:ClassView animated:YES completion:nil];
            
        }]];
        
        [self presentViewController:myalert animated:YES completion:nil];
        
    }

}
//时间1
- (IBAction)time1:(id)sender {
    
    _timeBack.hidden = NO;
    
    if (_beginT.text.length < 1) {
        
        [_timePicker setDate:[NSDate date]];
    }else{
        
        [_timePicker setDate:[MyTool dateSetStrToDate:_beginT.text]];
    }
    
     _timePicker.tag = 11;
}
//时间2
- (IBAction)time2:(id)sender {
    
    
    _timeBack.hidden = NO;
    
    if (_endT.text.length < 1) {
        
        [_timePicker setDate:[NSDate date]];
        
    }else{
        
        [_timePicker setDate:[MyTool dateSetStrToDate:_endT.text]];
    }
    _timePicker.tag = 22;
    
}
//提交
- (IBAction)update:(id)sender {
    if (_nameLa.text.length<1) {
        [self showHUDWithStr:@"项目名不能为空"];
        [_nameLa becomeFirstResponder];
        return;
    }
    if (_baseLa.text.length<1) {
        [self showHUDWithStr:@"基地不能为空"];
        [self selectbase:nil];
        return;
    }
    if (_schoolLa.text.length<1) {
        [self showHUDWithStr:@"学校不能为空"];
        [self selectSchool:nil];
        return;
    }
    if (_class1.text.length<1) {
        [self showHUDWithStr:@"班级不能为空"];
        [self Class1:nil];
        return;
    }
    if (_beginT.text.length<1) {
        [self showHUDWithStr:@"开始时间不能为空"];
        [self time1:nil];
        return;
    }
    
    _editModel.qName = _nameLa.text;
    
    if (_isADD) {
        _editModel.qUSE = NO;
        _editModel.qHidden = NO;
        _editModel.qDelete = NO;
    }else{
        
    }
    
    [[JKCoreDataManager shareInstance]efAddQobjectModel:_editModel];
    
    [self showHUDWithStr:@"提交成功"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//确定时间
- (IBAction)dealTime:(id)sender {
    
    NSLog(@"选择时间  %@",_timePicker.date);
    _timeBack.hidden = YES;
    if (_timePicker.tag==11) {
        
        _beginT.text = [MyTool dateSetDateToStr:_timePicker.date];
        _editModel.qtime = _beginT.text ;
    }
    if (_timePicker.tag==22) {
        _endT.text = [MyTool dateSetDateToStr:_timePicker.date];
        _editModel.qtime1 = _endT.text ;
    }
    
}
//取消时间
- (IBAction)cancelTime:(id)sender {
    
    _timeBack.hidden = YES;
    
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
