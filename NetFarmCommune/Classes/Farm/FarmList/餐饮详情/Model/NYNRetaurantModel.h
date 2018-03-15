//
//  NYNRetaurantModel.h
//  NetFarmCommune
//
//  Created by manager on 2018/3/15.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>
/**    categoryId = "<null>";
 createDate = "<null>";
 farmId = "<null>";
 id = 217;
 images = "[\"http://42.51.191.88/images/photo/82db121f90dd481cbf6fb7b6ab77cfe3.jpg\"]";
 intro = "<null>";
 modifyDate = "<null>";
 monthSales = 0;
 name = "\U5c0f\U6cb3\U9cab\U9c7c";
 price = 3;
 sn = "<null>";
 stock = 21;
 unitId = 22;
 unitName = "\U4efd";
**/
@interface NYNRetaurantModel : NSObject
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *farmId;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *intro;
@property (nonatomic,strong) NSString *modifyDate;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *monthSales;
@property (nonatomic,strong) NSString *sn;
@property (nonatomic,strong) NSString *unitId;
@property (nonatomic,strong) NSString *unitName;

@end

