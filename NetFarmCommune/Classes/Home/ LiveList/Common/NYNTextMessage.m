//
//  NYNTextMessage.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNTextMessage.h"

@implementation NYNTextMessage
- (void)decodeWithData:(NSData *)data {
    __autoreleasing NSError *__error = nil;
    if (!data) {
        return;
    }
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&__error];
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
    if (!__error && dict) {
        self.content = [dict objectForKey:@"content"];
        self.time = [dict objectForKey:@"time"];
        self.targetId = [dict objectForKey:@"targetId"];
        self.type = [[dict objectForKey:@"type"]intValue];
        
        
        NSDictionary *userinfoDic = [dict objectForKey:@"user"];
        [self decodeUserInfo:userinfoDic];
    } else {
        self.rawJSONData = data;
    }
}
- (NSData *)encode {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.content) {
        [dict setObject:self.content  forKey:@"content"] ;
    }
    if (self.targetId) {
        [dict setObject:self.targetId  forKey:@"targetId"];
    }
    if (self.time) {
        [dict setObject:self.time forKey:@"time"];
    }
    if (self.type) {
        [dict setObject:@(self.type)  forKey:@"type"];
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
    return LianmaiMessageIdentifier;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [super dealloc];
}
#endif //__has_feature(objc_arc)
@end
