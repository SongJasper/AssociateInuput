//
//  LKAssociateBasicModel.m
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import "LKAssociateBasicModel.h"
#import "LKAssociateTools.h"
#import "LKAssociateMacro.h"


@interface LKAssociateBasicModel ()

@property (nonatomic, copy) NSString *timestamp;/**<跟新的时间戳 精确到秒*/

@end
@implementation LKAssociateBasicModel
- (NSString *)timestamp{
    return [LKAssociateTools timeStamp];
}

- (NSString *)userid {
#ifdef APPCURRENTUSER
    return SafeString(APPCURRENTUSER.userId);
#else
    return @"";
#endif
}

+ (NSArray *)mj_allowedPropertyNames{
    return @[@"userid",@"timestamp",@"type",@"content"];
}

@end
