//
//  NYNPinZhongDataModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNPinZhongDataModel.h"

@implementation NYNPinZhongDataModel
-(NSMutableArray *)pinArr{
    if (!_pinArr) {
        _pinArr = [[NSMutableArray alloc]init];
    }
    return _pinArr;
}
@end
