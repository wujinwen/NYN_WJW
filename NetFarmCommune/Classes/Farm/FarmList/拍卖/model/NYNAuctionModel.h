//
//  NYNAuctionModel.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNAuctionModel : NSObject


@property(nonatomic,assign)int auctionID;//拍卖品id
@property(nonatomic,assign)long createDate;//发布时间
@property(nonatomic,strong)NSString * sn;//产品编号
@property(nonatomic,assign)int size;//产品规格
@property(nonatomic,assign)int unitId;//单位id
@property(nonatomic,strong)NSString * unitName;//单位名称
@property(nonatomic,assign)int  startPrice;//起价
@property(nonatomic,assign)int  endPrice;//最终价格
@property(nonatomic,assign)long  startTime;//开拍时间
@property(nonatomic,assign)int  addPrice;//加价单位
@property(nonatomic,assign)long  endTime;//截止时间
@property(nonatomic,assign)long  currentTime;//当前系统时间
@property(nonatomic,strong)NSString * intro;//产品介绍
@property(nonatomic,strong)NSString * images;//产品图片json
@property(nonatomic,strong)NSString * pImg;//产品主图
@property(nonatomic,assign)int  userCount;//竞拍人数
@property(nonatomic,assign)int  saleCount;//竞拍次数

@property(nonatomic,assign)int  newPrice;//最新价格
@property(nonatomic,strong)NSString * saleStatus;//拍卖状态 预拍 -preSale 竞拍中 -saleling 结束 -end

@end
