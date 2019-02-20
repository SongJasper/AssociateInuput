//
//  UITextField+LKAssociateCategory.h
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/14.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKAssociateProtocol.h"
#import "LKAssociateDelegate.h"

@interface UITextField (LKAssociateCategory)<LKAssociateProtocol>
- (void)openAssociateWithIdentifier:(NSString *)identifier;
@property (nonatomic, strong) LKAssociateDelegate *associateDelegate;
- (void)openAssociateWithSuffixArr:(NSArray *)arr;;
@end
