//
//  LocationViewController.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LocationViewDelagate< NSObject>

//回传地址
-(void)SureBtnClickDelagate:(NSString*)string;


@end

@interface LocationViewController : BaseViewController

@property(nonatomic,weak)id<LocationViewDelagate>delagate;

@end
