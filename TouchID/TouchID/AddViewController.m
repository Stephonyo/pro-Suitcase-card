//
//  AddViewController.m
//  TouchID
//
//  Created by 孙亚杰 on 16/5/18.
//  Copyright © 2016年 JassonSun. All rights reserved.
//

#import "AddViewController.h"
#import <MagicalRecord/MagicalRecord.h>
@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@end

@implementation AddViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    self.addBtn.layer.cornerRadius = 3;
    self.addBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1];
    if (self.entity)
    {
        _hostNameTF.text = self.entity.hostName;
        _userNameTF.text = self.entity.userName;
        _passWordTF.text = self.entity.passWord;
        _psTF.text = self.entity.ps;
    }
}
- (IBAction)addBtnAction:(id)sender
{
    if (self.entity)
    {
        [self.entity MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
//        [[NSManagedObjectContext MR_defaultContext] deleteObject:self.entity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
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
