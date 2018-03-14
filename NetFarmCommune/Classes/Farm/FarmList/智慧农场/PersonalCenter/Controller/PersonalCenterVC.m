//
//  PersonalCenterVC.m
//  SGPageViewExample
//
//  Created by apple on 2017/6/15.
//  Copyright © 2017年 Sorgle. All rights reserved.
//农场直播

#import "PersonalCenterVC.h"
#import "PersonalCenterTableView.h"
#import "PersonalCenterTopView.h"
#import "SGPageView.h"
#import "UIView+SGFrame.h"

#import "FTCultivateViewController.h"
#import "FTFarmProduceViewController.h"
#import "FTExerciseViewController.h"
#import "FTFoodViewController.h"
#import "FTFarmFlockViewController.h"
#import "NYNZhongZhiViewController.h"
#import "NYNZhuSuViewController.h"
#import <UShareUI/UShareUI.h>
#import "SDCycleScrollView.h"
#import "NYNProductNameModel.h"
#import "NYNWisDomModel.h"

#import "FarmChatViewController.h"
#import "FarmAuctionViewController.h"
#import "YJSegmentedControl.h"


#import "ChildLiveOne.h"
#import "ChildVideoView.h"
#import "NYNLiveRoomViewController.h"
#import "SaleEditViewController.h"
#import "ZWPullMenuView.h"

@interface PersonalCenterVC () <UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource, SGPageTitleViewDelegate, SGPageContentViewDelegate, PersonalCenterChildBaseVCDelegate,ChildLiveOneDelagate>
{
    ChildLiveOne * liveV;
    ChildVideoView * childV;
}
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic, strong) PersonalCenterTableView *tableView;
@property (nonatomic, strong) PersonalCenterTopView *topView;
@property (nonatomic, strong) UIScrollView *childVCScrollView;

@property (nonatomic, strong)FarmChatViewController * chatVC;

//头部数据模型
@property (nonatomic,strong) NYNWisDomModel *headerDataModel;
//装标题的数组
@property (nonatomic, strong) NSMutableArray *productNameArr;
//是否已经收藏
@property (nonatomic,assign) BOOL isCollection;

@property (nonatomic,strong) UIImageView *colletionImageView;

@property (nonatomic,copy) NSString *collectionID;

@property (nonatomic,strong) SDCycleScrollView *bannerScrollView;

@property (nonatomic,assign) int dataCount;

@property (nonatomic,strong) NSArray *childViewControllerss;
@end

@implementation PersonalCenterVC

static CGFloat const PersonalCenterVCPageTitleViewHeight = 41;
static CGFloat const PersonalCenterVCNavHeight = 0;
static CGFloat const PersonalCenterVCTopViewHeight = 171;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataCount = 6;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageNo = 1;
    self.pageSize = 10;
    //右侧按钮
//    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"拍卖" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
//    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home_icon_more_2"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
//
//    rightBarItem.style = UIBarButtonItemStyleDone;
    
    UIButton *button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(onClickedOKbtn:) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"home_icon_more_2" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"椭圆2770"] forState:UIControlStateNormal];
    
    UIBarButtonItem *rb = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rb;
 
    [self showLoadingView:@""];
    //查询农场信息
    [NYNNetTool FarmWisdomResquestWithparams:@{@"id":self.ID} isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            self.headerDataModel = [NYNWisDomModel mj_objectWithKeyValues:success[@"data"][@"farm"]];
            NSArray *productNameDataArr = [NSArray arrayWithArray:success[@"data"][@"farm"][@"farmCategories"]];
            for (NSDictionary *dic in productNameDataArr) {
                if ([dic[@"categoryId"] integerValue] != 72 && [dic[@"categoryId"] integerValue] != 76 && [dic[@"categoryId"] integerValue] != 77 && [dic[@"categoryId"] integerValue] != 78 && [dic[@"categoryId"] integerValue] != 78 && [dic[@"categoryId"] integerValue] != 80 && [dic[@"categoryId"] integerValue] != 81 && [dic[@"categoryId"] integerValue] != 82 && [dic[@"categoryId"] integerValue] != 83) {
                    
                    NYNProductNameModel *model = [NYNProductNameModel mj_objectWithKeyValues:dic];
                    
                    [self.productNameArr addObject:model];
                }
            }
         //   [self setWisdomScrollView];
            [self foundTableView];
            //设置导航栏UI
            [self setNav];
            
            [self showLoadingView:@""];
            
            [self hideLoadingView];
            
        }else{
            [self hideLoadingView];
            
        }
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //界面跳转回来继续播放视频
    dispatch_async(dispatch_get_main_queue(), ^{
        [liveV.player play];

    });
}
//导航栏右侧拍卖
-(void)onClickedOKbtn:(UIButton*)sender{
//    SaleEditViewController * saleVC = [[SaleEditViewController alloc]init];
//    saleVC.farmName=_farmName;
//    [self.navigationController pushViewController:saleVC animated:YES];
    
    
    NSArray *titleArray = @[@"分享",@"收藏",@"店铺资料"];
    NSArray *imageArray = @[@"矢量智能对象",
                            @"矢量智能对象2",
                            @"矢量智能对象3"];
    ZWPullMenuView *menuView = [ZWPullMenuView pullMenuAnchorView:sender
                                                       titleArray:titleArray
                                                       imageArray:imageArray];
    menuView.zwPullMenuStyle = PullMenuDarkStyle;
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        switch (menuRow) {
            case 0:
                [self shareLive];
                
                
                break;
            case 1:
            {
                [self colloectFarm];
                
            }
                break;
            case 2:
            {
                SaleEditViewController * saleVC = [[SaleEditViewController alloc]init];
                saleVC.farmName=_farmName;
                [self.navigationController pushViewController:saleVC animated:YES];
                
            }
                break;
                
            
                
            default:
                break;
        }
    };
}

//直播分享网页链接
-(void)shareLive{
    
    //显示分享面板
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_Qzone)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {

        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        NSString * str =[NSString stringWithFormat:@"http://help.dawangkeji.com/farm-live/index.html?farmId=%@&liveId=%@",self.ID,_LiveID];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"网农公社直播" descr:nil thumImage:nil];

    shareObject.webpageUrl = str;

    messageObject.shareObject = shareObject;
    
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {

            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
          
        }];
    
    }];
    
    
     }


//收藏
-(void)colloectFarm{
    [NYNNetTool ZengJiaShouCangWithparams:@{@"cid":self.ID,@"ctype":@"farm"} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        [self hideLoadingView];
        if ([[NSString stringWithFormat:@"%@",success[@"code"]]isEqualToString:@"200"]) {
            self.colletionImageView.image = Imaged(@"mine_icon_collection");
            [self showTextProgressView:@"收藏成功"];
            self.isCollection = !self.isCollection;
        }else{
             [self showTextProgressView:success[@"msg"]];
        }

    } failure:^(NSError *failure) {
        [self hideLoadingView];
        
    }];
}

- (void)foundTableView {
    [self.view addSubview:self.pageTitleView];
    [self.view addSubview:self.pageContentView];
}
#pragma mark---ChildLiveOneDelagate
- (void)telphone{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.headerDataModel.phone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
//开始直播
-(void)startLiveDelagate:(UIButton *)sender{
    //链接融云服务器
    NYNLiveRoomViewController *chatRoomVC = [[NYNLiveRoomViewController alloc]init];
     chatRoomVC.isVertical = YES;
      chatRoomVC.farmId = self.ID;
      chatRoomVC.fps  =10;
      chatRoomVC.kbps  =400;
      [self.navigationController pushViewController:chatRoomVC animated:NO];
}
//全屏播放

-(void)quanpingBtnDelagate:(UIButton *)sender{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
//退出全屏
-(void)playerTapGesDelagete{
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (PersonalCenterTopView *)topView {
    if (!_topView) {
        _topView = [PersonalCenterTopView SG_loadViewFromXib];
        _topView.frame = CGRectMake(0, 0, 0, PersonalCenterVCTopViewHeight);
    }
    return _topView;
}

- (SGPageTitleView *)pageTitleView {
    if (!_pageTitleView) {
        NSMutableArray *productNameArray = [[NSMutableArray alloc]init];
        NSString * str = @"聊天";
        [productNameArray addObject:str];
    
        
        for (NYNProductNameModel *model in self.productNameArr) {
            [productNameArray addObject:model.name];
        }
//        NSString * str1 = @"拍卖";
//        [productNameArray addObject:str1];
        
        NSArray *titleArr = [NSArray arrayWithArray:productNameArray];
        /// pageTitleView
        _pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, JZWITH(230), self.view.frame.size.width, PersonalCenterVCPageTitleViewHeight) delegate:self titleNames:titleArr];
        _pageTitleView.backgroundColor = [UIColor whiteColor];
        _pageTitleView.indicatorColor = Color90b659;
        _pageTitleView.titleColorStateNormal = Color383938;
        _pageTitleView.titleColorStateSelected = Color90b659;
        _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeEqual;
        
        for (int i = 0; i < self.productNameArr.count; i++) {
        //    NYNProductNameModel *model = self.productNameArr[i];
            UIButton *bt = _pageTitleView.btnMArr[i];
            bt.titleLabel.font = JZFont(15);
//            if ([model.type isEqualToString:@"1"]) {
////                UIButton *bt = _pageTitleView.btnMArr[i];
//                CGFloat textWith = [MyControl getTextWith:model.name andHeight:JZHEIGHT(13) andFontSize:8];
//                UILabel *zhuKLabel = [[UILabel alloc]initWithFrame:CGRectMake(bt.width / 2 + textWith / 2 + JZWITH(3) , JZHEIGHT(7), JZWITH(13), JZHEIGHT(13))];
//                zhuKLabel.backgroundColor = [UIColor redColor];
//                zhuKLabel.font = JZFont(8);
//                zhuKLabel.textColor = [UIColor whiteColor];
//                zhuKLabel.text = @"主";
//                zhuKLabel.layer.cornerRadius = JZWITH(6.5);
//                zhuKLabel.layer.masksToBounds = YES;
//                zhuKLabel.textAlignment = 1;
//                [bt addSubview:zhuKLabel];
//            }
        }
    }
    return _pageTitleView;
}


- (SGPageContentView *)pageContentView {
    if (!_pageContentView) {

        NSMutableArray *ssarr = [[NSMutableArray alloc]init];
        _chatVC= [[FarmChatViewController alloc]init];
        _chatVC.targetId  =self.islive?self.chatId:_ID;//看直播就用会话id,否则(监控)就用farmid
        _chatVC.zhuboId = self.userId;
        
        _chatVC.farmName = _farmName;
        _chatVC.conversationType = ConversationType_CHATROOM;
        [ssarr addObject:_chatVC];
        
        for (NYNProductNameModel * model in self.productNameArr) {
            if ([model.categoryId isEqualToString:@"68"]){
                //拍卖
                FarmAuctionViewController * auctionVC = [[FarmAuctionViewController alloc]init];
                //传入农场id
                [auctionVC getDataFarmIDString:self.headerDataModel.Id];
                [ssarr addObject:auctionVC];
            }
             else if ([model.categoryId isEqualToString:@"69"]) {
                //代种
                NYNZhongZhiViewController *oneVC = [[NYNZhongZhiViewController alloc]init];
                oneVC.categoryId = model.ID;
                oneVC.farmId = self.headerDataModel.Id;
                oneVC.pageNo = 1;
                oneVC.pageSize = 100;
                [oneVC updateData];
                oneVC.delegatePersonalCenterChildBaseVC = self;
                [ssarr addObject:oneVC];
                
            }
            else if ([model.categoryId isEqualToString:@"70"]){
                //代养
                FTCultivateViewController *twoVC = [[FTCultivateViewController alloc]init];
                twoVC.categoryId = model.ID;
                twoVC.farmId = self.headerDataModel.Id;
                twoVC.pageNo = 1;
                twoVC.pageSize = 100;
                [twoVC updateData];
                twoVC.delegatePersonalCenterChildBaseVC = self;
                [ssarr addObject:twoVC];

            }
            else if ([model.categoryId isEqualToString:@"71"]){
                //农产品
                FTFarmProduceViewController *threeVC = [[FTFarmProduceViewController alloc]init];
                threeVC.categoryId = model.ID;
                threeVC.farmId = self.headerDataModel.Id;
                threeVC.pageNo = 1;
                threeVC.pageSize = 100;
                [threeVC updateData];
                threeVC.delegatePersonalCenterChildBaseVC = self;
                [ssarr addObject:threeVC];

            }
            else if ([model.categoryId isEqualToString:@"73"]){
                //活动
                FTExerciseViewController *fourVC = [[FTExerciseViewController alloc]init];
                fourVC.categoryId = model.ID;
                fourVC.farmId = self.headerDataModel.Id;
                fourVC.pageNo = 1;
                fourVC.pageSize = 100;
                [fourVC updateData];
                fourVC.delegatePersonalCenterChildBaseVC = self;
                [ssarr addObject:fourVC];
            }
            else if ([model.categoryId isEqualToString:@"74"]){
                //餐饮
                FTFarmProduceViewController *threeVC = [[FTFarmProduceViewController alloc]init];
                threeVC.categoryId = model.ID;
                threeVC.farmId = self.headerDataModel.Id;
                threeVC.pageNo = 1;
                threeVC.pageSize = 100;
                [threeVC updateData];
                threeVC.delegatePersonalCenterChildBaseVC = self;
                [ssarr addObject:threeVC];
            }
            else if ([model.categoryId isEqualToString:@"75"]){
                //住宿
                FTFarmProduceViewController *threeVC = [[FTFarmProduceViewController alloc]init];
                threeVC.categoryId = model.ID;
                threeVC.farmId = self.headerDataModel.Id;
                threeVC.pageNo = 1;
                threeVC.pageSize = 100;
                [threeVC updateData];
                threeVC.delegatePersonalCenterChildBaseVC = self;
                [ssarr addObject:threeVC];
            }
            else if ([model.categoryId isEqualToString:@"79"]){
                //比赛
                FTFarmProduceViewController *threeVC = [[FTFarmProduceViewController alloc]init];
                threeVC.categoryId = model.ID;
                threeVC.farmId = self.headerDataModel.Id;
                threeVC.pageNo = 1;
                threeVC.pageSize = 100;
                [threeVC updateData];
                threeVC.delegatePersonalCenterChildBaseVC = self;
                [ssarr addObject:threeVC];
            }
        }
        
        FarmAuctionViewController * auctionVC = [[FarmAuctionViewController alloc]init];
        //传入农场id
        [auctionVC getDataFarmIDString:self.headerDataModel.Id];
        [ssarr addObject:auctionVC];
      
        
        NSArray *childArr = ssarr.copy;
        
        self.childViewControllerss = childArr;
        /// pageContentView
        CGFloat contentViewHeight = SCREENHEIGHT - PersonalCenterVCNavHeight - PersonalCenterVCPageTitleViewHeight-44-200-50;
        _pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, JZWITH(230) + PersonalCenterVCPageTitleViewHeight, SCREENWIDTH, contentViewHeight ) parentVC:self childVCs:childArr];
        _pageContentView.delegatePageContentView = self;
        
        __weak typeof(self) weakSelf = self;
        _pageTitleView.targetBack = ^(NSInteger index) {
            PersonalCenterChildBaseVC *vc = weakSelf.childViewControllerss[index];
            
            if (vc.dataArr.count < 1) {
                weakSelf.dataCount = 6;
            }else{
                weakSelf.dataCount = (int)vc.dataArr.count + 1;
            }
            
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
    return _pageContentView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.childVCScrollView && _childVCScrollView.contentOffset.y > 0) {
        self.tableView.contentOffset = CGPointMake(0, PersonalCenterVCTopViewHeight);
    }
    CGFloat offSetY = scrollView.contentOffset.y;
    
    NSLog(@"=============================================%f",offSetY);
    if (offSetY < PersonalCenterVCTopViewHeight) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pageTitleViewToTop" object:nil];
    }
}

- (void)personalCenterChildBaseVCScrollViewDidScroll:(UIScrollView *)scrollView {
    self.childVCScrollView = scrollView;
    if (self.tableView.contentOffset.y < PersonalCenterVCTopViewHeight) {
//        scrollView.contentOffset = CGPointZero;
//        scrollView.showsVerticalScrollIndicator = NO;
    } else {
        self.tableView.contentOffset = CGPointMake(0, PersonalCenterVCTopViewHeight);
      //  scrollView.showsVerticalScrollIndicator = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell.contentView addSubview:self.pageContentView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 41 + JZHEIGHT(11))];
    v.backgroundColor = Colore3e3e3;
    [v addSubview:self.pageTitleView];
    return v;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat contentViewHeight = SCREENHEIGHT - PersonalCenterVCNavHeight - PersonalCenterVCPageTitleViewHeight;

    float ht = (self.dataCount + 1 ) * JZHEIGHT(100);
    
    JZLog(@"高度%f",ht);
    
    return ht;
}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
 
        [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
        
        //    [self.tableView setRowHeight:selectedIndex * 400];
        
        PersonalCenterChildBaseVC *vc = self.childViewControllerss[selectedIndex];
        
        if (vc.dataArr.count < 1) {
            self.dataCount = 6;
        }else{
            self.dataCount = (int)(vc.dataArr.count) + 1;
        }
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    
    if (selectedIndex!=0) {
        [_chatVC.inputBar endEdit];
        _chatVC.inputBar.hidden = YES;
    }
    
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
  
        [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];

}

//设置头部视图
- (void)setWisdomScrollView{
    
    NSMutableArray *muArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.headerDataModel.images.count; i++) {
        NSDictionary *str = self.headerDataModel.images[i];
        
        [muArr addObject:str[@"imgUrl"]];
    }
    
  
//    [self.topView addSubview:bannerScrollView];
    
    UIView *bannerView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(140) , SCREENWIDTH, JZHEIGHT(31))];
    bannerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.topView addSubview:bannerView];
    
    UIView *starBackView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(106), JZHEIGHT(10), JZWITH(140), JZHEIGHT(25))];
    starBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
    starBackView.layer.cornerRadius = JZWITH(12.5);
    starBackView.layer.masksToBounds = YES;
    [self.topView addSubview:starBackView];
    
//    UILabel *starLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(12.5), 0, JZWITH(22), JZHEIGHT(25))];
//    starLabel.text = @"星级";
//    starLabel.font = JZFont(11);
//    starLabel.textColor = [UIColor whiteColor];
//    [starBackView addSubview:starLabel];
//    
//    int lightStarCount = [self.headerDataModel.grade intValue] / ([self.headerDataModel.commentCount intValue] == 0 ? 1 : [self.headerDataModel.commentCount intValue]);
//    
//    for (int i = 0; i < 5; i++) {
//        UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(starLabel.right + JZWITH(5) + (JZWITH(10) + JZWITH(3)) * i, JZHEIGHT(8), JZWITH(10), JZHEIGHT(10))];
//        starImageView.image = (i <= lightStarCount ?  Imaged(@"farm_icon_grade1") : Imaged(@"farm_icon_grade2")) ;
//        [starBackView addSubview:starImageView];
//    }
//    
    UIImageView *locationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), (bannerView.height - JZHEIGHT(10)) / 2, 8, 12)];
    locationImageView.image = [UIImage imageNamed:@"farm_icon_address2"];
    [bannerView addSubview:locationImageView];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(locationImageView.right+ JZHEIGHT(5), 0, JZWITH(230), bannerView.height)];
    addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.headerDataModel.province,self.headerDataModel.city,self.headerDataModel.area,self.headerDataModel.address];
    addressLabel.font = JZFont(12);
    addressLabel.textColor = [UIColor whiteColor];
    [bannerView addSubview:addressLabel];
    
    UILabel *juliLabel = [[UILabel alloc]initWithFrame:CGRectMake(addressLabel.right + JZWITH(5), 0, JZWITH(60), bannerView.height)];
    juliLabel.text = @"距离8KM";
    juliLabel.font = JZFont(11);
    juliLabel.textColor = [UIColor whiteColor];
    [bannerView addSubview:juliLabel];
    
    UIView *shuLineView = [[UIView alloc]initWithFrame:CGRectMake(juliLabel.right , (bannerView.height - JZHEIGHT(11)) / 2, JZWITH(1), JZHEIGHT(11))];
    shuLineView.backgroundColor = [UIColor whiteColor];
    [bannerView addSubview:shuLineView];
    
    UIImageView *callImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(16) - JZWITH(15), (bannerView.height - JZHEIGHT(15)) / 2, JZWITH(16), JZHEIGHT(15))];
    callImageView.image = Imaged(@"farm_icon_phone");
    [bannerView addSubview:callImageView];
    
    UIButton *callBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(31), 0, JZWITH(15+16), bannerView.height)];
    [callBt addTarget:self action:@selector(callOut) forControlEvents:UIControlEventTouchUpInside];
    [bannerView addSubview:callBt];
    
}

- (void)setNav{
    /// pageContentView
    NSMutableArray * navArr = [NSMutableArray arrayWithObjects:@"直播",@"图片", nil];
    /// pageTitleView
    
     YJSegmentedControl * segment3 = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREENWIDTH-JZWITH(90), 44) titleDataSource:navArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor colorWithRed:1.0 green:1 blue:1 alpha:0.5] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor whiteColor] buttonDownColor:[UIColor clearColor] Delegate:self];
     UIColor * color =Color90b659;
    
    segment3.backgroundColor = [color colorWithAlphaComponent:0];
    
    self.navigationItem.titleView = segment3;

    
    liveV = [[ChildLiveOne alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(235))url:_playUrl];
    liveV.playUrl = _playUrl;
    [liveV getLiveUrlWith:_playUrl];
    [liveV getDataWith:_ID];
//    [self.view bringSubviewToFront:liveV.videoView];
    UIColor* color1  = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    liveV.locationLabel.text = _farmName;
    liveV.backgroundColor = [color1 colorWithAlphaComponent:0.5];
//    liveV.targetId = _ID;
    liveV.targetId = self.islive?self.chatId:_ID;
//    liveV.liveId=_chatId?_chatId:_ID;
      liveV.liveId=_LiveID;
    liveV.zhuboId = self.userId;
    liveV.delegate =self;
    [self.view addSubview:liveV];
   liveV.videoView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(200))];
    liveV.videoView1.backgroundColor = [UIColor blackColor];
    [liveV addSubview:liveV.videoView1];



    
    childV = [[ChildVideoView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,JZHEIGHT(230))];

    NSMutableArray *muArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.headerDataModel.images.count; i++) {
        NSDictionary *str = self.headerDataModel.images[i];
        
        [muArr addObject:str[@"imgUrl"]];
    }
    int lightStarCount = [self.headerDataModel.grade intValue] / ([self.headerDataModel.commentCount intValue] == 0 ? 1 : [self.headerDataModel.commentCount intValue]);
    childV.lightStarCount = lightStarCount;
    
    childV.iamgeArr = muArr;
    
    childV.hidden=YES;
    [self.view addSubview:childV];

    if (!self.playUrl ||self.playUrl.length<1) {
        [segment3 selectTheSegument:1];
        
    }else{
        liveV.player = [[YfFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_playUrl] withOptions:NULL useDns:NO useSoftDecode:NO DNSIpCallBack:NULL appID:"" refer:"" bufferTime:3 display:YES isOpenSoundTouch:YES];
        
    }
    liveV.player.shouldAutoplay = YES;
    liveV.player.overalState = YfPLAYER_OVERAL_NORMAL;
    liveV.player.view.frame = CGRectMake(0, 0, SCREENWIDTH,JZHEIGHT(200));
    liveV.player.scalingMode = YfMPMovieScalingModeAspectFit;
    [liveV.videoView1 addSubview:liveV.player.view];
    liveV.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [liveV.player prepareToPlay];
    [liveV.player play];
    [liveV initiaUI];
    
    [NYNNetTool ShiFouShouCangWithparams:@{@"cid":self.headerDataModel.Id,@"ctype":self.ctype} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        JZLog(@"");
        if (![[NSString stringWithFormat:@"%@",success[@"data"]]isEqualToString:@"-1"]) {
            self.isCollection = YES;
         //   shareimageView.image = Imaged(@"mine_icon_collection");
            
            self.collectionID = [NSString stringWithFormat:@"%@",success[@"data"]];
        }else{
            self.isCollection = NO;
           // shareimageView.image = Imaged(@"farm_icon_Collection");
            
        }
        
    } failure:^(NSError *failure) {
        
    }];

    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    rightSpace.width = JZWITH(15);
//    self.navigationItem.rightBarButtonItems = @[one,rightSpace,two];
}

#pragma mark -- 遵守代理 实现代理方法
- (void)segumentSelectionChange:(NSInteger)selection{

    if (selection == 0) {
        childV.hidden = YES;
        liveV.hidden = NO;
        
        
    }else if (selection == 1){
        liveV.hidden = YES;
        childV.hidden = NO;
        
    }
    
}

#pragma 懒加载
-(NSMutableArray *)productNameArr{
    if (!_productNameArr) {
        _productNameArr = [[NSMutableArray alloc]init];
    }
    return _productNameArr;
}


#pragma 事件触发
- (void)callOut{
    JZLog(@"触发事件");
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"02885572795"];
    // NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
 
}

@end
