//
//  NYNGouMaiView.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^goumaiBlock) (NSString *strValue);
typedef void (^gouwucheBlock) (NSString *strValue);

@interface NYNGouMaiView : UIView

@property(nonatomic, copy) goumaiBlock goumaiBlock;
@property(nonatomic, copy) gouwucheBlock gouwucheBlock;

@property (nonatomic,strong) UIButton *goumaiBT;
@property (nonatomic,strong) UIButton *jiaGouWuCheBT;

@property (nonatomic,strong) UILabel *heJiLabel;

//-(instancetype)initWithFrame:(CGRect)frame withIndex:(int)index;
- (void)ConfigDataWithIndex:(int)index withFrame:(CGRect)rect;
@end
