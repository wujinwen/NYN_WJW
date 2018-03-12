//
//  BeautyView.h
//  NetFarmCommune
//
//  Created by manager on 2017/9/30.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BeautyClickDelagate<NSObject>

-(void)beautyButtonClick:(NSInteger)tag;

@end

@interface BeautyView : UIView

@property(assign,nonatomic)id<BeautyClickDelagate> delegate;



@end
