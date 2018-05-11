//
//  UPCell.h
//  TouchID
//
//  Created by 孙亚杰 on 16/5/20.
//  Copyright © 2016年 JassonSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPEntity.h"

typedef void(^SwipBlock)();
@interface UPCell : UITableViewCell
@property (nonatomic,strong) UIView *view;
@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UIButton *delBtn;
@property (nonatomic,strong) UILabel *hostNameLabel;
@property (nonatomic,strong) UILabel *passWordLabel;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *psLabel;
@property (nonatomic,copy) SwipBlock leftswipblock;
@property (nonatomic,copy) SwipBlock rightswipblock;
@property (nonatomic,copy) SwipBlock tapblock;
@property (nonatomic,copy) SwipBlock editblock;
@property (nonatomic,copy) SwipBlock delblock;
- (void)fullCellWithEntity:(UPEntity *)entity;
@end
