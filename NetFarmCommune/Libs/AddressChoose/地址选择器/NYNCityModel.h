//
//  NYNCityModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYNMergerModel.h"

@interface NYNCityModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSMutableArray *countys;
@end
