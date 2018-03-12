//
//  NYNWantYangZhiModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/5.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNWantYangZhiModel : NSObject
@property (nonatomic,copy) NSString *yangZhiName;


@property (nonatomic,copy) NSString *fangan;
@property (nonatomic,copy) NSString *guanjia;
@property (nonatomic,copy) NSString *biaozhi;
@property (nonatomic,copy) NSString *jiagong;
@property (nonatomic,copy) NSString *baoxian;

@property (nonatomic,assign) BOOL isChoosePeiSong;



@property (nonatomic,assign) float yangZhiCount;

@property (nonatomic,assign) float fangAnPrice;
@property (nonatomic,assign) float biaozhiPrice;
@property (nonatomic,assign) float jiagongPrice;
@property (nonatomic,assign) float baoxianPrice;
@property (nonatomic,assign) float peisongPrice;

@end
