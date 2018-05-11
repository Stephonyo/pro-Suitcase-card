//
//  RSServerFactory.h
//  CaiPiaoProject
//
//  Created by Wind on 2017/6/4.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSBaseServers.h"

typedef NS_ENUM(NSUInteger, RSServiceType) {
    
    RSServiceType_500Ticket,
    
    RSServiceType_163Ticket,
};

@interface RSServerFactory : NSObject

+ (instancetype)sharedInstance;


- (RSBaseServers*)serviceWithType:(RSServiceType)type;

@end
