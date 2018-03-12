//
//  NYNMeCollectionViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeCollectionViewController.h"
#import "SGPageView.h"

#import "NYNCollectionFarmViewController.h"
#import "NYNCollectionNongJiaLeViewController.h"
#import "NYNCollectionHuoDongViewController.h"
#import "NYNCollectionBiSaiViewController.h"
#import "NYNCollectyionTuDiViewController.h"
#import "NYNCollectionNongChanPinViewController.h"

@interface NYNMeCollectionViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation NYNMeCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"我的收藏";
    [self setupPageView];
    
}

- (void)setupPageView {
    NYNCollectionFarmViewController *oneVC = [[NYNCollectionFarmViewController alloc] init];
    NYNCollectionNongJiaLeViewController *twoVC = [[NYNCollectionNongJiaLeViewController alloc] init];
    NYNCollectionHuoDongViewController *threeVC = [[NYNCollectionHuoDongViewController alloc] init];
    NYNCollectionBiSaiViewController *fourVC = [[NYNCollectionBiSaiViewController alloc] init];
    NYNCollectyionTuDiViewController *fiveVC = [[NYNCollectyionTuDiViewController alloc] init];
    NYNCollectionNongChanPinViewController *sixVC = [[NYNCollectionNongChanPinViewController alloc] init];
    NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC ,fiveVC ,sixVC];
    /// pageContentView
    CGFloat contentViewHeight = SCREENHEIGHT - 64 - 44 ;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"农场", @"农家乐", @"活动", @"比赛", @"土地", @"农产品"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44) delegate:self titleNames:titleArr];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isIndicatorScroll = NO;
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeSpecial;
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.isNeedBounces = NO;
    _pageTitleView.titleColorStateSelected = Color90b659;
    _pageTitleView.titleColorStateNormal = Color686868;
    _pageTitleView.indicatorColor = Color90b659;
}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
