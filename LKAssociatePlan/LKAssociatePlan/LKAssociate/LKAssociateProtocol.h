//
//  LKAssociateProtocol.h
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LKAssociateProtocol <NSObject>


/**
 展示联想视图
 */
- (void)showAssociateView;

/**
 隐藏联想视图
 */
- (void)hideAssociateView;

/**
 根据关键字获取联想内容

 @param key 关键字(输入框文字)
 @return 数据源
 */
- (NSArray<NSString *> *)showAssociateContentsForKey:(NSString *)key;


/**
 将相关内容保存到本地

 @param content 需要保存的历史记录
 */
- (void)saveAssociateContent:(NSString *)content;


/**
 删除该用户下所有的历史记录
 */
- (void)removeAllContent;


@end
