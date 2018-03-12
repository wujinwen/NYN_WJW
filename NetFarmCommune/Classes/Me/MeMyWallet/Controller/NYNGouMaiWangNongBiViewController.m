//
//  NYNGouMaiWangNongBiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNGouMaiWangNongBiViewController.h"
#import "NYNGouMaiView.h"
#import "NYNMeChongZhiTableViewCell.h"
#import "NYNWalletChooseModel.h"
#import "FTHomeBottomButton.h"
#import "NYNGouMaiView.h"
#import "NYNMaiWangNongOneTableViewCell.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DealPasswordSetView.h"
#import<CommonCrypto/CommonDigest.h>
typedef enum : NSUInteger {
    PasswordStateDef,           //设置密码(默认)
    PasswordStateSure,          //确认密码
    PasswordStateCommit,        //提交
    PasswordStateReset,         //修改密码
} PasswordState;

@interface NYNGouMaiWangNongBiViewController ()<UITableViewDelegate,UITableViewDataSource,DealPasswordSetViewDelagate>
{
    NSInteger payNum;
    
}
@property (nonatomic,strong) UITableView *wangNongBiTable;
@property (nonatomic,strong) NYNGouMaiView *bottomView;
@property (nonatomic,strong) NSMutableArray *modelArr;
@property(nonatomic,strong)NSString * strCount;
@property (nonatomic,assign) PasswordState psdState;//密码输入情景
@property(nonatomic,assign)DealPasswordSetView * dealView;
@property(nonatomic,strong)NSString * firstPassword;//第一次输入的密码
@end

@implementation NYNGouMaiWangNongBiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _strCount = @"10000";
    
    
    for (int i = 0; i < 4; i++) {
        NYNWalletChooseModel *model = [[NYNWalletChooseModel alloc]init];
        if (i == 0) {
            model.iconName = @"mine_icon_panment";
            model.contentStr = @"支付方式";
            model.isChoose = NO;
        }
        if (i == 1) {
            model.iconName = @"mine_icon_zhifubao";
            model.contentStr = @"支付宝支付";
            model.isChoose = YES;
        }
        if (i == 2) {
            model.iconName = @"mine_icon_wxpanment";
            model.contentStr = @"微信支付";
            model.isChoose = NO;
        }
        if (i == 3) {
            model.iconName = @"mine_icon_balance";
            model.contentStr = @"余额支付";
            model.isChoose = NO;
        }
        [self.modelArr addObject:model];
    }

    self.title = @"购买网农币";
    
    [self createTable];
}

- (void)createTable{
    [self.view addSubview:self.wangNongBiTable];
    self.wangNongBiTable.showsVerticalScrollIndicator = NO;
    self.wangNongBiTable.showsHorizontalScrollIndicator = NO;
    self.wangNongBiTable.delegate = self;
    self.wangNongBiTable.dataSource = self;
    self.wangNongBiTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.bottomView];
    __weak typeof(self)weakSelf = self;
    _bottomView.goumaiBlock = ^(NSString *strValue) {
        
        if (payNum == 0) {
            //支付宝
          
      
            //typeS
            NSDictionary *dic = @{@"title":weakSelf.bottomView.heJiLabel.text,@"amount":weakSelf.strCount,@"type":@"recharge_coin"};
            [NYNNetTool AccountPayParams:dic isTestLogin:YES progress:^(NSProgress *progress) {
                
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
            
        }else if (payNum == 1){
            
                //微信充值接口
                UserInfoModel *model = userInfoModel;
                
                NSDictionary *dic = @{@"title":weakSelf.bottomView.heJiLabel.text,
                                      @"amount":weakSelf.strCount,
                                      @"spbill_create_ip":model.ip,
                                      @"type":@"recharge_coin"};
                
                [NYNNetTool AccountPayWXParams:dic isTestLogin:YES progress:^(NSProgress *progress) {
                    
                } success:^(id success) {
                    
                    
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
                
        }else if (payNum ==2){
            //余额支付
            [weakSelf isPayPasswd];
            
        }

        
        
    };
    
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
- (void)deleteBtnClick:(UIButton *)sender {
    _dealView.hidden = YES;
    
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
//                self.psdState = PasswordStateCommit;
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
//校验支付密码
-(void)checkClick:(NSString*)password{
    NSDictionary * dic =@{@"passwd":[self md5:VALID_STRING(password)],@"payType":@"pay",@"payOrderType":@"NORMAL",@"amount":self.strCount};
    
    [NYNNetTool CheckWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NSLog(@"-------------%@",success);
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//            _dataArray = success[@"data"];
//
//            //余额支付
//            [self yuePay:_dataArray[@"transToken"]];
            
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"code"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        JZLog(@"");
        
        [self hideLoadingView];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.modelArr.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        NYNMaiWangNongOneTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMaiWangNongOneTableViewCell class]) owner:self options:nil].firstObject;
        }
        //
        
        cell.countClick = ^(int i, NSString *type) {
            if ([type isEqualToString:@"-"]) {
                
                
            }else if ([type isEqualToString:@"+"]){
                
            }
            int priceInt =i;
            _bottomView.heJiLabel.text = [NSString stringWithFormat:@"%d元",priceInt/10];
            _strCount =[NSString stringWithFormat:@"%d元",priceInt*10];
            
        };
        
        cell.click = ^(int i, NSString *str) {
            int priceInt =[str intValue];
            _bottomView.heJiLabel.text = [NSString stringWithFormat:@"%d元",priceInt/10];
             _strCount =[NSString stringWithFormat:@"%d元",priceInt*10];
        };
        
        
        return cell;
        
        
        
    }else{
        NYNMeChongZhiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeChongZhiTableViewCell class]) owner:self options:nil].firstObject;
        }
        NYNWalletChooseModel *model = self.modelArr[indexPath.row];
        
        if (indexPath.row == 0) {
            farmLiveTableViewCell.iconImageView.image = Imaged(model.iconName);
            farmLiveTableViewCell.contentLabel.text = model.contentStr;
            farmLiveTableViewCell.chooseImageView.hidden= YES;
            
        }else{
            farmLiveTableViewCell.iconImageView.image = Imaged(model.iconName);
            farmLiveTableViewCell.contentLabel.text = model.contentStr;
        }
        if (model.isChoose) {
            farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_selected2");
            
        }else{
            farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_unchecked");
            
        }
        return farmLiveTableViewCell;
    }
    return nil;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (NYNWalletChooseModel *model in self.modelArr) {
        model.isChoose = NO;
    }
    
    NYNWalletChooseModel *model = self.modelArr[indexPath.row];
    model.isChoose = YES;
    
    payNum = indexPath.row-1;
    

    NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.wangNongBiTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
    
//    [self.wangNongBiTable reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 130;
        
    }else{
        return 45;
        
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headeV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(33))];
        headeV.backgroundColor = Colorededed;
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, SCREENWIDTH - JZWITH(20), JZHEIGHT(33))];
        textLabel.text = @"兑换比例：1元=10网农币";
        textLabel.font = JZFont(13);
        [headeV addSubview:textLabel];
        return headeV;
    }else{
        UIView *headeV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(62))];
        headeV.backgroundColor = Colorededed;
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, SCREENWIDTH - JZWITH(20), JZHEIGHT(62))];
        textLabel.text = @"购买网农币为本平台特有虚拟货币，仅供本平台使用，可在本平台 中某些功能中使用";
        textLabel.font = JZFont(13);
        textLabel.numberOfLines = 0;
        [headeV addSubview:textLabel];
        return headeV;

    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    footV.backgroundColor = Color888888;
    return footV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return JZHEIGHT(30);
    }else{
        return JZHEIGHT(62);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}


-(UITableView *)wangNongBiTable{
    if (!_wangNongBiTable) {
        _wangNongBiTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(46)) style:UITableViewStylePlain];
    }
    return _wangNongBiTable;
}

-(NYNGouMaiView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NYNGouMaiView alloc]init];
        [_bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) - 64, SCREENWIDTH, JZHEIGHT(45))];
        
        _bottomView.heJiLabel.text =@"100元";
    }
    
    _bottomView.gouwucheBlock = ^(NSString *strValue) {
        
    
        
    };
    

    
    return _bottomView;
}

-(NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [[NSMutableArray alloc]init];
    }
    return _modelArr;
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
