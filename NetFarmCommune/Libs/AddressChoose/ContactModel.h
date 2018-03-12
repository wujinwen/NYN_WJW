//
//  ContactModel.h
//  iFootbook_pay
//
//  Created by Apple on 2017/1/5.
//  Copyright © 2017年 iFootbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phoneNumber;
@property(nonatomic,strong)NSString *address;
+(NSArray *)contectData;
@end
