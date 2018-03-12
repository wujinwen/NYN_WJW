//
//  FTEarthDetailViewController.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/24.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTEarthDetailViewController.h"
#import "FTEarthParameterViewController.h"
#import "FTBuyNeedKnowViewController.h"
#import "FTPayViewController.h"

#import "ShopCartViewController.h"

#import "SDCycleScrollView.h"
#import "SGTopTitleView.h"
@interface FTEarthDetailViewController ()<SDCycleScrollViewDelegate,SGTopTitleViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scroBackView;

@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic,strong) UIView *headerView;
@end

@implementation FTEarthDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setNav];
    
    [self setEarthScrollView];
    
    [self configVcs];
    
    [self addGouWuView];
}

- (void)configVcs{
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    self.titles = @[@"图文详情",@"土地参数", @"购买须知"];
    
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, self.headerView.bottom + 0.5, self.view.frame.size.width , 44)];
    self.topTitleView.titleFontSize = 12;
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
    //    _topTitleView.isHiddenIndicator = YES;
    _topTitleView.delegate_SG = self;
    self.topTitleView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.scroBackView addSubview:_topTitleView];
    
    
    //scroll  cellheight  table暂定2000
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, self.topTitleView.bottom + 64, SCREENWIDTH, 2000);
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
//    [self.scroBackView addSubview:_mainScrollView];
    
    UIViewController *oneVC = [[UIViewController alloc]init];
    oneVC.view.backgroundColor = BackGroundColor;
    oneVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(242));
    [self addChildViewController:oneVC];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
    
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


- (void)setEarthScrollView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.scroBackView.scrollEnabled = NO;
    
    [self.view addSubview:self.scroBackView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(307))];
    [self.scroBackView addSubview:headerView];
    headerView.backgroundColor = BackGroundColor;
    self.headerView = headerView;
    
    SDCycleScrollView *bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(171)) delegate:self placeholderImage:PlaceImage];
    bannerScrollView.localizationImageNamesGroup = @[@"占位图",@"占位图",@"占位图",@"占位图"];
    [headerView addSubview:bannerScrollView];
    
    UIView *yihaotudibackView = [[UIView alloc]initWithFrame:CGRectMake(0, bannerScrollView.bottom, SCREENWIDTH, JZHEIGHT(95))];
    yihaotudibackView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:yihaotudibackView];
    
    UILabel *yihao = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(16), JZWITH(150), JZHEIGHT(13))];
    yihao.textColor = RGB56;
    yihao.text = @"1号土地";
    yihao.font = JZFont(14);
    [yihaotudibackView addSubview:yihao];
    
    UILabel *jiageLB = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(302), JZHEIGHT(15), JZWITH(63), JZHEIGHT(14))];
    jiageLB.text = @"0.9¥/斤";
    jiageLB.textColor = KNaviBarTintColor;
    jiageLB.font = JZFont(13);
    [yihaotudibackView addSubview:jiageLB];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(JZWITH(15), JZHEIGHT(43), SCREENWIDTH - JZWITH(30), 0.5)];
    lineView.backgroundColor = BackGroundColor;
    [yihaotudibackView addSubview:lineView];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), lineView.bottom + JZHEIGHT(13), SCREENWIDTH - JZWITH(20), JZHEIGHT(30))];
    lb.numberOfLines = 0;
    lb.textColor = RGB104;
    lb.font = JZFont(12);
    lb.text = @"习近平指出，我同总统先生在海湖庄园会晤，近日又进行了很好的通话，达成重要共识，受到两国民众和国际社会积极评价";
    lb.numberOfLines = 0;
    [yihaotudibackView addSubview:lb];
    
    UIView *sanView = [[UIView alloc]initWithFrame:CGRectMake(0, yihaotudibackView.bottom + JZHEIGHT(0.5), SCREENWIDTH, JZHEIGHT(40))];
    sanView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:sanView];
    
    UILabel *zhlb = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, JZWITH(100), sanView.height)];
    zhlb.text = @"智慧农场";
    zhlb.font = JZFont(13);
    zhlb.textColor = KNaviBarTintColor;
    [sanView addSubview:zhlb];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(zhlb.right + JZWITH(8), JZHEIGHT(15), JZWITH(6), JZHEIGHT(11))];
    imageV.image = PlaceImage;
    [sanView addSubview:imageV];
    
    NSString *locationStr = @"国际形势迅速变化，中美双方保持密切联系";
    CGFloat with = [locationStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, JZHEIGHT(40)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}  context:nil].size.width;
    
    UILabel *locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - with, 0, with, JZHEIGHT(40))];
    locationLabel.text = locationStr;
    locationLabel.font = [UIFont systemFontOfSize:12];
    locationLabel.textColor = RGB104;
    [sanView addSubview:locationLabel];
    
    UIImageView *locationView = [[UIImageView alloc]initWithFrame:CGRectMake(locationLabel.left - JZWITH(9) - JZWITH(12), JZHEIGHT(14), JZWITH(12), JZHEIGHT(13))];
    locationView.image = PlaceImage;
    [sanView addSubview:locationView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNav{
    self.navigationItem.title = @"土地详情";
    
    UIButton *shoucangbt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(16), JZHEIGHT(16))];
    UIImageView *shoucangimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, shoucangbt.width, shoucangbt.height)];
    shoucangimageView.userInteractionEnabled = NO;
    shoucangimageView.image = Imaged(@"占位图");
    [shoucangbt addSubview:shoucangimageView];
    
    UIButton *sharebt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(16), JZHEIGHT(16))];
    UIImageView *shareimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sharebt.width, sharebt.height)];
    shareimageView.userInteractionEnabled = NO;
    shareimageView.image = Imaged(@"占位图");
    [sharebt addSubview:shareimageView];
    
    UIBarButtonItem *one = [[UIBarButtonItem alloc]initWithCustomView:shoucangbt];
    UIBarButtonItem *two = [[UIBarButtonItem alloc]initWithCustomView:sharebt];
    
    self.navigationItem.rightBarButtonItems = @[one,two];
}


- (UIScrollView *)scroBackView{
    if (!_scroBackView) {
        _scroBackView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH,SCREENHEIGHT - 64)];
        _scroBackView.backgroundColor = BackGroundColor;
        _scroBackView.contentSize = CGSizeMake(0, SCREENHEIGHT * 2);
    }
    return _scroBackView;
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
    
    
    
    FTEarthParameterViewController *oneVC = [[FTEarthParameterViewController alloc]init];
    [self addChildViewController:oneVC];
    
    FTEarthParameterViewController *sixVC = [[FTEarthParameterViewController alloc]init];
    [self addChildViewController:sixVC];
    
    FTBuyNeedKnowViewController *eightVC = [[FTBuyNeedKnowViewController alloc]init];
    [self addChildViewController:eightVC];
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    //    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    if (scrollView.contentOffset.x == 0) {
        
    }else{
        
        // 3.滚动时，改变标题选中
        [self.topTitleView scrollTitleLabelSelecteded:selLabel];
    }
    
    
}

- (void)clickIndex:(NSInteger)index andFriendHeadImageURL:(NSString *)headURL andLevel:(NSString *)level andUserName:(NSString *)userName{
    
    
}

#pragma qqq
- (void)addGouWuView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45), SCREENWIDTH, JZHEIGHT(45))];
    [self.view addSubview:bottomView];
    
    UIImageView *imgV= [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(22), JZHEIGHT(13), JZWITH(21), JZHEIGHT(21))];
    imgV.image = PlaceImage;
    [bottomView addSubview:imgV];
    imgV.backgroundColor = BackGroundColor;
    
    NSString *price = @"12";
    NSString *lastPrice = [NSString stringWithFormat:@"合计：¥%@",price];
    
    CGFloat  lastPriceWith = [lastPrice boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, JZHEIGHT(45)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}  context:nil].size.width;
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - lastPriceWith - JZWITH(198), 0, lastPriceWith, JZHEIGHT(45))];
    priceLabel.font = [UIFont systemFontOfSize:13];
    priceLabel.text = lastPrice;
    [bottomView addSubview:priceLabel];
    
    UIButton *jiarugouwuche = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(171), 0, JZWITH(85), JZHEIGHT(45))];
    jiarugouwuche.backgroundColor = KNaviBarTintColor;
    [jiarugouwuche setTitle:@"加入购物车" forState:0];
    [jiarugouwuche setTitleColor:[UIColor whiteColor] forState:0];
    jiarugouwuche.titleLabel.font = JZFont(12);
    [jiarugouwuche addTarget:self action:@selector(addGouwu) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:jiarugouwuche];
    
    UIButton *lijizudi = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(85), 0, JZWITH(85), JZHEIGHT(45))];
    lijizudi.backgroundColor = KNaviBarTintColor;
    [lijizudi setTitle:@"立即租地" forState:0];
    [lijizudi setTitleColor:[UIColor whiteColor] forState:0];
    lijizudi.titleLabel.font = JZFont(12);
    [lijizudi addTarget:self action:@selector(lizu) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:lijizudi];
    
}

#pragma action
- (void)addGouwu{
    JZLog(@"加入购物车");
    ShopCartViewController *vc = [[ShopCartViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)lizu{
    JZLog(@"立即租地");
    FTPayViewController *vc = [[FTPayViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
