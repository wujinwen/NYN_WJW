//
//  NYNLeiDataModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNLeiDataModel.h"

@implementation NYNLeiDataModel
-(NSMutableArray *)leiArr{
    if (!_leiArr) {
        _leiArr = [[NSMutableArray alloc]init];
    }
    return _leiArr;
}
@end
