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



/* ------ style ------ */
@property (nonatomic, strong) UIColor *borderColor;/**<边框线的颜色*/
@property (nonatomic, strong) UIColor *separatorColor;/**<tableView分割线颜色*/
@property (nonatomic, strong) UIColor *highlightColor;/**<关键字高亮颜色*/
@property (nonatomic, assign) NSTextAlignment textAlignment;/**<联想词汇对齐方式*/
@property (nonatomic, strong) UIFont *contentFont;/**<联想文字字体大小*/
@property (nonatomic, strong) UIColor *contentColor;/**<联想文字字体颜色*/
@property (nonatomic, assign) CGFloat leadingAndTradingGap;/**<前面和后面对齐的间隔,正数向里偏*/
@end
