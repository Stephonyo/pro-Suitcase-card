//
//  RSBaseServers.h
//  CaiPiaoProject
//
//  Created by Wind on 2017/6/4.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@protocol RSBaseServersProtocol <NSObject>

@property (nonatomic,strong,readonly) AFHTTPRequestSerializer * requestSerializer;

@property (nonatomic,strong,readonly) AFHTTPResponseSerializer * responseSerializer;

@property (nonatomic,assign,readonly) NSInteger timeoutInterval;

@property (nonatomic,copy) NSSet <NSString *>*acceptableContentTypes;


@end


@interface RSBaseServers : NSObject<RSBaseServersProtocol>




@end
