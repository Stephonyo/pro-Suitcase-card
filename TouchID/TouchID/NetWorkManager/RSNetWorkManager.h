//
//  RSNetWorkManager.h
//  RopeSkippingiOS
//
//  Created by windpc on 2017/2/24.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSNetworkHeader.h"
#import "RSBaseServers.h"

@interface RSNetWorkManager : NSObject


+ (RSNetWorkManager *)sharedNetworking;

+ (void)startMonitoring;


+(NSURLSessionTask *)getWithUrl:(NSString *)url
                         params:(id)params
                        success:(RequestSuccessBlock)success
                           fail:(RequestFailureBlock)fail
                        showHUD:(BOOL)showHUD;


+(NSURLSessionTask *)postWithUrl:(NSString *)url
                          params:(id)params
                         success:(RequestSuccessBlock)success
                            fail:(RequestFailureBlock)fail
                         showHUD:(BOOL)showHUD;


#pragma mark - -------------new--------------


+(NSURLSessionTask *)getWithUrl:(NSString *)url
                         params:(id)params
                        servers:(RSBaseServers*)serrvers
                        success:(RequestSuccessBlock)success
                           fail:(RequestFailureBlock)fail
                        showHUD:(BOOL)showHUD;


+(NSURLSessionTask *)postWithUrl:(NSString *)url
                          params:(id)params
                          servers:(RSBaseServers*)serrvers
                         success:(RequestSuccessBlock)success
                            fail:(RequestFailureBlock)fail
                         showHUD:(BOOL)showHUD;

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
                    didFail:(RequestFailureBlock)failBlock;


@end
