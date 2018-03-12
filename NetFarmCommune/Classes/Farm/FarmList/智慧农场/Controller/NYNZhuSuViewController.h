//
//  NYNZhuSuViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "PersonalCenterChildBaseVC.h"


typedef void(^DateUp)(NSString *ss);
@interface NYNZhuSuViewController : PersonalCenterChildBaseVC
@property (nonatomic,strong) NSString *farmId;
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;
@property (nonatomic,copy) DateUp dateUp;

- (void)updateData;
@end
