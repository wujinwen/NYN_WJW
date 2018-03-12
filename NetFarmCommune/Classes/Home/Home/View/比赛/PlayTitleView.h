//
//  PlayTitleView.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PlayTitleViewClickDelagate<NSObject>

-(void)playSelectButtonClick:(NSInteger)tag;

@end

@interface PlayTitleView : UIView


@property(nonatomic,weak)id<PlayTitleViewClickDelagate>delagete;



@end
