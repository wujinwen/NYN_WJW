//
//  NYNLiveListViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/9/25.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//
//点击直播界面
#import "NYNLiveListViewController.h"

#import "NYNPushSrteamViewController.h"

#import "RecommndViewController.h"
#import "HotViewController.h"
#import "OutDoorViewController.h"
#import "MonitorViewController.h"
#import "SGPageView.h"
#import <RongIMLib/RongIMLib.h>
#import "NYNLiveRoomViewController.h"
#import "NYNNetTool.h"
#import "NYNPushStreamModel.h"
#import "ZWPullMenuView.h"

#import "MyMovieViewController.h"
#import "AttentionViewController.h"
#import "NYNLiveRoomViewController.h"
@interface NYNLiveListViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end


@implementation NYNLiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    UIButton *zhiboButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//    [zhiboButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
//    [zhiboButton setTitle:@"我的" forState:UIControlStateNormal];
//
//    UIBarButtonItem *rb = [[UIBarButtonItem alloc]initWithCustomView:zhiboButton];
//
//    self.navigationItem.rightBarButtonItem = rb;
    [self setupView];
    
    

}

- (void)setupView {
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    RecommndViewController *twoVC = [[RecommndViewController alloc] init];
    twoVC. hidesBottomBarWhenPushed= YES;
    
    
    HotViewController *oneVC = [[HotViewController alloc] init];
//    OutDoorViewController *threeVC = [[OutDoorViewController alloc] init];
     oneVC. hidesBottomBarWhenPushed= YES;

    MonitorViewController *foureVC = [[MonitorViewController alloc] init];
     foureVC. hidesBottomBarWhenPushed= YES;
    
    NSArray *childArr = @[twoVC, oneVC,foureVC];
    /// pageContentView
    CGFloat contentViewHeight = SCREENHEIGHT - 64;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"综合直播", @"互动直播",@"监控直播"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 34, SCREENWIDTH-(SCREENWIDTH/4), 40) delegate:self titleNames:titleArr];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isIndicatorScroll = NO;
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeSpecial;
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.isNeedBounces = NO;
    _pageTitleView.titleColorStateSelected = Color90b659;
    _pageTitleView.indicatorColor = Color90b659;
    _pageTitleView.titleColorStateNormal = Color686868;
    
    
    
    
    UIButton * startBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame =CGRectMake((SCREENWIDTH/4)*3, 34, SCREENWIDTH/4, 40);
    [startBtn setTitle:@"发起直播" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitleColor:Color686868 forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    startBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:startBtn];
    
    
//    UILabel * linelabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH/4)*3, 70, SCREENWIDTH/4, 1)];
//    linelabel.backgroundColor = Color686868;
//    [self.view addSubview:linelabel];

    
    
}
//发起直播

-(void)startBtnClick:(UIButton*)sender{
    //链接融云服务器
    NYNLiveRoomViewController *chatRoomVC = [[NYNLiveRoomViewController alloc]init];
    chatRoomVC.isVertical = YES;
    chatRoomVC.farmId = @"";
    chatRoomVC.fps  =10;
    chatRoomVC.kbps  =400;
    chatRoomVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatRoomVC animated:NO];
    
}
- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
- (void)push:(UIButton*)sender{
//    UserInfoModel * model = userInfoModel;
    
    
    NSArray *titleArray = @[@"我的直播",@"我的关注"];
    NSArray *imageArray = @[@"contacts_add_newmessage_30x30_",
                            @"contacts_add_friend_30x30_",
                            @"contacts_add_scan_30x30_",
                            @"contacts_add_scan_30x30_"];
  ZWPullMenuView *menuView =   [ZWPullMenuView pullMenuAnchorView:sender
                            titleArray:titleArray
                            imageArray:imageArray];
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
       //我的直播
        if ((long)menuRow == 0) {
            
            MyMovieViewController * myMovieVC =[[MyMovieViewController alloc]init];
            [self.navigationController pushViewController:myMovieVC animated:YES];
            
            
              
        }else if ((long)menuRow==1){
            //我的关注
            AttentionViewController * attentionVC = [[AttentionViewController alloc]init];
            [self.navigationController pushViewController:attentionVC animated:YES];
         
            
            
        }
    };
    


}


@end
