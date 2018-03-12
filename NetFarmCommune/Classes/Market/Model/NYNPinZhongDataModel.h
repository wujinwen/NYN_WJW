//
//  NYNPinZhongDataModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNPinZhongDataModel : NSObject
@property (nonatomic,strong) NSMutableArray *pinArr;
@property (nonatomic,copy) NSString *pinName;

@property (nonatomic,assign) BOOL isChoose;
@end
