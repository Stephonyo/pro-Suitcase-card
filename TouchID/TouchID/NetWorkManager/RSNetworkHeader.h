//
//  RSNetworkHeader.h
//  RopeSkippingiOS
//
//  Created by windpc on 2017/2/24.
//  Copyright © 2017年 Wind. All rights reserved.
//

#ifndef RSNetworkHeader_h
#define RSNetworkHeader_h


typedef NS_ENUM(NSInteger,NetworkStatus) {
    
    NetworkStatus_NotReachable,
    
    NetworkStatus_WWAN,
    
    NetworkStatus_WiFi,
};

typedef NS_ENUM(NSInteger,RequestMethod) {
    
    RequestMethod_GET,  //get
    
    RequestMethod_POST, //post
};


#if NS_BLOCKS_AVAILABLE

typedef void (^RequestSuccessBlock)(id  returnData);


typedef void (^RequestFailureBlock)(id  error);


#endif

#import "RSNetWorkManager.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "RSServerFactory.h"

#endif /* RSNetworkHeader_h */
