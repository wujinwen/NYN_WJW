//
//  NYNFangAnListModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNFangAnListModel : NSObject
@property (nonatomic,copy) NSString *artProductId;
@property (nonatomic,copy) NSString *categoryId;
@property (nonatomic,copy) NSString *categoryName;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *countTitle;
@property (nonatomic,copy) NSString *ctype;
@property (nonatomic,copy) NSString *duration;
@property (nonatomic,copy) NSString *durationTitle;
@property (nonatomic,copy) NSString *farmArtId;
@property (nonatomic,copy) NSString *farmArtName;
@property (nonatomic,copy) NSString *ftype;
@property (nonatomic,copy) NSString *interval;
@property (nonatomic,copy) NSString *intervalTitle;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSString *isCount;
@property (nonatomic,copy) NSString *isDefault;
@property (nonatomic,copy) NSString *isDuration;
@property (nonatomic,copy) NSString *isInterval;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *unionTask;
@property (nonatomic,copy) NSString *unionTitle;
@property (nonatomic,copy) NSString *unitName;


@property (nonatomic,strong) NSMutableArray *subArr;

@property (nonatomic,assign) BOOL cellChoose;

@property (nonatomic,copy) NSString *checked;


@end
