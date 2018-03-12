//
//  AttentionViewController.h
//  NetFarmCommune
//
//  Created by manager on 2017/11/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AttentionViewDelagate<NSObject>

-(void)backButtonDelagete:(UIButton*)sender;

@end

@interface AttentionViewController : BaseViewController

@property(nonatomic,assign)id<AttentionViewDelagate>delaget;


@end
