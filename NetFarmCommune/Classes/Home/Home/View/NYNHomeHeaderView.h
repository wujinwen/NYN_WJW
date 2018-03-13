//
//  NYNHomeHeaderView.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/2.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Bccc)(NSString *s);
@interface NYNHomeHeaderView : UIView
@property (nonatomic,copy) Bccc bcc;
@property (nonatomic,strong) UIButton *moreButton;

-(instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName Title:(NSString *)titleName DetailTitle:(NSString *)detailTitle;


@end
