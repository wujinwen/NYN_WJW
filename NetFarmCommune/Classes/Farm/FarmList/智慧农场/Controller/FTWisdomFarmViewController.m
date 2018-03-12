//
//  FTWisdomFarmViewController.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTWisdomFarmViewController.h"

#import "FTCultivateViewController.h"
#import "FTFarmProduceViewController.h"
#import "FTExerciseViewController.h"
#import "FTFoodViewController.h"
#import "FTFarmFlockViewController.h"
#import "NYNZhongZhiViewController.h"
#import "NYNZhuSuViewController.h"
#import <UShareUI/UShareUI.h>

#import "SDCycleScrollView.h"
#import "SGTopTitleView.h"

#import "NYNProductNameModel.h"
#import "NYNWisDomModel.h"


@interface FTWisdomFarmViewController ()<SGTopTitleViewDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *productNameArr;

@property (nonatomic,strong) UIView *dizhiview;

@property (nonatomic,strong) UITableView *WisdomFarmTable;
@property (nonatomic,strong) UIView *headerView;


@property (nonatomic,strong) NYNZhongZhiViewController *oneVC;
@property (nonatomic,strong) NYNWisDomModel *headerDataModel;

@property (nonatomic,strong) NSMutableArray *scrollControllerArr;
@property (nonatomic,assign) BOOL isCollection;
@property (nonatomic,strong) UIImageView *colletionImageView;
@property (nonatomic,copy) NSString *collectionID;
@end

@implementation FTWisdomFarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pageNo = 1;
    self.pageSize = 10;
    
    [self showLoadingView:@""];

    [NYNNetTool FarmWisdomResquestWithparams:@{@"id":self.ID} isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        JZLog(@"");
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            self.headerDataModel = [NYNWisDomModel mj_objectWithKeyValues:success[@"data"][@"farm"]];
            
            NSArray *productNameDataArr = [NSArray arrayWithArray:success[@"data"][@"farm"][@"farmBusinessList"]];
            for (NSDictionary *dic in productNameDataArr) {
                NYNProductNameModel *model = [NYNProductNameModel mj_objectWithKeyValues:dic];
                
                [self.productNameArr addObject:model];
            }
            [self setNav];
            
            [self setWisdomScrollView];
            
            [self configVcs];
            
            [self createWisdomFarmTable];
            
            [self showLoadingView:@""];

            [self hideLoadingView];

        }else{
            [self hideLoadingView];

        }
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];

}

- (void)setNav{
    self.navigationItem.title = self.headerDataModel.name;
    
    UIButton *shoucangbt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(20), JZHEIGHT(20))];
    [shoucangbt addTarget:self action:@selector(shareOut) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *shoucangimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, shoucangbt.width, shoucangbt.height)];
    shoucangimageView.userInteractionEnabled = NO;
    shoucangimageView.image = Imaged(@"farm_icon_share");
    [shoucangbt addSubview:shoucangimageView];
    
    UIButton *sharebt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(20), JZHEIGHT(20))];
    [sharebt addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *shareimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sharebt.width, sharebt.height)];
    shareimageView.userInteractionEnabled = NO;
    shareimageView.image = Imaged(@"farm_icon_Collection");
    [sharebt addSubview:shareimageView];
    self.colletionImageView = shareimageView;
    
    [NYNNetTool ShiFouShouCangWithparams:@{@"cid":self.headerDataModel.Id,@"ctype":self.ctype} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        JZLog(@"");
        if (![[NSString stringWithFormat:@"%@",success[@"data"]]isEqualToString:@"-1"]) {
            self.isCollection = YES;
            shareimageView.image = Imaged(@"mine_icon_collection");
            
            self.collectionID = [NSString stringWithFormat:@"%@",success[@"data"]];
        }else{
            self.isCollection = NO;
            shareimageView.image = Imaged(@"farm_icon_Collection");

        }
        
    } failure:^(NSError *failure) {
        
    }];
    
    UIBarButtonItem *one = [[UIBarButtonItem alloc]initWithCustomView:shoucangbt];
    UIBarButtonItem *two = [[UIBarButtonItem alloc]initWithCustomView:sharebt];
    
    self.navigationItem.rightBarButtonItems = @[one,two];
}

- (void)setWisdomScrollView{
    
    NSMutableArray *muArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.headerDataModel.images.count; i++) {
        NSDictionary *str = self.headerDataModel.images[i];

        [muArr addObject:str[@"imgUrl"]];
    }
    
    SDCycleScrollView *bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(171)) delegate:self placeholderImage:PlaceImage];
    bannerScrollView.imageURLStringsGroup = [NSArray arrayWithArray:muArr];
    [self.headerView addSubview:bannerScrollView];
    
    UIView *bannerView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(140) , SCREENWIDTH, JZHEIGHT(31))];
    bannerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.headerView addSubview:bannerView];
    
    UIView *starBackView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(106), JZHEIGHT(10), JZWITH(140), JZHEIGHT(25))];
    starBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
    starBackView.layer.cornerRadius = JZWITH(12.5);
    starBackView.layer.masksToBounds = YES;
    [self.headerView addSubview:starBackView];
    
    UILabel *starLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(12.5), 0, JZWITH(22), JZHEIGHT(25))];
    starLabel.text = @"星级";
    starLabel.font = JZFont(11);
    starLabel.textColor = [UIColor whiteColor];
    [starBackView addSubview:starLabel];
    
    int lightStarCount = [self.headerDataModel.grade intValue] / ([self.headerDataModel.commentCount intValue] == 0 ? 1 : [self.headerDataModel.commentCount intValue]);
    
    for (int i = 0; i < 5; i++) {
        UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(starLabel.right + JZWITH(5) + (JZWITH(10) + JZWITH(3)) * i, JZHEIGHT(8), JZWITH(10), JZHEIGHT(10))];
        starImageView.image = (i <= lightStarCount ?  Imaged(@"farm_icon_grade1") : Imaged(@"farm_icon_grade2")) ;
        [starBackView addSubview:starImageView];
    }
    
    UIImageView *locationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), (bannerView.height - JZHEIGHT(10)) / 2, JZWITH(8), JZHEIGHT(10))];
    locationImageView.image = [UIImage imageNamed:@"farm_icon_address2"];
    [bannerView addSubview:locationImageView];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(locationImageView.right+ JZHEIGHT(5), 0, JZWITH(230), bannerView.height)];
    addressLabel.text = self.headerDataModel.address;
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


- (void)configVcs{
    NSMutableArray *productNameArray = [[NSMutableArray alloc]init];
    
    for (NYNProductNameModel *model in self.productNameArr) {
        [productNameArray addObject:model.name];
    }
    
    self.titles = [NSArray arrayWithArray:productNameArray];
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, JZHEIGHT(212 - 44), SCREENWIDTH , 41)];
    self.topTitleView.titleFontSize = 15;
    _topTitleView.scrollTitleArr = [NSArray arrayWithArray:_titles];
    //    _topTitleView.isHiddenIndicator = YES;
    _topTitleView.delegate_SG = self;
    self.topTitleView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:_topTitleView];
    
    
    //scroll  cellheight  table暂定2000
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0 , SCREENWIDTH, 2000);
    _mainScrollView.contentSize = CGSizeMake(SCREENWIDTH * _titles.count, 0);
    _mainScrollView.backgroundColor = BackGroundColor;
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    if (self.productNameArr.count > 0) {
        
        int index = 0;
        // 1 计算滚动的位置
        CGFloat offsetX = index * self.view.frame.size.width;
        self.mainScrollView.contentOffset = CGPointMake(offsetX, index);
        
        // 2.给对应位置添加对应子控制器
        CGFloat offsetXx = index * self.view.frame.size.width;
        
        UIViewController *vc = self.childViewControllers[index];
        __weak typeof(self)weakSelf = self;

        
        if ([vc isKindOfClass:[NYNZhongZhiViewController class]]) {
            NYNZhongZhiViewController *newvc = (NYNZhongZhiViewController *)vc;
            [newvc updateData];
            newvc.dateUp = ^(NSString *ss) {
                [weakSelf.mainScrollView addSubview:vc.view];
                vc.view.frame = CGRectMake(offsetXx, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
            };
        }
        
        if ([vc isKindOfClass:[FTCultivateViewController class]]) {
            FTCultivateViewController *newvc = (FTCultivateViewController *)vc;
            [newvc updateData];
            newvc.dateUp = ^(NSString *ss) {
                [weakSelf.mainScrollView addSubview:vc.view];
                vc.view.frame = CGRectMake(offsetXx, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
            };
        }
        
        if ([vc isKindOfClass:[FTFarmProduceViewController class]]) {
            FTFarmProduceViewController *newvc = (FTFarmProduceViewController *)vc;
            [newvc updateData];
            newvc.dateUp = ^(NSString *ss) {
                [weakSelf.mainScrollView addSubview:vc.view];
                vc.view.frame = CGRectMake(offsetXx, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
            };
        }
        
        if ([vc isKindOfClass:[FTExerciseViewController class]]) {
            FTExerciseViewController *newvc = (FTExerciseViewController *)vc;
            [newvc updateData];
            newvc.dateUp = ^(NSString *ss) {
                [weakSelf.mainScrollView addSubview:vc.view];
                vc.view.frame = CGRectMake(offsetXx, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
            };
        }
        
        if ([vc isKindOfClass:[FTFoodViewController class]]) {
            FTFoodViewController *newvc = (FTFoodViewController *)vc;
            [newvc updateData];
            newvc.dateUp = ^(NSString *ss) {
                [weakSelf.mainScrollView addSubview:vc.view];
                vc.view.frame = CGRectMake(offsetXx, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
            };
        }
        
        if ([vc isKindOfClass:[NYNZhuSuViewController class]]) {
            NYNZhuSuViewController *newvc = (NYNZhuSuViewController *)vc;
            [newvc updateData];
            newvc.dateUp = ^(NSString *ss) {
                [weakSelf.mainScrollView addSubview:vc.view];
                vc.view.frame = CGRectMake(offsetXx, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
            };
        }
        
        
        
        // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
        //        if (vc.isViewLoaded) return;
        

        

//        if ([vc isEqual:[NYNZhongZhiViewController class]]) {
//            [(NYNZhongZhiViewController *)vc updateData];
//        }
//        if ([vc isEqual:[NYNZhongZhiViewController class]]) {
//            [(NYNZhongZhiViewController *)vc updateData];
//        }
//        if ([vc isEqual:[NYNZhongZhiViewController class]]) {
//            [(NYNZhongZhiViewController *)vc updateData];
//        }
//        if ([vc isEqual:[NYNZhongZhiViewController class]]) {
//            [(NYNZhongZhiViewController *)vc updateData];
//        }
//        if ([vc isEqual:[NYNZhongZhiViewController class]]) {
//            [(NYNZhongZhiViewController *)vc updateData];
//        }
//        if ([vc isEqual:[NYNZhongZhiViewController class]]) {
//            [(NYNZhongZhiViewController *)vc updateData];
//        }
//        if ([vc isEqual:[NYNZhongZhiViewController class]]) {
//            [(NYNZhongZhiViewController *)vc updateData];
//        }
//        if ([vc isEqual:[NYNZhongZhiViewController class]]) {
//            [(NYNZhongZhiViewController *)vc updateData];
//        }
//        if ([vc isEqual:[NYNZhongZhiViewController class]]) {
//            [(NYNZhongZhiViewController *)vc updateData];
//        }
        
    }
    
//    if (self.productNameArr.count > 0) {
//        NYNProductNameModel * model = [self.productNameArr firstObject];
//        
//        if ([model.showType isEqualToString:@"1"]) {
//            //种植
//            NYNZhongZhiViewController *oneVC = [[NYNZhongZhiViewController alloc]init];
//            oneVC.view.backgroundColor = BackGroundColor;
//            oneVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 108);
//            oneVC.categoryId = model.ID;
//            oneVC.farmId = self.headerDataModel.Id;
//            oneVC.pageNo = 1;
//            oneVC.pageSize = 10;
//            [oneVC updateData];
//            [self addChildViewController:oneVC];
//            [_mainScrollView addSubview:oneVC.view];
//
//            
////            [self.view addSubview:oneVC.view];
//
//        }
//        else if ([model.showType isEqualToString:@"2"]){
//            //养殖
//            FTCultivateViewController *twoVC = [[FTCultivateViewController alloc]init];
//            twoVC.view.backgroundColor = BackGroundColor;
//            twoVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 108);
//            twoVC.categoryId = model.ID;
//            twoVC.farmId = self.headerDataModel.Id;
//            twoVC.pageNo = 1;
//            twoVC.pageSize = 10;
//            [self addChildViewController:twoVC];
//            [twoVC updateData];
//            [_mainScrollView addSubview:twoVC.view];
//            
//
//
//        }
//        else if ([model.showType isEqualToString:@"3"]){
//            //农产品
//            FTFarmProduceViewController *threeVC = [[FTFarmProduceViewController alloc]init];
//            threeVC.view.backgroundColor = BackGroundColor;
//            threeVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 108);
//            threeVC.categoryId = model.ID;
//            threeVC.farmId = self.headerDataModel.Id;
//            threeVC.pageNo = 1;
//            threeVC.pageSize = 10;
//            [threeVC updateData];
//            [self addChildViewController:threeVC];
//            [_mainScrollView addSubview:threeVC.view];
//
//            
//
//        }
//        else if ([model.showType isEqualToString:@"4"]){
//            //活动
//            FTExerciseViewController *fourVC = [[FTExerciseViewController alloc]init];
//            fourVC.view.backgroundColor = BackGroundColor;
//            fourVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 108);
//            fourVC.categoryId = model.ID;
//            fourVC.farmId = self.headerDataModel.Id;
//            fourVC.pageNo = 1;
//            fourVC.pageSize = 10;
//            [fourVC updateData];
//            [self addChildViewController:fourVC];
//            [_mainScrollView addSubview:fourVC.view];
//            
//            
//
//
//        }
//        else if ([model.showType isEqualToString:@"5"]){
//            //餐饮
//            FTFoodViewController *fiveVC = [[FTFoodViewController alloc]init];
//            fiveVC.view.backgroundColor = BackGroundColor;
//            fiveVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 108);
//            fiveVC.categoryId = model.ID;
//            fiveVC.farmId = self.headerDataModel.Id;
//            fiveVC.pageNo = 1;
//            fiveVC.pageSize = 10;
//            [fiveVC updateData];
//            [self addChildViewController:fiveVC];
//            [_mainScrollView addSubview:fiveVC.view];
//            
//
//
//        }
//        else if ([model.showType isEqualToString:@"6"]){
//            //住宿
//            NYNZhuSuViewController *sixVC = [[NYNZhuSuViewController alloc]init];
//            sixVC.view.backgroundColor = BackGroundColor;
//            sixVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 108);
////            self.oneVC = sixVC;
//            sixVC.categoryId = model.ID;
//            sixVC.farmId = self.headerDataModel.Id;
//            sixVC.pageNo = 1;
//            sixVC.pageSize = 10;
//            [sixVC updateData];
//            [self addChildViewController:sixVC];
//            [_mainScrollView addSubview:sixVC.view];
//
//
//        }
//        else{
//            //种植
//            NYNZhongZhiViewController *oneVC = [[NYNZhongZhiViewController alloc]init];
//            oneVC.view.backgroundColor = BackGroundColor;
//            oneVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 108);
////            self.oneVC = oneVC;
//            oneVC.categoryId = model.ID;
//            oneVC.farmId = self.headerDataModel.Id;
//            oneVC.pageNo = 1;
//            oneVC.pageSize = 10;
//            [oneVC updateData];
//            [self addChildViewController:oneVC];
//            [_mainScrollView addSubview:oneVC.view];
//
//        }
//
//        
//        
////        NYNZhongZhiViewController *oneVC = [[NYNZhongZhiViewController alloc]init];
////        oneVC.view.backgroundColor = BackGroundColor;
////        oneVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 108);
////        self.oneVC = oneVC;
////        [self addChildViewController:oneVC];
//    }else{
//        NYNZhongZhiViewController *oneVC = [[NYNZhongZhiViewController alloc]init];
//        oneVC.view.backgroundColor = BackGroundColor;
//        oneVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 108);
//        oneVC.farmId = self.headerDataModel.Id;
//        oneVC.pageNo = 1;
//        oneVC.pageSize = 10;
//        [oneVC updateData];
//        [self addChildViewController:oneVC];
//        [_mainScrollView addSubview:oneVC.view];
//
//    }
    
//    UIView *vd = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
//    vd.backgroundColor = [UIColor yellowColor];
//    [_mainScrollView addSubview:vd];
    
//    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 44-1, SCREENWIDTH, 1)];
    backView.backgroundColor = [UIColor clearColor];
    //加阴影
    backView.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    backView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.topTitleView.layer.masksToBounds = NO;
    self.topTitleView.clipsToBounds = NO;
    backView.layer.masksToBounds = NO;
    backView.clipsToBounds = NO;
    backView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    [self.topTitleView addSubview:backView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index{
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
    
    
}

// 添加所有子控制器
- (void)setupChildViewController {
    
    for (NYNProductNameModel * model in self.productNameArr) {
        if ([model.showType isEqualToString:@"1"]) {
            //种植
            NYNZhongZhiViewController *oneVC = [[NYNZhongZhiViewController alloc]init];
            oneVC.categoryId = model.ID;
            oneVC.farmId = self.headerDataModel.Id;
            oneVC.pageNo = 1;
            oneVC.pageSize = 10;
            [oneVC updateData];

            [self addChildViewController:oneVC];
            [oneVC didMoveToParentViewController:self];

            [self.scrollControllerArr addObject:oneVC];

        }
        else if ([model.showType isEqualToString:@"2"]){
            //养殖
            FTCultivateViewController *twoVC = [[FTCultivateViewController alloc]init];
            twoVC.categoryId = model.ID;
            twoVC.farmId = self.headerDataModel.Id;
            twoVC.pageNo = 1;
            twoVC.pageSize = 10;
            [twoVC updateData];
            [self addChildViewController:twoVC];
            
            [self.scrollControllerArr addObject:twoVC];

        }
        else if ([model.showType isEqualToString:@"3"]){
            //农产品
            FTFarmProduceViewController *threeVC = [[FTFarmProduceViewController alloc]init];
            threeVC.categoryId = model.ID;
            threeVC.farmId = self.headerDataModel.Id;
            threeVC.pageNo = 1;
            threeVC.pageSize = 10;
            [threeVC updateData];

            [self addChildViewController:threeVC];
            
            [self.scrollControllerArr addObject:threeVC];

        }
        else if ([model.showType isEqualToString:@"4"]){
            //活动
            FTExerciseViewController *fourVC = [[FTExerciseViewController alloc]init];
            fourVC.categoryId = model.ID;
            fourVC.farmId = self.headerDataModel.Id;
            fourVC.pageNo = 1;
            fourVC.pageSize = 10;
            [fourVC updateData];

            [self addChildViewController:fourVC];
            
            [self.scrollControllerArr addObject:fourVC];

        }
        else if ([model.showType isEqualToString:@"5"]){
            //餐饮
            FTFoodViewController *fiveVC = [[FTFoodViewController alloc]init];
            fiveVC.categoryId = model.ID;
            fiveVC.farmId = self.headerDataModel.Id;
            fiveVC.pageNo = 1;
            fiveVC.pageSize = 10;
            
            [fiveVC updateData];

            [self addChildViewController:fiveVC];
            
            [self.scrollControllerArr addObject:fiveVC];

        }
        else if ([model.showType isEqualToString:@"6"]){
            //住宿
            NYNZhuSuViewController *sixVC = [[NYNZhuSuViewController alloc]init];
            sixVC.categoryId = model.ID;
            sixVC.farmId = self.headerDataModel.Id;
            sixVC.pageNo = 1;
            sixVC.pageSize = 10;
            
            [sixVC updateData];

            [self addChildViewController:sixVC];
            
            [self.scrollControllerArr addObject:sixVC];

        }
        else{
            //种植
            NYNZhongZhiViewController *oneVC = [[NYNZhongZhiViewController alloc]init];
            oneVC.categoryId = model.ID;
            oneVC.farmId = self.headerDataModel.Id;
            oneVC.pageNo = 1;
            oneVC.pageSize = 10;
            
            [oneVC updateData];

            [self addChildViewController:oneVC];
            
            [self.scrollControllerArr addObject:oneVC];

        }
    }

}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
//        if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.topTitleView] || [scrollView isEqual:self.mainScrollView]) {
        // 计算滚动到哪一页
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        // 1.添加子控制器view
        [self showVc:index];
        
        // 2.把对应的标题选中
        UILabel *selLabel = self.topTitleView.allTitleLabel[index];
        
        
        [self.topTitleView scrollTitleLabelSelecteded:selLabel];
    }
    

    //    if (scrollView.contentOffset.x == 0) {
    //
    //    }else{
    
    // 3.滚动时，改变标题选中
//    }

    
}

- (void)clickIndex:(NSInteger)index andFriendHeadImageURL:(NSString *)headURL andLevel:(NSString *)level andUserName:(NSString *)userName{
    
    
}


- (void)createWisdomFarmTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.WisdomFarmTable.delegate = self;
    self.WisdomFarmTable.dataSource = self;
    self.WisdomFarmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.WisdomFarmTable.showsVerticalScrollIndicator = NO;
    self.WisdomFarmTable.showsHorizontalScrollIndicator = NO;
    self.WisdomFarmTable.tableHeaderView = self.headerView;
    
    
    [self.view addSubview:self.WisdomFarmTable];
}

#pragma 懒加载
-(UITableView *)WisdomFarmTable
{
    if (!_WisdomFarmTable) {
        _WisdomFarmTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    }
    return _WisdomFarmTable;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(222 ) - 4 - 4)];
        _headerView.backgroundColor = Colore3e3e3;
        
        
        CGFloat w = SCREENWIDTH;
        if (w < 374) {
            _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 184)];
        }
    }
    return _headerView;
}

-(NSMutableArray *)productNameArr{
    if (!_productNameArr) {
        _productNameArr = [[NSMutableArray alloc]init];
    }
    return _productNameArr;
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *colletionViewTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"colletionViewTableViewCell"];
    if (colletionViewTableViewCell == nil) {
        colletionViewTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"colletionViewTableViewCell"];
    }
    //这里不需要重复使用
    
//    for (UIView *subView in colletionViewTableViewCell.contentView.subviews) {
//        [subView removeFromSuperview];
//    }
    [colletionViewTableViewCell.contentView addSubview:self.mainScrollView];
    return colletionViewTableViewCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //scroll  cellheight  table暂定2000

    
    return 10 * 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    self.titles = @[@"种植",@"养殖", @"农产品", @"活动", @"餐饮", @"住宿", @"农场群", @"分享"];

    
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
//    return headerView;
    
    UIView *headerLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
    headerLineView.backgroundColor = RGB136;
    
    return headerLineView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma scrollviewdelegate
//CGRectMake(JZWITH(20), self.dizhiview.bottom, self.view.frame.size.width , 44)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual: self.WisdomFarmTable]) {
        NSLog(@"%f   ---    %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
        
        if (scrollView.contentOffset.y > JZHEIGHT(170)) {
                self.topTitleView.frame = CGRectMake(0, 0, self.view.frame.size.width , 41);
                [self.view addSubview:self.topTitleView];
            
            POST_NTF(@"starFarmScroll", nil);
        }else{
                self.topTitleView.frame = CGRectMake(0, JZHEIGHT(212 - 44), self.view.frame.size.width , 41);
                [self.headerView addSubview:self.topTitleView];
            
            POST_NTF(@"stopFarmScroll", nil);

        }
    }
}

#pragma 事件触发
- (void)callOut{
    JZLog(@"触发事件");
}

- (void)shareOut{
    JZLog(@"分享事件");
    //显示分享面板
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Qzone)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//        messageObject.title = @"快来下载网农公社吧，哈哈哈哈";
        messageObject.text = @"快来下载网农公社吧，哈哈哈哈";
        
        //创建图片内容对象
//        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
//        shareObject.thumbImage = self.snapshot;
//        [shareObject setShareImage:self.snapshot];
//        shareObject.title = @"快来下载网农公社吧，哈哈哈哈";
//        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];

    }];
}

- (void)collect{
    JZLog(@"收藏事件");

    [self showLoadingView:@""];

    if (self.isCollection) {
        [NYNNetTool ZengJiaShouCangWithparams:@{@"cid":self.headerDataModel.Id,@"ctype":self.ctype} isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            if ([[NSString stringWithFormat:@"%@",success[@"code"]]isEqualToString:@"200"]) {
                self.colletionImageView.image = Imaged(@"farm_icon_Collection");
                [self showTextProgressView:@"取消成功"];
                
                self.isCollection = !self.isCollection;
            }
            [self hideLoadingView];

        } failure:^(NSError *failure) {
            [self hideLoadingView];

        }];
    }else{
        [NYNNetTool ZengJiaShouCangWithparams:@{@"cid":self.headerDataModel.Id,@"ctype":self.ctype} isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            if ([[NSString stringWithFormat:@"%@",success[@"code"]]isEqualToString:@"200"]) {
                self.colletionImageView.image = Imaged(@"mine_icon_collection");
                [self showTextProgressView:@"收藏成功"];
                
                self.isCollection = !self.isCollection;

            }
            [self hideLoadingView];

        } failure:^(NSError *failure) {
            [self hideLoadingView];

        }];
    }
    
}

-(NSMutableArray *)scrollControllerArr{
    if (!_scrollControllerArr) {
        _scrollControllerArr = [[NSMutableArray alloc]init];
    }
    return _scrollControllerArr;
}
@end
