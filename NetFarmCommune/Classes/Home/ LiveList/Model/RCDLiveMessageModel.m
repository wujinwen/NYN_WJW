//
//  RCDLiveMessageModel.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "RCDLiveMessageModel.h"

@implementation RCDLiveMessageModel
- (instancetype)initWithMessage:(RCMessage *)rcMessage {
    self = [super init];
    if (self) {
        self.conversationType = rcMessage.conversationType;
        self.targetId = rcMessage.targetId;
        self.messageId = rcMessage.messageId;
        self.messageDirection = rcMessage.messageDirection;
        self.senderUserId = rcMessage.senderUserId;
        self.receivedStatus = rcMessage.receivedStatus;
        self.sentStatus = rcMessage.sentStatus;
        self.sentTime = rcMessage.sentTime;
        self.objectName = rcMessage.objectName;
        self.content = rcMessage.content;
        self.isDisplayMessageTime = NO;
        self.userInfo = nil;
        self.receivedTime = rcMessage.receivedTime;
        self.extra = rcMessage.extra;
    }
    
    return self;
}
@end
