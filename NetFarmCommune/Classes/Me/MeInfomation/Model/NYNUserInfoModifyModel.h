//
//  NYNUserInfoModifyModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/7/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNUserInfoModifyModel : NSObject
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,strong) UIImage *imageData;
@property (nonatomic,copy) NSString *nameStr;
@property (nonatomic,copy) NSString *sexStr;
@property (nonatomic,copy) NSString *bornDate;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *mySign;



@end
