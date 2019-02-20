//
//  LKAssociateProtocol.h
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LKAssociateProtocol <NSObject>

- (void)showAssociateView;
- (void)hideAssociateView;

- (NSArray<NSString *> *)showAssociateContentsForKey:(NSString *)key;
- (void)saveAssociateContent:(NSString *)content;
- (void)removeAllContent;

@end
