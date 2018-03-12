//
//  NYNPayViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNPayViewController.h"
#import "NYNChoosePayMethodTableViewCell.h"
#import "NYNChoosePayTwoTableViewCell.h"
#import "NYNPayChooseModel.h"
#import "NYNGouMaiView.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DealPasswordSetView.h"
#import "ForgetPasswordView.h"
#import "FTLoginNetTool.h"
#import "AllDealViewController.h"
#import<CommonCrypto/CommonDigest.h>
typedef enum : NSUInteger {
    PasswordStateDef,           //设置密码(默认)
    PasswordStateSure,          //确认密码
    PasswordStateCommit,        //提交
    PasswordStateReset,         //修改密码
} PasswordState;


@interface NYNPayViewController ()<UITableViewDelegate,UITableViewDataSource,WXApiDelegate,DealPasswordSetViewDelagate,ForgetPasswordViewDelagate>
{
     NSTimer* time;
}
@property (nonatomic,strong) UITableView *chooseChoosePayMethod;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NYNGouMaiView* bottomView;
@property (nonatomic,assign) NSInteger num;
@property(nonatomic,assign)DealPasswordSetView * dealView;

@property(nonatomic,strong)ForgetPasswordView * forgetView;
@property (nonatomic,assign) int codeIndex;
@property(nonatomic,strong)NSString * firstPassword;//第一次输入的密码
@property (nonatomic,assign) PasswordState psdState;//密码输入情景
@property(nonatomic,strong)NSMutableDictionary * dataArray;



@end

@implementation NYNPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.title = @"支付订单";
    
    for (int i = 0; i < 3; i++) {
        NYNPayChooseModel *model = [[NYNPayChooseModel alloc]init];
        if (i == 0) {
            model.iconStr = @"farm_icon_balance";
            model.aliPayStr = @"余额支付";
        }
//        else if (i == 1){
////            model.iconStr = @"farm_icon_gold";
////            model.aliPayStr = @"网农币支付";
//        }
        else if (i == 1){
            model.iconStr = @"farm_icon_zhifubao";
            model.aliPayStr = @"支付宝支付";
        }
        else if (i == 2){
            model.iconStr = @"farm_icon_weixin";
            model.aliPayStr = @"微信支付";
        }
//        else{
//            model.iconStr = @"farm_icon_cash";
//            model.aliPayStr = @"花果山农场代金券 100元";
//            model.detailContentStr = @"仅限花果山农场使用";
//            model.timeContentStr = @"过期时间：2017-05-20";
//        }
        model.isChoose = NO;
        [self.dataArr addObject:model];
    }
    
    
    self.view.backgroundColor = Color888888;
    self.chooseChoosePayMethod.backgroundColor = Colorededed;
    self.chooseChoosePayMethod.scrollEnabled = NO;
    
    [self createchooseChoosePayMethod];
    
    
    self.bottomView = [[NYNGouMaiView alloc]init];
    [self.bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) -64, SCREENWIDTH, JZHEIGHT(45))];
    [self.bottomView.goumaiBT setTitle:@"确认付款" forState:0];
    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"%.2f元",[_totlePrice floatValue]];
    __weak typeof(self)weakSelf = self;
    self.bottomView.goumaiBlock = ^(NSString *strValue) {
//        NYNPayViewController *vc = [[NYNPayViewController alloc]init];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
        JZLog(@"去支付款");
    
        
        switch (weakSelf.num) {
                case 0:
            {
                    //余额支付前付款前先判断是否存在支付密码
                [weakSelf isPayPasswd];
                
            }
                
                break;
                
                
            case 1:
            {
            //支付宝
                NSString *typeS;
                if ([weakSelf.typeStr isEqualToString:@"0"] || [weakSelf.typeStr isEqualToString:@"1"]) {
                    typeS = @"NORMAL";
                }
                
                if ([weakSelf.typeStr isEqualToString:@"3"]) {
                    typeS = @"NEWTASK";
                }else if ([weakSelf.typeStr isEqualToString:@"4"]){
                     typeS = @"CART";//购物车订单
                }
                //typeS
                NSDictionary *dic = @{@"orderSn":weakSelf.model.sn,@"payOrderType":typeS};
                [NYNNetTool AliPayWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
                    
                } success:^(id success) {
                    JZLog(@"");
                    if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                        NSString *str = [NSString stringWithFormat:@"%@",success[@"data"]];
                        [[AlipaySDK defaultService] payOrder:str fromScheme:@"wangnonggongshelalala" callback:^(NSDictionary *resultDic) {
                            
//                            [self.navigationController popToViewController:self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 3] animated:YES];
                            
                            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                            
                            NSLog(@"reslut = %@",resultDic);
                        }];
                        
                    }else{
                        [weakSelf showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                    }
                    [weakSelf hideLoadingView];
                } failure:^(NSError *failure) {
                    JZLog(@"");
                    [weakSelf hideLoadingView];
                }];
                
                
            }
                break;
            case 2:
            {
            //微信支付
                UserInfoModel *model = userInfoModel;
                
                NSString *typeS;
                if ([weakSelf.typeStr isEqualToString:@"0"] ||[weakSelf.typeStr isEqualToString:@"1"]) {
                    typeS = @"NORMAL";
                }else if ([weakSelf.typeStr isEqualToString:@"4"]){
                    typeS = @"CART";
                }
                
                
                NSDictionary *dic = @{@"body":weakSelf.model.orderName,
                                    @"out_trade_no":weakSelf.model.sn,
                                    @"total_fee":[NSString stringWithFormat:@"%.0f",[weakSelf.model.amount doubleValue] * 100],
                                    @"spbill_create_ip":model.ip,
//                                    @"attach":@"",
                                    @"payOrderType":typeS};
                [weakSelf showLoadingView:@""];
                
                [NYNNetTool WeChatPayWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
                    
                } success:^(id success) {
                    NSLog(@"-------------%@",success);
                    
                    
                    if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                        PayReq *request = [[PayReq alloc] init];
                        
                        request.partnerId = [NSString stringWithFormat:@"%@",success[@"data"][@"partnerid"]];
                        
                        request.prepayId= [NSString stringWithFormat:@"%@",success[@"data"][@"prepayid"]];
                        
                        request.package = [NSString stringWithFormat:@"%@",success[@"data"][@"packageValue"]];
                        
                        request.nonceStr= [NSString stringWithFormat:@"%@",success[@"data"][@"noncestr"]];
                        
                        request.timeStamp= [[NSString stringWithFormat:@"%@",success[@"data"][@"timestamp"]] intValue];
                        
                        request.sign= [NSString stringWithFormat:@"%@",success[@"data"][@"sign"]];
                        
//                        request.appID = [NSString stringWithFormat:@"%@",success[@"appid"]];
                        
                        [WXApi sendReq: request];
                        
                    }else{
                        [weakSelf showTextProgressView:[NSString stringWithFormat:@"%@",success[@"code"]]];
                    }
                    
                    [weakSelf hideLoadingView];
                } failure:^(NSError *failure) {
                    JZLog(@"");
                    
                    [weakSelf hideLoadingView];
                }];

            }
                break;
                
            default:
            {
            
            }
                break;
        }
        
    };
    [self.view addSubview:self.bottomView];
    
}
#pragma mark--DealPasswordSetViewDelagate
//设置新密码
-(void)SetTextFieldString:(NSString*)textField{
    //根据当前情况,对输入框进行相应设置
    switch (self.psdState) {
        case PasswordStateDef://设置密码(默认)
            //记录输入的密码
            self.firstPassword = textField;
            //切换情景为确认密码
            self.psdState = PasswordStateSure;
            
            _dealView.titleLabel.text =@"请再次输入确定密码";
            [_dealView clear];
            
            break;
        case PasswordStateSure://确认密码
            [self makeSurePassword:textField];
            break;
        case PasswordStateCommit://提交
            _dealView.forgetBtn.hidden = NO;
            _dealView.forgetBtn.hidden = NO;
            
            [self checkClick:textField];
            
            
            break;
        case PasswordStateReset://修改密码
            
            break;
            
        default:
            break;
    }

    


}

- (void)makeSurePassword:(NSString *)password {
    if ([self.firstPassword isEqualToString:password]) {
        //确认成功
        NSLog(@"确认密码成功");
        //请求设置新密码
        NSDictionary* dic =@{@"newPasswd":[self md5:VALID_STRING(password)]};
        
        [NYNNetTool AddPayPasswdWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            NSLog(@"-------------%@",success);
            
            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                //切换情景为提交
                self.psdState = PasswordStateCommit;
                //清空输入框
                [self.dealView clear];
                //设置输入框标题
                self.dealView.titleLabel.text = @"请输入交易密码";
            }else{
                [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            }
            
            [self hideLoadingView];
        } failure:^(NSError *failure) {
            
            [self hideLoadingView];
        }];
    

        
    }else {
        //确认密码失败
        NSLog(@"两次密码输入不一样");
    }
}

//忘记密码
-(void)setGetPassword:(UIButton *)sender{
    //移除密码
    _dealView.hidden = YES;
    
    ForgetPasswordView * forgetView = [[ForgetPasswordView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
     UIColor * color = [UIColor whiteColor];
    forgetView.backgroundColor=[color colorWithAlphaComponent:0];
    forgetView.delegate=self;
    forgetView.delegate=self;
    
    [self.view addSubview:forgetView];
    _forgetView = forgetView;
    
    
    
    
}

- (void)deleteBtnClick:(UIButton *)sender {
        _dealView.hidden = YES;
    
}


//校验支付密码
-(void)checkClick:(NSString*)password{
    NSDictionary * dic =@{@"passwd":[self md5:VALID_STRING(password)],@"payType":@"pay",@"orderSn":self.model.sn,@"payOrderType":@"NORMAL"};
    
    [NYNNetTool CheckWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NSLog(@"-------------%@",success);
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            _dataArray = success[@"data"];
            
            //余额支付
            [self yuePay:_dataArray[@"transToken"]];
            
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"code"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        JZLog(@"");
        
        [self hideLoadingView];
    }];
    
}



#pragma mark---ForgetPasswordViewDelagate
//获取验证码
-(void)GetyanzhengmaClick:(NSString *)phoneStr{
    
    [self showLoadingView:@""];
    if ([MyControl isPhoneNumber:phoneStr]) {
        [FTLoginNetTool ObtainCodeWithparams:@{@"account":phoneStr} isTestLogin:NO progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            [self showTextProgressView:VALID_STRING(success[@"msg"])];
            [self hideLoadingView];
            
            if([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]){
                //这里是验证码计时开始
                [_forgetView.yanzhengBtn setEnabled:NO];
                self.codeIndex = 60;
                [_forgetView.yanzhengBtn setTitle:[NSString stringWithFormat:@"%dS",self.codeIndex] forState:UIControlStateNormal];
                
                time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gogo) userInfo:nil repeats:YES];
            }else{
                
            }
        } failure:^(NSError *failure) {
            [self showTextProgressView:@"网络请求失败!"];
            [self hideLoadingView];
        }];
    }else{
        [self showTextProgressView:@"请输入正确的手机号码!"];
        [self hideLoadingView];
    }
    
}

- (void)gogo{
    self.codeIndex--;
    
    [ _forgetView.yanzhengBtn setTitle:[NSString stringWithFormat:@"%dS",self.codeIndex] forState:UIControlStateNormal];
    
    if (self.codeIndex<=0) {
        [_forgetView.yanzhengBtn setEnabled:YES];
        [_forgetView.yanzhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [time invalidate];
    }
}


-(void)GetphoneNumber:(NSString *)phoneStr yanzhengmaStr:(NSString *)yanzhengmaStr{
    
    NSDictionary * dic =@{@"account":phoneStr,@"captcha":yanzhengmaStr};
    
    [NYNNetTool ForgetPayPasswdWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NSLog(@"-------------%@",success);
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            UIColor * color = [UIColor whiteColor];
            
            //添加支付密码的view
            DealPasswordSetView* dealView = [[DealPasswordSetView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
            dealView.backgroundColor=[color colorWithAlphaComponent:0];
            dealView.delegate=self;
            
            [self.view addSubview:dealView];
            _dealView = dealView;
            
            //0表示没有设置过密码，1表示有初始化密码
            if ([success[@"data"] intValue]==0) {
                [_dealView setTitleNameStr:@"" isBool:0];
            }else{
                self.psdState = PasswordStateCommit;
                [_dealView setTitleNameStr:@"" isBool:1];
                
            }
            
            
            
            
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"code"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        JZLog(@"");
        
        [self hideLoadingView];
    }];
    
}

//删除按钮
-(void)deletButton:(UIButton *)sender{
    _forgetView.hidden=YES;
    
}

//查询是否有支付密码
-(void)isPayPasswd{
    NSDictionary * dic = @{};
    
    [NYNNetTool IsPayPasswdWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NSLog(@"-------------%@",success);
        
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            UIColor * color = [UIColor whiteColor];
            
            //添加支付密码的view
            DealPasswordSetView* dealView = [[DealPasswordSetView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
            dealView.backgroundColor=[color colorWithAlphaComponent:0];
            dealView.delegate=self;
            
            [self.view addSubview:dealView];
            _dealView = dealView;
            
            //0表示没有设置过密码，1表示有初始化密码
            if ([success[@"data"] intValue]==0) {
                [_dealView setTitleNameStr:@"" isBool:0];
            }else{
                self.psdState = PasswordStateCommit;
                [_dealView setTitleNameStr:@"" isBool:1];
                
            }
            
            
            
            
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"code"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        JZLog(@"");
        
        [self hideLoadingView];
    }];
    
    
}




-(void)yuePay:(NSString*)token{
    //余额支付
    NSDictionary * dic = @{@"transToken":token};
    [NYNNetTool CostBlanceWithparams:dic  isTestLogin:YES progress:^(NSProgress *progress) {
        
        
    } success:^(id success) {
        NSLog(@"%@",success);
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            _dealView.hidden= YES;
            
            //跳转到我的订单界面
            AllDealViewController *vc = [[AllDealViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.fromMarket = YES;
            if (_selectBool ==YES) {
                 vc.selectedIndex = 0;
            }else{
                 vc.selectedIndex = 1;
            }
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else{
            
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
           
        }
         [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
        
    }];
}
- (void)createchooseChoosePayMethod{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.chooseChoosePayMethod.delegate = self;
    self.chooseChoosePayMethod.dataSource = self;
    self.chooseChoosePayMethod.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chooseChoosePayMethod.showsVerticalScrollIndicator = NO;
    self.chooseChoosePayMethod.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.chooseChoosePayMethod];
}



#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        NYNChoosePayTwoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChoosePayTwoTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        NYNPayChooseModel *model = self.dataArr[indexPath.row];
        
        
        
        if (model.isChoose) {
            farmLiveTableViewCell.chooseImageView.image = [UIImage imageNamed:@"farm_icon_selected4"];
        }else{
            farmLiveTableViewCell.chooseImageView.image = [UIImage imageNamed:@"farm_icon_notselected3"];
            
            
            
        }
        
        farmLiveTableViewCell.iconImageView.image = Imaged(model.iconStr);
        farmLiveTableViewCell.chooseLabel.text = model.aliPayStr;
        farmLiveTableViewCell.detailLabel.text = model.detailContentStr;
        farmLiveTableViewCell.timeLabel.text = model.timeContentStr;
        return farmLiveTableViewCell;
    }else{
        NYNChoosePayMethodTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChoosePayMethodTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        NYNPayChooseModel *model = self.dataArr[indexPath.row];
        
        
        
        if (model.isChoose) {
            farmLiveTableViewCell.chooseImageView.image = [UIImage imageNamed:@"farm_icon_selected4"];
        }else{
            farmLiveTableViewCell.chooseImageView.image = [UIImage imageNamed:@"farm_icon_notselected3"];
        }
        
        farmLiveTableViewCell.iconImageView.image = Imaged(model.iconStr);
        farmLiveTableViewCell.chooseLabel.text = model.aliPayStr;
        
        return farmLiveTableViewCell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        return JZHEIGHT(66);
        
    }else{
        return JZHEIGHT(46);
        
    }
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
//    return headerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return section == 0 ?  0.0001 : 5;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
//    return footerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.0001;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    FTEarthDetailViewController *vc = [[FTEarthDetailViewController alloc]init];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
    
    for (NYNPayChooseModel *model in self.dataArr) {
        model.isChoose = NO;
    }
    
    NYNPayChooseModel *model = self.dataArr[indexPath.row];
    model.isChoose = YES;
    
    self.num = indexPath.row;
    
    //    NSIndexSet *ss = [NSIndexSet indexSetWithIndex:indexPath.section];
    //    [self.chooseChoosePayMethod reloadSections:ss withRowAnimation:UITableViewRowAnimationNone];
    //    NSIndexPath *dd = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    //    [self.chooseChoosePayMethod reloadRowsAtIndexPaths:@[dd] withRowAnimation:UITableViewRowAnimationNone];
    [self.chooseChoosePayMethod reloadData];
}


-(UITableView *)chooseChoosePayMethod{
    if (!_chooseChoosePayMethod) {
        _chooseChoosePayMethod = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    }
    return _chooseChoosePayMethod;
}


-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

//获取ip地址
//- (NSArray *)getIpAddresses{
//    NSString *address = @"error";
//    struct ifaddrs *interfaces = NULL;
//    struct ifaddrs *temp_addr = NULL;
//    int success = 0;
//    // retrieve the current interfaces - returns 0 on success
//    success = getifaddrs(&interfaces);
//    if (success == 0)
//    {
//        // Loop through linked list of interfaces
//        temp_addr = interfaces;
//        while(temp_addr != NULL)
//        {
//            if(temp_addr->ifa_addr->sa_family == AF_INET)
//            {
//                // Check if interface is en0 which is the wifi connection on the iPhone
//                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
//                {
//                    // Get NSString from C String
//                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                }
//            }
//            temp_addr = temp_addr->ifa_next;
//        }
//    }
//    // Free memory
//    freeifaddrs(interfaces);
//    return [address UTF8String];
//}

-(void)onReq:(BaseReq *)req{
    JZLog(@"");
}

-(void)onResp:(BaseResp *)resp{
    JZLog(@"");
}


- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end
