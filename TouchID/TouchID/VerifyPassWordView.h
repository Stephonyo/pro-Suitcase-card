//
//  VerifyPassWordView.h
//  TouchID
//
//  Created by 孙亚杰 on 16/6/20.
//  Copyright © 2016年 JassonSun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^VerifySucess)();
typedef void(^VerifyFailed)();
@interface VerifyPassWordView : UIView
@property (nonatomic,copy) VerifySucess sucess;
@property (nonatomic,copy) VerifyFailed failed;
@property (nonatomic,assign) BOOL isSetPassWord;
- (void)show:(VerifySucess)sucess verifyFailed:(VerifyFailed)failed;
- (void)hide;
@end
