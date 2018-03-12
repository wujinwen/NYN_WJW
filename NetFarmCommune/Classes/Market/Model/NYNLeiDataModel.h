//
//  NYNLeiDataModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYNPinZhongDataModel.h"

@interface NYNLeiDataModel : NSObject
@property (nonatomic,strong) NSMutableArray *leiArr;
@property (nonatomic,copy) NSString *LeiName;
@property (nonatomic,assign) BOOL isChoose;




@end
