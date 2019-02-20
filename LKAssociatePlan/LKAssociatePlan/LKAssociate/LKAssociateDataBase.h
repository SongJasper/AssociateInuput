//
//  LKAssociateDataBase.h
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKAssociateMacro.h"



#define lk_ass_db [LKAssociateDataBase shareDatabase].database
#define lk_ass_queue [LKAssociateDataBase shareDatabase].queue

@interface LKAssociateDataBase : NSObject
+ (instancetype)shareDatabase;
@property (nonatomic, strong) FMDatabase *database;
@property (nonatomic, strong) FMDatabaseQueue *queue;
@end

/*
 注意 本数据库只存 字符串类型的数据
 */
