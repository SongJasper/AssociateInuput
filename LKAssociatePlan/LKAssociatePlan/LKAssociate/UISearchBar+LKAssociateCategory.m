//
//  UISearchBar+LKAssociateCategory.m
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import "UISearchBar+LKAssociateCategory.h"
#import <objc/runtime.h>

#import "LKSearchBarHistoryModel.h"

@implementation UISearchBar (LKAssociateCategory)

- (void)openAssociateWithIdentifier:(NSString *)identifier{
    if (!self.associateDelegate) {
        LKAssociateDelegate *delegate = [LKAssociateDelegate new];
        delegate.saveTableViewName = @"table_searchbarhistory";
        delegate.registModelClassName = @"LKSearchBarHistoryModel";
        delegate.needAssociateView = self;
        delegate.identifier = identifier;
        self.associateDelegate = delegate;
    }
    [self.associateDelegate configSetting];
}


- (LKAssociateDelegate *)associateDelegate{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAssociateDelegate:(LKAssociateDelegate *)associateDelegate{
    objc_setAssociatedObject(self, @selector(associateDelegate), associateDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)hideAssociateView {
    [[self associateDelegate]hideAssociateView];
}

- (void)removeAllContent {
    [[self associateDelegate]removeAllContent];
}

- (void)saveAssociateContent:(NSString *)content {
    [[self associateDelegate]saveAssociateContent:content];
}

- (NSArray<NSString *> *)showAssociateContentsForKey:(NSString *)key {
    return  [[self associateDelegate]showAssociateContentsForKey:key];
}

- (void)showAssociateView {
    [[self associateDelegate] showAssociateView];
}



@end
