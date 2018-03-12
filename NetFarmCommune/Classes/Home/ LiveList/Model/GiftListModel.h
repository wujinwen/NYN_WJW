//
//  GiftListModel.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftListModel : NSObject

@property(nonatomic,strong)NSString * giftName;//礼物名

@property(nonatomic,strong)NSString * giftImg;//giftImg

@property(nonatomic,assign)int giftId;

@property(nonatomic,assign)int count;

@property(nonatomic,assign)int userName;


@property(nonatomic,strong)NSString * name;

@property(nonatomic,strong)NSString * img;

@property(nonatomic,assign)NSString * liID;

@property(nonatomic,assign)int score;

@property(nonatomic,assign)int type;

@property(nonatomic,assign)double price;


@end
