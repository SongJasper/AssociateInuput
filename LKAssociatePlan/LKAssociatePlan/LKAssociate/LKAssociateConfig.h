//
//  LKAssociateConfig.h
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LKAssociateConfig : NSObject
+ (instancetype)shareConfig;

/* ------ setting ------ */
@property (nonatomic, assign) CGFloat rowHeight;/**<搜索栏的行高*/
@property (nonatomic, assign) NSInteger maxShowCount;/**<最多展示的个数*/
@property (nonatomic, assign) BOOL canDeleteRow;/**<是否允许删除行*/
@property (nonatomic, assign) BOOL sendNotificationWhenSelect;/**<是否在选择的时候 发送通知 默认 NO*/
@property (nonatomic, assign) BOOL isInvokeBlockWhenSelect;/**<是否在选择时调用block*/



/* ------ style ------ */
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, strong) UIColor *highlightColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, strong) UIFont *contentFont;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, assign) CGFloat leadingAndTradingGap;/**<前面和后面对齐的间隔,正数向里偏*/
@end
