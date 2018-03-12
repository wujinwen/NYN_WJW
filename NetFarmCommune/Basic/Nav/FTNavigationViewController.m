//
//  FTNavigationViewController.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/18.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTNavigationViewController.h"
//#import "NETestingViewController.h"
//#import "NEPractisingViewController.h"
//#import "NEMeViewController.h"
#import "NYNHomeViewController.h"
#import "FTSearchViewController.h"
#import "NYNFarmViewController.h"
#import "NYNLiveRoomViewController.h"
#import "OutDoorLiveRoomVC.h"


@interface FTNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation FTNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.navigationBar setBarTintColor:SelectedColor];
    
//    UIImageView * navbg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public_title bar@3x"]];
//    navbg.frame = CGRectMake(0, -[[UIApplication sharedApplication] statusBarFrame].size.height, SCREENWIDTH, self.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
//    [self.navigationBar insertSubview:navbg atIndex:0];
    UIImage * image = [self scaleToSize:[UIImage imageNamed:@"public_title bar@3x"] size:CGSizeMake(SCREENWIDTH, self.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];  //设置背景
    

    

    //    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:9];
    //    NSDictionary *dic = @{NSFontAttributeName:font,
    //                          NSForegroundColorAttributeName: [UIColor blackColor]};
    //    self.navigationBar.titleTextAttributes =dic;
    self.delegate = self;
}
//图片缩放到指定大小尺寸
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//需要隐藏nav的在这里统一操作
- (BOOL) needHiddenBarInViewController:(UIViewController *)viewController {
    
    BOOL needHideNaivgaionBar = NO;
    if ([viewController isKindOfClass: [NYNHomeViewController class]]
        ||[viewController isKindOfClass: [FTSearchViewController class]]
        ||[viewController isKindOfClass: [NYNFarmViewController class]]
        ||[viewController isKindOfClass: [NYNLiveRoomViewController class]]
        ||[viewController isKindOfClass:[OutDoorLiveRoomVC class]]
      
        ) {
        needHideNaivgaionBar = YES;
    }

    return needHideNaivgaionBar;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 在 NavigationController 的这个代理方法中, 设置导航栏的隐藏和显示
    [self setNavigationBarHidden: [self needHiddenBarInViewController: viewController]
                        animated: animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
