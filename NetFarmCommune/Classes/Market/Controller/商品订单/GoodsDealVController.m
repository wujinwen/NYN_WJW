//
//  GoodsDealVController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/4.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "GoodsDealVController.h"
#import "GoodsSectionTVCell.h"
#import "GoodsTwoSectionViewCell.h"
#import "NYNMarketListModel.h"
#import "GoodsTwoSectionViewCell.h"

#import "GoodsThreeTableViewCell.h"
#import "NYNGouMaiView.h"
#import "NYNGouMaiWangNongBiViewController.h"
#import "BuyPlayViewController.h"

#import "GoodsTableVController.h"
#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJDefaultTabViewBar.h"
#import "NYNGoodDealView.h"
#import "DetailsViewController.h"
#import "RootsViewController.h"
#import "NYNRootModel.h"
@interface GoodsDealVController ()<HJTabViewControllerDataSource, HJTabViewControllerDelagate, HJDefaultTabViewBarDelegate>


@property(nonatomic,strong)NSMutableArray * dataArr;


@property (nonatomic,strong) NYNGouMaiView* bottomView;
@property(nonatomic,strong)NYNMarketListModel * lictModel;
@property(nonatomic,strong)NSString* countString;
@property(nonatomic,strong)NYNGoodDealView *headerView ;

@property(nonatomic,strong)GoodsTableVController *goodVc;
@property(nonatomic,strong)DetailsViewController * detalVC;
@property(nonatomic,strong)RootsViewController *rootsVc;
@property(nonatomic,strong)NSArray * rootArray;//溯源数据

@property(nonatomic,assign)double  yunfeiPrice;//运费价格


@end

@implementation GoodsDealVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    _dataArr = [[NSMutableArray alloc]init];

    
    [self.view addSubview:self.bottomView];
    
    self.tabDataSource = self;
    self.tabDelegate = self;
    //初始化
    HJDefaultTabViewBar *tabViewBar = [HJDefaultTabViewBar new];
    tabViewBar.delegate = self;
    //设置标题选中颜色
    tabViewBar.highlightedColor = Color90b659;
    HJTabViewControllerPlugin_TabViewBar *tabViewBarPlugin = [[HJTabViewControllerPlugin_TabViewBar alloc] initWithTabViewBar:tabViewBar delegate:nil];
    [self enablePlugin:tabViewBarPlugin];
    
    [self enablePlugin:[HJTabViewControllerPlugin_HeaderScroll new]];

  
     __weak typeof(self)weakSelf = self;
    self.bottomView.heJiLabel.text=@"0";
    self.bottomView.goumaiBlock = ^(NSString *strValue) {
        //   跳转购买支付界面
        BuyPlayViewController* goumaiVc=[[BuyPlayViewController alloc]init];
             goumaiVc.yunfeiPrice = weakSelf.yunfeiPrice;
        goumaiVc.lictModel = weakSelf.lictModel;
        goumaiVc.farmId = weakSelf.farmId;
        goumaiVc.countString=weakSelf.countString;
   
        
        [weakSelf.navigationController pushViewController:goumaiVc animated:YES];

    };
    
    //加入购物车
    self.bottomView.gouwucheBlock =^(NSString *strValue) {
        [weakSelf addCart];
    };
    
    [self initiaNavigation];
    
    [self postData];
    //溯源接口数据
    [self resourceData];
    
}
-(void)backbtnClick:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)postData{
    NSDictionary * dic =@{@"productId":_productId};
    //查询集市产品
    [NYNNetTool QueryInfoWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            _lictModel = [NYNMarketListModel mj_objectWithKeyValues:success[@"data"]];
          
            
            //               //添加数据
            //               [self.dataArr addObject:_lictModel];
            _headerView.model =_lictModel ;
                _goodVc.model=_lictModel;
              _detalVC.model = _lictModel;
            //调用计算运费
            [self calculateYunFei];
            
        }else{
            
        }
        
    } failure:^(NSError *failure) {
    }];
    
}



//计算运费
-(void)calculateYunFei{
    if ([_lictModel.shippingMethod[@"freightType"] isEqualToString:@"free"]) {
//        _yunfeiLabel.text = @"(运费：¥0.00)";
        _yunfeiPrice=0;
        

    }else if ([_lictModel.shippingMethod[@"freightType"] isEqualToString:@"condition"]){
        //指定条件包邮
        if ([_countString intValue]<=[_lictModel.shippingMethod[@"quantity"] intValue] &&[_countString intValue]*[_lictModel.price intValue]>=[_lictModel.shippingMethod[@"conditionFreight"] intValue]) {
             _yunfeiPrice=0;

        }else{
            //不包邮
            double a = [_countString intValue] /[_lictModel.shippingMethod[@"quantity"] intValue];
            if (a<=1) {
//                _yunfeiLabel.text = [NSString stringWithFormat:@"(运费：¥%.2f)",[freightModel.freight floatValue]];
//                _yunfeiMoeny =[freightModel.freight floatValue];
                _yunfeiPrice=[_lictModel.shippingMethod[@"freight"] floatValue];
                

            }else{
                int a =([_countString intValue] -[_lictModel.shippingMethod[@"quantity"] intValue])/ [_lictModel.shippingMethod[@"addQuantity"] intValue];
                int b = (a==0)?(a=1):a;
                float c = b*[_lictModel.shippingMethod[@"addFreight"] floatValue]+[_lictModel.shippingMethod[@"freight"] floatValue];
//                _yunfeiLabel.text = [NSString stringWithFormat:@"(运费：¥%.2f)",c];
                  _yunfeiPrice=c;

            }

        }


    }else{
        //不包邮
        double a = [_countString intValue] /[_lictModel.shippingMethod[@"quantity"] intValue];
        if (a<=1) {
              _yunfeiPrice=[_lictModel.shippingMethod[@"freight"] floatValue];
            
        }else{
            int a =([_countString intValue] -[_lictModel.shippingMethod[@"quantity"] intValue])/ [_lictModel.shippingMethod[@"addQuantity"] intValue];
            int b = (a==0)?(a=1):a;
            float c = b*[_lictModel.shippingMethod[@"addFreight"] floatValue]+[_lictModel.shippingMethod[@"freight"] floatValue];
                _yunfeiPrice=c;
        }

    }
}



//溯源
-(void)resourceData{
    [NYNNetTool SourceWithparams:_productId isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//                        NYNRootModel *model = [NYNRootModel mj_objectWithKeyValues:success[@"data"]];
            //            self.model = model;
            //
            //            JZLog(@"");
            //            [self setTable];
            _rootArray=success[@"data"][@"infos"];
            
                 _rootsVc.dataArray = _rootArray;
            
            
        }else{
            // [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        //  [self hideLoadingView];
    } failure:^(NSError *failure) {
        // [self hideLoadingView];
    }];
}

-(void)initiaNavigation{
    
    self.title =@"商品详情";
    //已经无语了改了不知道好多回了，暂时不删除，以防后期又改
    //初始化导航栏
//    UIView *starBackView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2, JZHEIGHT(10), JZWITH(140), JZHEIGHT(25))];
//    UIColor * color = [UIColor whiteColor];
//    starBackView.backgroundColor=[color colorWithAlphaComponent:0];
//    starBackView.layer.cornerRadius = JZWITH(12.5);
//    starBackView.layer.masksToBounds = YES;
//    self.navigationItem.titleView = starBackView;
//
//    UILabel *starLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(12.5), 0, JZWITH(22), JZHEIGHT(25))];
//    starLabel.text = @"";
//    starLabel.font = JZFont(11);
//    starLabel.textColor = [UIColor whiteColor];
//    [starBackView addSubview:starLabel];
//    for (int i = 0; i < 5; i++) {
//        UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(starLabel.right + JZWITH(5) + (JZWITH(15) + JZWITH(3)) * i, JZHEIGHT(8), JZWITH(15), JZHEIGHT(15))];
//        // starImageView.image = (i < _lightStarCount ?  Imaged(@"farm_icon_grade1") : Imaged(@"farm_icon_grade2")) ;
//        starImageView.image =  Imaged(@"farm_icon_collection2") ;
//        [starBackView addSubview:starImageView];
//    }
    
//

    UIButton * backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setImage:[UIImage imageNamed:@"public_icon_return"] forState:UIControlStateNormal];
    backbtn.frame =CGRectMake(0, 0, 40, 40);
    [backbtn addTarget:self action:@selector(backbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    
    UIButton *shopbButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(16), JZHEIGHT(16))];
    [shopbButton setImage:[UIImage imageNamed:@"farm_icon_shopping_cart"] forState:UIControlStateNormal];
    UIButton *sharebt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(16), JZHEIGHT(16))];
    [shopbButton setImage:[UIImage imageNamed:@"farm_icon_consultation"] forState:UIControlStateNormal];
    
    UIBarButtonItem *one = [[UIBarButtonItem alloc]initWithCustomView:shopbButton];
    UIBarButtonItem *two = [[UIBarButtonItem alloc]initWithCustomView:sharebt];
        self.navigationItem.rightBarButtonItems = @[one,two];
}


#pragma mark - HJDefaultTabViewBarDelegate

- (NSInteger)numberOfTabForTabViewBar:(HJDefaultTabViewBar *)tabViewBar {
    return [self numberOfViewControllerForTabViewController:self];
}

- (id)tabViewBar:(HJDefaultTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    if (index == 0) {
        return @"商品详情";
    }else if (index == 1) {
        return @"商品规格";
    }else if (index == 2) {
        return @"溯源";
    }else if (index == 3) {
        return @"评价";
    }else{
        return @"";
        
    }
  
}

- (void)tabViewBar:(HJDefaultTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    BOOL anim = labs(index - self.curIndex) > 1 ? NO: YES;
    [self scrollToIndex:index animated:anim];
}
#pragma mark -

- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY {
    // 博主很傻，用此方法渐变导航栏是偷懒表现，只是为了demo演示。正确科学方法请自行百度 iOS导航栏透明
    //    self.navigationController.navigationBar.alpha = contentPercentY;
}
//分页个数
- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController {
    return 4;
}

- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {

//    vc.index = index;
    
    if (index ==0) {
        //商品详情
        _detalVC = [DetailsViewController new];
           _detalVC.index = index;
        return _detalVC;
    }else if (index ==1){
        //商品规格
        _goodVc= [GoodsTableVController new];
         _goodVc.index = index;

       return _goodVc;
    }else if (index ==2){
      //溯源
        _rootsVc = [[RootsViewController alloc]init];

    
        return _rootsVc;
    }else if (index ==3){
        //评价
        GoodsTableVController *vc = [[GoodsTableVController alloc]init];
        vc.index = index;
        vc.model=_lictModel;
        return vc;
    }

    return nil;
    

}

//头部视图
- (UIView *)tabHeaderViewForTabViewController:(HJTabViewController *)tabViewController {
    CGRect rect = CGRectMake(0, 0, 0, JZWITH(360));
    _headerView = [[NYNGoodDealView alloc] initWithFrame:rect];
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.userInteractionEnabled = YES;
    __weak typeof(self)weakSelf = self;
    _headerView.selectClick = ^(int str) {
        
        if (str < 1) {
            _countString=[NSString stringWithFormat:@"%d",1];
        }else{
            _countString=[NSString stringWithFormat:@"%d",str];
        }
        
        [weakSelf reloadPrice];
    };
    return _headerView;
  
    
}

- (CGFloat)tabHeaderBottomInsetForTabViewController:(HJTabViewController *)tabViewController {
    return HJTabViewBarDefaultHeight + CGRectGetMaxY(self.navigationController.navigationBar.frame);
}

- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//刷新数据方法
-(void)reloadPrice{
    int totalPrice = [_lictModel.price intValue] *[_countString intValue];
    self.bottomView.heJiLabel.text =[NSString stringWithFormat:@"%d",totalPrice];
    
    
}
//添加购物车
-(void)addCart{
    if (_countString==nil) {
      //[self showTextProgressView:@"数量不能为0"];
        return;
        
    }
    NSDictionary * dic =@{@"productId":_productId,@"quantity":_countString,@"productType":@"general"};
    //添加购物车
    [NYNNetTool CartWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            

            //   [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            
        }else{
            //[self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
       // [self hideLoadingView];
    } failure:^(NSError *failure) {
        
        //[self hideLoadingView];
    }];
    
}



-(NYNGouMaiView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NYNGouMaiView alloc]init];
         [_bottomView ConfigDataWithIndex:0 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45)-62, SCREENWIDTH, JZHEIGHT(45))];
        [_bottomView.goumaiBT setTitle:@"提交订单" forState:UIControlStateNormal];
        
        
    }
    return _bottomView;
    
    
}


@end
