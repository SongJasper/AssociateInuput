//
//  LKAssociateConfig.m
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import "LKAssociateConfig.h"

@implementation LKAssociateConfig
static LKAssociateConfig *_instance = nil;
+ (instancetype)shareConfig{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[LKAssociateConfig alloc]init];
        });
    }
    return _instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig{
    self.borderColor = [UIColor groupTableViewBackgroundColor];
    self.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.highlightColor = [UIColor colorWithRed:234/255.0 green:31/255.0 blue:50/255.0 alpha:1];
    self.contentColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1];
    self.contentFont = [UIFont systemFontOfSize:16];
    
    self.rowHeight = 44.0;
    self.maxShowCount = 5;
    self.leadingAndTradingGap = 2;
    
    self.canDeleteRow = YES;
    self.sendNotificationWhenSelect = NO;
    self.isInvokeBlockWhenSelect = YES;
    self.textAlignment = NSTextAlignmentLeft;
    
}

@end
