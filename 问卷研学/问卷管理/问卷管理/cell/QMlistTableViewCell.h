//
//  QMlistTableViewCell.h
//  问卷研学
//
//  Created by 程党威 on 2018/3/6.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMlistTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tittle;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *qNumber;

@end
