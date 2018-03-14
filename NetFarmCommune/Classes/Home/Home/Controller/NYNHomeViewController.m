//
//  NYNHomeViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/5/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNHomeViewController.h"

#import "NYNNongJiaLeTableViewCell.h"
#import "FTBannerScrollTableViewCell.h"
#import "FTCategoryTableViewCell.h"
#import "FTHomeFunctionChooseTableViewCell.h"
#import "FTFarmRecommendTableViewCell.h"
#import "FTFarmLiveTableViewCell.h"
#import "LQScrollView.h"
#import "SDCycleScrollView.h"
#import "FTHomeButton.h"
#import "FTHomeBottomButton.h"
#import "NYNHomeHeaderView.h"
#import "PersonalCenterVC.h"

#import "FTCodeScanViewController.h"
#import "NEInfoViewController.h"
#import "FTSearchViewController.h"

#import "NYNFarmCellModel.h"
#import "NYNLiveListViewController.h"

#import "YJSegmentedControl.h"
#import "NYNMarketViewController.h"
#import "PlayViewController.h"//比赛
#import "AgritmntViewController.h"//农家乐
#import "ActivityViewController.h"//活动
#import "LeaseViewController.h"
#import "LocationViewController.h"//定位
#import "TuiJianViewController.h"

#import "SGPageView.h"
@interface NYNHomeViewController ()<GCDAsyncSocketDelegate,SGPageTitleViewDelegate, SGPageContentViewDelegate,LocationViewDelagate>
@property (nonatomic,strong) UITableView *homeTable;
@property (nonatomic,strong) NSArray *picArr;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *detailArr;

@property (nonatomic,strong) NSMutableArray *bannnerDataArr;

@property (nonatomic,strong) NSMutableArray *liveDataArr;//直播数组

@property(nonatomic,strong)NSMutableArray * marketArray;//集市数组
@property(nonatomic,strong)NSMutableArray * agritmntArray;//农家乐
@property(nonatomic,strong)NSMutableArray * activityArr;//活动

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@property (nonatomic,strong) FTBannerScrollTableViewCell *bannerCell;

@property (nonatomic,strong)UILabel *cityNameLabel;

@property (nonatomic,strong) GCDAsyncSocket *socket;
@end

@implementation NYNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.socket= [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [self createHomeUI];
    [self initiaHearderSelectUI];
}

#pragma mark---LocationViewDelagate
-(void)SureBtnClickDelagate:(NSString *)string{
    
}

#pragma mark---GCDAsyncSocketDelegate
//链接成功
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    
}
//链接失败
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    
}

- (void)createHomeUI{
    ADD_NTF(@"live", @selector(livePage));
    ADD_NTF(@"active", @selector(active));
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    nav.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nav];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, nav.width, nav.height)];
    backImageView.image = Imaged(@"public_title bar");
    [nav addSubview:backImageView];
    UIButton *locationButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, JZWITH(40), 40)];
    UIColor * color = [UIColor whiteColor];
    locationButton.backgroundColor = [color colorWithAlphaComponent:0];
    UILabel *cityNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, JZWITH(30), JZHEIGHT(20))];
    cityNameLabel.text = @"成都";
    cityNameLabel.font = JZFont(13);
    cityNameLabel.textColor = [UIColor whiteColor];
    cityNameLabel.userInteractionEnabled = NO;
    [locationButton addSubview:cityNameLabel];
    _cityNameLabel =cityNameLabel;

    UIImageView *rightImageItem = [[UIImageView alloc]initWithFrame:CGRectMake(cityNameLabel.right + JZWITH(5), 27, JZWITH(10), 6)];
    rightImageItem.image = Imaged(@"public_icon_select");
    rightImageItem.userInteractionEnabled = NO;
    [locationButton addSubview:rightImageItem];
    
    [locationButton addTarget:self action:@selector(pushToSearch) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:locationButton];
    
    //search
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(65), JZWITH(25), JZWITH(230), JZHEIGHT(30))];
//    searchButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
      searchButton.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    searchButton.layer.cornerRadius = 4;
    searchButton.layer.masksToBounds = YES;
    [searchButton addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:searchButton];
    
    UIImageView *searchV = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(15), 8, JZWITH(12), JZHEIGHT(12))];
    searchV.image = Imaged(@"shousuo");
    searchV.userInteractionEnabled = NO;
    [searchButton addSubview:searchV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(searchV.right + JZWITH(7), 8, JZWITH(50), JZHEIGHT(11))];
    label.text = @"搜索";
    label.textColor = [UIColor colorWithWhite:0 alpha:1];;
    label.userInteractionEnabled = NO;
    label.font = JZFont(11);
    [searchButton addSubview:label];
    
    UIButton *saoyisao = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(310), JZWITH(15), JZWITH(22), JZWITH(18))];
    [nav addSubview:saoyisao];
    [saoyisao addTarget:self action:@selector(codeScan) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *sao = [[UIImageView alloc]initWithFrame:CGRectMake(0, JZWITH(15), saoyisao.width, saoyisao.height)];
    sao.image = Imaged(@"home_icon_scan");
    sao.userInteractionEnabled = NO;
    [saoyisao addSubview:sao];
    
//    UILabel *saoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, sao.bottom + 3, saoyisao.width, 10)];
//    saoLabel.text = @"扫一扫";
//    saoLabel.textColor = [UIColor whiteColor];
//    saoLabel.textAlignment = 1;
//    saoLabel.userInteractionEnabled = NO;
//    saoLabel.font = JZFont(9);
//    [saoyisao addSubview:saoLabel];
    
//    UIButton *searchButton1 = [[UIButton alloc]initWithFrame:CGRectMake(searchButton.right+5, JZWITH(11), JZWITH(20), JZHEIGHT(22))];
//    //    searchButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
////    searchButton1.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    searchButton1.layer.cornerRadius = 4;
//    searchButton1.layer.masksToBounds = YES;
//    searchButton1.backgroundColor  =[UIColor whiteColor];
//
////    [searchButton1 addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
//    [nav addSubview:searchButton1];
//
//    UIImageView *shou = [[UIImageView alloc]initWithFrame:CGRectMake(0, JZWITH(0), saoyisao.width, saoyisao.height)];
//    shou.image = Imaged(@"shousuo");
//    shou.userInteractionEnabled = NO;
//    [searchButton1 addSubview:shou];
    
    UIButton *xiaoxi = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(346), JZWITH(16), JZWITH(20), JZWITH(20))];
    [nav addSubview:xiaoxi];
    [xiaoxi addTarget:self action:@selector(goMes) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *xiao = [[UIImageView alloc]initWithFrame:CGRectMake(0, JZWITH(14), xiaoxi.width, xiaoxi.height)];
    xiao.image = Imaged(@"message");
    xiao.userInteractionEnabled = NO;
    [xiaoxi addSubview:xiao];
}

//首页选择的
-(void)initiaHearderSelectUI{
    TuiJianViewController * tuijianVC = [[TuiJianViewController alloc]init];
    NYNLiveListViewController *oneVC = [[NYNLiveListViewController alloc]init];
    ActivityViewController * activityVC = [[ActivityViewController alloc]init];
    LeaseViewController * leaseVC = [[LeaseViewController alloc]init];
    PlayViewController * playVC = [[PlayViewController alloc]init];

    NSArray *childArr = @[tuijianVC,oneVC, activityVC, leaseVC, playVC];
    CGFloat contentViewHeight = SCREENHEIGHT - 64;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];

    NSArray *titleArr = @[@"推荐",@"直播",@"活动", @"租地", @"比赛"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, SCREENWIDTH, 34) delegate:self titleNames:titleArr];
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

#pragma 城市定位
- (void)pushToSearch{
    //定位界面
    LocationViewController * locationVC=[[LocationViewController alloc]init];
    locationVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:locationVC animated:YES];
}

#pragma 搜索
- (void)goSearch{
    FTSearchViewController *vc = [[FTSearchViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mes系统消息
- (void)goMes{
    NEInfoViewController *vc = [[NEInfoViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma 扫描二维码
- (void)codeScan{
    FTCodeScanViewController *vc = [[FTCodeScanViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex{
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
- (void)livePage{
    [self seletIndex:1];
}
- (void)active{
    [self seletIndex:2];
}

- (void)seletIndex:(NSInteger)idedx{
    NSArray *titleArr = @[@"推荐",@"直播",@"活动", @"租地", @"比赛"];
    [self.pageTitleView removeFromSuperview];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, SCREENWIDTH, 34) delegate:self titleNames:titleArr];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isIndicatorScroll = NO;
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeSpecial;
    _pageTitleView.selectedIndex = idedx;
    _pageTitleView.isNeedBounces = NO;
    _pageTitleView.titleColorStateSelected = Color90b659;
    _pageTitleView.indicatorColor = Color90b659;
    _pageTitleView.titleColorStateNormal = Color686868;
}

-(NSMutableArray *)bannnerDataArr{
    if (!_bannnerDataArr) {
        _bannnerDataArr = [[NSMutableArray alloc]init];
    }
    return _bannnerDataArr;
}

@end
