//
//  NYNLiveGiftMessege.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNLiveGiftMessege.h"

@implementation NYNLiveGiftMessege

- (void)decodeWithData:(NSData *)data {
    __autoreleasing NSError *__error = nil;
    if (!data) {
        return;
    }
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&__error];
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
    if (!__error && dict) {
        self.ID = [[dict objectForKey:@"ID"]intValue];
        self.content = [dict objectForKey:@"content"] ;
        self.time = [dict objectForKey:@"time"];
        self.targetName = [dict objectForKey:@"targetName"];
        self.count = [[dict objectForKey:@"count"]intValue];
        
        
        NSDictionary *userinfoDic = [dict objectForKey:@"user"];
        [self decodeUserInfo:userinfoDic];
    } else {
        self.rawJSONData = data;
    }
}

- (NSData *)encode {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.ID) {
        [dict setObject:@(self.ID)  forKey:@"ID"] ;
    }
    if (self.count) {
        [dict setObject:@(self.count)  forKey:@"count"];
    }
    if (self.time) {
        [dict setObject:self.time forKey:@"time"];
    }
    if (self.targetName) {
        [dict setObject:self.targetName forKey:@"targetName"];
    }
    if (self.content) {
        [dict setObject:self.content forKey:@"content"];
    }
    if (self.senderUserInfo) {
        NSMutableDictionary *__dic = [[NSMutableDictionary alloc] init];
        if (self.senderUserInfo.name) {
            [__dic setObject:self.senderUserInfo.name forKeyedSubscript:@"name"];
        }
        if (self.senderUserInfo.portraitUri) {
            [__dic setObject:self.senderUserInfo.portraitUri forKeyedSubscript:@"icon"];
        }
        if (self.senderUserInfo.userId) {
            [__dic setObject:self.senderUserInfo.userId forKeyedSubscript:@"id"];
        }
        [dict setObject:__dic forKey:@"user"];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
    return jsonData;
}

+ (NSString *)getObjectName {
    return LiveGiftMessageIdentifier;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [super dealloc];
}
#endif //__has_feature(objc_arc)

@end
