//
//  AllDealViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//全部订单

#import "AllDealViewController.h"
#import "NYNShouHouViewController.h"
#import "NYNMeDealViewController.h"
#import "CustomProductionVC.h"
#import "LeaseDealViewController.h"
#import "SaleDealViewController.h"
#import "AftersalesViewController.h"
@interface AllDealViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end

@implementation AllDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
      self.title=@"我的订单";
    
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(60), JZHEIGHT(13))];
    [bt setTitle:@"我的售后" forState:0];
    [bt setTitleColor:[UIColor whiteColor] forState:0];
    bt.titleLabel.font = JZFont(13);
    UIBarButtonItem *ss = [[UIBarButtonItem alloc]initWithCustomView:bt];
    self.navigationItem.rightBarButtonItem = ss;
    [bt addTarget:self action:@selector(shouhou) forControlEvents:UIControlEventTouchUpInside];
   
    [self setupPageView];

}

//重写父类返回事件
- (void)backToLast:(UIButton *)btn {
    if (self.fromMarket) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        //跳转到Me
        [self.tabBarController setSelectedIndex:4];
    }else {
        [super backToLast:btn];
    }
}

//我的售后
- (void)shouhou{
    NYNShouHouViewController *vc = [[NYNShouHouViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
 
    
}

- (void)setupPageView {
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    NYNMeDealAllViewController *twoVC = [[NYNMeDealAllViewController alloc] init];
    NYNMeDealViewController * twoVC = [[NYNMeDealViewController alloc]init];
    LeaseDealViewController * leaseVC =[[LeaseDealViewController alloc]init];
    SaleDealViewController * threeVC = [[SaleDealViewController alloc]init];
    
    twoVC.weigth = 44;
    
    CustomProductionVC * oneVC = [[CustomProductionVC alloc]init];
    
    NSArray *childArr = @[oneVC, twoVC, threeVC, leaseVC];
    /// pageContentView
    CGFloat contentViewHeight = SCREENHEIGHT  - 108;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"代种代养", @"商品订单", @"消费订单", @"租赁订单"];
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

@end
