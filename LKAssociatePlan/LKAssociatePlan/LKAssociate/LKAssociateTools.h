//
//  LKAssociateTools.h
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LKAssociateTools : NSObject

/**
 获取时间戳(精确到秒)

 @return 时间戳
 */
+ (NSString *)timeStamp;

/**
 获取对象属性字符串数组

 @param obj 目标对象
 @return 以,隔开的属性 数组字符串
 */
+ (NSString *)keysArrForObject:(NSObject *)obj;

/**
 获取对象属性值字符串数组

 @param obj 目标对象
 @return 以,隔开的属性值 数组字符串
 */
+ (NSString *)valuesStrForObject:(NSObject *)obj;


/**
 获取对象属性拼接的SQL

 @param obj 目标对象
 @return 创建对象SQL部分语句
 */
+ (NSString *)createSqlForObject:(NSObject *)obj;


/**
 获取对象属性数组(按照首字母排序)

 @param obj 目标对象
 @return 对象属性数组
 */
+ (NSArray *)allKeysForObject:(NSObject *)obj;


/**
 类似搜索结果
 
 @param keyWordsArr 关键词数组
 @param searchStr 需要搜索的字符串
 @param label 赋值给指定label
 */
+(void)setHighLightKeyWords:(NSArray *)keyWordsArr withSearchString:(NSString *)searchStr onLabel:(UILabel *)label color:(UIColor *)color;

@end
