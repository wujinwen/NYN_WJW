//
//  NYNDIYChooseHeaderView.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/30.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickAction)(int ss ,NSString *type);
@interface NYNDIYChooseHeaderView : UIView
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,assign) int count;

@property (nonatomic,copy) ClickAction ClickAction;
@end
