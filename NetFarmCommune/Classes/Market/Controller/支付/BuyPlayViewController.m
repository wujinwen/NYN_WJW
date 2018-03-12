//
//  BuyPlayViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/9.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "BuyPlayViewController.h"
#import "NYNMeChongZhiTableViewCell.h"
#import "GoumaiOneTableViewCell.h"
#import "GoumaiTwoTableViewCell.h"
#import "PayMoneyTableViewCell.h"
#import "NYNMeAdressViewController.h"
#import "NYNMeAddressModel.h"
#import "WXApi.h"
#import "NYNDealModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DealPasswordSetView.h"
#import<CommonCrypto/CommonDigest.h>

#import "AllDealViewController.h"
#import "NYNPayViewController.h"
#import <Masonry/Masonry.h>

typedef enum : NSUInteger {
    PasswordStateDef,           //设置密码(默认)
    PasswordStateSure,          //确认密码
    PasswordStateCommit,        //提交
    PasswordStateReset,         //修改密码
} PasswordState;


@interface BuyPlayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSArray * payStyleArr;

@property(nonatomic,strong)NSMutableDictionary * dataArray;

@property(nonatomic,strong)NSString * selectString;
@property (nonatomic,assign) NSInteger didSelectNumber;//选中的支付

@property(nonatomic,strong)DealPasswordSetView* dealView;

@property(nonatomic,strong)NSString * firstPassword;//第一次输入的密码
@property (nonatomic,assign) PasswordState psdState;//密码输入情景

@property(nonatomic,strong)NSString * addresString;//地址

@property(nonatomic,strong)UIButton * tijiaoButton;//提交订单






@end

@implementation BuyPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.title =@"购买支付";
    [self.view addSubview:self.tableView];
  
 
    
    _payStyleArr = @[@"余额支付",@"微信支付",@"支付宝支付"];
    _dataArray = [[NSMutableDictionary alloc]init];
    [self getDefaultAddress];
    [self.view addSubview:self.tijiaoButton];
    [self.tijiaoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_offset(JZHEIGHT(45));
    }];
    
    


}
//提交订单
-(void)tijiaoButtonClick:(UIButton*)sender{
    
       [self getData];
}

//删除按钮
-(void)deleteBtnClick:(UIButton *)sender{
    _dealView.hidden = YES;
    
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



-(void)getData{
    
    //获取订单信息
        NSMutableArray *itemModels = [[NSMutableArray alloc]init];
        NSDictionary *chanPinDic = @{@"productId":_lictModel.ID,@"quantity":_countString};
        [itemModels addObject:chanPinDic];
    
        NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
          [dic setObject:_addresString forKey:@"userAddressId"];
          [dic setObject:_farmId forKey:@"farmId"];
          [dic setObject:@"general" forKey:@"type"];
  
          [dic setObject:itemModels forKey:@"itemModels"];
    
                NSDictionary *cc = @{@"data":[MyControl dictionaryToJson:dic]};
    
    
                [NYNNetTool AddMarketSaveWithparams:cc isTestLogin:YES progress:^(NSProgress *progress) {
    
                } success:^(id success) {
    
                    if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//                       NYNDealModel *model = [NYNDealModel mj_objectWithKeyValues:success[@"data"]];
                        
                        _dataArray =success[@"data"];

                        NYNPayViewController * payvc =[[NYNPayViewController alloc]init];
                        payvc.typeStr=@"NORMAL";
                        payvc.totlePrice =[NSString stringWithFormat:@"%.2f",[_countString floatValue]*[_lictModel.price floatValue]+_yunfeiPrice];
                        
                        
                        NYNDealModel *model = [NYNDealModel mj_objectWithKeyValues:_dataArray];
                        payvc.model =model;
                        [self.navigationController pushViewController:payvc animated:YES];
                        
                    }else{
                        [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                    }
                    [self hideLoadingView];
                } failure:^(NSError *failure) {
                    [self hideLoadingView];
                }];
    
}



//获取用户默认地址
-(void)getDefaultAddress{
    
    NSDictionary * dic = @{};
    
    [NYNNetTool DefaultqueryWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//                                   NYNDealModel *model = [NYNDealModel mj_objectWithKeyValues:success[@"data"]];
            
            
            if (success[@"data"] ==NULL) {
                [self showTextProgressView:@"请先填写收货地址"];
                 [self hideLoadingView];
            }
            self.lictModel.defaultUserAddressTitle   = success[@"data"][@"address"];
         _addresString= success[@"data"][@"id"];
        
            [self.tableView reloadData];
            
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}
//选择支付方式
-(void)chooseButtonclick:(UIButton*)sender{
    
}

#pragma mark--UITableViewDelegate,UITableViewDataSource;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
   }

        else{
        return 1;
        
    }


}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
     __weak typeof(self)weakSelf = self;
    if (indexPath.section==0) {
      GoumaiOneTableViewCell  * goumaiCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (goumaiCell == nil) {
            goumaiCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GoumaiOneTableViewCell class]) owner:self options:nil].firstObject;
        }
        if (_lictModel!= nil) {
//            goumaiCell.farmLabel.text = _lictModel.name;
            goumaiCell.countLabel.text = [NSString stringWithFormat:@"x%@",_countString];
            goumaiCell.lictModel =_lictModel;
            
            goumaiCell.messegeTextView.text =_lictModel.intro;
            goumaiCell.totallabel.text =[NSString stringWithFormat:@"合计：¥%.2f",[_countString floatValue]*[_lictModel.price floatValue]+_yunfeiPrice];
            goumaiCell.yunfeiLabel.text =[NSString stringWithFormat:@"(含运费%.2f)",_yunfeiPrice];
            
            
        }
 
        
    
        goumaiCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return goumaiCell;
        
        
    }else if (indexPath.section==1){
        GoumaiTwoTableViewCell  * Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (Cell == nil) {
            Cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GoumaiTwoTableViewCell class]) owner:self options:nil].firstObject;
        }
        NYNMeAdressViewController * addressVC = [[NYNMeAdressViewController alloc]init];
        addressVC.addressClickBlock = ^(NYNMeAddressModel *model) {
            self.lictModel.defaultUserAddressId = model.ID;
              self.lictModel.defaultUserAddressTitle = model.address;
            NSIndexPath *idp = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationNone];
        };
      

        //地址管理跳转
        Cell.guanliBlock= ^(NSString *strValue){
            [weakSelf.navigationController pushViewController:addressVC animated:YES];
            
        };
      
  
        
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return Cell;
        
    }else if (indexPath.section==2){
        NYNMeChongZhiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeChongZhiTableViewCell class]) owner:self options:nil].firstObject;
        }
        if (indexPath.row == 0) {
            farmLiveTableViewCell.contentLabel.font=[UIFont systemFontOfSize:17];
            
            
        }else{
            farmLiveTableViewCell.contentLabel.text=_payStyleArr[indexPath.row-1];
        }
        [farmLiveTableViewCell.chooseButton addTarget:self action:@selector(chooseButtonclick:) forControlEvents:UIControlEventTouchUpInside];
        
        
       farmLiveTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return farmLiveTableViewCell;
    }else{
        PayMoneyTableViewCell * payCell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (payCell == nil) {
            payCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PayMoneyTableViewCell class]) owner:self options:nil].firstObject;
        }
        //付款按钮bolck回传
        payCell.moneyBlock= ^(NSString *strValue){
            [weakSelf getData];
            
            
        };
        payCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return payCell;
        
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 180;
    }else if (indexPath.section==1){
         return 80;
        
    }else{
        return 72;
        
        
    }
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        _selectString=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        
    }
        self.didSelectNumber = indexPath.row;
}











-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor lightGrayColor];
        view.alpha=0.5;
        
        return view;
    }
    return nil;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
           return 8;
    }
    return 0;
    
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
    
}

-(UIButton *)tijiaoButton{
    if (!_tijiaoButton) {
        _tijiaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _tijiaoButton.backgroundColor =Color90b659;
        [_tijiaoButton setTitle:@"提交订单" forState:UIControlStateNormal];
        _tijiaoButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_tijiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_tijiaoButton addTarget:self action:@selector(tijiaoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
    }
    return _tijiaoButton;
    
}

@end
