//
//  NYNStarsView.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNStarsView.h"

@implementation NYNStarsView

//-(id) initViewWithFrame:(CGRect) frame{
//    
//    self = [super initWithFrame:frame];
//
//    if (self) {
//        
//    }
//    
//    return self;
//}

+ (instancetype)shareStarsWith:(int)count  with:(CGRect) frame{
    
    NYNStarsView *v = [[NYNStarsView alloc]initWithFrame:frame];
    for (int i = 0; i < 5; i++) {
        UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(5) + (JZWITH(10) + JZWITH(3)) * i, (v.height - JZHEIGHT(10)) / 2, JZWITH(10), JZHEIGHT(10))];
        starImageView.image = Imaged(i > count ? @"farm_icon_grade2" : @"farm_icon_grade1");
        [v addSubview:starImageView];
    }
    
    return v;
}
@end
