//
//  ContactModel.m
//  iFootbook_pay
//
//  Created by Apple on 2017/1/5.
//  Copyright © 2017年 iFootbook. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel
+(NSArray *)contectData{
    ContactModel *c1 = [[ContactModel alloc]init];
    c1.name = @"秋莉帕";
    c1.phoneNumber = @"18767676777";
    c1.address = @"上海市杨浦区锦创路1212";

    ContactModel *c2 = [[ContactModel alloc]init];
    c2.name = @"老王";
    c2.phoneNumber = @"18613299678";
    c2.address = @"上海市杨浦区大学路666号";
  
    ContactModel *c3 = [[ContactModel alloc]init];
    c3.name = @"老王";
    c3.phoneNumber = @"18613299678";
    c3.address = @"上海市杨浦区大学路666号";

    ContactModel *c4 = [[ContactModel alloc]init];
    c4.name = @"老王";
    c4.phoneNumber = @"18613299678";
    c4.address = @"上海市杨浦区大学路666号";

    return @[c1,c2,c3,c4];
 
}

@end
