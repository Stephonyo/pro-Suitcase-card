//
//  RSNetWorkResponseHandler.h
//  RopeSkippingiOS
//
//  Created by windpc on 2017/2/24.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSNetworkHeader.h"

@interface RSNetWorkResponseHandler : NSObject

/**
 网络失败的集中处理
 
 @param dataTask     返回的处理
 @param error        错误描述
 @param errorHandler 回调
 */
+ (void)errorHandlerWithSessionDataTask:(NSURLSessionDataTask *)dataTask  error:(NSError *)error errorHandler:(RequestFailureBlock) errorHandler;



/**
 网络成功的集中处理
 
 @param dataTask       返回要做的处理
 @param responseObject 返回的数据
 @param successHandler 成功的回调
 @param errorHandler   数据处理失败回调
 */
+ (void)successHandlerWithSessionDataTask:(NSURLSessionDataTask *)dataTask
                           responseObject:(id)responseObject
                           successHandler:(RequestSuccessBlock)successHandler errorHandler:(RequestFailureBlock)errorHandler;

@end
