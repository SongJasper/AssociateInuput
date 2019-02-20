//
//  LKAssociateTools.m
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#import "LKAssociateTools.h"
#import "LKAssociateMacro.h"

@implementation LKAssociateTools
+ (NSString *)timeStamp{
    NSDate *date = [self localDate];
    NSString *time = date.description;
    if (time.length > 19) {
        time = [time substringToIndex:19];
    }
    return time;
}

+ (NSDate *)localDate{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

+ (NSArray *)allKeysForObject:(NSObject *)obj{
    NSMutableArray<NSString *> *arr = [obj.class mj_allowedPropertyNames].mutableCopy;
    [arr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    return arr;
}

+ (NSString *)keysArrForObject:(NSObject *)obj{
    NSArray *arr = [self allKeysForObject:obj];
    if (arr.count == 0) {
        return @"";
    }
    return [arr componentsJoinedByString:@","];
}

+ (NSString *)valuesStrForObject:(NSObject *)obj{
    NSArray *arr = [self allKeysForObject:obj];
    if (arr.count == 0) {
        return @"";
    }
    NSMutableArray<NSString *> *valueArr = [NSMutableArray array];
    for (NSString *key in arr) {
        NSString *value = [obj valueForKey:key];
        value = SafeString(value);
        value = [NSString stringWithFormat:@"'%@'",value];
        [valueArr addObject:value];
    }
    return [valueArr componentsJoinedByString:@","];
}

+ (NSString *)createSqlForObject:(NSObject *)obj{
    NSArray *arr = [self allKeysForObject:obj];
    if (arr.count == 0) {
        return @"";
    }
    NSMutableArray *resultArr = [NSMutableArray array];
    for (NSString *key in arr) {
        NSString *value = [NSString stringWithFormat:@"%@ text",key];
        [resultArr addObject:value];
    }
    return [resultArr componentsJoinedByString:@","];
}


+(void)setHighLightKeyWords:(NSArray *)keyWordsArr withSearchString:(NSString *)searchStr onLabel:(UILabel *)label color:(UIColor *)color{
    NSString *key = SafeString(searchStr);
    [self setAttributedText:key withRegularPattern:[self regularPattern:keyWordsArr] attributes:@{ NSForegroundColorAttributeName : color} Label:label];
    
}

+ (NSString *)regularPattern:(NSArray *)keys{
    NSMutableString *pattern = [[NSMutableString alloc]initWithString:@"(?i)"];
    
    for (NSString *key in keys) {
        [pattern appendFormat:@"%@|",key];
    }
    
    return pattern;
}

+ (void)setAttributedText:(NSString *)text
       withRegularPattern:(NSString *)pattern
               attributes:(NSDictionary *)attributesDict
                    Label:(UILabel *)label {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:nil];
    [self setAttributedText:text withRegularExpression:regex attributes:attributesDict label:label];
}

+ (void)setAttributedText:(NSString *)text
    withRegularExpression:(NSRegularExpression *)expression
               attributes:(NSDictionary *)attributesDict
                    label:(UILabel *)label
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [expression enumerateMatchesInString:text
                                 options:0
                                   range:NSMakeRange(0, [text length])
                              usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                  NSRange matchRange = [result range];
                                  if (attributesDict) {
                                      [attributedString addAttributes:attributesDict range:matchRange];
                                  }
                                  
                                  if ([result resultType] == NSTextCheckingTypeLink) {
                                      NSURL *url = [result URL];
                                      [attributedString addAttribute:NSLinkAttributeName value:url range:matchRange];
                                  }
                              }];
    [label setAttributedText:attributedString];
}

@end
