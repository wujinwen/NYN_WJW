//
//  NYNWantYangZhiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNWantYangZhiViewController.h"
#import "NYNEarthZuDiTableViewCell.h"
#import "NYNChooseTableViewCell.h"
#import "NYNZuDiZhongZhiTableViewCell.h"
#import "NYNXuanZeZhongZiTableViewCell.h"
#import "NYNSheXiangJianKongTableViewCell.h"
#import "NYNShouHuoPeiSongTableViewCell.h"
#import "NYNChoosePeiSongAddressTableViewCell.h"
#import "NYNChooseSeedViewController.h"
#import "NYNChooseGuanJiaViewController.h"
#import "NYNChooseBiaoShiPaiViewController.h"
#import "NYNChanPinJiaGongViewController.h"
#import "NYNBaoXianGouMaiViewController.h"
#import "NYNPayViewController.h"
#import "NYNZhongZhiFangAnViewController.h"
#import "NYNAiXinJuanZengViewController.h"
#import "NYNYangZhiBuyActionTableViewCell.h"
#import "NYNMeAdressViewController.h"
#import "NYNQueRenDingDanViewController.h"

#import "NYNYangZhiFangAnViewController.h"

#import "NYNXuanZeZhongZiModel.h"
#import "NYNGouMaiView.h"


#import "NYNWantYangZhiModel.h"
#import "NYNChuShiHuaModel.h"
#import "NYNYangZhiFangAnModel.h"
#import "ChooseLandViewController.h"
#import "NYNCategoryPageModel.h"

@interface NYNWantYangZhiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *wangtZhongTable;
@property (nonatomic,strong) NYNGouMaiView* bottomView;

@property (nonatomic,strong) NYNWantYangZhiModel *dataModel;

@property (nonatomic,assign) float totlePrice;

@property (nonatomic,strong) NYNChuShiHuaModel *chuShiHuaModel;


@property (nonatomic,strong) UITextField *whoTextField;
@property (nonatomic,strong) UITextField *forWhoTextField;
@property (nonatomic,strong) UITextField *whatTextField;

@property(nonatomic,strong)NSString * countSting;//养殖数量






@end

@implementation NYNWantYangZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"养殖订单";
    
    [self showLoadingView:@""];

    UserInfoModel * user= userInfoModel;
    NSLog(@"%@",user.token);
    
    
    
    [NYNNetTool InitDataWithparams:@{@"farmingId":self.yangzhiID} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        JZLog(@"");
        if ([[NSString stringWithFormat:@"%@",success[@"msg"]] isEqualToString:@"success"]) {
            NYNChuShiHuaModel *model = [NYNChuShiHuaModel mj_objectWithKeyValues:success[@"data"]];
            self.chuShiHuaModel = model;
             self.chuShiHuaModel.jianKongIsChoose = YES;
            
            self.chuShiHuaModel.yangZhiCountStr = 1;
            self.chuShiHuaModel.yangZhiFangAnNameStr = @"省心方案";
            self.chuShiHuaModel.yangZhiFangAnTotlePriceStr = 0;
//            self.chuShiHuaModel.yangZhiBiaoZhiIDStr
            
            self.chuShiHuaModel.yangZhiGuanJiaNameStr = @"系统自动分配";
//            self.chuShiHuaModel.yangZhiGuanJiaIDStr
            
            self.chuShiHuaModel.yangZhiBiaoZhiNameStr = self.chuShiHuaModel.defaultSignboardName;
            self.chuShiHuaModel.yangZhiBiaoZhiIDStr = self.chuShiHuaModel.defaultSignboardId;
            self.chuShiHuaModel.yangZhiBiaoZhiPriceStr = self.chuShiHuaModel.defaultSignboardPrice;
            
            self.chuShiHuaModel.farmManagerId = @"-1";
            
            self.chuShiHuaModel.yangZhiJiaGongNameStr = @"请选择";
            self.chuShiHuaModel.yangZhiJiaGongIDStr = @"-1";
            self.chuShiHuaModel.yangZhiJiaGongPriceStr = @"0.00";
            
            self.chuShiHuaModel.yangZhiBaoXianNameStr = @"请选择";
            self.chuShiHuaModel.yangZhiBaoXianIDStr = @"-1";
            self.chuShiHuaModel.yangZhiJiaGongPriceStr = @"0.00";
            
            self.chuShiHuaModel.yangZhiPeiSongIsChoose = YES;
            
            self.chuShiHuaModel.peiSongDiZhiIsChoose = YES;
            self.chuShiHuaModel.aiXinJuanZengIsChoose = NO;
            
            //是使用默认订单
            self.chuShiHuaModel.isDefaultTemplate = YES;
            
            //周期这里不传
            
            [NYNNetTool GetMoRenFangAnWithparams:@{@"farmingId":self.yangzhiID} isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                    
//                    if (([success[@"data"][@"cycleTime"] isEqual:[NSNull null]] || [success[@"data"][@"cycleTime"] isKindOfClass:[NSNull class]] || success[@"data"][@"cycleTime"] == nil)) {
//                        self.chuShiHuaModel.cycTime = 100;
//                    }else{
//                        self.chuShiHuaModel.cycTime = [[NSString stringWithFormat:@"%@",success[@"data"][@"cycleTime"]] intValue];
//
//                    }
                     self.chuShiHuaModel.cycTime = [[NSString stringWithFormat:@"%@",success[@"data"][@"cycleTime"]] intValue];
                    
                    [self.chuShiHuaModel.fangAnArr removeAllObjects];
                    
//                    self.cycleTime = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",success[@"data"][@"cycleTime"]]];
                    
                    NSMutableArray *arr = [NSMutableArray arrayWithArray:success[@"data"][@"artOrderItemResults"]];
                    
                    NSMutableArray *lieBiaoArr = [[NSMutableArray alloc]init];
                    for (NSDictionary *dc in arr) {
                        NYNYangZhiFangAnModel *model = [NYNYangZhiFangAnModel mj_objectWithKeyValues:dc];
                        [lieBiaoArr addObject:model];
                    }
                    
                    NYNYangZhiFangAnModel *shiFeiModel = [[NYNYangZhiFangAnModel alloc]init];
                    shiFeiModel.ctype = @"1";
                    
                    NYNYangZhiFangAnModel *caoNiMaModel = [[NYNYangZhiFangAnModel alloc]init];
                    caoNiMaModel.ctype = @"6";
                    
                    //创建周期model  前台手动增加一个cellmodel
                    NYNYangZhiFangAnModel *zhouQiModel = [[NYNYangZhiFangAnModel alloc]init];
                    zhouQiModel.ctype = @"3";
//                    zhouQiModel.count = [NSString stringWithFormat:@"%d",self.chuShiHuaModel.cycTime];
                    zhouQiModel.checked = @"1";
                    [self.chuShiHuaModel.fangAnArr addObject:zhouQiModel];
                    
                    for (NYNYangZhiFangAnModel *subM in lieBiaoArr) {
                        if ([subM.ctype isEqualToString:@"1"]) {
                            [shiFeiModel.subArr addObject:subM];
                        }
                        else if ([subM.ctype isEqualToString:@"6"]){
                            [caoNiMaModel.subArr addObject:subM];
                        }
                        else{
                            [self.chuShiHuaModel.fangAnArr addObject:subM];
                            
                            if ([subM.ctype isEqualToString:@"2"]) {
                                subM.chooseDate = [NSDate date];
                            }
                        }
                    }
                    
                    caoNiMaModel.checked = @"1";
                    shiFeiModel.checked = @"1";
                    
                    caoNiMaModel.count = @"0";
                    shiFeiModel.count = @"0";
                    
                    for (int i = 0; i < caoNiMaModel.subArr.count; i++) {
                                    NYNYangZhiFangAnModel *caoMD = caoNiMaModel.subArr[i];
                                    if (i == 0) {
                                        caoMD.checked = @"1";
                                    }else{
                                        caoMD.checked = @"0";
                                    }
                                }
                    
                    for (int i = 0; i < shiFeiModel.subArr.count; i++) {
                                    NYNYangZhiFangAnModel *caoMD = shiFeiModel.subArr[i];
                                    if (i == 0) {
                                        caoMD.checked = @"1";
                                    }else{
                                        caoMD.checked = @"0";
                                    }
                                }
                    
                    //最后将这个数据加入
                    if (caoNiMaModel.subArr.count > 0) {
                        //这个是ctype=6
                        [self.chuShiHuaModel.fangAnArr addObject:caoNiMaModel];
                    }
                    
                    if (shiFeiModel.subArr.count > 0) {
                        //这个是ctype=1
                        [self.chuShiHuaModel.fangAnArr addObject:shiFeiModel];
                    }
                    

                    
                    [self createwangtZhongTable];
                    
                    self.bottomView = [[NYNGouMaiView alloc]init];
                    [self.bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) -64, SCREENWIDTH, JZHEIGHT(45))];
                    [self.bottomView.goumaiBT setTitle:@"付款" forState:0];
                    __weak typeof(self)weakSelf = self;
                    self.bottomView.goumaiBlock = ^(NSString *strValue) {
                        
                        if (weakSelf.whoTextField.text.length < 1 || weakSelf.forWhoTextField.text.length < 1 || weakSelf.whatTextField.text.length < 1) {
                            [weakSelf showTextProgressView:@"请补充名称"];
                            [weakSelf hideLoadingView];
                            return ;
                        }
                        
                        
                        //这里拼接订单的数据
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        NSString *nameStr = [NSString stringWithFormat:@"%@为%@种的%@",weakSelf.whoTextField.text,weakSelf.forWhoTextField.text,weakSelf.whatTextField.text];
                        
                        [dic setObject:nameStr forKey:@"name"];
                        [dic setObject:@([weakSelf.chuShiHuaModel.farmManagerId integerValue]) forKey:@"farmManagerId"];
                        [dic setObject:@([weakSelf.chuShiHuaModel.defaultUserAddressId integerValue]) forKey:@"userAddressId"];
                        [dic setObject:weakSelf.chuShiHuaModel.isDefaultTemplate ? @1 : @0 forKey:@"isDefaultTemplate"];
                        [dic setObject:@([weakSelf.farmID integerValue]) forKey:@"farmId"];
                        [dic setObject:weakSelf.chuShiHuaModel.yangZhiPeiSongIsChoose ? @1 : @0 forKey:@"isDelivery"];
//                        [dic setValue:true forKey:@"isDelivery"];
                        [dic setObject:@(weakSelf.chuShiHuaModel.yangZhiCycle) forKey:@"cycleTime"];
                        [dic setObject:@"grow" forKey:@"type"];
                        NSMutableArray *itemModels = [[NSMutableArray alloc]init];
                        
                        //类型  主要，eg: 土地（禽畜、集市产品）
                        NSMutableDictionary *chanPinDic = @{@"productId":@([weakSelf.yangzhiID integerValue]),@"type":@"MINOR",@"quantity":@(weakSelf.chuShiHuaModel.yangZhiCountStr)}.mutableCopy;
                        
                        //养殖场地
              
                        NSMutableDictionary *zhongZiDic = @{@"productId":@([weakSelf.chuShiHuaModel.yangzhiID integerValue]),@"type":@"MAJOR",@"quantity":@(weakSelf.chuShiHuaModel.yangZhiCountStr)}.mutableCopy;
                        
                        NSMutableDictionary *biaoZhiPaiDic = @{@"productId":@([weakSelf.chuShiHuaModel.defaultSignboardId integerValue]),@"type":@"PRODUCT",@"quantity":@1}.mutableCopy;

                        NSMutableDictionary *jiaGongDic = @{@"productId":@([weakSelf.chuShiHuaModel.yangZhiJiaGongIDStr integerValue]),@"type":@"PLAN_PRODUCT",@"quantity":@1,@"duration":@1,@"interval":@1}.mutableCopy;
                        
                        
                      //监控
                        NSMutableArray * jianKongDic = @{@"productId":@([weakSelf.chuShiHuaModel.monitorId integerValue]),@"type":@"PRODUCT",@"quantity":@1}.mutableCopy;


                        [itemModels addObject:chanPinDic];

                        [itemModels addObject:zhongZiDic];
     
                        
                        if (![weakSelf.chuShiHuaModel.yangZhiBiaoZhiNameStr isEqualToString:@"请选择"]) {
                            [itemModels addObject:biaoZhiPaiDic];

                        }
                        
                        if (![weakSelf.chuShiHuaModel.yangZhiJiaGongNameStr isEqualToString:@"请选择"]) {
                            [itemModels addObject:jiaGongDic];

                        }
                        if (weakSelf.chuShiHuaModel.jianKongIsChoose ==YES) {
                            [itemModels addObject:jianKongDic];
                        }
                        
                        
                        if (weakSelf.chuShiHuaModel.isDefaultTemplate) {
                            
                        }else{
                            for (NYNYangZhiFangAnModel *model in weakSelf.chuShiHuaModel.fangAnArr) {
                                //只有选中才计算价格
                                if ([model.checked isEqualToString:@"1"]) {
                                    
                                    NSMutableDictionary *d ;
                                    
                                    if ([model.ctype isEqualToString:@"0"]) {
                                    d = @{@"productId":@([model.artProductId integerValue]),@"type":@"PLAN",
                                            @"quantity":@([model.count intValue])}.mutableCopy;
                                    }
                                    else if ([model.ctype isEqualToString:@"1"]){
                                        //这里清理出来选中的子单元格
                                    NYNYangZhiFangAnModel *nowSubModel;
                                    for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                                            if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                                                nowSubModel = subFirstDataModel;
                                            }
                                        }
                                        
                                    d = @{@"productId":@([nowSubModel.artProductId integerValue]),@"type":@"PLAN",
                                              @"quantity":@([nowSubModel.count intValue])}.mutableCopy;
                                    }
                                    else if ([model.ctype isEqualToString:@"2"]){
                                    NSString *timeStr = [MyControl timeToTimeCode:model.executeDate];
                                        NSArray *rr = @[@{@"title":model.categoryName,@"executeDate":timeStr}];
                                        
                                    d = @{@"productId":@([model.artProductId integerValue]),
                                          @"type":@"PLAN",
                                          @"quantity":@([model.count intValue]),
                                          @"countItemModels":rr
                                          }.mutableCopy;
                                        
                                    }
                                    else if ([model.ctype isEqualToString:@"3"]){
                                    d = @{@"productId":@([model.artProductId integerValue]),@"type":@"PLAN",
                                              @"quantity":@([model.count intValue])}.mutableCopy;
                                    }
                                    else if ([model.ctype isEqualToString:@"4"]){
                                    d = @{@"productId":@([model.artProductId integerValue]),
                                          @"type":@"PLAN",
                                          @"quantity":@([model.count intValue]),
                                          @"duration":@([model.duration intValue]),
                                          @"interval":@([model.interval intValue])
                                          }.mutableCopy;
                                    }
                                    else if ([model.ctype isEqualToString:@"6"]){
                                        //这里清理出来选中的子单元格
                                        NYNYangZhiFangAnModel *nowSubModel;
                                        for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                                            if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                                                nowSubModel = subFirstDataModel;
                                            }
                                        }
                                        
                                        d = @{@"productId":@([nowSubModel.artProductId integerValue]),@"type":@"PLAN",
                                              @"quantity":@1}.mutableCopy;
                                    }
                                    else{
                                        
                                    }
                                    
                                    if ([model.ctype isEqualToString:@"3"]) {
                                        
                                    }else{
                                        [itemModels addObject:d];
                                    }
                                    
                                }
                            }
                        }
                        

                        
                        
                        [dic setObject:itemModels forKey:@"itemModels"];
                        
                        NSDictionary *cc = @{@"data":[MyControl dictionaryToJson:dic]};

                        [weakSelf showLoadingView:@""];
                        [NYNNetTool AddDealWithYangZhiZhongZhiWithparams:cc isTestLogin:YES progress:^(NSProgress *progress) {
                            
                        } success:^(id success) {
                            
                            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                                //订单
                                NYNDealModel *model = [NYNDealModel mj_objectWithKeyValues:success[@"data"]];
                                
                                NYNQueRenDingDanViewController *vc = [[NYNQueRenDingDanViewController alloc]init];
                                vc.model = model;
                                vc.type = @"1";
                                vc.picName = weakSelf.picName;

                                
                                [weakSelf.navigationController pushViewController:vc animated:YES];
                            }else{
                                [weakSelf showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                            }
                            [weakSelf hideLoadingView];
                        } failure:^(NSError *failure) {
                            [weakSelf hideLoadingView];
                        }];
                        
                        
//                        NYNPayViewController *vc = [[NYNPayViewController alloc]init];
//                        
//                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    };
                    [self.view addSubview:self.bottomView];
                    
                    
                    [self reloadFangAnPrice];
                    
                }else{
                    [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                }
                
                [self hideLoadingView];
            } failure:^(NSError *failure) {
                
                [self hideLoadingView];
            }];
            
            
 
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",success[@"msg"]]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        JZLog(@"");
        [self hideLoadingView];
    }];
    
    
    
    ADD_NTF_OBJ(@"yangZhiNotify", @selector(yangzhi), nil);
}

- (void)yangzhi{
    self.chuShiHuaModel.isDefaultTemplate = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self reloadPrice];
}

- (void)createwangtZhongTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.wangtZhongTable.delegate = self;
    self.wangtZhongTable.dataSource = self;
    self.wangtZhongTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.wangtZhongTable.showsVerticalScrollIndicator = NO;
    self.wangtZhongTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.wangtZhongTable];
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        return 4;
    }else{
        if (self.chuShiHuaModel.yangZhiPeiSongIsChoose == YES) {
            return 3;
        }else{
            return 1;
        }
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NYNYangZhiBuyActionTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNYangZhiBuyActionTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            __weak typeof(self)weakSelf = self;
            
            farmLiveTableViewCell.count = self.chuShiHuaModel.yangZhiCountStr;
            
            NSString *tStr = [NSString stringWithFormat:@"%.2f元",self.chuShiHuaModel.yangZhiCountStr * self.unitPrice];
            NSString *dStr = [NSString stringWithFormat:@"(%.2f/%@元)",self.unitPrice,self.unit];
            farmLiveTableViewCell.priceLabel.attributedText = [MyControl CreateNSAttributedString:[NSString stringWithFormat:@"%@%@",tStr,dStr] thePartOneIndex:NSMakeRange(0, tStr.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:14] andPartTwoIndex:NSMakeRange(tStr.length, dStr.length) withColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
            
            
            __weak typeof(farmLiveTableViewCell)weakFarmLiveTableViewCell = farmLiveTableViewCell;
            farmLiveTableViewCell.selectClick = ^(int str) {
//                _countSting =farmLiveTableViewCell.countLable.text;
                
                if (str < 1) {
                    self.chuShiHuaModel.yangZhiCountStr = 1;
                }else{
                    weakSelf.chuShiHuaModel.yangZhiCountStr = str;
                }
                NSString *tStr = [NSString stringWithFormat:@"%.2f元",self.chuShiHuaModel.yangZhiCountStr * self.unitPrice];
                NSString *dStr = [NSString stringWithFormat:@"(¥%.2f/%@)",self.unitPrice,self.unit];
                weakFarmLiveTableViewCell.priceLabel.attributedText = [MyControl CreateNSAttributedString:[NSString stringWithFormat:@"%@%@",tStr,dStr] thePartOneIndex:NSMakeRange(0, tStr.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:14] andPartTwoIndex:NSMakeRange(tStr.length, dStr.length) withColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
                
                [weakSelf reloadFangAnPrice];
        
//                NSIndexPath *indexP = [NSIndexPath indexPathForRow:2 inSection:2];
                NSIndexPath *indexP1 = [NSIndexPath indexPathForRow:0 inSection:3];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[indexP1] withRowAnimation:UITableViewRowAnimationNone];
                
            };
            
            return farmLiveTableViewCell;
        }else if (indexPath.row ==1){
            NYNYangZhiBuyActionTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNYangZhiBuyActionTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.timeLabel.text = @"养殖周期";
            farmLiveTableViewCell.priceLabel.hidden = YES;
            farmLiveTableViewCell.count = self.chuShiHuaModel.yangZhiCycle;
               __weak typeof(self)weakSelf = self;
            farmLiveTableViewCell.selectClick = ^(int str) {
                //                _countSting =farmLiveTableViewCell.countLable.text;
                
                if (str < 1) {
                    weakSelf.chuShiHuaModel.yangZhiCountStr = 1;
                }else{
                    weakSelf.chuShiHuaModel.yangZhiCycle = str;
                }
                
                [weakSelf reloadFangAnPrice];
                
//                NSIndexPath *indexP = [NSIndexPath indexPathForRow:2 inSection:2];
                NSIndexPath *indexP1 = [NSIndexPath indexPathForRow:0 inSection:1];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[indexP1] withRowAnimation:UITableViewRowAnimationNone];
                
            };
            
               return farmLiveTableViewCell;
        }
        else{
            NYNZuDiZhongZhiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNZuDiZhongZhiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            NSString *str = @"动物名片 *";
        
            farmLiveTableViewCell.iConTitleLabel.attributedText = [MyControl CreateNSAttributedString:str thePartOneIndex:NSMakeRange(0, 4) withColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14] andPartTwoIndex:NSMakeRange(4, 2) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:14]];
            
            self.whoTextField = farmLiveTableViewCell.whoTF;
//            self.whoTextField.text = userInfoModel.name;
            self.forWhoTextField = farmLiveTableViewCell.forWhoTF;
//            self.forWhoTextField.text = @"喜欢的人";
            self.whatTextField = farmLiveTableViewCell.ZhiWuTF;
            self.whatTextField.text = self.proName;
            return farmLiveTableViewCell;
        }
        
        
        
    }else if (indexPath.section == 1){
        if (indexPath.row ==0 ) {
            NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabel.text = @"养殖场地";
            farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"%@",self.chuShiHuaModel.yangZhiNameStr];
//            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",self.selectModel.selectCount * [self.selectModel.price doubleValue]];
          //个数*周期
//            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",self.chuShiHuaModel.yangZhiFangAnTotlePriceStr];
              farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元", [self.chuShiHuaModel.price  doubleValue]* self.chuShiHuaModel.yangZhiCycle];
            
            return farmLiveTableViewCell;
        }else if (indexPath.row == 1) {
            NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabel.text = @"养殖方案";
            farmLiveTableViewCell.contentLabel.text = self.dataModel.fangan;
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",self.chuShiHuaModel.yangZhiFangAnTotlePriceStr];

            return farmLiveTableViewCell;
        }else{
            NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabel.text = @"biao'zhi";
            farmLiveTableViewCell.contentLabel.text = self.chuShiHuaModel.yangZhiFangAnNameStr;
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",self.chuShiHuaModel.yangZhiFangAnTotlePriceStr];
            return farmLiveTableViewCell;
        }
    }else if (indexPath.section == 2){
        
        switch (indexPath.row) {
            case 0:
            {
                NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.titleLabel.text = @"执行管家";
                farmLiveTableViewCell.contentLabel.text = @"";
//                farmLiveTableViewCell.priceLabel.text = self.dataModel.guanjia;
                farmLiveTableViewCell.priceLabel.textColor = Color252827;
                
                farmLiveTableViewCell.zhanweiLabel.text = self.chuShiHuaModel.yangZhiGuanJiaNameStr;
                farmLiveTableViewCell.contentLabel.hidden = YES;
                farmLiveTableViewCell.priceLabel.hidden = YES;
                farmLiveTableViewCell.zhanweiLabel.hidden = NO;
                
                return farmLiveTableViewCell;
            }
                break;
            case 1:
            {
                NYNSheXiangJianKongTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNSheXiangJianKongTableViewCell class]) owner:self options:nil].firstObject;
                }
                 farmLiveTableViewCell.titleLabel.text = @"监控摄像";
                farmLiveTableViewCell.priceLabel.text =  [NSString stringWithFormat:@"%d",[self.chuShiHuaModel.defaultMonitor intValue]];
                
                if (self.chuShiHuaModel.jianKongIsChoose) {

                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
                    [self reloadPrice];
                    farmLiveTableViewCell.priceLabel.text =  [NSString stringWithFormat:@"%d",[self.chuShiHuaModel.defaultMonitor intValue]];
                }else{
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
                    farmLiveTableViewCell.priceLabel.text =  @"0";
                        [self reloadPrice];
                }
              

                return farmLiveTableViewCell;
            }
                break;
            case 2:
            {
                NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.titleLabel.text = @"标志标识";
                farmLiveTableViewCell.contentLabel.text = self.chuShiHuaModel.yangZhiBiaoZhiNameStr;
                farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%@元",self.chuShiHuaModel.yangZhiBiaoZhiPriceStr];
                farmLiveTableViewCell.xingLabel.hidden = YES;
                return farmLiveTableViewCell;
            }
                break;
            case 3:
            {
                NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.titleLabel.text = @"产品加工";
                farmLiveTableViewCell.contentLabel.text = self.chuShiHuaModel.yangZhiJiaGongNameStr;
                farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[self.chuShiHuaModel.yangZhiJiaGongPriceStr doubleValue] * self.chuShiHuaModel.yangZhiCountStr];
                farmLiveTableViewCell.xingLabel.hidden = YES;
                return farmLiveTableViewCell;
            }
                break;
            default:
            {
                NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.titleLabel.text = @"作物保险";
                farmLiveTableViewCell.contentLabel.text = self.chuShiHuaModel.yangZhiBaoXianNameStr;
                farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%@元",self.chuShiHuaModel.yangZhiBaoXianPriceStr];
                farmLiveTableViewCell.xingLabel.hidden = YES;
                return farmLiveTableViewCell;
            }
                break;
        }
        
        
    }else{
        
        switch (indexPath.row) {
            case 0:
            {
                NYNShouHuoPeiSongTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShouHuoPeiSongTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.cellLabel.text = [NSString stringWithFormat:@"（%.2f/㎡）",[self.chuShiHuaModel.freight doubleValue]];
                farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[self.chuShiHuaModel.freight doubleValue] * self.chuShiHuaModel.yangZhiCountStr];
                if (self.chuShiHuaModel.yangZhiPeiSongIsChoose == YES) {
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
                }else{
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
                }
            
                return farmLiveTableViewCell;
            }
                break;
            case 1:
            {
                NYNChoosePeiSongAddressTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChoosePeiSongAddressTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"配送地址：%@",self.chuShiHuaModel.defaultUserAddressTitle];

                if (self.chuShiHuaModel.peiSongDiZhiIsChoose == YES) {
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_selected");
                }else{
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_unchecked");
                }
                return farmLiveTableViewCell;
            }
                break;
            case 2:
            {
                NYNChoosePeiSongAddressTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChoosePeiSongAddressTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.contentLabel.text = @"亲自到场收取";
                
                if (self.chuShiHuaModel.aiXinJuanZengIsChoose) {
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_selected");
                }else{
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_unchecked");
                }
                
                return farmLiveTableViewCell;
            }
                break;
            default:
            {
                NYNChoosePeiSongAddressTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChoosePeiSongAddressTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.contentLabel.text = @"爱心捐赠：张彩芳";
                
                return farmLiveTableViewCell;
            }
                break;
        }
        
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return JZHEIGHT(JZHEIGHT(51));
        }
        else{
            return JZHEIGHT(45);
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return JZHEIGHT(45);
        }
        else{
            return JZHEIGHT(45);
        }
    }else if (indexPath.section == 2){
        return JZHEIGHT(45);
    }else{
        if (indexPath.row == 0) {
            return JZHEIGHT(45);
        }
        else{
            return JZHEIGHT(40);
        }
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : JZHEIGHT(5))];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }else{
        return JZHEIGHT(5);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
//                NYNCategoryPageModel *model = self.dataArr[indexPath.row];
            //选择作物种植
           __weak typeof(self)weakSelf = self;
            ChooseLandViewController * landVC = [[ChooseLandViewController alloc]init];

            landVC.farmID = self.farmID;
            
            [landVC getTitle:@"选择养殖场地" type:@"grow"];
            
//            landVC.selectModel = self.selectModel;
            landVC.selectBlock= ^(NYNXuanZeZhongZiModel *model){
//                _priceString = model.price;
//                _yangzhiName =model.name;
                weakSelf.chuShiHuaModel.yangZhiNameStr =model.name;
                weakSelf.chuShiHuaModel.price = model.price;
                weakSelf.chuShiHuaModel.yangzhiID = model.ID;
                
                
//                [weakSelf seedChange];
        
                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                
            };
            
            
            [self.navigationController pushViewController:landVC animated:YES];
            
            
        }else{
            NYNYangZhiFangAnViewController *vc = [[NYNYangZhiFangAnViewController alloc]init];
            vc.farmingId = self.yangzhiID;
            vc.yangZhiCount = self.chuShiHuaModel.yangZhiCountStr;
            vc.chuShiHuaModel = [self.chuShiHuaModel copy];
            vc.dataArr = vc.chuShiHuaModel.fangAnArr;
            vc.yangzhiTime =self.chuShiHuaModel.yangZhiCycle;
            
            __weak typeof(self)weakSelf = self;
            vc.modelBack = ^(NYNChuShiHuaModel *model) {
                weakSelf.chuShiHuaModel = model;
                [weakSelf reloadFangAnPrice];
                NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
                [weakSelf.wangtZhongTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
      
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            NYNChooseGuanJiaViewController *vc = [[NYNChooseGuanJiaViewController alloc]init];
            vc.farmID = self.farmID;
            __weak typeof(self)weakSelf = self;
            vc.guanJiaBlcok = ^(NYNGuanJiaModel *model) {
//                [self.priceArr replaceObjectAtIndex:indexPath.row withObject:name];
                weakSelf.chuShiHuaModel.yangZhiGuanJiaNameStr = model.name;
                weakSelf.chuShiHuaModel.yangZhiGuanJiaIDStr = model.ID;
//                weakSelf.
                
                NSIndexPath *ss = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[ss] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1){
            //监控摄像
             self.chuShiHuaModel.jianKongIsChoose = !self.chuShiHuaModel.jianKongIsChoose;
            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            [self.wangtZhongTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
            
            
        }
        else if (indexPath.row == 3){
            NYNChanPinJiaGongViewController *vc = [[NYNChanPinJiaGongViewController alloc]init];
            vc.productId = self.yangzhiID;
            [vc setProductId:self.yangzhiID type:@"1"];
            __weak __typeof(self)weakSelf = self;
            
            vc.returnBlock = ^(NYNChanPinJiaGongModel *model) {
                weakSelf.chuShiHuaModel.yangZhiJiaGongNameStr = model.farmArtName;
                weakSelf.chuShiHuaModel.yangZhiJiaGongPriceStr = model.price;
                weakSelf.chuShiHuaModel.yangZhiJiaGongIDStr = model.ID;
                
                
//                weakSelf.jiagongPrice = [model.price floatValue];
                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (indexPath.row == 2){
            //保险界面后期不要
//            NYNBaoXianGouMaiViewController *vc = [[NYNBaoXianGouMaiViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
            //标志标识
            NYNChooseBiaoShiPaiViewController *vc = [[NYNChooseBiaoShiPaiViewController alloc]init];
            vc.farmID = self.farmID;
            __weak __typeof(self)weakSelf = self;
               vc.type = @"1";
            
            vc.chooseBlock = ^(NYNBiaoShiPaiModel *model) {
                
                weakSelf.chuShiHuaModel.defaultSignboardName = model.name;
                weakSelf.chuShiHuaModel.defaultSignboardPrice = model.price;
                weakSelf.chuShiHuaModel.yangZhiBiaoZhiIDStr = model.ID;
                
                [weakSelf reloadPrice];

                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            
        }
    }else{
        if (indexPath.row == 0) {
            self.chuShiHuaModel.yangZhiPeiSongIsChoose = !self.chuShiHuaModel.yangZhiPeiSongIsChoose;

            NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
            [self.wangtZhongTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
            
            [self reloadPrice];
        }
        
        if (indexPath.row == 1) {
            NYNMeAdressViewController *vc = [[NYNMeAdressViewController alloc]init];
            __weak typeof(self) weakSelf = self;
            vc.addressClickBlock = ^(NYNMeAddressModel *model) {
                self.chuShiHuaModel.defaultUserAddressTitle = model.address;
                self.chuShiHuaModel.defaultUserAddressId = model.ID;
                
                self.chuShiHuaModel.peiSongDiZhiIsChoose = YES;
                NSIndexPath *idp = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        //爱心捐赠后期也不要了
        
//        if (indexPath.row == 2) {
//            NYNAiXinJuanZengViewController *vc = [[NYNAiXinJuanZengViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
    }
}

#pragma 懒加载
-(UITableView *)wangtZhongTable
{
    
    if (!_wangtZhongTable) {
        _wangtZhongTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(45)) style:UITableViewStyleGrouped];
    }
    return _wangtZhongTable;
}

-(NYNWantYangZhiModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [NYNWantYangZhiModel new];
        
        _dataModel.yangZhiCount = 0;
        
        _dataModel.yangZhiName = @"谁为谁中的大西瓜";
        
        _dataModel.fangan = @"省心方案";
        _dataModel.guanjia = @"默认管家";
        _dataModel.biaozhi = @"木质牌";
        _dataModel.jiagong = @"去泥清洗";
        _dataModel.baoxian = @"自然灾害险";
        
        _dataModel.isChoosePeiSong = YES;
        
        _dataModel.fangAnPrice = 20;
        _dataModel.biaozhiPrice = 5;
        _dataModel.jiagongPrice = 5;
        _dataModel.baoxianPrice = 5;
        _dataModel.peisongPrice = 15;

    }
    return _dataModel;
}

- (void)reloadPrice{
    self.totlePrice=0;
    
    float price = 0;
    price = price
    + self.chuShiHuaModel.yangZhiFangAnTotlePriceStr
    + [self.chuShiHuaModel.yangZhiBiaoZhiPriceStr doubleValue]
    + [self.chuShiHuaModel.yangZhiJiaGongPriceStr doubleValue] * self.chuShiHuaModel.yangZhiCountStr
    + [self.chuShiHuaModel.yangZhiBaoXianPriceStr doubleValue]
    +self.chuShiHuaModel.yangZhiCountStr * self.unitPrice;
    
    if (self.chuShiHuaModel.yangZhiPeiSongIsChoose == YES) {
        price = price + [self.chuShiHuaModel.freight doubleValue] * self.chuShiHuaModel.yangZhiCountStr;
    }
    
    self.totlePrice = price;

    //养殖场地
     self.totlePrice =self.totlePrice +  [self.chuShiHuaModel.price intValue] * self.chuShiHuaModel.yangZhiCycle ;
    
    //监控的价格
    if (self.chuShiHuaModel.jianKongIsChoose) {
        self.totlePrice = self.totlePrice + [self.chuShiHuaModel.defaultMonitor doubleValue];
        JZLog(@"监控价格%.2f",[self.chuShiHuaModel.defaultMonitor doubleValue]);
        
        
        
    }
    
//    //标志的价格
//    self.totlePrice = self.totlePrice + [self.chuShiHuaModel.yangZhiBiaoZhiPriceStr doubleValue];
//    JZLog(@"标志价格%.2f",[self.chuShiHuaModel.yangZhiBiaoZhiPriceStr doubleValue]);
    
    
    //加工的价格
//    self.totlePrice = self.totlePrice + [self.chuShiHuaModel.yangZhiJiaGongPriceStr doubleValue];
//    JZLog(@"加工价格%.2f",[self.chuShiHuaModel.yangZhiJiaGongPriceStr doubleValue]);
    
    
    //配送价格
    if (self.chuShiHuaModel.yangZhiPeiSongIsChoose) {
        self.totlePrice = self.totlePrice + [self.chuShiHuaModel.freight doubleValue] * self.chuShiHuaModel.chooseEarthCount;
        //
        JZLog(@"配送价格%.2f",[self.chuShiHuaModel.freight doubleValue]);
    }
    
    
    
    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"%.2f元",self.totlePrice];
    
   
}

- (void)reloadFangAnPrice{
    self.chuShiHuaModel.yangZhiFangAnTotlePriceStr = 0;
    for (NYNYangZhiFangAnModel *model in self.chuShiHuaModel.fangAnArr) {
        
        if ([model.checked isEqualToString:@"1"]) {
            
            if ([model.ctype isEqualToString:@"0"]) {
                double addPrice = [model.price doubleValue] * self.chuShiHuaModel.yangZhiCountStr * [model.count intValue];
                self.chuShiHuaModel.yangZhiFangAnTotlePriceStr = self.chuShiHuaModel.yangZhiFangAnTotlePriceStr + addPrice;
                
                JZLog(@"ctype1 price = %f  yangZhiFangAnTotlePriceStr = %f",addPrice,self.chuShiHuaModel.yangZhiFangAnTotlePriceStr);
            }
            else if ([model.ctype isEqualToString:@"1"]){
                //这里清理出来选中的子单元格
                NYNYangZhiFangAnModel *nowSubModel;
                for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                    if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                        nowSubModel = subFirstDataModel;
                    }
                }
                double addPrice = [nowSubModel.price doubleValue] * self.chuShiHuaModel.yangZhiCountStr * [nowSubModel.count intValue];
                self.chuShiHuaModel.yangZhiFangAnTotlePriceStr = self.chuShiHuaModel.yangZhiFangAnTotlePriceStr + addPrice;
                
                JZLog(@"ctype1 price = %f  yangZhiFangAnTotlePriceStr = %f",addPrice,self.chuShiHuaModel.yangZhiFangAnTotlePriceStr);

            }
            else if ([model.ctype isEqualToString:@"2"]){
                
                double addPrice = [model.price doubleValue] * self.chuShiHuaModel.yangZhiCountStr;
                self.chuShiHuaModel.yangZhiFangAnTotlePriceStr = self.chuShiHuaModel.yangZhiFangAnTotlePriceStr + addPrice;
                
                
            }
            else if ([model.ctype isEqualToString:@"3"]){
                //养殖周期
                int a =self.chuShiHuaModel.yangZhiCycle/ [model.interval intValue];
                int b = (a==0)?(a=1):a;
                
                //farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%d", b* [model.count intValue]];
                double addPrice = b* [model.count intValue]*[model.price doubleValue];
               self.chuShiHuaModel.yangZhiFangAnTotlePriceStr = self.chuShiHuaModel.yangZhiFangAnTotlePriceStr + addPrice;
                
                JZLog(@"ctype4 price = %f  yangZhiFangAnTotlePriceStr = %f",addPrice,self.totlePrice);
            }
            else if ([model.ctype isEqualToString:@"4"]){
//                double addPrice = [model.price doubleValue] * ([model.duration intValue] / [model.interval intValue] * [model.count intValue]);
//                self.chuShiHuaModel.yangZhiFangAnTotlePriceStr = self.chuShiHuaModel.yangZhiFangAnTotlePriceStr + addPrice;
                
                int a =self.chuShiHuaModel.yangZhiCycle/ [model.interval intValue];
                int b = (a==0)?(a=1):a;
                double addPrice = b* [model.count intValue]*[model.price doubleValue];
              self.chuShiHuaModel.yangZhiFangAnTotlePriceStr = self.chuShiHuaModel.yangZhiFangAnTotlePriceStr + addPrice;
                
                JZLog(@"ctype4 price = %f  yangZhiFangAnTotlePriceStr = %f",addPrice,self.totlePrice);
            }
            else if ([model.ctype isEqualToString:@"6"]){
                //这里清理出来选中的子单元格
                NYNYangZhiFangAnModel *nowSubModel;
                for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                    if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                        nowSubModel = subFirstDataModel;
                    }
                }
                double addPrice = [nowSubModel.price doubleValue] * self.chuShiHuaModel.yangZhiCountStr;
                self.chuShiHuaModel.yangZhiFangAnTotlePriceStr = self.chuShiHuaModel.yangZhiFangAnTotlePriceStr + addPrice;
                
                JZLog(@"ctype1 price = %f  yangZhiFangAnTotlePriceStr = %f",addPrice,self.chuShiHuaModel.yangZhiFangAnTotlePriceStr);

            }
            else {
                JZLog(@"未知的ctype出现，编号为:%@",model.ctype);
            }
            
        }
        
    }
    JZLog(@"当前方案总价为:%.2f",self.chuShiHuaModel.yangZhiFangAnTotlePriceStr);
    
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    [self.wangtZhongTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
    [self reloadPrice];
}

@end

