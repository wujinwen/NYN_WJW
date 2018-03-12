//
//  Contact.m
//  通讯录
//
//  Created by Apple on 2017/1/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "Contact.h"

#define NAME_KEY  @"name"
#define PHONE_KEY @"phone"
#define ADDRESS_KEY @"address"


@implementation Contact
@synthesize name = _name,phone = _phone,address=_address;

//编码：
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:NAME_KEY];
    [aCoder encodeObject:self.phone forKey:PHONE_KEY];
    [aCoder encodeObject:self.address forKey:ADDRESS_KEY];
}

//解码：
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        self.name = [aDecoder decodeObjectForKey:NAME_KEY];
        self.phone = [aDecoder decodeObjectForKey:PHONE_KEY];
        self.address = [aDecoder decodeObjectForKey:ADDRESS_KEY];
    }
    
    return self;
}

@end
