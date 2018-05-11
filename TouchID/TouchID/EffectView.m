//
//  EffectView.m
//  TouchID
//
//  Created by 孙亚杰 on 16/5/23.
//  Copyright © 2016年 JassonSun. All rights reserved.
//

#import "EffectView.h"

@implementation EffectView
+ (Class)layerClass
{
    return [CAGradientLayer class];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
