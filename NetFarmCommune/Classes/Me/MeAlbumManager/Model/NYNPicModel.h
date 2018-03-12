//
//  NYNPicModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNPicModel : NSObject
@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *modifyDate;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *userId;

//0 照片  1加号
@property (nonatomic,copy) NSString *cType;

@property (nonatomic,strong) UIImage *imageContent;
@end
