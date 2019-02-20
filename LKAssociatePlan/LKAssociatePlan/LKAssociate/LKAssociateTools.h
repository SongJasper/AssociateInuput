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
+ (NSString *)timeStamp;
+ (NSString *)keysArrForObject:(NSObject *)obj;
+ (NSString *)valuesStrForObject:(NSObject *)obj;
+ (NSString *)createSqlForObject:(NSObject *)obj;
+ (NSArray *)allKeysForObject:(NSObject *)obj;


/**
 类似搜索结果
 
 @param keyWordsArr 关键词数组
 @param searchStr 需要搜索的字符串
 @param label 赋值给指定label
 */
+(void)setHighLightKeyWords:(NSArray *)keyWordsArr withSearchString:(NSString *)searchStr onLabel:(UILabel *)label color:(UIColor *)color;

@end
