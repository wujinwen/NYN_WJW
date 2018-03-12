//
//  PersonalCenterChildBaseVC.h
//  SGPageViewExample
//
//  Created by apple on 2017/6/15.
//  Copyright © 2017年 Sorgle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol PersonalCenterChildBaseVCDelegate <NSObject>

- (void)personalCenterChildBaseVCScrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface PersonalCenterChildBaseVC : BaseViewController

- (void)didReceiveReloadNotification:(NSNotification *)notification;

@property (nonatomic, weak) id<PersonalCenterChildBaseVCDelegate> delegatePersonalCenterChildBaseVC;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end
