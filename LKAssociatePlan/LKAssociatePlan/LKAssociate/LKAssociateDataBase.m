//
//  LKAssociateDataBase.m
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import "LKAssociateDataBase.h"

#define LKASSOCIATEDATABASEPATH ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"LKAssociateDataBase.sqlite"])

@implementation LKAssociateDataBase

static LKAssociateDataBase *_instance = nil;
+ (instancetype)shareDatabase{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[LKAssociateDataBase alloc]init];
        });
    }
    return _instance;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"--database %@",LKASSOCIATEDATABASEPATH);
        self.database = [FMDatabase databaseWithPath:LKASSOCIATEDATABASEPATH];
        if ([self.database open]) {
            
        }else{
            NSLog(@"--database 数据库打开失败");
        }
        self.queue = [FMDatabaseQueue databaseQueueWithPath:LKASSOCIATEDATABASEPATH];
    }
    return self;
}

@end
