//
//  classViewController.h
//  问卷研学
//
//  Created by 程党威 on 2018/4/2.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import "KBaseViewController.h"

@interface classViewController : KBaseViewController

@property (nonatomic,strong) NSString * schoolID;
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UITextField *className;
@property (weak, nonatomic) IBOutlet UITextField *fuzer;
@property (weak, nonatomic) IBOutlet UITextField *notice;

@end
