//
//  PersonalCenterVC.h
//  SGPageViewExample
//
//  Created by apple on 2017/6/15.
//  Copyright © 2017年 Sorgle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PersonalCenterVC : BaseViewController
//farmId
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *LiveID;

@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;
@property (nonatomic,copy) NSString *ctype;

@property(nonatomic,strong)NSString * farmName;//农场名

@property(nonatomic,strong)NSString * playUrl;
@property(nonatomic,assign)BOOL islive;//是否是看直播
@property(nonatomic,strong)NSString * chatId;//看直播的回话id
@property(nonatomic,strong)NSString * userId;//用户名ID

@end
