//
//  VerifyPassWordView.m
//  TouchID
//
//  Created by 孙亚杰 on 16/6/20.
//  Copyright © 2016年 JassonSun. All rights reserved.
//
//
//
//  PS.1、界面tag值：密码的6个label的tag分别为10086、10087...10091;
//     2、@“请输入密码”的label的tag为10092

#import "VerifyPassWordView.h"
#import <MagicalRecord/MagicalRecord.h>
#import "LoginEntity.h"
#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height
@interface VerifyPassWordView()
@property (nonatomic,strong) NSMutableString *passWord;
@property (nonatomic,strong) NSMutableString *repassWord;
@end
@implementation VerifyPassWordView
- (instancetype)init
{
    if (self = [super init])
    {
        _isSetPassWord = NO;
        _passWord = [[NSMutableString alloc] init];
        _repassWord = [[NSMutableString alloc] init];
    }
    return self;
}
- (void)show:(VerifySucess)sucess verifyFailed:(VerifyFailed)failed
{
    self.sucess = sucess;
    self.failed = failed;
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth * 0.7, kWidth * 0.35)];
    view.center = self.center;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 8;

    
    //取消密码输入窗口
    UIButton *exit = [UIButton buttonWithType:UIButtonTypeSystem];
    [exit setTitle:@"X" forState:UIControlStateNormal];
    [exit setTitleColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] forState:UIControlStateNormal];
    exit.frame = CGRectMake(view.bounds.size.width * 0.9, 0, view.bounds.size.width*0.1, view.bounds.size.height*0.1);
    [exit addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    exit.layer.cornerRadius = 8;
    [view addSubview:exit];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width *0.2, 0, view.bounds.size.width * 0.6, view.bounds.size.height * 0.3)];
    label.tag = 10092;
    label.text = @"请输入密码";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];

    //===========密码输入框===================
    for (int i = 0 ; i < 6 ; i ++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 + i*(view.bounds.size.width - 20)/6 + 1, view.bounds.size.height * 0.4, (view.bounds.size.width - 20)/6 - 1, view.bounds.size.height*0.2 - 1)];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 10086 + i;
        label.layer.borderWidth = 1;
        label.layer.borderColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1].CGColor;
        [view addSubview:label];
    }


    //=====================两个button===============================
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cancel.frame = CGRectMake(0, view.bounds.size.height*0.7, view.bounds.size.width/2, view.bounds.size.height*0.3 - 1);
    [cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    cancel.layer.cornerRadius = 8;
    [view addSubview:cancel];
    //=====button上面的线===========
    UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(view.bounds.size.width/2,view.bounds.size.height*0.7 -1, 1, view.bounds.size.height * 0.3)];
    vline.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [view addSubview:vline];
    UIView *lline = [[UIView alloc] initWithFrame:CGRectMake(0,view.bounds.size.height*0.7 - 1, view.bounds.size.width, 1)];
    lline.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [view addSubview:lline];
    //========line ok==========
    UIButton *done = [UIButton buttonWithType:UIButtonTypeSystem];
    [done setTitle:@"确定" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    done.frame = CGRectMake(view.bounds.size.width/2, view.bounds.size.height*0.7, view.bounds.size.width/2, view.bounds.size.height*0.3-1);
    [done addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    done.layer.cornerRadius = 8;
    [view addSubview:done];
    [self addSubview:view];
    //=============================button end============================
    
    
    //========键盘========
    UIView *keyBoardView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight *0.7, kWidth, kHeight *0.3)];
    NSArray *keyBoard = @[@"1\n   ",@"2\nABC",@"3\nDEF",@"4\nGHI",@"5\nJKL",@"6\nMNO",@"7\nPQRS",@"8\nTUV",@"9\nWXYZ",@"0"];
    keyBoardView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    for (int i = 0; i < 4; i ++)
    {
        for (int j = 0; j < 3; j ++)
        {
            if (i != 3 || j != 0)
            {
                if (i == 3 && j == 2)
                {
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(j * kWidth/3, i * kHeight *0.3*0.25, kWidth/3, kHeight * 0.3 * 0.25)];
                    label.text = @"退格";
                    label.textAlignment = NSTextAlignmentCenter;
                    label.font = [UIFont systemFontOfSize:15];
                    label.userInteractionEnabled = YES;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                    [label addGestureRecognizer:tap];
                    label.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
                    [keyBoardView addSubview:label];
                }
                else
                {
                    static int a = 0;
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(j * kWidth/3, i * kHeight *0.3*0.25, kWidth/3, kHeight * 0.3 * 0.25)];
                    label.numberOfLines = 0;
                    label.font = [UIFont systemFontOfSize:15];
                    label.lineBreakMode = NSLineBreakByCharWrapping;
                    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:keyBoard[a]];
                    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 1)];
                    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(1, str.length - 1)];
                    label.attributedText = str;
                    
                    label.textAlignment = NSTextAlignmentCenter;
                    label.backgroundColor = [UIColor whiteColor];
                    label.userInteractionEnabled = YES;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                    [label addGestureRecognizer:tap];
                    [keyBoardView addSubview:label];
                    a++;
                    if (a == 10)
                    {
                        a = 0;
                    }
                }
            }
        }
    }
    //按键上面的分割线
    for (int i = 1; i <= 3; i ++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.25 *0.3 * i, kWidth, 1)];
        view.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [keyBoardView addSubview:view];
    }
    for (int j = 1; j <= 2; j ++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kWidth /3 * j, 0, 1, kHeight * 0.3)];
        view.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [keyBoardView addSubview:view];
    }
    [self addSubview:keyBoardView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)hide
{
    [self removeFromSuperview];
}
- (void)cancelAction
{
    [self hide];
}
- (void)doneAction
{
    
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (_passWord.length < 6)
    {
        NSString *str = [((NSMutableAttributedString *)((UILabel *)tap.view).attributedText) string];
        if ([str characterAtIndex:0] >= 48 && [str characterAtIndex:0] <=57 )
        {
            NSString *part = [NSString stringWithFormat:@"%c",[str characterAtIndex:0]];
            [_passWord appendString:part];
        }
        else
        {
            if (_passWord.length > 0)
            {
                [_passWord deleteCharactersInRange:NSMakeRange(_passWord.length - 1,1)];
            }
        }
    
        for (int j = 0; j < 6; j++)
        {
            UILabel *label = [self viewWithTag:10086+j];
            label.text = @"";
        }
        for (int i = 0; i < _passWord.length ; i++)
        {
            UILabel *label = [self viewWithTag:10086+i];
            label.text = @"●";
        }
    }
    if (_passWord.length == 6)
    {
        NSArray *arr = [LoginEntity MR_findAll];
        if (arr.firstObject)
        {
            if (_isSetPassWord)
            {
                [self repeatPassWord];
            }
            else
            {
                LoginEntity *entity = arr.firstObject;
                if ([entity.passWord isEqualToString:_passWord])
                {
                    //验证通通过
                    self.sucess();
                }
                else
                {
                    //验证失败
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [av show];
                    UILabel *label = [self viewWithTag:10092];
                    label.text = @"请输入密码";
                    _passWord = [NSMutableString stringWithString:@""];
                    _repassWord = [NSMutableString stringWithString:@""];
                    for (int j = 0; j < 6; j++)
                    {
                        UILabel *label = [self viewWithTag:10086+j];
                        label.text = @"";
                    }
                    self.failed();

                }
            }
        }
        else
        {
            [self repeatPassWord];
        }
    }
}
- (void)repeatPassWord
{
    //是首次使用
    if (_repassWord.length == 6 && _passWord.length == 6)
    {
        if ([_repassWord isEqualToString:_passWord])
        {
            if (_isSetPassWord)
            {
                //修改密码
                LoginEntity *entity = [LoginEntity MR_findAll].firstObject;
                entity.passWord = _passWord;
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
                    UIAlertView *vc = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [vc show];
                    self.sucess();
                }];
            }
            else
            {
                //添加密码
                LoginEntity *entity = [LoginEntity MR_createEntity];
                entity.passWord= _passWord;
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
                    UIAlertView *vc = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码设置成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [vc show];
                    self.sucess();
                }];
            }
        }
        else
        {
            //两次密码不同
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入的密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [av show];
            UILabel *label = [self viewWithTag:10092];
            label.text = @"请输入密码";
            _passWord = [NSMutableString stringWithString:@""];
            _repassWord = [NSMutableString stringWithString:@""];
            for (int j = 0; j < 6; j++)
            {
                UILabel *label = [self viewWithTag:10086+j];
                label.text = @"";
            }
            self.failed();
        }
    }
    else
    {
        UILabel *label = [self viewWithTag:10092];
        label.text = @"请再次输入密码";
        for (int j = 0; j < 6; j++)
        {
            UILabel *label = [self viewWithTag:10086+j];
            label.text = @"";
        }
    }
    _repassWord = _passWord;
    _passWord = [NSMutableString stringWithString:@""];
}
@end
