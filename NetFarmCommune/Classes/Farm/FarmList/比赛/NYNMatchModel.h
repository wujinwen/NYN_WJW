//
//  NYNMatchModel.h
//  NetFarmCommune
//
//  Created by manager on 2018/3/15.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNMatchModel : NSObject
/**endDate = 1527782400000;
 {
 code = 200;
 data =     {
 address = "\U6d77\U53e3\U5e02\U79c0\U82f1\U533a\U79c0\U82f1\U533a\U5357\U6d77\U5927\U9053\U4e0e\U706b\U5c71\U53e3\U5927\U9053\U4ea4";
 awardsDesc = "\U7b2c\U4e00\U540d\U5956\U52b1600\U5143\Uff0c\U7b2c\U4e8c\U540d\U5956\U52b1400\U5143\Uff0c\U7b2c\U4e09\U540d\U5956\U52b1200\U5143";
 currentDate = 1521336605017;
 details = "\U5206\U4e3a\U4e09\U7ec4\Uff0c\U6bcf\U7ec410\U4eba\Uff0c\U901a\U8fc7\U62bd\U7b7e\U8fdb\U884c\U5206\U7ec4\U3002\U521d\U8d5b\U5b89\U6392\U5728\U524d\U4e09\U5929\Uff0c\U6bcf\U5929\U8fdb\U884c\U4e00\U573a\Uff0c\U6bcf\U6b21\U4e00\U7ec4\U3002\U6bcf\U573a\U6bd4\U8d5b\U9009\U51fa\U524d\U4e09\U540d\Uff0c\U6700\U5148\U8dd1\U5230\U7ec8\U70b9\U7ebf\U7684\U524d\U4e09\U540d\U53c2\U8d5b\U8005\U664b\U7ea7\U3002\U6700\U540e\U4e00\U5929\U4e3e\U884c\U51b3\U8d5b\Uff0c\U6bcf\U7ec4\U7684\U524d\U4e09\U540d\U664b\U7ea7\U9009\U624b\U8fdb\U884c\U6bd4\U8d5b\Uff0c\U6700\U5148\U62b5\U8fbe\U7ec8\U70b9\U7ebf\U7684\U53c2\U8d5b\U9009\U624b\U4fbf\U662f\U51a0\U519b\U3001\U4e9a\U519b\U548c\U5b63\U519b\U3002";
 distance = "1336.527137058263";
 endDate = 1527782400000;
 farm =         {
 id = 8;
 images =             (
 );
 name = "\U706b\U5c71\U6cc9\U4f11\U95f2\U519c\U5e84";
 userId = 16;
 };
 id = 1;
 images = "[\"http://42.51.191.88/images/image/32e48b1159cf4912b7e0a6864dab787a.jpg\"]";
 latitude = "19.88434436079741";
 longitude = "110.26320040618856";
 maxStock = 30;
 name = "\U5361\U4e01\U8f66\U6bd4\U8d5b";
 phone = 13976575427;
 price = "80.01000000000001";
 signUpEndDate = 1523808000000;
 signUpStartDate = 1516809600000;
 startDate = 1524067200000;
 stock = 30;
 thumbnail = "http://42.51.191.88/images/image/32e48b1159cf4912b7e0a6864dab787a.jpg";
 };
 msg = success;
 }
**/

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *awardsDesc;
@property (nonatomic,copy) NSString *currentDate;
@property (nonatomic,copy) NSString *details;
@property (nonatomic,copy) NSString *endDate;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSDictionary *farm;
@property (nonatomic,copy) NSString *images;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *maxStock;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *signUpEndDate;
@property (nonatomic,copy) NSString *signUpStartDate;
@property (nonatomic,copy) NSString *startDate;
@property (nonatomic,copy) NSString *stock;
@property (nonatomic,copy) NSString *thumbnail;
@end
