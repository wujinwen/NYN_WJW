//
//  Contact.h
//  通讯录
//
//  Created by Apple on 2017/1/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject<NSCoding>
@property(nonatomic,retain)NSString* name;
@property(nonatomic,retain)NSString* phone;
@property(nonatomic,strong)NSString *address;
@end
