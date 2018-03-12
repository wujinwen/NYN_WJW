//
//  NYNMeMyFarmViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeMyFarmViewController.h"
#import "SGPageView.h"

#import "NYNMeZhongZhiViewController.h"
#import "NYNMeYangZhiViewController.h"
#import "NYNMeYiShouHuoViewController.h"
#import "NYNMeQiYeZhuanShuViewController.h"


@interface NYNMeMyFarmViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end

@implementation NYNMeMyFarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
    NSArray *titleArr = @[@"种植", @"养殖", @"已收货", @"企业专属"];
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
