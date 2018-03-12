//
//  NYNMessageContent.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMessageContent.h"

@implementation NYNMessageContent

/*
 * 对于聊天室中发送频繁的消息比如点赞 鲜花 之类的不重要的消息可以设置成状态消息
 */
+ (RCMessagePersistent)persistentFlag {
    /*!
     在本地进行存储并计入未读数
     */
    return MessagePersistent_ISCOUNTED;
}

- (void)decodeWithData:(NSData *)data {
    __autoreleasing NSError *__error = nil;
    if (!data) {
        return;
    }
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&__error];
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
    if (!__error && dict) {
        self.msg = [dict objectForKey:@"msg"];
        self.isDanmu = [[dict objectForKey:@"isDanmu"] boolValue];
        self.time = [dict objectForKey:@"time"];
        self.targetName = [dict objectForKey:@"targetName"];

        NSDictionary *userinfoDic = [dict objectForKey:@"user"];
        [self decodeUserInfo:userinfoDic];
    } else {
        self.rawJSONData = data;
    }
}

- (NSData *)encode {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.msg) {
        [dict setObject:self.msg forKey:@"msg"];
    }
    if (self.isDanmu) {
        [dict setObject:@(self.isDanmu)  forKey:@"isDanmu"];
    }
    if (self.time) {
        [dict setObject:self.time forKey:@"time"];
    }
    if (self.targetName) {
        [dict setObject:self.targetName forKey:@"targetName"];
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
    return InformationNotificationMessageIdentifier;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [super dealloc];
}
#endif //__has_feature(objc_arc)



@end
