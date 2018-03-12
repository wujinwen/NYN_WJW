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
@interface NYNHomeViewController ()<UITableViewDelegate,UITableViewDataSource,GCDAsyncSocketDelegate,SGPageTitleViewDelegate, SGPageContentViewDelegate,LocationViewDelagate>
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
    //由于需求的变化下面分为多个controller控制。所有的请求都注释了
    
//    BOOL isConnect = [self.socket connectToHost:@"" onPort:@"" error:nil];
    
   // self.homeTable.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
  //农场显示
  //  [self getData];
    //直播显示
   // [self liveData];
    //首页集市
   // [self marketData];
    //活动列表
   // [self activityListData];
    //农家乐
   // [self getagritmntData];
    
    [self configData];
    
    [self createHomeUI];
    
  //  [self createTable];
    [self initiaHearderSelectUI];
//    _liveDataArr = [[NSMutableArray alloc]init];
//    _marketArray = [[NSMutableArray alloc]init];
//    _agritmntArray = [[NSMutableArray alloc]init];
//    _activityArr = [[NSMutableArray alloc]init];
    
    
    
    
    

}
////下拉刷新
//-(void)refreshData{
//    [self getData];
//    //直播显示
//    [self liveData];
//
//}

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

- (void)getData{
   
    NSDictionary * locDic =JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"] ?: @"";
    NSString *lon =locDic[@"lon"] ?: @"";
    NSString *province = locDic[@"province"] ?: @"";
    NSString *city = locDic[@"city"] ?: @"";
    
    
    NSMutableDictionary *dic = @{@"longitude":lon?:@"",@"latitude":lat?:@"",@"sort":@"normal",@"pageNo":@"1",@"pageSize":@"10",@"province":province,@"city":city,@"orderBy":@"asc"}.mutableCopy;
    
    [self showLoadingView:@""];
    [dic setObject:@"farm" forKey:@"type"];
    
    
    [self showLoadingView:@""];
    
    [NYNNetTool FarmPageResquestWithparams:dic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        [self.bannnerDataArr removeAllObjects];
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNFarmCellModel *model = [NYNFarmCellModel mj_objectWithKeyValues:dic];
                [self.bannnerDataArr addObject:model];
            }
            
            [self.homeTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self endRefresh];
        [self hideLoadingView];
        
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
     [self endRefresh];
        
    }];
}


//直播显示

-(void)liveData{
    NSDictionary *dic = @{@"pageNo":@"1",@"pageSize":@"3",@"orderType":@"multiple"};
    
    [NYNNetTool PostLiveListWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            _liveDataArr = success[@"data"];
            [self.homeTable reloadData];
            [self endRefresh];
            [self hideLoadingView];
        }
    
    } failure:^(NSError *failure) {
          [self endRefresh];
    }];
}
//集市列表
-(void)marketData{
    [NYNNetTool HomeMarketParams:@{} isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            _marketArray =success[@"data"];
            [self.homeTable reloadData];
        }
      
        
    } failure:^(NSError *failure) {
        
        
    }];
    
}
//活动列表

-(void)activityListData{
//    NSDictionary *locationDic = JZFetchMyDefault(@"location");
//    NSString *lat = locationDic[@"lat"];
//    NSString *lon = locationDic[@"lon"];
      UserInfoModel * model = userInfoModel;

    NSMutableDictionary *dic = @{@"longitude":JZFetchMyDefault(SET_Location)[@"lat"] ? : @"",
                                 @"latitude":JZFetchMyDefault(SET_Location)[@"lon"] ? : @"",
                                 @"orderType":@"position",
                                 @"pageNo":@"1",
                                 @"pageSize":@"3",
                                 @"orderBy":@"asc"}.mutableCopy;
    [NYNNetTool ActivityListParams:dic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            _activityArr =success[@"data"];
            [self.homeTable reloadData];
        }
        
        
    } failure:^(NSError *failure) {
        
        
    }];
    
    
    
}
//农家乐
-(void)getagritmntData{
   
//    NSDictionary *locationDic = JZFetchMyDefault(@"location");
//    NSString *lat = locationDic[@"lat"];
//    NSString *lon = locationDic[@"lon"];
//         UserInfoModel * model = userInfoModel;
    NSDictionary * locDic =JZFetchMyDefault(SET_Location);

    NSString *lat = locDic[@"lat"];
    NSString *lon = locDic[@"lon"];
 
    NSString *province =  locDic[@"province"] ?: @"";
    NSString *city =  locDic[@"city"] ?: @"";
    
    NSMutableDictionary *dic = @{@"longitude":lon,@"latitude":lat,@"sort":@"normal",@"pageNo":@"1",@"pageSize":@"4",@"province":province,@"city":city,@"orderBy":@"asc"}.mutableCopy;
    
    [self showLoadingView:@""];
    [dic setObject:@"agritmnt" forKey:@"type"];
    
    
    [self showLoadingView:@""];
    
    [NYNNetTool FarmPageResquestWithparams:dic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            self.agritmntArray =success[@"data"];
            [self.homeTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self hideLoadingView];
        
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
        
    }];
    
}


- (void)endRefresh{
    [self.homeTable.mj_header endRefreshing];
}
//collectionview头部标题
- (void)configData{
    self.picArr = @[@"home_title_farm",@"home_title_live",@"home_title_market",@"home_title_activity",@"home_title_njl"];
    //本月热门店铺推荐
    self.detailArr = @[@"",@"热门直播",@"本月热销农产品",@"热门活动推荐",@"热门农家乐推荐"];

}

- (void)createHomeUI{
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
    
//    UILabel *xiaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, sao.bottom + 3, xiaoxi.width, 10)];
//    xiaoLabel.text = @"消息";
//    xiaoLabel.textAlignment = 1;
//    xiaoLabel.textColor = [UIColor whiteColor];
//    xiaoLabel.userInteractionEnabled = NO;
//    xiaoLabel.font = JZFont(9);
//    [xiaoxi addSubview:xiaoLabel];
    
    
    
    
}

//首页选择的
-(void)initiaHearderSelectUI{
//    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
//    nav.backgroundColor =[UIColor whiteColor];
//    [self.view addSubview:nav];
//    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, nav.width, nav.height)];
//    backImageView.image = Imaged(@"public_title bar");
//    [nav addSubview:backImageView];
//
//    //    NSMutableArray * navArr = [NSMutableArray arrayWithObjects:@"直播",@"活动",@"拍卖",@"租地",@"比赛", nil];
//    NSMutableArray * navArr = [NSMutableArray arrayWithObjects:@"推荐",@"直播",@"活动",@"租地",@"比赛", nil];
//    /// pageTitleView
//
//    YJSegmentedControl * segment3 = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 20, SCREENWIDTH, 64-20) titleDataSource:navArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor whiteColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor whiteColor] buttonDownColor:nil Delegate:self];
//    segment3.onlyMenu = YES;
////    UIColor * color =Color90b659;
////    segment3.backgroundColor =Color8;
//    segment3.backgroundColor =[UIColor clearColor];
//
//    [nav addSubview:segment3];
    
    
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
#pragma mark -- 遵守代理 实现代理方法
//- (void)segumentSelectionChange:(NSInteger)selection{
//    if (selection == 0) {
//
//
//    }else if (selection == 1){
//        //点击直播
//        NYNLiveListViewController *vc = [[NYNLiveListViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }else if (selection == 2){
//        //农家乐
////        AgritmntViewController * agritVC = [[AgritmntViewController alloc]init];
////         agritVC.hidesBottomBarWhenPushed = YES;
////        [self.navigationController pushViewController:agritVC animated:YES];
//
//        //活动
//        ActivityViewController * activityVC = [[ActivityViewController alloc]init];
//        activityVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:activityVC animated:YES];
//
//
//    }else if (selection == 3){
//        //租地
//        LeaseViewController * leaseVC = [[LeaseViewController alloc]init];
//        [self.navigationController pushViewController:leaseVC animated:YES];
//
//
//
//    }else if (selection == 4){
//        //比赛
//        PlayViewController * playVC = [[PlayViewController alloc]init];
//         playVC.hidesBottomBarWhenPushed = YES;
//          [self.navigationController pushViewController:playVC animated:YES];
//
//    }
//
//}

//- (void)createTable{
//    self.homeTable.delegate = self;
//    self.homeTable.dataSource = self;
//    self.homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.homeTable.showsVerticalScrollIndicator = NO;
//    self.homeTable.showsHorizontalScrollIndicator = NO;
//    [self.view addSubview:self.homeTable];
//}

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
- (void)click{
    NSLog(@"ghsjdghf");
}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    
     if ((indexPath.section == 0) && (indexPath.row == 0)){
        //直播,活动农家乐cell
        FTCategoryTableViewCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:@"scrollTextCell"];
        if (bannerCell == nil) {
            bannerCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTCategoryTableViewCell class]) owner:self options:nil].firstObject;
        }
        bannerCell.selectionStyle = UITableViewCellSelectionStyleNone;
         NSMutableArray * picArr = [[NSMutableArray alloc]init];
         NSMutableArray * nameArr = [[NSMutableArray alloc]init];
         
         if (self.bannnerDataArr.count >0) {
             NSInteger  a = 6;
             if (self.bannnerDataArr.count<6) {
                 a = self.bannnerDataArr.count;
             }
             for (int i = 0; i <a; i++) {
                 NSString * str  =   [self.bannnerDataArr[i] img];
                 [picArr addObject:str];

                 NSString * nameS = [self.bannnerDataArr[i] name];
                 [nameArr addObject:nameS];

             }


             [bannerCell getDataListArr:picArr textArray:nameArr];
             
    
         }
       
         
        bannerCell.buttonAction = ^(FTHomeButton *sender) {
            NYNFarmCellModel *model = self.bannnerDataArr[sender.indexFB];

            PersonalCenterVC *vc = [PersonalCenterVC new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = model.Id;
            vc.farmName = model.name;

            vc.ctype = @"farm";

            [self.navigationController pushViewController:vc animated:YES];
            
            
//            switch (sender.indexFB) {
//                case 0:
//                {
////                    FTMarketViewController *vc = [[FTMarketViewController alloc]init];
////                    vc.hidesBottomBarWhenPushed = YES;
////                    [weakself.navigationController pushViewController:vc animated:YES];
//                }
//                    break;
//                case 1:
//                {
////                    //点击直播
////                    NYNLiveListViewController *vc = [[NYNLiveListViewController alloc]init];
////                    vc.hidesBottomBarWhenPushed = YES;
////                    [self.navigationController pushViewController:vc animated:YES];
//
//                }
//                    break;
//                default:
//                    break;
//            }
        };
        return bannerCell;
    }
    
    
    else if ((indexPath.section == 1)){
        //直播推荐
        FTHomeFunctionChooseTableViewCell *functionChooseCell = [tableView dequeueReusableCellWithIdentifier:@"HomeFunctionChooseTableViewCell"];
        if (functionChooseCell == nil) {
            functionChooseCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTHomeFunctionChooseTableViewCell class]) owner:self options:nil].firstObject;
        }
        NSMutableArray * pic = [[NSMutableArray alloc]init];
        NSMutableArray * name = [[NSMutableArray alloc]init];
        
        if (_liveDataArr.count>0) {
            for (int i =0 ; i<self.liveDataArr.count; i++) {
                NSString * str = self.liveDataArr[i][@"pimg"];
                [pic addObject:str];
                NSString * str1 = self.liveDataArr[i][@"title"];
                [name addObject:str1];
              
            }
            
            [functionChooseCell getLivePicArray:pic textArray:name];
        }

  
        
        functionChooseCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        functionChooseCell.buttonAction = ^(NYNLiveButton *sender) {
            NYNFarmCellModel *model = self.bannnerDataArr[sender.indexFB];
            
            PersonalCenterVC *vc = [PersonalCenterVC new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = model.Id;
            vc.farmName = model.name;
            
            vc.ctype = @"farm";
            
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        
        return functionChooseCell;
    }
    else if ((indexPath.section == 2)){
        
        //集市
        FTFarmRecommendTableViewCell *teachCell = [tableView dequeueReusableCellWithIdentifier:@"teachCell"];
        if (teachCell == nil) {
            teachCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTFarmRecommendTableViewCell class]) owner:self options:nil].firstObject;
        }

        if (_marketArray.count>0) {
            teachCell.dataArray =_marketArray;
        }
      
        
        teachCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return teachCell;
    }
    else if (indexPath.section == 3) {
        
        //活动
        FTFarmLiveTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTFarmLiveTableViewCell class]) owner:self options:nil].firstObject;
        }
        if (_activityArr.count>0) {
            farmLiveTableViewCell.totalArr = _activityArr;

        }
        
        return farmLiveTableViewCell;
    }
    //
    else if (indexPath.section == 4) {
    //农家乐 NYNNongJiaLeTableViewCell
        NYNNongJiaLeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNNongJiaLeTableViewCell class]) owner:self options:nil].firstObject;
        }
        if (_agritmntArray.count>0) {
            farmLiveTableViewCell.totalArray = _agritmntArray;

        }
        
        return farmLiveTableViewCell;
    }else{
        NYNNongJiaLeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNNongJiaLeTableViewCell class]) owner:self options:nil].firstObject;
        }
        return farmLiveTableViewCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
                return JZHEIGHT(140*2);

        }
            break;
        case 1:
        {
            return JZHEIGHT(150);
        }
            break;
        case 2:
        {
            return JZHEIGHT(140);
        }
            break;
        case 3:
        {
            return JZHEIGHT(150);
            
        }
            break;
        case 4:
        {
            return JZHEIGHT(140);
            
        }
            break;
        default:
        {
            return 10;
        }
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   //农场hearder
    NYNHomeHeaderView *headerView = [[NYNHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(40)) Image:self.picArr[section] Title:@"" DetailTitle:self.detailArr[section]];
//    if (section == 2 || section == 4) {
//        headerView.backgroundColor = [UIColor colorWithHexString:@"eef4e5"];
//    }else{
        headerView.backgroundColor = [UIColor whiteColor];
 //   }
    __weak typeof(self)weakSelf = self;
    headerView.bcc = ^(NSString *s) {
        if (section==3) {
//            NYNMarketViewController * marketVC = [[NYNMarketViewController alloc]init];
//            [weakSelf.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>]
        }
        if (weakSelf.TiaoZhuan) {
          
            weakSelf.TiaoZhuan(s);
        }

    };
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return JZHEIGHT(40);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //#import "WFactivityViewController.h"
    
    
}
#pragma 懒加载
-(UITableView *)homeTable
{
    if (!_homeTable) {
        _homeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, SCREENWIDTH, SCREENHEIGHT - 64 - 50-40) style:UITableViewStyleGrouped];
    }
    return _homeTable;
}



-(NSMutableArray *)bannnerDataArr{
    if (!_bannnerDataArr) {
        _bannnerDataArr = [[NSMutableArray alloc]init];
    }
    return _bannnerDataArr;
}

@end
