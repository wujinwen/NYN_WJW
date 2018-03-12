//
//  NewFriendModel.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewFriendModel : NSObject
@property(nonatomic,strong)NSString * fromUserId;
@property(nonatomic,strong)NSString * msg;
@property(nonatomic,strong)NSString * status;
@property(nonatomic,strong)NSString * toUserId;
@property(nonatomic,strong)NSDictionary * fromUser;
@property(nonatomic,strong)NSDictionary * toUser;
@end
