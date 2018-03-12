//
//  NYNMarketCagoryModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNMarketCagoryModel : NSObject
@property (nonatomic,strong) NSMutableArray *children;

@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString *modifyDate;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *parentId;
@property (nonatomic,copy) NSString *showType;
@property (nonatomic,copy) NSString *type;

@property (nonatomic,assign) BOOL isChoose;

@property (nonatomic,strong) NSMutableArray *productCategories;
@end
