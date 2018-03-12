//
//  AllDealViewController.h
//  NetFarmCommune
//
//  Created by manager on 2017/12/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"
#import "SGPageView.h"
@interface AllDealViewController : BaseViewController

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, assign) NSInteger selectedIndex;

//是否是从集市下单跳转过来的
@property (nonatomic,assign)BOOL fromMarket;
@end
