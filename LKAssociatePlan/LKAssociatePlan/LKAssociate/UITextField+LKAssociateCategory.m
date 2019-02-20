//
//  UITextField+LKAssociateCategory.m
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/14.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import "UITextField+LKAssociateCategory.h"
#import <objc/runtime.h>
#import "LKTextFieldAssociateModel.h"

@implementation UITextField (LKAssociateCategory)
- (void)openAssociateWithIdentifier:(NSString *)identifier{
    if (!self.associateDelegate) {
        LKAssociateDelegate *delegate = [LKAssociateDelegate new];
        delegate.saveTableViewName = @"table_textfield";
        delegate.registModelClassName = @"LKTextFieldAssociateModel";
        delegate.needAssociateView = self;
        delegate.identifier = identifier;
        self.associateDelegate = delegate;
    }
    [self.associateDelegate configSetting];
}

- (void)openAssociateWithSuffixArr:(NSArray *)arr{
    if (!self.associateDelegate) {
        LKAssociateDelegate *delegate = [LKAssociateDelegate new];
        delegate.needAssociateView = self;
        delegate.suffixArr = arr;
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
