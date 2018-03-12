//
//  NYNCategoryPageModel.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/16.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNCategoryPageModel : NSObject
/*
 
 farm =             {
 address = "\U5f6d\U4e61\Uff08\U9547\Uff09\U5e38\U5b58\U6751";
 area = "\U53cc\U6d41\U53bf";
 city = "\U6210\U90fd\U5e02";
 id = 1;
 img = "http://192.168.9.200/images/image/07fa557e117d45dca138db45fdaf2a7f.jpg";
 latitude = "30.62028202515755";
 longitude = "103.85817631047337";
 name = "\U6d77\U4f73\U53cc\U6d41\U6709\U673a\U519c";
 phone = 13980300960;
 province = "\U56db\U5ddd\U7701";
 };
 farmArtProductList =             (
 );
 farmArts =             (
 );
 farmId = 0;
 id = 125;
 images = "[\"http://192.168.9.200/images/image/2c84c88659d14bc783c6ac99374bb90d.jpg\",\"http://192.168.9.200/images/image/b1d118c4dbc34de28f12a04887eb5fde.jpg\"]";
 intro = "\U6d4b\U8bd5\U4e00\U4e2a\U79cd\U5b50";
 isRecommend = 0;
 name = "\U6d4b\U8bd52";
 price = 2;
 sn = ZZ002;
 square = 23;
 stock = 80;
 type = plant;
 unitId = 0;
 unitName = "<null>";
 
 
 
 
 
 
 */
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *pImg;
@property (nonatomic,copy) NSString *imge;
@property (nonatomic,copy) NSString *sn;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *unitId;
@property (nonatomic,copy) NSString *unitName;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSString *stock;//库存
@property (nonatomic,copy) NSString *isStock;
@property (nonatomic,copy) NSString *isSale;
@property (nonatomic,copy) NSString *saleType;
//
@property (nonatomic,copy) NSString *commentCount;
@property (nonatomic,copy) NSString *landStock;
@property (nonatomic,copy) NSString * distance;

@property (nonatomic,copy) NSString *maxStock;


@property (nonatomic,copy) NSString *reviews;
@property (nonatomic,copy) NSString *cycleTime;

@property (nonatomic,copy) NSDictionary *farm;
@property (nonatomic,copy) NSString *isRecommend;
@property (nonatomic,copy) NSArray *images;
@property (nonatomic,copy) NSString *square;//每平方米种植多少颗
@end
