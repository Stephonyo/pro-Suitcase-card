//
//  RSNetWorkManager.m
//  RopeSkippingiOS
//
//  Created by windpc on 2017/2/24.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import "RSNetWorkManager.h"
#import "RSNetWorkResponseHandler.h"
#import "SVProgressHUD.h"

@interface RSNetWorkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *engine;

@end
static NSMutableArray *tasks;
@implementation RSNetWorkManager

+ (RSNetWorkManager *)sharedNetworking{
    
    static RSNetWorkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[RSNetWorkManager alloc] init];
        
    });
    return manager;
}

+(NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}

+ (void)startMonitoring{

    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                
                
                
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                
                break;
        }
    }];
    [mgr startMonitoring];
}


+(NSURLSessionTask *)getWithUrl:(NSString *)url
                         params:(id)params
                        success:(RequestSuccessBlock)success
                           fail:(RequestFailureBlock)fail
                        showHUD:(BOOL)showHUD{

    return [self baseRequestType:RequestMethod_GET url:url params:params success:success fail:fail showHUD:showHUD];
}


+(NSURLSessionTask *)postWithUrl:(NSString *)url
                          params:(id)params
                         success:(RequestSuccessBlock)success
                            fail:(RequestFailureBlock)fail
                         showHUD:(BOOL)showHUD{
    
    return [self baseRequestType:RequestMethod_POST url:url params:params success:success fail:fail showHUD:showHUD];
    
}


#pragma mark - -------------new--------------


+(NSURLSessionTask *)getWithUrl:(NSString *)url
                         params:(id)params
                        servers:(RSBaseServers*)serrvers
                        success:(RequestSuccessBlock)success
                           fail:(RequestFailureBlock)fail
                        showHUD:(BOOL)showHUD{
    
        return [self newBaseRequestType:RequestMethod_GET url:url params:params servers:serrvers success:success fail:fail showHUD:showHUD];

}


+(NSURLSessionTask *)postWithUrl:(NSString *)url
                          params:(id)params
                         servers:(RSBaseServers*)serrvers
                         success:(RequestSuccessBlock)success
                            fail:(RequestFailureBlock)fail
                         showHUD:(BOOL)showHUD{

        return [self newBaseRequestType:RequestMethod_POST url:url params:params servers:serrvers success:success fail:fail showHUD:showHUD];
}

+(NSURLSessionTask *)newBaseRequestType:(RequestMethod)type
                                 url:(NSString *)url
                              params:(NSDictionary *)params
                             servers:(RSBaseServers*)serrvers
                             success:(RequestSuccessBlock)success
                                fail:(RequestFailureBlock)fail
                                showHUD:(BOOL)showHUD{

    if (url==nil) {
        
        return nil;
    }
    
    //DELog(@"-------------------------网络请求开启------------------\n");
    
    if (showHUD==YES) {
        
        [[self class] privateShowHUD];
        
        //        [SVProgressHUD show];
    }
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager * man =  [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    
    man.requestSerializer = serrvers.requestSerializer;
    
    man.responseSerializer = serrvers.responseSerializer;
    
    man.responseSerializer.acceptableContentTypes = serrvers.acceptableContentTypes;
    
    man.requestSerializer.timeoutInterval = serrvers.timeoutInterval;
    
    NSURLSessionTask *sessionTask=nil;
    
    if (type==RequestMethod_GET) {
        
        sessionTask= [man GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (showHUD==YES) {
                
                [[self class] privateDissmissHUD];
                //               [SVProgressHUD dismiss];
            }
            
            [RSNetWorkResponseHandler successHandlerWithSessionDataTask:task responseObject:responseObject successHandler:success errorHandler:fail];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (showHUD==YES) {
                
                [[self class] privateDissmissHUD];
                
                //                [SVProgressHUD dismiss];
            }
            
            [RSNetWorkResponseHandler errorHandlerWithSessionDataTask:task error:error errorHandler:fail];
            
        }];
        
    }else if (type==RequestMethod_POST){
        
        sessionTask = [man POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (showHUD==YES) {
                
                [[self class] privateDissmissHUD];
                //                [SVProgressHUD dismiss];
            }
            
            [RSNetWorkResponseHandler successHandlerWithSessionDataTask:task responseObject:responseObject successHandler:success errorHandler:fail];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (showHUD==YES) {
                
                [[self class] privateDissmissHUD];
                //                [SVProgressHUD dismiss];
            }
            
            [RSNetWorkResponseHandler errorHandlerWithSessionDataTask:task error:error errorHandler:fail];
            
        }];
        
    }
    
    
    return sessionTask;
    
}


/**
 下载方法
 
 @param param         参数
 @param url           地址
 @param saveToPath    保存的文件
 @param progressBlock 百分比
 @param successBlock  成功
 @param failBlock     失败
 */
+(void)startDownloadRequest:(NSDictionary*)param
                     didUrl:(NSString*)url
                 saveToPath:(NSString *)saveToPath
                   progress:(void (^)(double bytesProgress))progressBlock
                 didSuccess:(RequestSuccessBlock)successBlock
                    didFail:(RequestFailureBlock)failBlock{

    RSNetWorkManager * man = [RSNetWorkManager sharedNetworking];
    
    NSError * err ;
    
    BOOL isok = [[NSFileManager defaultManager] removeItemAtPath:saveToPath error:&err];

    NSURLRequest * urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [[man.engine downloadTaskWithRequest:urlrequest progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:saveToPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:saveToPath];
        
        NSLog(@"dic  %@",dic);
        
        NSString *bunid = [[NSBundle mainBundle]bundleIdentifier];
        
        if ([[[dic objectForKey:bunid] objectForKey:@"isAudit"] boolValue]) {
            
            NSLog(@"已通过");
        }else{
        
            NSLog(@"未通过");
        }

    }] resume];
    
    
}


+(NSURLSessionTask *)baseRequestType:(RequestMethod)type
                                 url:(NSString *)url
                              params:(NSDictionary *)params
                             success:(RequestSuccessBlock)success
                                fail:(RequestFailureBlock)fail
                             showHUD:(BOOL)showHUD{
    
    if (url==nil) {
        
        return nil;
    }
    
    //DELog(@"-------------------------网络请求开启------------------\n");
    
    if (showHUD==YES) {
        
        [[self class] privateShowHUD];
        
//        [SVProgressHUD show];
    }
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager * man =  [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    
    man.requestSerializer = [AFJSONRequestSerializer serializer];
    
    man.responseSerializer = [AFJSONResponseSerializer serializer];
    
    man.requestSerializer.timeoutInterval=10;
    
    man.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"text/json",
                                                         @"text/plain",
                                                         @"text/javascript",
                                                         @"text/xml",
                                                         @"image/*, nil", nil];
    
    NSURLSessionTask *sessionTask=nil;
    
    if (type==RequestMethod_GET) {
        
       sessionTask= [man GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
           if (showHUD==YES) {
               
                  [[self class] privateDissmissHUD];
//               [SVProgressHUD dismiss];
           }
           
           [RSNetWorkResponseHandler successHandlerWithSessionDataTask:task responseObject:responseObject successHandler:success errorHandler:fail];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (showHUD==YES) {
                
                  [[self class] privateDissmissHUD];
                
//                [SVProgressHUD dismiss];
            }
            
            [RSNetWorkResponseHandler errorHandlerWithSessionDataTask:task error:error errorHandler:fail];
            
        }];
        
    }else if (type==RequestMethod_POST){
    
        sessionTask = [man POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (showHUD==YES) {
                
                  [[self class] privateDissmissHUD];
//                [SVProgressHUD dismiss];
            }
            
            [RSNetWorkResponseHandler successHandlerWithSessionDataTask:task responseObject:responseObject successHandler:success errorHandler:fail];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (showHUD==YES) {
                
                  [[self class] privateDissmissHUD];
//                [SVProgressHUD dismiss];
            }
            
            [RSNetWorkResponseHandler errorHandlerWithSessionDataTask:task error:error errorHandler:fail];
            
        }];
        
    }
    

    return sessionTask;
}


+(void)privateShowHUD{

    [SVProgressHUD show];
}

+(void)privateDissmissHUD{
    
    [SVProgressHUD dismiss];
}


-(AFHTTPSessionManager *)engine{
    
    if (!_engine) {
    
        _engine = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        
        _engine.requestSerializer = [AFJSONRequestSerializer serializer];
        
        _engine.responseSerializer = [AFJSONResponseSerializer serializer];
        
        _engine.requestSerializer.timeoutInterval=10;
        
        _engine.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                             @"text/html",
                                                             @"text/json",
                                                             @"text/plain",
                                                             @"text/javascript",
                                                             @"text/xml",
                                                             @"image/*, nil", nil];
    }
    return _engine;
}

+(NSString *)strUTF8Encoding:(NSString *)str{
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
