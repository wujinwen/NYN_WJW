//
//  NYNProductExtraValuesModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNProductExtraValuesModel : NSObject
@property (nonatomic,copy) NSString *attributeId;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSDictionary *attribute;

@property (nonatomic,assign) BOOL isChoose;
@end
