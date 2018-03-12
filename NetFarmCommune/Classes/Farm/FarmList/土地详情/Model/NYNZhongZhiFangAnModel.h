//
//  NYNZhongZhiFangAnModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/28.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNZhongZhiFangAnModel : NSObject

@property (nonatomic,assign) BOOL boZhongIsChoose;
@property (nonatomic,assign) BOOL zhouqiIsChoose;
@property (nonatomic,assign) BOOL shiFeiIsChoose;
@property (nonatomic,assign) BOOL jiaoShuiIsChoose;
@property (nonatomic,assign) BOOL paiZhaoIsChoose;



@property (nonatomic,assign) int boZhongCount;
@property (nonatomic,assign) int boZhongZhouQiCount;
@property (nonatomic,assign) int shiFeiCount;
@property (nonatomic,assign) int jiaoShuiCount;
@property (nonatomic,assign) int paiZhaoCount;

@property (nonatomic,assign) int paizhaocishuCount;
@property (nonatomic,assign) int paizhaozhouqiCount;
@property (nonatomic,assign) int paizhaojiangeCount;

@property (nonatomic,assign) double boZhongPrice;
@property (nonatomic,assign) double boZhongZhouQiPrice;
@property (nonatomic,assign) double shiFeiPrice;
@property (nonatomic,assign) double jiaoShuiPrice;
@property (nonatomic,assign) double paiZhaoPrice;

@property (nonatomic,strong) NSDate* chooseDate;

@property (nonatomic,strong) NSMutableArray *shiFeiArr;
@property (nonatomic,strong) NSMutableArray *jiaoShuiArr;


@property (nonatomic,strong) NSMutableArray *shiFeiDataArr;
@property (nonatomic,strong) NSMutableArray *jiaoShuiDataArr;
@end

