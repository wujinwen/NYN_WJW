//
//  BaseViewController.h
//  NetworkEngineer
//
//  Created by tangjinzhao on 17/5/15.
//  Copyright © 2017年 com.NetworkEngineer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DataBackUp)(id ss);


@interface BaseViewController : UIViewController

@property (nonatomic,strong) UIView *bakcView;

/**需求大类的id*/
@property(nonatomic, copy) NSString *requireID;
//控制器回调
@property (nonatomic,copy) DataBackUp DataBackUp;

- (CGFloat)caculateheight:(NSString *)content;
/**蒙版*/
- (void)showLoadingView:(NSString*)tipText;
/**隐藏蒙版*/
- (void)hideLoadingView;
- (void)showTextProgressView:(NSString*)tipText;
/**提示*/
- (void)showTipsView:(NSString*)tipText;
/**移除提示*/
- (void)removeTipsView;
/**跳出上一级 */
- (void)popToLastViewController;
/**获取登录用户*/
//- (BiNetUserInfoModel *)getLoginUserModel;

/**获取登录信息*/
//-(JNLoginUserInfo *)ToGetAccount;

/**随机生成七牛图片名称*/
- (NSString*)getRandomFileName:(NSString*)suffix;
// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum;
//邮箱地址的正则表达式
- (BOOL)isValidateEmail:(NSString *)email;
//返回事件
- (void)backToLast:(UIButton *)btn;

@end
