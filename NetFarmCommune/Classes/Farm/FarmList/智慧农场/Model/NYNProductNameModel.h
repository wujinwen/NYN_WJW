//
//  NYNProductNameModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/15.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//
//查询农场信息

#import <Foundation/Foundation.h>

@interface NYNProductNameModel : NSObject
@property (nonatomic,copy) NSString *ID;//农场id
@property (nonatomic,copy) NSString *name;//农场名称

@property (nonatomic,strong) NSDictionary *children;
@property (nonatomic,copy) NSString *showType;

//@property (nonatomic,copy) NSString *categoryId;
@property (nonatomic,copy) NSString *categoryName;
@property (nonatomic,copy) NSString *farmId;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *orderBy;
@property (nonatomic,copy) NSString *type;

@property (nonatomic,copy) NSString *categoryId;

@end
