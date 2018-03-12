//
//  NYNZYView.h
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChooseBlock) (NSString *strValue);

@interface NYNZYView : UIView
@property (nonatomic,strong) UIButton *chooseButton;
@property(nonatomic, copy) ChooseBlock ChooseBlock;

@end
