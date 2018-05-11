//
//  AddUPController.m
//  TouchID
//
//  Created by 孙亚杰 on 16/5/23.
//  Copyright © 2016年 JassonSun. All rights reserved.
//

#import "AddUPController.h"
#import <MagicalRecord/MagicalRecord.h>
@interface AddUPController ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *creatBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hostNameTFTrailing;

@end

@implementation AddUPController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self animations];
}
- (void)animations
{
    
    UIImageView *hostImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hostname"]];
    hostImageView.frame = CGRectMake(5, 0, 30, 30);
    self.hostNameTF.leftView = hostImageView;
    self.hostNameTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
    userImageView.frame = CGRectMake(5, 0, 30, 30);
    self.userNameTF.leftView = userImageView;
    self.userNameTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    passwordImageView.frame = CGRectMake(5, 0, 30, 30);
    self.passWordTF.leftView = passwordImageView;
    self.passWordTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *psImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ps"]];
    psImageView.frame = CGRectMake(5, 0, 30, 30);
    self.psTF.leftView = psImageView;
    self.psTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    self.titleL.layer.position = CGPointMake(-self.view.bounds.size.width/2, self.titleL.center.y);
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.titleL.layer.position = CGPointMake(self.view.bounds.size.width/2, self.titleL.center.y);
        self.titleL.alpha = 1;
        
    } completion:nil];
    
    
    self.hostNameTF.layer.position = CGPointMake(-self.view.bounds.size.width/2, self.hostNameTF.center.y);
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.hostNameTF.layer.position = CGPointMake(self.view.bounds.size.width/2, self.hostNameTF.center.y);
        self.hostNameTF.alpha = 1;
        
    } completion:nil];
    
    self.userNameTF.layer.position = CGPointMake(-self.view.bounds.size.width/2, self.userNameTF.center.y);
    [UIView animateWithDuration:0.5 delay:0.7 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.userNameTF.layer.position = CGPointMake(self.view.bounds.size.width/2, self.userNameTF.center.y);
        self.userNameTF.alpha = 1;
        
    } completion:nil];
    
    self.passWordTF.layer.position = CGPointMake(-self.view.bounds.size.width/2, self.passWordTF.center.y);
    [UIView animateWithDuration:0.5 delay:0.9 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.passWordTF.layer.position = CGPointMake(self.view.bounds.size.width/2, self.passWordTF.center.y);
        self.passWordTF.alpha = 1;
    } completion:nil];
    
    self.creatBtn.layer.position = CGPointMake(-self.view.bounds.size.width/2, self.creatBtn.center.y);
    [UIView animateWithDuration:0.5 delay:0.9 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.creatBtn.layer.position = CGPointMake(self.view.bounds.size.width/2, self.creatBtn.center.y);
        self.creatBtn.alpha = 1;
        
    } completion:nil];
    
    self.psTF.layer.position = CGPointMake(-self.view.bounds.size.width/2, self.psTF.center.y);
    [UIView animateWithDuration:0.5 delay:1.1 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.psTF.layer.position = CGPointMake(self.view.bounds.size.width/2, self.psTF.center.y);
        self.psTF.alpha = 1;
        self.psTF.alpha = 1;
    } completion:nil];
    
//    self.coverView.hidden = YES;
    CGRect rect = self.addBtn.bounds;
    CGSize size = rect.size;
    rect.size.width = 0;
    rect.size.height = 0;
    self.addBtn.bounds = rect;
    [UIView animateWithDuration:0.5 delay:1.3 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        CGRect rect = self.addBtn.bounds;
        rect.size.width = size.width;
        rect.size.height = size.height;
        self.addBtn.bounds = rect;
        self.psTF.alpha = 1;
        self.addBtn.alpha = 1;
    } completion:^(BOOL finished) {
        [self.addBtn setTitle:@"添    加" forState:UIControlStateNormal];
    }];
    
    self.addBtn.layer.cornerRadius = 3;
    self.creatBtn.layer.cornerRadius = 5;
    self.passWordTF.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 65, 0)];
    _passWordTF.rightViewMode = UITextFieldViewModeAlways;
    if (self.entity)
    {
        _hostNameTF.text = self.entity.hostName;
        _userNameTF.text = self.entity.userName;
        _passWordTF.text = self.entity.passWord;
        _psTF.text = self.entity.ps;
    }
}
- (IBAction)creatBtnAction:(id)sender
{
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < 10; i++)
    {
        if (arc4random()%2)
        {
            int c = arc4random()%10;
            [str appendFormat:@"%d",c];
        }
        else
        {
            char c = 97 + arc4random()%26;
            [str appendFormat:@"%c",c];
        }
        
    }
    _passWordTF.text = str;
}
- (IBAction)addBtnAction:(id)sender
{
    //如果是更新数据那么
    if (self.entity)
    {
        UPEntity *entity = [UPEntity MR_findByAttribute:@"hostName" withValue:self.entity.hostName].firstObject;
        entity.hostName = _hostNameTF.text;
        entity.userName = _userNameTF.text;
        entity.passWord = _passWordTF.text;
        entity.ps = _psTF.text;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
            if (contextDidSave)
            {
                UIAlertController *uc = [UIAlertController alertControllerWithTitle:@"提示" message:@"数据更新成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                [uc addAction:ac];
                [self presentViewController:uc animated:YES completion:nil];
            }
            else
            {
                NSLog(@"error:%@",error);
            }
        }];

    }
    else
    {
    //如果是新添加数据，那么
    if (_hostNameTF.text.length > 0 && _userNameTF.text.length > 0 &&_passWordTF.text.length > 0)
    {
        NSArray *arr = [UPEntity MR_findAll];
        int a = 0;
        for (UPEntity *entity in arr)
        {
            if ([entity.hostName isEqualToString:_hostNameTF.text])
            {
                break;
            }
            a++;
        }
        if (a == arr.count)
        {
            //数据库中没有这个hostname，那么就添加这个hostname
            UPEntity *entity = [UPEntity MR_createEntity];
            entity.hostName = _hostNameTF.text;
            entity.userName = _userNameTF.text;
            entity.passWord = _passWordTF.text;
            entity.ps = _psTF.text;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
                if (contextDidSave)
                {
                    UIAlertController *uc = [UIAlertController alertControllerWithTitle:@"提示" message:@"数据保存成功" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }];
                    [uc addAction:ac];
                    [self presentViewController:uc animated:YES completion:nil];
                }
                else
                {
                    NSLog(@"error:%@",error);
                }
            }];
        }
        else
        {
            //弹出通知，已经存在此hostname
            UIAlertController *uc = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经存在相同的网站名称" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [uc addAction:ac];
            [self presentViewController:uc animated:YES completion:nil];
        }
    }
    else
    {
        UIAlertController *uc = [UIAlertController alertControllerWithTitle:@"提示" message:@"请将信息填写完整" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [uc addAction:ac];
        [self presentViewController:uc animated:YES completion:nil];
    }
    }

}
- (void)keyboardDidShowNotification:(NSNotification *)notification
{
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    for (id tf in self.view.subviews)
    {
        if ([tf isKindOfClass:[UITextField class]])
        {
            UITextField *t = tf;
            if ([t isFirstResponder])
            {
                if (CGRectGetMinY(keyBoardFrame) < CGRectGetMaxY(t.frame))
                {
                    CGRect rect = self.view.bounds;
                    rect.origin.y = CGRectGetMinY(keyBoardFrame) - CGRectGetMaxY(t.frame);
                    NSLog(@"%lf",rect.origin.y);
                    self.view.frame = rect;
                }
            }
        }
    }
}
- (void)keyboardDidHideNotification:(NSNotification *)notification
{
    self.view.frame = self.view.bounds;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"密码安全箱";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
