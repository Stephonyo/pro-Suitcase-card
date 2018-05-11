//
//  UPEntity+CoreDataProperties.h
//  TouchID
//
//  Created by 孙亚杰 on 16/5/18.
//  Copyright © 2016年 JassonSun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UPEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface UPEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *hostName;
@property (nullable, nonatomic, retain) NSString *passWord;
@property (nullable, nonatomic, retain) NSString *ps;
@property (nullable, nonatomic, retain) NSString *userName;

@end

NS_ASSUME_NONNULL_END
