//
//  LKAssociateDelegate.m
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import "LKAssociateDelegate.h"
#import "LKAssociateDataBase.h"
#import "LKAssociateTools.h"
#import "LKAssociateBasicModel.h"
#import "LKAssociateMacro.h"
#import "LKAssociateCommonCell.h"

@interface LKAssociateDelegate ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LKAssociateConfig *config;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger mode;/**< 0:历史记录 1:增加后缀*/

@end

@implementation LKAssociateDelegate


- (void)configSetting{
    
    if (self.suffixArr.count > 0) {
        self.mode = 1;
    }else{
        self.mode = 0;
        
        //  建表  初始化数据库相关信息
        if ([lk_ass_db open]) {
            // 建表 pkvalue 自增 count统计频率
            NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(pkvalue integer primary key autoincrement,count integer,identifier text,%@);",self.saveTableViewName,[LKAssociateTools createSqlForObject:[self registModel]]];
            if (![lk_ass_db executeUpdate:sql]) {
                NSLog(@"--database 数据库建表失败");
            }
        }else{
            NSLog(@"--database 数据库打开失败");
        }
    }
    
}

- (void)saveAssociateContent:(NSString *)content {
    
    if (self.mode==1) {
        return;
    }
    
    if (content.length == 0) {
        return;
    }
    LKAssociateBasicModel *model = [self registModel];
    NSString *sql = [NSString stringWithFormat:@"select pkvalue,count from %@ where content = '%@' and userid = '%@' and type = '%@' and identifier = '%@';",self.saveTableViewName,content,model.userid,model.type,self.identifier];
   
    FMResultSet *set = [lk_ass_db executeQuery:sql];
    if (set.next) {
        // 如果有搜索结果 修改原来的记录
        int pkvalue = [set intForColumn:@"pkvalue"];
        int count = [set intForColumn:@"count"];
        count ++;
        NSString *usql = [NSString stringWithFormat:@"update %@ set count = '%d' where pkvalue = '%d';",self.saveTableViewName,count,pkvalue];
        BOOL flag = [lk_ass_db executeUpdate:usql];
        if (!flag) {
            NSLog(@"--database 数据库更新 %@ 失败 %@",content,usql);
        }
    }else{
        // 如果没有类似记录 插入新的数据
        model.content = content;
        NSString *isql = [NSString stringWithFormat:@"insert into %@(%@,count,identifier)values(%@,1,'%@');",self.saveTableViewName,[LKAssociateTools keysArrForObject:model],[LKAssociateTools valuesStrForObject:model],self.identifier];
        BOOL flag = [lk_ass_db executeUpdate:isql];
        if (!flag) {
            NSLog(@"--database 数据库插入 %@ 失败 %@",content,isql);
        }
    }
}

- (NSArray<NSString *> *)showAssociateContentsForKey:(NSString *)key {
    
    if (self.mode == 1) {
        /*
         通过词根第一位进行判断,用户输入内容是否已经和词根重合
         如果重合(第一次)  按照词根第一位 分割字符串 对比后面的内容是否重合 然后进行词根过滤展示
         
         */
        NSMutableArray *result = [NSMutableArray array];
        for (NSString *suffix in self.suffixArr) {
            NSString *firstChar = [suffix substringToIndex:1];
            if ([key containsString:firstChar]) {
                // 不要直接分割 防止出现分割数组 count>2 的情况
                NSRange range = [key rangeOfString:firstChar];
                NSString *firstKey = [key substringToIndex:range.location];
                NSString *lastKey  = [key substringFromIndex:range.location+1];
                // 需要对比的对象
                NSString *lastSuffix = [suffix substringFromIndex:1];
                if ( lastKey.length == 0 || [lastSuffix containsString:lastKey]) {
                   [result addObject:[firstKey stringByAppendingString:suffix]];
                }
            }else{
                [result addObject:[key stringByAppendingString:suffix]];
            }
        }
        return result;
    }
    
    // 历史记录
    LKAssociateBasicModel *model = [self registModel];
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where content like '%%%@%%' and userid = '%@' and type = '%@' and identifier = '%@' order by count desc;",self.saveTableViewName,key,model.userid,model.type,self.identifier];
    if (self.config.maxShowCount) {
        // 增加获取限制
        sql = [sql stringByReplacingOccurrencesOfString:@";" withString:[NSString stringWithFormat:@" limit %ld;",self.config.maxShowCount]];
    }
    FMResultSet *set =  [lk_ass_db executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray array];
    while (set.next) {
        NSString *content = [set stringForColumn:@"content"];
        if (content.length > 0) {
            [arr addObject:content];
        }
    }
    return arr;
}

- (void)reloadTableView{
    [self.tableView removeFromSuperview];
    NSInteger count = [self showAssociateContentsForKey:self.text].count;
    
    
    if (count == 0) {
        self.tableView.hidden = YES;
    } else if (self.mode == 1 && self.text.length == 0){
        // 没有相关联想内容 则不展示相关控件
        self.tableView.hidden = YES;
    }
    else{
        self.tableView.hidden = NO;
        // 自动切换位置 优先展示在下面
        CGRect newFrame = CGRectMake(self.needAssociateView.frame.origin.x+self.config.leadingAndTradingGap, CGRectGetMaxY(self.needAssociateView.frame), CGRectGetWidth(self.needAssociateView.frame)-2*self.config.leadingAndTradingGap, self.config.rowHeight*count);
        if (CGRectGetMaxY(newFrame) > CGRectGetMaxY(self.needAssociateView.superview.frame)) {
            newFrame = CGRectMake(self.needAssociateView.frame.origin.x+self.config.leadingAndTradingGap, CGRectGetMinY(self.needAssociateView.frame)-self.config.rowHeight*count, CGRectGetWidth(self.needAssociateView.frame)-2*self.config.leadingAndTradingGap, self.config.rowHeight*count);
        }
        self.tableView.frame = newFrame;
        [self.needAssociateView.superview addSubview:self.tableView];
    }
    [self.tableView reloadData];
}

- (void)removeAllContent{
    if (self.mode == 1) {
        return;
    }
    LKAssociateBasicModel *model = [self registModel];
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where userid = '%@' ",self.saveTableViewName,model.userid];
    if (![lk_ass_db executeUpdate:sql]) {
        NSLog(@"--database 数据清除记录失败 %@",sql);
    }
}

- (void)hideAssociateView {
    self.tableView .hidden = YES;
}
- (void)showAssociateView {
    if ([self showAssociateContentsForKey:self.text].count > 0) {
        self.tableView.hidden = NO;
        [self reloadTableView];
    }else{
        self.tableView.hidden = YES;
    }
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self showAssociateContentsForKey:self.text].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LKAssociateCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[LKAssociateCommonCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.contentLabel.textAlignment = self.config.textAlignment;
    cell.contentLabel.textColor = self.config.contentColor;
    cell.contentLabel.font = self.config.contentFont;
    NSString *content = [self showAssociateContentsForKey:self.text][indexPath.row];
    if (self.mode == 0) {
        [LKAssociateTools setHighLightKeyWords:@[self.text] withSearchString:content onLabel:cell.contentLabel color:self.config.highlightColor];
    }else{
        cell.contentLabel.text = content;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *content = [self showAssociateContentsForKey:self.text][indexPath.row];
    [self hideAssociateView];
    if (self.needAssociateView && [self.needAssociateView respondsToSelector:@selector(setText:)]) {
        [self.needAssociateView performSelector:@selector(setText:) withObject:content];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:LKASSOCIATESELECTNOTIFICATION object:nil];
    if (self.selectBlock) {
        self.selectBlock(self.needAssociateView, indexPath.row, content);
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.mode == 1) {
        return NO;
    }
    return self.config.canDeleteRow;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除操作
        NSString *content = [self showAssociateContentsForKey:self.text][indexPath.row];
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where content = '%@'",self.saveTableViewName,content];
        if (![lk_ass_db executeUpdate:sql]) {
            NSLog(@"--database 数据库 删除记录%@失败 %@",content,sql);
        }
        [self reloadTableView];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark - getter / setter
- (void)setSuffixArr:(NSArray<NSString *> *)suffixArr{
    // 去重 及 数据源内容校验
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *key in suffixArr) {
        if (key.length > 0 && ![arr containsObject:key]) {
            [arr addObject:key];
        }
    }
    _suffixArr = arr;
}
- (NSString *)identifier{
    return SafeString(_identifier);
}
- (LKAssociateBasicModel *)registModel{
    return [NSClassFromString(self.registModelClassName) new];
}
- (NSString *)text{
    NSString *str = @"";
    if (self.needAssociateView && [self.needAssociateView respondsToSelector:@selector(text)]) {
        str = [self.needAssociateView performSelector:@selector(text)];
    }
    return str;
}
- (LKAssociateConfig *)config{
    if (self.personalConfig) {
        return self.personalConfig;
    }
    return [LKAssociateConfig shareConfig];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [UITableView new];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.rowHeight = self.config.rowHeight;
            tableView.separatorColor = self.config.separatorColor;
            
            // 去除tableView分割线边距
            if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
                [tableView setSeparatorInset:UIEdgeInsetsZero];
            }
            if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
                [tableView setLayoutMargins:UIEdgeInsetsZero];
            }
            
            tableView.layer.borderWidth = 1;
            tableView.layer.borderColor = self.config.borderColor.CGColor;
            tableView.scrollEnabled = NO;
            tableView;
        });
    }
    return _tableView;
}
@end
