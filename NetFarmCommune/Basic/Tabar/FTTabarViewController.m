//
//  FTTabarViewController.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/18.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTTabarViewController.h"
#import "FTNavigationViewController.h"

#import "NYNHomeViewController.h"
#import "NYNFarmViewController.h"
#import "NYNMarketViewController.h"
#import "NYNCommunityViewController.h"
#import "NYNMeViewController.h"




@interface FTTabarViewController ()

@end

@implementation FTTabarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTabBarItemStyle];//设置tabbarItem样式
    [self addAllChildViewController];//添加子控制器
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
}

-(void)setupTabBarItemStyle{
    /******设置通用的item属性*******/
    UITabBarItem *item = [UITabBarItem appearance];//设定一个统一的item
    //tabbarItem普通状态下的文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    attrs[NSForegroundColorAttributeName] = Color686868;
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    //tabbarItem选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = Color90b659;
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}

//设置tabbarItem样式
-(void)setupOneChildViewController:(UIViewController *)vc andTitle:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    UIImage *img = [UIImage imageNamed:image];
    vc.tabBarItem.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectimg = [UIImage imageNamed:selectedImage];
    selectimg = [selectimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selectimg;
    
    [self addChildViewController:vc];
}
//初始化一个子控制器:*vc:子控制器名 *title:控制器标题 *image:item未选中的图片*selectedImage:item选中时的图片
//#import "NEMeViewController.h"
//#import "NEPractisViewController.h"
//#import "NETestViewController.h"
//#import "NETrainingViewController.h"
//#import "NEHomeViewController.h"
-(void)addAllChildViewController{
    //    [self setupOneChildViewController:[[LCNavigationContoller alloc]initWithRootViewController:[[DeliveryStatusViewConotroller alloc]init]] andTitle:@"订单管理" andImage:@"icon_1" andSelectedImage:@"icon_11"];
    
    NYNHomeViewController *homeV = [[NYNHomeViewController alloc]init];
    homeV.TiaoZhuan = ^(NSString *ss) {
        self.selectedIndex = 1;
    };
    [self setupOneChildViewController:[[FTNavigationViewController alloc]initWithRootViewController:homeV] andTitle:@"首页" andImage:@"public_tab_home1" andSelectedImage:@"public_tab_home2"];
    
    [self setupOneChildViewController:[[FTNavigationViewController alloc]initWithRootViewController:[[NYNFarmViewController alloc]init]] andTitle:@"店铺" andImage:@"public_tab_farm1" andSelectedImage:@"public_tab_farm2"];
    
    [self setupOneChildViewController:[[FTNavigationViewController alloc]initWithRootViewController:[[NYNMarketViewController alloc]init]] andTitle:@"集市" andImage:@"Market_default" andSelectedImage:@"Market_selected"];
    //    [self setupOneChildViewController:[[UIViewController alloc]init] andTitle:nil andImage:@"~" andSelectedImage:@"~"];//留出中间按钮的位置(用来占位的控制器，可选项);
    
    [self setupOneChildViewController:[[FTNavigationViewController alloc]initWithRootViewController:[[NYNCommunityViewController alloc]init]] andTitle:@"社区" andImage:@"public_tab_community1" andSelectedImage:@"public_tab_community2"];
    
    [self setupOneChildViewController:[[FTNavigationViewController alloc]initWithRootViewController:[[NYNMeViewController alloc]init]] andTitle:@"我的" andImage:@"public_tab_mine1" andSelectedImage:@"public_tab_mine2"];
//    
//    WFMainViewController *mainVC = [[UIViewController alloc] initWithNibName:@"WFMainViewController" bundle:NULL];
//    
//    WFNavViewController *navVC = [[WFNavViewController alloc] initWithRootViewController:mainVC];
//    [navVC setNavigationBarHidden:YES];
//    [self setupOneChildViewController:[[WFNavViewController alloc]initWithRootViewController:mainVC] andTitle:@"我的" andImage:@"wo" andSelectedImage:@"ｗｏ－"];
    
}//添加子控制器

////添加中间按钮（在View即将显示时候调用的方法里面添加）
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    //为了防止此方法被调用多次而产生多个button，所以代码最好写在单利方法里面(也可以让这个button懒加载)
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        /*增加一个中间的按钮*/
//        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [publishButton setImage:[UIImage imageNamed:@"tabBar_wo_icon"] forState:UIControlStateNormal];
//        [publishButton setImage:[UIImage imageNamed:@"tabBar_wo_selected_icon"] forState:UIControlStateHighlighted];
//        publishButton.frame = CGRectMake(0, 0, self.tabBar.frame.size.width / 5, self.tabBar.frame.size.height);
//        publishButton.center = CGPointMake(self.tabBar.frame.size.width*0.5, self.tabBar.frame.size.height*0.5);
//        [publishButton addTarget:self action:@selector(CenterClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.tabBar addSubview:publishButton];
//    });
//}
//


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
