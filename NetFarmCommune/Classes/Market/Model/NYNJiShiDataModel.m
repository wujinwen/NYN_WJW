//
//  NYNJiShiDataModel.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNJiShiDataModel.h"

@implementation NYNJiShiDataModel
-(NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [[NSMutableArray alloc]init];
        
    }
    return _titleArr;
}

-(NSMutableArray *)productCategories{
    if (!_productCategories) {
        _productCategories = [[NSMutableArray alloc]init];
        
    }
    return _productCategories;
    
}
@end
