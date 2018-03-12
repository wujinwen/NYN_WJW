//
//  TuiJianViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/22.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "TuiJianViewController.h"

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

#import "SGPageView.h"
#import "NYNHuoDongViewController.h"
#import "NYNAuctionModel.h"

@interface TuiJianViewController ()<UITableViewDelegate,UITableViewDataSource,GCDAsyncSocketDelegate>

@property (nonatomic,strong) UITableView *homeTable;
@property (nonatomic,strong) NSArray *picArr;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *detailArr;

@property (nonatomic,strong) NSMutableArray *bannnerDataArr;

@property (nonatomic,strong) NSMutableArray *liveDataArr;//直播数组

@property(nonatomic,strong)NSMutableArray * marketArray;//集市数组
@property(nonatomic,strong)NSMutableArray * agritmntArray;//农家乐
@property(nonatomic,strong)NSMutableArray * activityArr;//活动
@property(nonatomic,strong)NSMutableArray * paimaiArr;//拍卖

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@property (nonatomic,strong) FTBannerScrollTableViewCell *bannerCell;


@property (nonatomic,strong) GCDAsyncSocket *socket;

@end

@implementation TuiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeTable.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    //农场显示
    [self getData];
    //直播显示
    [self liveData];
    //首页集市
    [self marketData];
    //活动列表
    [self activityListData];
    //农家乐
    // [self getagritmntData];
    
    [self configData];
    //拍卖
    [self paimai];
    
    

    
    [self createTable];

    _liveDataArr = [[NSMutableArray alloc]init];
    _marketArray = [[NSMutableArray alloc]init];
    _agritmntArray = [[NSMutableArray alloc]init];
    _activityArr = [[NSMutableArray alloc]init];
    _paimaiArr = [[NSMutableArray alloc]init];
}
//下拉刷新
-(void)refreshData{
    [self getData];
    //直播显示
    [self liveData];
    
}

#pragma mark---GCDAsyncSocketDelegate
//链接成功
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    
}
//链接失败
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    
    
}

- (void)getData{
    
    NSDictionary * locDic = JZFetchMyDefault(SET_Location);
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
    NSDictionary *dic = @{@"pageNo":@"1",@"pageSize":@"3",@"orderType":@"multiple",@"type":@"monitor"};
    
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
    NSDictionary * locDic = JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"] ?: @"";
    NSString *lon =locDic[@"lon"] ?: @"";
  
    
    NSMutableDictionary *dic = @{@"longitude":lon,
                                 @"latitude":lat,
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
//拍卖
-(void)paimai{
    NSDictionary * dic = @{};
    
    [NYNNetTool QuerySaleHomeParams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
                _paimaiArr =success[@"data"];
                [self.homeTable reloadData];
            
            
            
        }else{
            
        }
    } failure:^(NSError *failure) {
        
        
    }];
}
//农家乐
-(void)getagritmntData{
    
    //    NSDictionary *locationDic = JZFetchMyDefault(@"location");
    //    NSString *lat = locationDic[@"lat"];
    //    NSString *lon = locationDic[@"lon"];
  
    
    NSDictionary * locDic = JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"] ?: @"";
    NSString *lon =locDic[@"lon"] ?: @"";
    NSString *province = locDic[@"province"] ?: @"";
    NSString *city = locDic[@"city"] ?: @"";
    
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
    self.picArr = @[@"shouye",@"zhibo",@"paimai",@"jishi",@"huodong"];
    //本月热门店铺推荐
//    self.detailArr = @[@"",@"热门直播",@"本月热销农产品",@"热门活动推荐",@"热门农家乐推荐"];
    self.detailArr = @[@"店铺",@"直播",@"拍卖",@"集市",@"活动"];
    
}
- (void)createTable{
    self.homeTable.delegate = self;
    self.homeTable.dataSource = self;
    self.homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTable.showsVerticalScrollIndicator = NO;
    self.homeTable.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.homeTable];
}

//获取农场直播信息
-(void)getFarmLiveInfoData{

    
    
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
        
       __weak typeof(self) weakSelf = self;
        bannerCell.buttonAction = ^(FTHomeButton *sender) {
               NYNFarmCellModel *model = weakSelf.bannnerDataArr[sender.indexFB];
            //农场直播详情
            [NYNNetTool GetFarmLiveInfoWithparams:@{@"farmId":model.Id} isTestLogin:NO progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                NSLog(@"---------------%@",success);
                
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                    //            NYNLiveListModel *model = [NYNLiveListModel mj_objectWithKeyValues:dic];
                    //            [self.dataArr addObject:model];
                    //            self.headerDataModel = [NYNWisDomModel mj_objectWithKeyValues:success[@"data"][@"farm"]];
                    //
                    //            NSArray *productNameDataArr = [NSArray arrayWithArray:success[@"data"][@"farm"][@"farmBusinessList"]];
                    //            for (NSDictionary *dic in productNameDataArr) {
                    //                NYNProductNameModel *model = [NYNProductNameModel mj_objectWithKeyValues:dic];
                    //
                    //                [self.productNameArr addObject:model];
                    //            }
                    
                 
              
                    PersonalCenterVC *vc = [PersonalCenterVC new];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.ID = model.Id;
                    NSArray * arr =success[@"data"];
                    if (arr.count>0) {
                      vc.playUrl = success[@"data"][0][@"rtmpPull"];
                        vc.LiveID= success[@"data"][0][@"id"];
                        if ([success[@"data"][0][@"type"] isEqualToString:@"live"]) {
                              vc.islive =YES;
                             vc.chatId =[NSString stringWithFormat:@"%@",success[@"data"][0][@"id"]];
                        }
                    }
                   
                    
                    vc.farmName = model.name;
              
                    
                    vc.ctype = @"farm";
                    
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    
                }
            } failure:^(NSError *failure) {
                
                
                
                
            }];
      
 
            
            
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
                [pic addObject:[str isKindOfClass:[NSNull class]] ? @"" : str];
                NSString * str1 = self.liveDataArr[i][@"title"];
                [name addObject:str1.length > 0 ? str1 : @""];
            }
            
            [functionChooseCell getLivePicArray:pic textArray:name];
        }
        
        
        
        functionChooseCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return functionChooseCell;
    }
    else if ((indexPath.section == 2)){
        
        NYNNongJiaLeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNNongJiaLeTableViewCell class]) owner:self options:nil].firstObject;
        }
        if (_picArr.count>0) {
            farmLiveTableViewCell.totalArray = _paimaiArr;
            
        }
        
        return farmLiveTableViewCell;
        
        
    }
    else if (indexPath.section == 3) {
        
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
    //
    else if (indexPath.section == 4) {
//        //农家乐 NYNNongJiaLeTableViewCell
//        NYNNongJiaLeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//        if (farmLiveTableViewCell == nil) {
//            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNNongJiaLeTableViewCell class]) owner:self options:nil].firstObject;
//        }
//        if (_agritmntArray.count>0) {
//            farmLiveTableViewCell.totalArray = _agritmntArray;
//
//        }
//
//        return farmLiveTableViewCell;
//
        
        //活动
        FTFarmLiveTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTFarmLiveTableViewCell class]) owner:self options:nil].firstObject;
        }
    
            if (_activityArr.count>0) {
                farmLiveTableViewCell.totalArr = _activityArr;

            }
    
        

       //活动cell点击
        farmLiveTableViewCell.activityClick = ^(NSInteger selectCount) {
            //  活动详情
            NYNHuoDongViewController * huodongVC = [[NYNHuoDongViewController alloc]init];
            [self.navigationController pushViewController:huodongVC animated:YES];
            
            
            
        };
        

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
            return JZHEIGHT(150);
            
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
        _homeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 34, SCREENWIDTH, SCREENHEIGHT - 64 - 50-40) style:UITableViewStyleGrouped];
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
