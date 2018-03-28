//
//  TestTableViewCell.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/13.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *index;
@property (weak, nonatomic) IBOutlet UILabel *messageLa;

@end
