//
//  StopSpeakView.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface StopSpeakView : UIView

@property(nonatomic,strong)NSString * liveID;

//加载数据
- (void)getDataWith:(NSString *)liveID;

@end
