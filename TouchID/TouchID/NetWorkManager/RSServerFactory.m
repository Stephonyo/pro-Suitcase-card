//
//  RSServerFactory.m
//  CaiPiaoProject
//
//  Created by Wind on 2017/6/4.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import "RSServerFactory.h"
#import "RS500Ticket.h"
#import "RS163Ticket.h"

@implementation RSServerFactory

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static RSServerFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RSServerFactory alloc] init];
    });
    return sharedInstance;
}


- (RSBaseServers*)serviceWithType:(RSServiceType)type{

    RSBaseServers * base =  nil;
  
    switch (type) {
        case RSServiceType_500Ticket:
           
            base = [[RS500Ticket alloc] init];
            
            break;
            
        case RSServiceType_163Ticket:
            
            base = [[RS163Ticket alloc] init];
            
            break;
            
        default:
            break;
    }
    
    return base;
}

@end
