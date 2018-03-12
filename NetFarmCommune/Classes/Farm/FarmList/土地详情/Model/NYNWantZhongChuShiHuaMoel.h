//
//  NYNWantZhongChuShiHuaMoel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/6.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYNYangZhiFangAnModel.h"

@interface NYNWantZhongChuShiHuaMoel : NSObject
@property (nonatomic,strong) NSMutableArray *artOrderItemResults;
@property (nonatomic,copy) NSString *defaultSignboardId;
@property (nonatomic,copy) NSString *defaultSignboardName;
@property (nonatomic,copy) NSString *defaultSignboardPrice;
@property (nonatomic,copy) NSString *defaultTemplateAmount;
@property (nonatomic,copy) NSString *defaultUserAddressId;
@property (nonatomic,copy) NSString *defaultUserAddressTitle;
@property (nonatomic,copy) NSString *farmManagerId;
@property (nonatomic,copy) NSString *freight;

@property (nonatomic,assign) int cycTime;

//判断是否使用系统的默认方案
@property (nonatomic,assign) BOOL isDefaultTemplate;

//下面的是专门给养殖模型做的扩展   种植模型不再管
//养殖模型增加参数
//养殖的数量
@property (nonatomic,assign) int yangZhiCountStr;
//名称
@property (nonatomic,copy) NSString *yangZhiNameStr;
//方案类型
@property (nonatomic,copy) NSString *yangZhiFangAnNameStr;
//方案总价
@property (nonatomic,assign) double yangZhiFangAnTotlePriceStr;
//方案ID
@property (nonatomic,copy) NSString *yangZhiFangAnTotlePriceIDStr;
//管家名称
@property (nonatomic,copy) NSString *yangZhiGuanJiaNameStr;
//管家ID
@property (nonatomic,copy) NSString *yangZhiGuanJiaIDStr;
//标志名称
@property (nonatomic,copy) NSString *yangZhiBiaoZhiNameStr;
//标志ID
@property (nonatomic,copy) NSString *yangZhiBiaoZhiIDStr;
//标志价格
@property (nonatomic,copy) NSString *yangZhiBiaoZhiPriceStr;
//加工名称
@property (nonatomic,copy) NSString *yangZhiJiaGongNameStr;
//加工ID
@property (nonatomic,copy) NSString *yangZhiJiaGongIDStr;
//加工价格
@property (nonatomic,copy) NSString *yangZhiJiaGongPriceStr;
//保险名称
@property (nonatomic,copy) NSString *yangZhiBaoXianNameStr;
//保险ID
@property (nonatomic,copy) NSString *yangZhiBaoXianIDStr;
//保险价格
@property (nonatomic,copy) NSString *yangZhiBaoXianPriceStr;
//配送是否选择
@property (nonatomic,assign) BOOL yangZhiPeiSongIsChoose;

@property (nonatomic,assign) BOOL peiSongDiZhiIsChoose;
@property (nonatomic,assign) BOOL aiXinJuanZengIsChoose;

//养殖方案的具体数组
@property (nonatomic,strong) NSMutableArray *fangAnArr;
@end
