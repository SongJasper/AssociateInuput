//
//  LKAssociateBasicModel.h
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKAssociateBasicModel : NSObject
@property (nonatomic, copy) NSString *content;/**<搜索的内容*/
@property (nonatomic, copy) NSString *type;/**<条目的类型*/
@property (nonatomic, copy) NSString *userid;/**<所属用户*/
@end
