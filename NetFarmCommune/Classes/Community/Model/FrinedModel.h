//
//  FrinedModel.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FrinedModel : NSObject

@property(nonatomic,strong)NSString * alias;

@property(nonatomic,strong)NSDictionary * friend1;

@property(nonatomic,strong)NSString * userId;

@property(nonatomic,strong)NSString * status;//好友状态 -normal 正常 -blacklist 黑名单 -delete 删除



@end
