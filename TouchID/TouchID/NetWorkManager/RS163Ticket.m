//
//  RS163Ticket.m
//  CaiPiaoProject
//
//  Created by Wind on 2017/6/6.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import "RS163Ticket.h"

@implementation RS163Ticket

-(NSInteger)timeoutInterval{
    
    return 10;
}

-(AFHTTPRequestSerializer *)requestSerializer{
    
    return [AFHTTPRequestSerializer serializer];
}

-(AFHTTPResponseSerializer *)responseSerializer{
    
    return [AFHTTPResponseSerializer serializer];
    
}

-(NSSet<NSString *> *)acceptableContentTypes{
    
    return [NSSet setWithObjects:@"application/json",
            @"text/html",
            @"text/json",
            @"text/plain",
            @"text/javascript",
            @"text/xml",
            @"image/*, nil", nil];
}

@end
