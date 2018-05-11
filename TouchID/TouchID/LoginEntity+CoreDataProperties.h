//
//  LoginEntity+CoreDataProperties.h
//  TouchID
//
//  Created by 孙亚杰 on 16/6/21.
//  Copyright © 2016年 JassonSun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LoginEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginEntity (CoreDataProperties)

@property (nonatomic) BOOL isFirstTime;
@property (nullable, nonatomic, retain) NSString *passWord;

@end

NS_ASSUME_NONNULL_END
