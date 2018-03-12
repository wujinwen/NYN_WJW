//
//  NYNMeDealViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeDealViewController.h"

#import "NYNMeDealAllViewController.h"
#import "NYNMeDealDaiFuKuanViewController.h"
#import "NYNMeDealDaiFaHuoViewController.h"
#import "NYNMeDealDaiShouHuoViewController.h"
#import "NYNMeDealDaiPingJiaViewController.h"

#import "NYNShouHouViewController.h"
#import "CustomModel.h"
#import "AftersalesViewController.h"

@interface NYNMeDealViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property(nonatomic,strong)NSMutableArray *dataListArr;


@end

@implementation NYNMeDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"我的订单";
    
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(60), JZHEIGHT(13))];
    [bt setTitle:@"我的售后" forState:0];
    [bt setTitleColor:[UIColor whiteColor] forState:0];
    bt.titleLabel.font = JZFont(13);
    UIBarButtonItem *ss = [[UIBarButtonItem alloc]initWithCustomView:bt];
    self.navigationItem.rightBarButtonItem = ss;
    [bt addTarget:self action:@selector(shouhou) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupPageView];

}



- (void)setupPageView {
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NYNMeDealAllViewController *oneVC = [[NYNMeDealAllViewController alloc] init];
    NYNMeDealDaiFuKuanViewController *twoVC = [[NYNMeDealDaiFuKuanViewController alloc] init];
    NYNMeDealDaiFaHuoViewController *threeVC = [[NYNMeDealDaiFaHuoViewController alloc] init];
    NYNMeDealDaiShouHuoViewController *fourVC = [[NYNMeDealDaiShouHuoViewController alloc] init];
    NYNMeDealDaiPingJiaViewController *fiveVC = [[NYNMeDealDaiPingJiaViewController alloc] init];

    
    NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC ,fiveVC];
    /// pageContentView
    CGFloat contentViewHeight = SCREENHEIGHT  - 108;
    int y = _weigth;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, y, SCREENWIDTH, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"全部", @"待付款", @"待发货", @"待收货", @"待评价"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44) delegate:self titleNames:titleArr];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isIndicatorScroll = NO;
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeSpecial;
    _pageTitleView.isNeedBounces = NO;
    _pageTitleView.selectedIndex = _selectedIndex;
    _pageTitleView.titleColorStateSelected = Color90b659;
    _pageTitleView.indicatorColor = Color90b659;
    _pageTitleView.titleColorStateNormal = Color686868;
    
}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    _pageTitleView.selectedIndex = _selectedIndex;

}

- (void)shouhou{
    NYNShouHouViewController *vc = [[NYNShouHouViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    

}
@end
