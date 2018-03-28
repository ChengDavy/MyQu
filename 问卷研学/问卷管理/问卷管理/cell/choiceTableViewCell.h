//
//  choiceTableViewCell.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/27.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface choiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *up;
@property (weak, nonatomic) IBOutlet UIButton *down;
@property (weak, nonatomic) IBOutlet UIButton *deleteBu;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
