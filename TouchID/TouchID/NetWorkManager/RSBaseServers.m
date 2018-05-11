//
//  RSBaseServers.m
//  CaiPiaoProject
//
//  Created by Wind on 2017/6/4.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import "RSBaseServers.h"

@implementation RSBaseServers

-(NSInteger)timeoutInterval{

    return 10;
}

-(AFHTTPRequestSerializer *)requestSerializer{

    return [AFJSONRequestSerializer serializer];
}

-(AFHTTPResponseSerializer *)responseSerializer{

    return [AFJSONResponseSerializer serializer];

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
