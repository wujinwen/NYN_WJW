//
//  NYNWisDomModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNWisDomModel : NSObject
@property (nonatomic,strong) NSString *Id;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *name;
//@property (nonatomic,strong) NSString *images;
@property (nonatomic,strong) NSString *introduce;
@property (nonatomic,strong) NSString *detail;
@property (nonatomic,strong) NSString *auditState;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *auditTime;
@property (nonatomic,strong) NSString *auditOpinion;
@property (nonatomic,strong) NSString *saleCount;
@property (nonatomic,strong) NSString *commentCount;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *grade;
@property (nonatomic,strong) NSString *mainImage;
@property (nonatomic,strong) NSString *mainBusiness;
@property (nonatomic,strong) NSString *landStock;
@property (nonatomic,strong) NSString *businessScope;


@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSArray *farmBusinessList;

@property (nonatomic,strong) NSString *cycleTime;

@property(nonatomic,copy)NSString * farmId;
@property(nonatomic,copy)NSString * categoryId;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * orderBy;
@property(nonatomic,copy)NSString * categoryName;

@end
