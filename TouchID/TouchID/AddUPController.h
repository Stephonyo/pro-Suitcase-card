//
//  AddUPController.h
//  TouchID
//
//  Created by 孙亚杰 on 16/5/23.
//  Copyright © 2016年 JassonSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPEntity.h"
@interface AddUPController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UITextField *hostNameTF;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *psTF;
@property (nonatomic,strong) UPEntity *entity;
@end
