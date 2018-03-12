//
//  SaleTwoTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/23.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleTwoTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel * farmLabel;//农场名

@property(nonatomic,strong) UILabel * locationLabel;//地址

@property(nonatomic,strong) UILabel * distanceLabel;//距离

@property(nonatomic,strong)UIImageView * locationImage;//地址图片

@property(nonatomic,strong)UIButton * phoneButton;//电话

@property(nonatomic,strong)UILabel * zerenLabel;//责任人

@property(nonatomic,strong)UIButton * zerenNameLabel;//责任人名字

@property(nonatomic,strong)UILabel * phoneLabel;//电话

@property(nonatomic,strong)UIButton * phoneNumberBtn;//电话号码显示


@end

