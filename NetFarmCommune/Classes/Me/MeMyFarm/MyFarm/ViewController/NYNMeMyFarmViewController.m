//
//  NYNMeMyFarmViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//这个界面不要了

#import "NYNMeMyFarmViewController.h"
#import "SGPageView.h"

#import "NYNMeZhongZhiViewController.h"
#import "NYNMeYangZhiViewController.h"
#import "NYNMeYiShouHuoViewController.h"
#import "NYNMeQiYeZhuanShuViewController.h"
#import "NYNMyFarmZhongZhiViewController.h"


@interface NYNMeMyFarmViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end

@implementation NYNMeMyFarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的农场";
   
    [self setupPageView];
    
}

- (void)setupPageView {
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NYNMeZhongZhiViewController *oneVC = [[NYNMeZhongZhiViewController alloc] init];
    NYNMeYangZhiViewController *twoVC = [[NYNMeYangZhiViewController alloc] init];
    NYNMeYiShouHuoViewController *threeVC = [[NYNMeYiShouHuoViewController alloc] init];
    NYNMeQiYeZhuanShuViewController *fourVC = [[NYNMeQiYeZhuanShuViewController alloc] init];
    
    NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC];
    /// pageContentView
    CGFloat contentViewHeight = SCREENHEIGHT - 64;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"种植", @"养殖", @"已收获", @"企业专属"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44) delegate:self titleNames:titleArr];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isIndicatorScroll = NO;
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeSpecial;
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.isNeedBounces = NO;
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





@end
