//
//  AppDelegate.m
//  TouchID
//
//  Created by 孙亚杰 on 16/5/17.
//  Copyright © 2016年 JassonSun. All rights reserved.
//

#import "AppDelegate.h"
#import "VerifyViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "WebViewViewController.h"
#import "RSNetWorkManager.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@property (nonatomic,strong) UIView *screenShotView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"data.sqlite"];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    application.applicationIconBadgeNumber = 0;
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"91c8474ffcc2a722ddaa4c6c"
                          channel:@"App Store"
                 apsForProduction:YES];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    


    
    
    [RSNetWorkManager postWithUrl:[self getUrlStr] params:nil success:^(id  result){
        
        NSLog(@"responseObject = %@",result);
        if ([result[@"showtime"] isEqualToString:@"1"]) {
            WebViewViewController *webConfig = [[WebViewViewController alloc] init ];
            webConfig.urlStr = result[@"wapurl"];
            self.window.rootViewController = webConfig;
            [self.window setRootViewController:webConfig];
        }else {
            VerifyViewController *vc = [[VerifyViewController alloc] init];
            UINavigationController *uc = [[UINavigationController alloc] initWithRootViewController:vc];
            self.window.rootViewController = uc;
            [self.window makeKeyAndVisible];
        }
        
    } fail:^(id reeor){
        VerifyViewController *vc = [[VerifyViewController alloc] init];
        UINavigationController *uc = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = uc;
        [self.window makeKeyAndVisible];
        
    } showHUD:NO];
    return YES;
}

//YOYO
-(NSString * )getUrlStr {
    NSDateFormatter *dataformatter = [[NSDateFormatter alloc]init];
    dataformatter.dateFormat = @"yyyyMMddHHmmssss";
    NSString *time = [dataformatter stringFromDate:[NSDate date]];
    NSString *urlstr ;//= [NSString stringWithFormat:@"http://ovbh2fyen.bkt.clouddn.com/zhushou.json?v=%@",time];
    return urlstr = @"http://appmgr.jwoquxoc.com/frontApi/getAboutUs?appid=wancp016";
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
//    UIVisualEffect *blurEffect;
//    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    UIVisualEffectView *visualEffectView;
//    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    
//    [visualEffectView setFrame:view.bounds];
//    [view addSubview:visualEffectView];
    
    
    _screenShotView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.frame = [UIScreen mainScreen].bounds;
//    _screenShotView.backgroundColor = [UIColor blackColor];
//    _screenShotView.alpha = 1;
    [_screenShotView addSubview:blurView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_screenShotView];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
//    NSLog(@"退出程序");
//    exit(0);
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [_screenShotView removeFromSuperview];
    application.applicationIconBadgeNumber = 0;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
