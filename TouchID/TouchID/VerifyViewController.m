//
//  VerifyViewController.m
//  TouchID
//
//  Created by 孙亚杰 on 16/5/18.
//  Copyright © 2016年 JassonSun. All rights reserved.
//

#import "VerifyViewController.h"
#import "AddViewController.h"
#import "UPEntity.h"
#import "UPCell.h"
#import "AddUPController.h"
#import "VerifyPassWordView.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <MagicalRecord/MagicalRecord.h>
#import "LoginEntity.h"
@interface VerifyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) BOOL verifyIsSucess;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) UIButton *inputBtn;
@end

@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.verifyIsSucess = NO;
    [self initUI];
}
- (void)initUI
{

    //选择自己喜欢的颜色
    UIColor * color = [UIColor whiteColor];
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    //大功告成
    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:38/255.0 green:44/255.0 blue:59/255.0 alpha:0.5];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    
    _managedObjectContext = [NSManagedObjectContext MR_defaultContext];
    self.view.backgroundColor = [UIColor colorWithRed:34/255.0 green:39/255.0 blue:52/255.0 alpha:1];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UPCell class] forCellReuseIdentifier:@"upcell"];
    self.tableView.showsVerticalScrollIndicator= NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:34/255.0 green:39/255.0 blue:52/255.0 alpha:1];
    [self.view addSubview:self.tableView];
    self.dataList = [NSMutableArray array];
    _inputBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _inputBtn.frame = CGRectMake(0,0,self.view.bounds.size.width*0.5,30);
    _inputBtn.center = self.view.center;
    [_inputBtn addTarget:self action:@selector(inputAction) forControlEvents:UIControlEventTouchUpInside];
    [_inputBtn setTitle:@"点击验证身份" forState:UIControlStateNormal];
    [_inputBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _inputBtn.hidden = YES;
    [self.view addSubview:_inputBtn];
    if ([LoginEntity MR_findAll].count == 0)
    {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"首次使用请设置您的密码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *aa     = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self verify];
        }];
        [ac addAction:aa];
        [self presentViewController:ac animated:YES completion:nil];
    }
    else
    {
        [self verify];
    }
}
- (void)addBtnAction
{
    AddUPController *ac = [[AddUPController alloc] init];
    [self.navigationController pushViewController:ac animated:YES];
}
- (void)inputAction
{
    [self verify];
}
#pragma mark 验证、验证成功、验证失败
- (void)verify
{
    //初始化touchid
    LAContext *context = [[LAContext alloc] init];
    NSError *err= nil;
    context.localizedFallbackTitle = @"确认";
    //判断手机是否越狱，越狱后env就不为空
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"------%s",env);
    __weak __typeof(self) weakSelf = self;
    if (!env)
    {
        //检查touchid是否可用
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err])
        {
            LoginEntity *entity = [LoginEntity MR_findAll].firstObject;
            if (!entity)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf verifyPassword];
                });
            }
            else
            {
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"使用TOUCH ID登录" reply:^(BOOL success, NSError * _Nullable error) {
                    if (success)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            weakSelf.verifyIsSucess = YES;
                            [weakSelf verifySucess];
                        });
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf verifyPassword];
                        });
                    }
                }];
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf verifyPassword];
            });
        }
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf verifyPassword];
        });
    }
}
- (void)verifyPassword
{
    _inputBtn.hidden = NO;
    VerifyPassWordView *vc = [[VerifyPassWordView alloc] init];
    [vc show:^{
        self.verifyIsSucess = YES;
        [self verifySucess];
        [vc hide];
    } verifyFailed:^{
        
    }];
}
- (void)verifySucess
{
    _inputBtn.hidden = YES;
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnAction)];
    self.navigationItem.rightBarButtonItem = addBtn;
    UIBarButtonItem *setPassWordBtn = [[UIBarButtonItem alloc] initWithTitle:@"修改密码" style:UIBarButtonItemStyleDone target:self action:@selector(setPassWordBtnAction)];
    self.navigationItem.leftBarButtonItem = setPassWordBtn;
    if (self.dataList.count > 0)
    {
        [self.dataList removeAllObjects];
    }
    [self.dataList addObjectsFromArray:[UPEntity MR_findAll]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
- (void)setPassWordBtnAction
{
    VerifyPassWordView *vc = [[VerifyPassWordView alloc] init];
    vc.isSetPassWord = YES;
    [vc show:^{
        [vc hide];
    } verifyFailed:^{
        
    }];
}
- (void)verifyFailed:(NSString *)str
{
    UIAlertController *uc = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ua = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        exit(0);
    }];
    [uc addAction:ua];
    [self presentViewController:uc animated:YES completion:nil];
}
#pragma mark 数据展示的tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UPEntity *entity = self.dataList[indexPath.row];
    UPCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"upcell" forIndexPath:indexPath];
    
    //==================cell动画=======================
    CGRect rect = cell.contentView.frame;
    rect.origin.x = -self.view.bounds.size.width/0.9;
    cell.contentView.frame = rect;
    [cell fullCellWithEntity:entity];
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.8 initialSpringVelocity:0.1f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        CGRect rect = cell.contentView.frame;
        rect.origin.x = 0;
        cell.contentView.frame = rect;
        [cell layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    //==================cell动画=======================
    __weak typeof(UPCell) *weakcell = cell;
    [weakcell setLeftswipblock:^(){
        CGRect rect = weakcell.view.frame;
        rect.origin.x = -[UIScreen mainScreen].bounds.size.width*0.13*2 + 10;
        weakcell.delBtn.hidden = NO;
        weakcell.editBtn.hidden = NO;
        weakcell.view.frame = rect;
        for (UPCell *cell in self.tableView.visibleCells)
        {
            if (cell != weakcell)
            {
            CGRect rect = cell.view.frame;
            rect.origin.x = 10;
            cell.delBtn.hidden = YES;
            cell.editBtn.hidden = YES;
            cell.view.frame = rect;
            }
        }
    }];
    [weakcell setRightswipblock:^(){
        CGRect rect = weakcell.view.frame;
        rect.origin.x = 10;
        weakcell.delBtn.hidden = YES;
        weakcell.editBtn.hidden = YES;
        weakcell.view.frame = rect;
    }];
    [weakcell setTapblock:^(){
        CGRect rect = weakcell.view.frame;
        rect.origin.x = 10;
        weakcell.delBtn.hidden = YES;
        weakcell.editBtn.hidden = YES;
        weakcell.view.frame = rect;
    }];
    [cell setEditblock:^(){
        AddUPController *ac = [[AddUPController alloc] init];
        [self.navigationController pushViewController:ac animated:YES];
        ac.entity = entity;
    }];
    [cell setDelblock:^(){
        [self.dataList removeObject:entity];
        [entity MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self.tableView reloadData];
    }];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.verifyIsSucess)
    {
        return self.dataList.count;
    }
    else
    {
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UPEntity *entity = self.dataList[indexPath.row];
    if (entity.ps.length > 0)
    {
        return 170;
    }
    else
    {
        return 130;
    }
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (UPCell *cell in self.tableView.visibleCells)
    {
        CGRect rect = cell.view.frame;
        rect.origin.x = 10;
        cell.delBtn.hidden = YES;
        cell.editBtn.hidden = YES;
        cell.view.frame = rect;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"密码安全箱";
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:[UPEntity MR_findAll]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

}
- (void)viewWillDisappear:(BOOL)animated
{
        for (UPCell *cell in self.tableView.visibleCells)
        {
            CGRect rect = cell.view.frame;
            rect.origin.x = 10;
            cell.delBtn.hidden = YES;
            cell.editBtn.hidden = YES;
            cell.view.frame = rect;
        }
        [self.dataList removeAllObjects];
        [self.tableView reloadData];
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
