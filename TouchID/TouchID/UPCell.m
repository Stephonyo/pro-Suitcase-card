//
//  UPCell.m
//  TouchID
//
//  Created by 孙亚杰 on 16/5/20.
//  Copyright © 2016年 JassonSun. All rights reserved.
//

#import "UPCell.h"
#import "EffectView.h"
#import <Masonry.h>
@interface UPCell()


@end
@implementation UPCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorWithRed:34/255.0 green:39/255.0 blue:52/255.0 alpha:1];
//        self.backgroundColor = [UIColor redColor];
        _delBtn = [[UIButton alloc] init];
        _delBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_delBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_delBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_delBtn addTarget:self action:@selector(delAction) forControlEvents:UIControlEventTouchUpInside];
        _delBtn.layer.cornerRadius = 5;
        _delBtn.hidden = YES;
        _delBtn.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_delBtn];
        [_delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(-20));
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width*0.13));
        }];

        
        _editBtn = [[UIButton alloc] init];
//        _editBtn.layer.shadowOffset = CGSizeMake(0, 5);
//        _editBtn.layer.shadowColor = [UIColor blackColor].CGColor;
//        _editBtn.layer.shadowOpacity = 0.3;
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _editBtn.hidden = YES;
        _editBtn.layer.cornerRadius = 5;
        _editBtn.backgroundColor = [UIColor colorWithRed:150/255.0f green:150/255.0f blue:160/255.0f alpha:1.0f];
        [self.contentView addSubview:_editBtn];
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_delBtn.mas_left);
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(-20));
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width*0.13));
        }];
//        [self addEffect:_delBtn];
//        [self addEffect:_editBtn];
        
        
        
        _view = [[UIView alloc] init];
        _view.backgroundColor = [UIColor whiteColor];
        _view.layer.cornerRadius = 5;
        _view.alpha = 0.95;
//        _view.layer.shadowOffset = CGSizeMake(-5, 5);
//        _view.layer.shadowColor = [UIColor blackColor].CGColor;
//        _view.layer.shadowOpacity = 0.3;
        [self.contentView addSubview:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(10));
            make.top.equalTo(@(0));
            make.right.equalTo(@(-10));
            make.bottom.equalTo(@(-20));
        }];

        NSArray *arr = @[@"hostname",@"user",@"password",@"ps"];
        for (int i = 0; i < 4; i ++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, i*35 + 10, 25, 25)];
            imageView.image = [UIImage imageNamed:arr[i]];
            [_view addSubview:imageView];
            if (i == 3)
            {
                //备忘label的tag是300
                imageView.tag = 300;
            }
        }
        _hostNameLabel = [[UILabel alloc] init];
        _hostNameLabel.textColor = [UIColor colorWithRed:150/255.0f green:150/255.0f blue:160/255.0f alpha:1.0f];
        _hostNameLabel.textAlignment = NSTextAlignmentLeft;
        _hostNameLabel.font = [UIFont systemFontOfSize:15];
        [_view addSubview:_hostNameLabel];
        [_hostNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(50));
            make.top.equalTo(@(10));
            make.right.equalTo(@(-10));
            make.height.equalTo(@(25));
        }];
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = [UIColor colorWithRed:150/255.0f green:150/255.0f blue:160/255.0f alpha:1.0f];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.font = [UIFont systemFontOfSize:15];
        [_view addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(50));
            make.right.equalTo(@(-10));
            make.top.mas_equalTo(_hostNameLabel.mas_bottom).with.offset(10);
            make.height.equalTo(@(25));
        }];
        
        _passWordLabel = [[UILabel alloc] init];
        _passWordLabel.textColor = [UIColor colorWithRed:150/255.0f green:150/255.0f blue:160/255.0f alpha:1.0f];
        _passWordLabel.textAlignment = NSTextAlignmentLeft;
        _passWordLabel.font = [UIFont systemFontOfSize:15];
        [_view addSubview:_passWordLabel];
        [_passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(50));
            make.right.equalTo(@(-10));
            make.top.mas_equalTo(_userNameLabel.mas_bottom).with.offset(10);
            make.height.equalTo(@(25));
        }];

        _psLabel = [[UILabel alloc] init];
        _psLabel.textColor = [UIColor colorWithRed:150/255.0f green:150/255.0f blue:160/255.0f alpha:1.0f];
        _psLabel.textAlignment = NSTextAlignmentLeft;
        _psLabel.font = [UIFont systemFontOfSize:15];
        [_view addSubview:_psLabel];
        [_psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(50));
            make.right.equalTo(@(-10));
            make.top.mas_equalTo(_passWordLabel.mas_bottom).with.offset(10);
            make.height.equalTo(@(25));
        }];

        
        
//        self.view.userInteractionEnabled = YES;
        UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
        swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:swipLeft];
        
        UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
        swipRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:swipRight];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)];
        [self.view addGestureRecognizer:tap];
    }
    return self;
}
- (void)addEffect:(id)sender
{
        EffectView *view = [[EffectView alloc] init];
    if ([sender isKindOfClass:[UIView class]])
    {
        [(UIView *)sender addSubview:view];
    }
    else
    {
        [(UIButton *)sender addSubview:view];
    }
        view.layer.cornerRadius = 5;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(0));
            make.left.equalTo(@(0));
            make.top.equalTo(@(1));
            make.height.equalTo(@(5));
        }];
        ((CAGradientLayer *)view.layer).startPoint = CGPointMake(0, 0);
        ((CAGradientLayer *)view.layer).endPoint = CGPointMake(0, 1);
        ((CAGradientLayer *)view.layer).colors = @[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)((UIView *)sender).backgroundColor.CGColor];
        ((CAGradientLayer *)view.layer).locations = @[@(0.0),@(1.0)];
        
        
        EffectView *view0 = [[EffectView alloc] init];
    if ([sender isKindOfClass:[UIView class]])
    {
        [(UIView *)sender addSubview:view0];
    }
    else
    {
        [(UIButton *)sender addSubview:view0];
    }
        view0.layer.cornerRadius = 5;
    view0.alpha = 0.5;
        [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(0));
            make.left.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.height.equalTo(@(5));
        }];
        ((CAGradientLayer *)view0.layer).startPoint = CGPointMake(0, 0);
        ((CAGradientLayer *)view0.layer).endPoint = CGPointMake(0, 1);
        ((CAGradientLayer *)view0.layer).colors = @[(__bridge id)((UIView *)sender).backgroundColor.CGColor,(__bridge id)[UIColor blackColor].CGColor];
        ((CAGradientLayer *)view0.layer).locations = @[@(0.0),@(1.0)];
    
}
- (void)fullCellWithEntity:(UPEntity *)entity
{
    _hostNameLabel.text = entity.hostName;
    _userNameLabel.text = entity.userName;
    _passWordLabel.text = entity.passWord;
    if (entity.ps.length > 0)
    {
        ((UIImageView *)[self.contentView viewWithTag:300]).hidden = NO;
        _psLabel.hidden = NO;
        _psLabel.text = entity.ps;
    }
    else
    {
        ((UIImageView *)[self.contentView viewWithTag:300]).hidden = YES;
        _psLabel.hidden = YES;
    }
}
- (void)editBtnAction
{
    if (self.editblock)
    {
        self.editblock();
    }
}
- (void)delAction
{
    if (self.delblock)
    {
        self.delblock();
    }
}
- (void)action
{
    if (self.tapblock)
    {
        self.tapblock();
    }
}
- (void)action:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (self.leftswipblock)
        {
            self.leftswipblock();
        }
    }
    else
    {
        if (self.rightswipblock)
        {
            self.rightswipblock();
        }
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
