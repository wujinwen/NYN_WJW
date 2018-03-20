//
//  NSString+NYN.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/14.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NSString+NYN.h"

@implementation NSString (NYN)
+ (NSString *)jsonImg:(NSString *)imgstr{
    if (imgstr == nil) {
        return @"";
    }
    NSData *jsonData = [imgstr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    return dic[0];
}
@end
