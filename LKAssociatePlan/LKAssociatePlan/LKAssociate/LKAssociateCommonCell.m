//
//  LKAssociateCommonCell.m
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/14.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import "LKAssociateCommonCell.h"
#import "LKAssociateMacro.h"



@implementation LKAssociateCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self uisetting];
    }
    return self;
}

- (void)uisetting{
    self.contentLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label;
    });
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(15);
        make.trailing.offset(-15);
        make.top.and.bottom.offset(0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
