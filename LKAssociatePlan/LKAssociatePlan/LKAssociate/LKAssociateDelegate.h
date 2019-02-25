//
//  LKAssociateDelegate.h
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LKAssociateProtocol.h"
#import "LKAssociateConfig.h"


/**
 负责从Config中获取样式
 保存并获取数据库存储的历史输入记录
 展示联想的tableView
 */
@interface LKAssociateDelegate : NSObject <LKAssociateProtocol>
@property (nonatomic, weak) UIView<LKAssociateProtocol> *needAssociateView;/**<需要被联想的View*/
@property (nonatomic, copy) NSString *registModelClassName;/**<注册model的名称*/
@property (nonatomic, copy) NSString *saveTableViewName;/**<存储数据的表名*/
@property (nonatomic, copy) NSString *identifier;/**<取数据的标识符*/
@property (nonatomic, copy) LKAssociateConfig *personalConfig;/**<自定义配置 如果不设置 就是用全局的*/
- (void)configSetting;/**<设置完上面的静态属性之后调用此此方法 不调用无效*/
@property (nonatomic, readonly) UITableView *tableView;/**<展示的tableview*/

@property (nonatomic, copy) void(^selectBlock)(UIView<LKAssociateProtocol> *,NSInteger,NSString *);/**<需要联想的视图,选择的序号,选择的内容*/


@property (nonatomic, copy) NSArray<NSString *> *suffixArr;/**<联想词根数组*/
@end
