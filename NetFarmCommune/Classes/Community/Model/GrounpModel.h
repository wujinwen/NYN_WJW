//
//  GrounpModel.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrounpModel : NSObject

@property(nonatomic,strong)NSString * name;

@property(nonatomic,assign)int  areaId;//区域id
@property(nonatomic,strong)NSString * groupId;//群组号

@property(nonatomic,strong)NSString * intro;//群组简介
@property(nonatomic,strong)NSString * avatar;//群组头像

@property(nonatomic,assign)int  usersCount;//群组人数

@property(nonatomic,strong)NSArray * city;//城市实体




@end
