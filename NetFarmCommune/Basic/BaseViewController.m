//
//  BaseViewController.m
//  NetworkEngineer
//
//  Created by tangjinzhao on 17/5/15.
//  Copyright © 2017年 com.NetworkEngineer. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "JNTipsView.h"
#import "SVProgressHUD.h"



@interface BaseViewController ()
@property (nonatomic, retain) MBProgressHUD *progressHUD;

@property (nonatomic, retain) NSTimer * tipsTimer;

@property (nonatomic, retain) SVProgressHUD *svProgressHUD;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    // IOS7新特性，UIScrollView、UITableView会自动下移20px
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BackGroundColor;
    
    UIView *bakcView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    self.bakcView = bakcView;
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH - JZWITH(198)) / 2, JZHEIGHT(112), JZWITH(198), JZHEIGHT(139))];
    backImageView.image = Imaged(@"public_no-data");
    [bakcView addSubview:backImageView];
    
    UILabel *wuShuJuLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, backImageView.bottom + JZHEIGHT(12), SCREENWIDTH, JZHEIGHT(20))];
    wuShuJuLabel.text = @"当前暂无数据";
    wuShuJuLabel.font = JZFont(15);
    wuShuJuLabel.textColor = Color888888;
    wuShuJuLabel.textAlignment = 1;
    [bakcView addSubview:wuShuJuLabel];
    
    [self.view addSubview:bakcView];
    
    self.bakcView.hidden = YES;
    
    [self setBackbuttonItem];

    
}
#pragma mark=================================设置返回按钮==================================
- (void)setBackbuttonItem{
    //判断子视图控制器的数量，如果不为1，则重置返回按钮
    NSInteger count = self.navigationController.childViewControllers.count;
    if (count != 1) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"public_icon_return"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 20);
        [btn addTarget:self action:@selector(backToLast:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        //使用弹簧控件缩小菜单按钮和边缘距离
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = -10;
        self.navigationItem.leftBarButtonItems = @[spaceItem, barButtonItem];
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     
     @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
       
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

- (void)backToLast:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark =============================提示框========================================

/*
 ScaleToFill   填充父控件，会拉伸变形
 AspectToFit   宽高比不变保持长边贴近父控件
 AspectToFill  宽高比不变最大填充父控件
 4.7寸是667的高
 */

- (CGFloat)caculateheight:(NSString *)content{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGSize labelsize = [content boundingRectWithSize:CGSizeMake(SCREENWIDTH-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    JZLog(@"%f",labelsize.height);
    return labelsize.height;
}
/**蒙版*/
- (void)showLoadingView:(NSString*)tipText {
    
    NSString *showText ;
    if (tipText.length < 1) {
        showText = @"正在加载";
        
    }else{
        showText = tipText;

    }
    
    [SVProgressHUD showWithStatus:showText];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setForegroundColor:Color90b659];
    [SVProgressHUD setRingThickness:6];
    [SVProgressHUD setRingRadius:JZWITH(32.5)];
    [SVProgressHUD setRingNoTextRadius:JZWITH(32.5)];
    
    
    
}



- (void)showTextProgressView:(NSString*)tipText{
    [SVProgressHUD showWithStatus:tipText];

}


/**隐藏蒙版*/
- (void)hideLoadingView {
//    if (nil != self.progressHUD) {
////        [self.progressHUD hide:YES];
//        [self.progressHUD hide:YES afterDelay:0.3];
//    }
//    self.progressHUD=nil;
    [SVProgressHUD dismissWithDelay:0.5];
}
/**跳出上一级 */
- (void)popToLastViewController{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
/**提示*/
- (void)showTipsView:(NSString*)tipText
{
    JNTipsView * tipsView = (JNTipsView *)[self.view viewWithTag:TIP_VIEW_TAG];
    
    if (nil == tipsView) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        tipsView = [[JNTipsView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
        [tipsView setTag:TIP_VIEW_TAG];
        [self.view.window addSubview:tipsView];
    }
    
    [tipsView setTipText:tipText];
    [self.view.window bringSubviewToFront:tipsView];
    
    self.tipsTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(removeTipsView) userInfo:nil repeats:NO];
}

- (void)removeTipsView {
    [self.tipsTimer invalidate];
    self.tipsTimer = nil;
    
    JNTipsView * tipsView = (JNTipsView *)[self.view.window viewWithTag:TIP_VIEW_TAG];
    
    if (nil != tipsView) {
        [tipsView removeFromSuperview];
    }
}

/**获取登录信息*/
//-(JNLoginUserInfo *)ToGetAccount
//{
//    JNLoginUserInfo * account=[NSKeyedUnarchiver unarchiveObjectWithFile:JNAccountPathFile];
//    return account;
//}

/**随机生成七牛图片名称*/
- (NSString*)getRandomFileName:(NSString*)suffix
{
    int cur_time_interval = (int)[[NSDate date] timeIntervalSince1970];
    int rand = arc4random() % 100; // 获取 0-99之间的随机数
    return [NSString stringWithFormat:@"%d%d.%@", cur_time_interval, rand, suffix];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum{
    /**18384596599
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183,184
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,181,189,177
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,152,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[0127-9]|8[23478]|78|47)\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,176,145
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|76|45)\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,181,189,177
     22         */
    NSString * CT = @"^1((33|53|8[019]|77)[0-9]|349)\\d{7}\\d{3}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        if([regextestcm evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        return YES;
    }
    else
    {
        return NO;
    }
}
//邮箱地址的正则表达式
- (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}





@end
