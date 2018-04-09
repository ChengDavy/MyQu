//
//  objectTableViewCell.h
//  问卷研学
//
//  Created by 程党威 on 2018/4/3.
//  Copyright © 2018年 程党威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface objectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *basemane;
@property (weak, nonatomic) IBOutlet UILabel *schoolname;
@property (weak, nonatomic) IBOutlet UILabel *qname;
@property (weak, nonatomic) IBOutlet UILabel *classname;
@property (weak, nonatomic) IBOutlet UILabel *timela;
@property (weak, nonatomic) IBOutlet UIButton *hiddenb;
@property (weak, nonatomic) IBOutlet UIButton *beginbu;

@end
