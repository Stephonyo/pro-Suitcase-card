//
//  RSNetWorkResponseHandler.m
//  RopeSkippingiOS
//
//  Created by windpc on 2017/2/24.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import "RSNetWorkResponseHandler.h"
#import "MJExtension.h"


@implementation RSNetWorkResponseHandler

/**
 网络失败的集中处理
 
 @param dataTask     返回的处理
 @param error        错误描述
 @param errorHandler 回调
 */
+ (void)errorHandlerWithSessionDataTask:(NSURLSessionDataTask *)dataTask  error:(NSError *)error errorHandler:(RequestFailureBlock) errorHandler;{

    NSLog(@"错误内容...%@ \n请求地址...%@ \n请求参数...",error.localizedDescription,dataTask.currentRequest.URL.absoluteString);
    
    NSString *msg = error.localizedDescription;
    
    if([msg rangeOfString:@"NSURLErrorDomain"].location !=NSNotFound)
    {
        if (errorHandler) {
            
            errorHandler(@"连接服务器失败");
        }
        
    }else{
        
        if (errorHandler) {
            
            errorHandler(error.localizedDescription);
        }
    }
}



/**
 网络成功的集中处理
 
 @param dataTask       返回要做的处理
 @param responseObject 返回的数据
 @param successHandler 成功的回调
 @param errorHandler   数据处理失败回调
 */
+ (void)successHandlerWithSessionDataTask:(NSURLSessionDataTask *)dataTask
                           responseObject:(id)responseObject
                           successHandler:(RequestSuccessBlock)successHandler errorHandler:(RequestFailureBlock)errorHandler{
    
    NSString * url = dataTask.currentRequest.URL.absoluteString ;
    
   // NSLog(@"-------------------------网络请求结束------------------\n返回json =%@\n请求地址=%@\n",[responseObject mj_JSONString],url);
    
    if (successHandler) {
        successHandler(responseObject);
    }

}

@end
