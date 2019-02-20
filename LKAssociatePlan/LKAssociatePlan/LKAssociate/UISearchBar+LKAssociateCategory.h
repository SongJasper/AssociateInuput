//
//  UISearchBar+LKAssociateCategory.h
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKAssociateProtocol.h"
#import "LKAssociateDelegate.h"

@interface UISearchBar (LKAssociateCategory)<LKAssociateProtocol>
- (void)openAssociateWithIdentifier:(NSString *)identifier;
@property (nonatomic, strong) LKAssociateDelegate *associateDelegate;
@end
