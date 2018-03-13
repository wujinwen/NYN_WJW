//
//  NYNWantZhongZhiNewViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/6.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNWantZhongZhiNewViewController.h"
#import "NYNWantZhongChuShiHuaMoel.h"
#import "NYNChuShiHuaModel.h"
#import "NYNYangZhiFangAnModel.h"

#import "NYNGouMaiView.h"
#import "NYNDealModel.h"
#import "NYNXuanZeZhongZiModel.h"
#import "NYNQueRenDingDanViewController.h"



#import "NYNEarthZuDiTableViewCell.h"
#import "NYNChooseTableViewCell.h"
#import "NYNZuDiZhongZhiTableViewCell.h"
#import "NYNXuanZeZhongZiTableViewCell.h"
#import "NYNSheXiangJianKongTableViewCell.h"
#import "NYNShouHuoPeiSongTableViewCell.h"
#import "NYNChoosePeiSongAddressTableViewCell.h"


#import "NYNChooseSeedViewController.h"
#import "NYNZhongZhiFangAnViewController.h"
#import "NYNZhongZhiNewFangAnViewController.h"
#import "NYNChooseGuanJiaViewController.h"
#import "NYNChooseBiaoShiPaiViewController.h"
#import "NYNChanPinJiaGongViewController.h"
#import "NYNBaoXianGouMaiViewController.h"
#import "NYNMeAdressViewController.h"
#import "NYNAiXinJuanZengViewController.h"
#import "NYNPayViewController.h"

#import "ChooseLandViewController.h"

@interface NYNWantZhongZhiNewViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL myselfGetBool;//亲自到场收取
    
}
@property (nonatomic,strong) NYNChuShiHuaModel *model;
@property (nonatomic,strong) UITableView *wantZhongTable;

@property (nonatomic,strong) NYNGouMaiView* bottomView;
@property (nonatomic,strong) UITextField *whoTextField;
@property (nonatomic,strong) UITextField *forWhoTextField;
@property (nonatomic,strong) UITextField *whatTextField;

@property(nonatomic,strong)NSString * titleString;//面积
@property(nonatomic,strong)NSString * cycleString;//时长





@property (nonatomic,assign) double totlePrice;
@end

@implementation NYNWantZhongZhiNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myselfGetBool =NO;
    
    
    
    [self fenLiChooseSeed];
    
    [self initData];
    
}

- (void)fenLiChooseSeed{
    
    self.selectModel = nil;
    for (NYNXuanZeZhongZiModel *selectModel in self.seedArr) {
        if (selectModel.isChoose) {
            self.selectModel = selectModel;
        }
    }
    if (self.selectModel == nil) {
        self.selectModel = [self.seedArr firstObject];
    }
    
    
    //单位重置一下
    self.earthUnit = @"㎡";
    
    self.title = @"代种订单";
}

- (void)initData{
    [self showLoadingView:@""];

    
    [NYNNetTool InitDataWithparams:@{@"farmingId":self.earthID} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NSLog(@"-------代种订单接口数据：%@",success);
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            NYNChuShiHuaModel *model = [NYNChuShiHuaModel mj_objectWithKeyValues:success[@"data"]];
            model.isDefaultTemplate = YES;
            self.model = model;
            
            self.model.jianKongIsChoose = YES;
            
            self.model.cycTime = [self.selectModel.cycleTime intValue];
            
            float f = self.selectModel.selectCount / [self.selectModel.cname intValue];
            int newInt = (int)f;
            int a;
            if (newInt - f > 0) {
                a = ceil(f);
            }else{
                a = newInt;
            }
            self.model.chooseEarthCount = a;
            self.model.earthCycleCount = [self.selectModel.cycleTime intValue];
            
            self.model.yangZhiCountStr = 1;
            self.model.yangZhiFangAnNameStr = @"省心方案";
            self.model.yangZhiFangAnTotlePriceStr = 0;
            
            self.model.yangZhiGuanJiaNameStr = @"系统自动分配";
            
            self.model.zhongZhiJianKongPriceStr = @"0.00";
            
            self.model.yangZhiBiaoZhiNameStr = self.model.defaultSignboardName;
            self.model.yangZhiBiaoZhiIDStr = self.model.defaultSignboardId;
            self.model.yangZhiBiaoZhiPriceStr = self.model.defaultSignboardPrice;
            
            self.model.farmManagerId = @"-1";

//            self.model.yangZhiJiaGongNameStr = @"请选择";
            self.model.yangZhiJiaGongIDStr = @"-1";
            self.model.yangZhiJiaGongPriceStr = @"0.00";
            
//            self.model.yangZhiBaoXianNameStr = @"请选择";
            self.model.yangZhiBaoXianIDStr = @"-1";
            self.model.yangZhiJiaGongPriceStr = @"0.00";
            
            self.model.yangZhiPeiSongIsChoose = YES;
            
            self.model.peiSongDiZhiIsChoose = YES;
            self.model.aiXinJuanZengIsChoose = NO;
            
            //获取默认方案数据
            [NYNNetTool GetMoRenFangAnWithparams:@{@"farmingId":self.earthID} isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                if([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]){
                    [model.zhongMoArr removeAllObjects];
                    
                    NSArray *arr = [NSArray arrayWithArray:success[@"data"][@"artOrderItemResults"]];
                    NSMutableArray *moLieBiaoArr = [[NSMutableArray alloc]init];

                    for (NSDictionary *dic in arr) {
                        NYNYangZhiFangAnModel *subModel = [NYNYangZhiFangAnModel mj_objectWithKeyValues:dic];;
                        
                        [moLieBiaoArr addObject:subModel];
                    }
                    
                    NYNYangZhiFangAnModel *moShiFeiModel = [[NYNYangZhiFangAnModel alloc]init];
                    moShiFeiModel.ctype = @"1";
                    
                    NYNYangZhiFangAnModel *moSixMaModel = [[NYNYangZhiFangAnModel alloc]init];
                    moSixMaModel.ctype = @"6";
                    
                    //创建周期model  前台手动增加一个cellmodel
                    NYNYangZhiFangAnModel *moZhouQiModel = [[NYNYangZhiFangAnModel alloc]init];
                    moZhouQiModel.ctype = @"3";
                    moZhouQiModel.checked = @"1";
                    [model.zhongMoArr addObject:moZhouQiModel];

                    for (NYNYangZhiFangAnModel *subM in moLieBiaoArr) {
                        if ([subM.ctype isEqualToString:@"1"]) {
                            [moShiFeiModel.subArr addObject:subM];
                        }
                        else if ([subM.ctype isEqualToString:@"6"]){
                            [moSixMaModel.subArr addObject:subM];
                        }
                        else{
                            [model.zhongMoArr addObject:subM];
                            if ([subM.ctype isEqualToString:@"2"]) {
                                subM.chooseDate = [NSDate date];
                            }
                        }
                    }
                    
                    moShiFeiModel.checked = @"1";
                    moSixMaModel.checked = @"1";
                    
                    moShiFeiModel.count = @"0";
                    moSixMaModel.count = @"0";
                    
                    
                    for (int i = 0; i < moSixMaModel.subArr.count; i++) {
                        NYNYangZhiFangAnModel *caoMD = moSixMaModel.subArr[i];
                        if (i == 0) {
                            caoMD.checked = @"1";
                        }else{
                            caoMD.checked = @"0";
                        }
                    }
                    
                    for (int i = 0; i < moShiFeiModel.subArr.count; i++) {
                        NYNYangZhiFangAnModel *caoMD = moShiFeiModel.subArr[i];
                        if (i == 0) {
                            caoMD.checked = @"1";
                        }else{
                            caoMD.checked = @"0";
                        }
                    }
                    
                    //最后将这个数据加入
                    if (moSixMaModel.subArr.count > 0) {
                        //这个是ctype=6
                        [model.zhongMoArr addObject:moSixMaModel];
                    }
                    
                    if (moShiFeiModel.subArr.count > 0) {
                        //这个是ctype=1
                        [model.zhongMoArr addObject:moShiFeiModel];
                    }
                    
                    
                    
                    //获取自定义方案数据
                    [NYNNetTool GetZiDingYiFangAnWithparams:@{@"farmingId":self.earthID,@"type":@"order"} isTestLogin:YES progress:^(NSProgress *progress) {
                        
                    } success:^(id success) {
                        if (([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"])) {
                            
                            
                            NSArray *arr = [NSArray arrayWithArray:success[@"data"]];
                            NSMutableArray *ziLieBiaoArr = [[NSMutableArray alloc]init];
                            
                            for (NSDictionary *dic in arr) {
                                NYNYangZhiFangAnModel *subModel = [NYNYangZhiFangAnModel mj_objectWithKeyValues:dic];;
                                
                                [ziLieBiaoArr addObject:subModel];
                            }
                            
                            NYNYangZhiFangAnModel *ziShiFeiModel = [[NYNYangZhiFangAnModel alloc]init];
                            ziShiFeiModel.ctype = @"1";
                            
                            NYNYangZhiFangAnModel *ziSixMaModel = [[NYNYangZhiFangAnModel alloc]init];
                            ziSixMaModel.ctype = @"6";
                            
                            //创建周期model  前台手动增加一个cellmodel
                            NYNYangZhiFangAnModel *ziZhouQiModel = [[NYNYangZhiFangAnModel alloc]init];
                            ziZhouQiModel.ctype = @"3";
                            ziZhouQiModel.checked = @"0";
                            [model.zhongZiMoArr addObject:ziZhouQiModel];
                            
                            for (NYNYangZhiFangAnModel *subM in ziLieBiaoArr) {
                                if ([subM.ctype isEqualToString:@"1"]) {
                                    [ziShiFeiModel.subArr addObject:subM];
                                }
                                else if ([subM.ctype isEqualToString:@"6"]){
                                    [ziSixMaModel.subArr addObject:subM];
                                }
                                else{
                                    [model.zhongZiMoArr addObject:subM];
                                    if ([subM.ctype isEqualToString:@"2"]) {
                                        subM.chooseDate = [NSDate date];
                                    }
                                }
                            }
                            
                            ziShiFeiModel.checked = @"0";
                            ziShiFeiModel.checked = @"0";
                            
                            ziShiFeiModel.count = @"0";
                            ziShiFeiModel.count = @"0";
                            
                            
                            for (int i = 0; i < ziSixMaModel.subArr.count; i++) {
                                NYNYangZhiFangAnModel *caoMD = ziSixMaModel.subArr[i];
                                if (i == 0) {
                                    caoMD.checked = @"1";
                                }else{
                                    caoMD.checked = @"0";
                                }
                            }
                            
                            for (int i = 0; i < ziShiFeiModel.subArr.count; i++) {
                                NYNYangZhiFangAnModel *caoMD = ziShiFeiModel.subArr[i];
                                if (i == 0) {
                                    caoMD.checked = @"1";
                                }else{
                                    caoMD.checked = @"0";
                                }
                            }
                            
                            //最后将这个数据加入
                            if (ziSixMaModel.subArr.count > 0) {
                                //这个是ctype=6
                                [model.zhongZiMoArr addObject:ziSixMaModel];
                            }
                            
                            if (ziShiFeiModel.subArr.count > 0) {
                                //这个是ctype=1
                                [model.zhongZiMoArr addObject:ziShiFeiModel];
                            }
                            
                            
                            [self beginConfigUI];
                            
                            [self reloadPrice];

                            
                            JZLog(@"");
                        }else{
                            [self showTextProgressView:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",success[@"msg"]]]];

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
                [self hideLoadingView];

            }];
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",success[@"msg"]]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];

}


- (void)reloadPrice{
    self.totlePrice = 0.00;
    self.selectModel.selectCount =  [_cycleString intValue];

    
   //self.model.chooseEarthCount *
    //土地的价格
    self.totlePrice = self.totlePrice +  self.model.earthCycleCount * [self.earthPriceStr doubleValue]*[_cycleString intValue];
    JZLog(@"土地价格%.2f",self.model.chooseEarthCount * self.model.earthCycleCount * [self.earthPriceStr doubleValue]);
    
    //种子的价格self.selectModel.selectCount *
    self.totlePrice = self.totlePrice + [self.selectModel.price doubleValue]*self.model.chooseEarthCount;
    JZLog(@"种子价格%.2f",self.model.chooseEarthCount * [self.selectModel.price doubleValue]);

    
    //监控的价格
    if (self.model.jianKongIsChoose) {
        self.totlePrice = self.totlePrice + [self.model.defaultMonitor doubleValue];
        JZLog(@"监控价格%.2f",[self.model.defaultMonitor doubleValue]);

    }
    
    //标志的价格
    self.totlePrice = self.totlePrice + [self.model.yangZhiBiaoZhiPriceStr doubleValue];
    JZLog(@"标志价格%.2f",[self.model.yangZhiBiaoZhiPriceStr doubleValue]);

    
    //加工的价格
    self.totlePrice = self.totlePrice + [self.model.yangZhiJiaGongPriceStr doubleValue]* self.model.chooseEarthCount;
    JZLog(@"加工价格%.2f",[self.model.yangZhiJiaGongPriceStr doubleValue]);

    //保险的价格
//    self.totlePrice = self.totlePrice + [self.model.yangZhiBaoXianPriceStr doubleValue];
//    JZLog(@"保险价格%.2f",[self.model.yangZhiBaoXianPriceStr doubleValue]);

    //方案的价格
    [self reloadFangAnPrice];
    self.totlePrice = self.totlePrice + self.model.yangZhiFangAnTotlePriceStr;
    JZLog(@"方案价格%.2f",self.model.yangZhiFangAnTotlePriceStr);

    //配送价格
    if (self.model.yangZhiPeiSongIsChoose) {
        self.totlePrice = self.totlePrice + [self.model.freight doubleValue] * self.model.chooseEarthCount;
//
        JZLog(@"配送价格%.2f",self.totlePrice);
    }
    
    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"%.2f元",self.totlePrice];
//    self.bottomView.heJiLabel.backgroundColor = [UIColor redColor];
}

- (void)reloadFangAnPrice{
    self.model.yangZhiFangAnTotlePriceStr = 0;
//界面显示风格：0-浇水style，1-施肥style，2-播种style，3-周期style，4-拍照style
    //这里判断是否是使用的默认的方案
    if (self.model.isDefaultTemplate) {
        for (NYNYangZhiFangAnModel *model in self.model.zhongMoArr) {
            
            if ([model.checked isEqualToString:@"1"]) {
                
                if ([model.ctype isEqualToString:@"0"]) {
                     double addPrice = [model.price doubleValue] * [_titleString intValue] * [model.count intValue];
                    self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
                }
                else if ([model.ctype isEqualToString:@"1"]){
                    //这里清理出来选中的子单元格
                    NYNYangZhiFangAnModel *nowSubModel;
                    for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                        if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                            nowSubModel = subFirstDataModel;
                        }
                    }
                    double addPrice = [nowSubModel.price doubleValue] * [_cycleString intValue]* [nowSubModel.count intValue];
                    self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
                    
                }
                else if ([model.ctype isEqualToString:@"2"]){
                    
                    //double addPrice = [model.price doubleValue] * self.selectModel.selectCount;
                    //面积*价格
                      double addPrice = [model.price doubleValue] * [_titleString intValue];
                    self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
              
                    
                    JZLog(@"ctype2 price = %f  yangZhiFangAnTotlePriceStr = %f",addPrice,self.model.yangZhiFangAnTotlePriceStr);
                    
                }
                else if ([model.ctype isEqualToString:@"3"]){
                    //养殖周期
                }
                else if ([model.ctype isEqualToString:@"4"]){
//                    double addPrice = [model.price doubleValue] * ([model.duration intValue] / [model.interval intValue] * [model.count intValue]);
                    int a =[_cycleString intValue]/ [model.interval intValue];
                    int b = (a==0)?(a=1):a;
                    
                    //farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%d", b* [model.count intValue]];
                    double addPrice = b* [model.count intValue]*[model.price doubleValue];
                    self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
                    
                    JZLog(@"ctype4 price = %f  yangZhiFangAnTotlePriceStr = %f",addPrice,self.model.yangZhiFangAnTotlePriceStr);
                    
                }
                else if ([model.ctype isEqualToString:@"6"]){
                    //这里清理出来选中的子单元格
                    NYNYangZhiFangAnModel *nowSubModel;
                    for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                        if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                            nowSubModel = subFirstDataModel;
                        }
                    }
                    double addPrice = [nowSubModel.price doubleValue] * self.selectModel.selectCount;
                    self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
                    
                }
                else {
        
                }
                
            }
            
        }
        
        
    }else{
        for (NYNYangZhiFangAnModel *model in self.model.zhongZiMoArr) {
            
            if ([model.checked isEqualToString:@"1"]) {
                
                if ([model.ctype isEqualToString:@"0"]) {
                    double addPrice = [model.price doubleValue] * [_titleString intValue] * [model.count intValue];
                    self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
//
                }
                else if ([model.ctype isEqualToString:@"1"]){
                    //这里清理出来选中的子单元格
                    NYNYangZhiFangAnModel *nowSubModel;
                    for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                        if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                            nowSubModel = subFirstDataModel;
                        }
                    }
                    //self.selectModel.selectCount
                    double addPrice = [nowSubModel.price doubleValue] * [_titleString intValue]* [nowSubModel.count intValue];
                    self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
                    
                }
                else if ([model.ctype isEqualToString:@"2"]){
//                    double addPrice = [model.price doubleValue] * self.selectModel.selectCount;
                    double addPrice = [model.price doubleValue] *[_titleString intValue];
                    self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
                    
                }
                else if ([model.ctype isEqualToString:@"3"]){
                    //养殖周期
                    double addPrice = [model.price doubleValue] *  [model.count intValue];
//                    self.totlePrice = self.totlePrice + addPrice;
                     self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
                    
                }
                else if ([model.ctype isEqualToString:@"4"]){
                    //double addPrice = [model.price doubleValue] * ([model.duration intValue] / [model.interval intValue] * [model.count intValue]);
           
      
                    
                    
                    int a =[_cycleString intValue] / [model.interval intValue];
                    int b = (a==0)?(a=1):a;
                    
                    //farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%d", b* [model.count intValue]];
                    double addPrice = b* [model.count intValue]*[model.price floatValue];

                    self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
                    
                }
                else if ([model.ctype isEqualToString:@"6"]){
                    //这里清理出来选中的子单元格
                    NYNYangZhiFangAnModel *nowSubModel;
                    for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                        if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                            nowSubModel = subFirstDataModel;
                        }
                    }
                    double addPrice = [nowSubModel.price doubleValue] * self.selectModel.selectCount;
                    self.model.yangZhiFangAnTotlePriceStr = self.model.yangZhiFangAnTotlePriceStr + addPrice;
                    
                }
                else {

                }
                
            }
            
        }

    }

    
}


- (void)beginConfigUI{
    
    self.selectModel.selectCount =[_cycleString intValue];
    
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
        [dic setObject:@([weakSelf.model.farmManagerId integerValue]) forKey:@"farmManagerId"];
        [dic setObject:@([weakSelf.model.defaultUserAddressId integerValue]) forKey:@"userAddressId"];
        [dic setObject:weakSelf.model.isDefaultTemplate ? @1 : @0 forKey:@"isDefaultTemplate"];
        [dic setObject:@([weakSelf.farmID integerValue]) forKey:@"farmId"];
        [dic setObject:weakSelf.model.yangZhiPeiSongIsChoose ? @1 : @0 forKey:@"isDelivery"];
        [dic setObject:@(weakSelf.model.cycTime) forKey:@"cycleTime"];
        [dic setObject:@"plant" forKey:@"type"];
        
        NSMutableArray *itemModels = [[NSMutableArray alloc]init];
        
        //类型  主要，eg: 土地（禽畜、集市产品）
        NSMutableDictionary *chanPinDic = @{@"productId":@([weakSelf.earthID integerValue]),@"type":@"MINOR",@"quantity":@([weakSelf.titleString intValue]),@"duration":@(weakSelf.model.earthCycleCount)}.mutableCopy;
        // weakSelf.model.chooseEarthCount weakSelf.selectModel.selectCount
        NSMutableDictionary *zhongZiDic = @{@"productId":@([weakSelf.selectModel.ID integerValue]),@"type":@"MAJOR",@"quantity":weakSelf.titleString}.mutableCopy;
        NSMutableDictionary *biaoZhiPaiDic = [[NSMutableDictionary alloc]init];
        
        if ([weakSelf.model.defaultSignboardPrice isEqualToString:@"0"]) {
            //标志
            
        }else{
            biaoZhiPaiDic = @{@"productId":@([weakSelf.model.defaultSignboardId integerValue]),@"type":@"PRODUCT",@"quantity":@1}.mutableCopy;
        }
        NSString * str =[NSString stringWithFormat:@"%d",[self.model.yangZhiJiaGongPriceStr intValue] * self.selectModel.selectCount];
        NSMutableArray * jianKongDic  = [[NSMutableArray alloc]init];
        
        if ([str isEqualToString:@"0"]) {
            
        }else{
            jianKongDic = @{@"productId":@([weakSelf.model.monitorId integerValue]),@"type":@"PRODUCT",@"quantity":@1}.mutableCopy;
        }

        NSMutableDictionary *jiaGongDic = @{@"productId":@([weakSelf.model.yangZhiJiaGongIDStr integerValue]),@"type":@"PLAN_PRODUCT",@"quantity":@1,@"duration":@1,@"interval":@1}.mutableCopy;
        
      
        
        
        /*       //类型  主要，eg: 土地（禽畜、集市产品）
         NSMutableDictionary *chanPinDic = @{@"productId":@([weakSelf.earthID integerValue]),@"type":@"MINOR",@"quantity":@([weakSelf.titleString intValue]),@"duration":@(weakSelf.model.earthCycleCount)}.mutableCopy;
         
         NSMutableDictionary *zhongZiDic = @{@"productId":@([weakSelf.selectModel.ID integerValue]),@"type":@"MAJOR",@"quantity":@(weakSelf.selectModel.selectCount)}.mutableCopy;
         
         
         NSMutableDictionary *biaoZhiPaiDic = @{@"productId":@([weakSelf.model.defaultSignboardId integerValue]),@"type":@"PRODUCT",@"quantity":@1}.mutableCopy;
         
         NSMutableDictionary *jiaGongDic = @{@"productId":@([weakSelf.model.yangZhiJiaGongIDStr integerValue]),@"type":@"PLAN_PRODUCT",@"quantity":@1,@"duration":@1,@"interval":@1}.mutableCopy;
         
         NSMutableArray * jianKongDic = @{@"productId":@([weakSelf.model.monitorId integerValue]),@"type":@"PRODUCT",@"quantity":@1}.mutableCopy;*/
        
        
        
        //保险这里先不加上
//        NSMutableDictionary *baoxianDic = @{@"productId":@([weakSelf.chuShiHuaModel.defaultSignboardId integerValue]),@"type":@"PRODUCT",@"quantity":@1,@"duration":@1,@"interval":@1}.mutableCopy;
        [itemModels addObject:chanPinDic];
        [itemModels addObject:zhongZiDic];
        
        if (![weakSelf.model.yangZhiBiaoZhiNameStr isEqualToString:@"请选择"]) {
            [itemModels addObject:biaoZhiPaiDic];
            
        }
        
        if (![weakSelf.model.yangZhiJiaGongNameStr isEqualToString:@"请选择"]) {
            [itemModels addObject:jiaGongDic];
            
        }
//        if (weakSelf.model.jianKongIsChoose ==YES ) {
//              [itemModels addObject:jianKongDic];
//        }
        if ([str isEqualToString:@"0"]) {
            
        }else{
                [itemModels addObject:jianKongDic];
        }
        if (weakSelf.model.isDefaultTemplate) {
            
        }else{
            for (NYNYangZhiFangAnModel *model in weakSelf.model.zhongZiMoArr) {
                //只有选中才计算价格
                if ([model.checked isEqualToString:@"1"]) {
                    
                    NSMutableDictionary *d ;
                    
                    if ([model.ctype isEqualToString:@"0"]) {
                        d = @{@"productId":@([model.artProductId integerValue]),@"type":@"PLAN",
                              @"quantity":@([model.count intValue])}.mutableCopy;
                        
                        if (model.yiChuLiDataArr.count > 0) {
                            [d setObject:model.yiChuLiDataArr forKey:@"countItemModels"];
                        }
                        
                        
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
                NYNDealModel *model = [NYNDealModel mj_objectWithKeyValues:success[@"data"]];
//
//                NYNQueRenDingDanViewController *vc = [[NYNQueRenDingDanViewController alloc]init];
//                vc.model = model;
//                vc.type = @"1";
//                [weakSelf.navigationController pushViewController:vc animated:YES];
//
//                vc.picName = weakSelf.picName;
                
                NYNPayViewController *payvc = [[NYNPayViewController alloc]init];
                payvc.model = model;
                payvc.totlePrice = model.amount ;
                payvc.selectBool  =YES;
                payvc.typeStr = @"NORMAL";
                [weakSelf.navigationController pushViewController:payvc animated:YES];
            }else{
                [weakSelf showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            }
            
            
            
            [weakSelf hideLoadingView];
//              NYNPayViewController *vc = [[NYNPayViewController alloc]init];
//               vc.model = weakSelf.model;
//           [weakSelf.navigationController pushViewController:vc animated:YES];
        } failure:^(NSError *failure) {
            [weakSelf hideLoadingView];
            NSLog(@"%@",failure);
            
            
        }];
        
        

    };
    [self.view addSubview:self.bottomView];
    
    JZLog(@"");
}

- (void)createwangtZhongTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.wantZhongTable.delegate = self;
    self.wantZhongTable.dataSource = self;
    self.wantZhongTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.wantZhongTable.showsVerticalScrollIndicator = NO;
    self.wantZhongTable.showsHorizontalScrollIndicator = NO;
    
    self.wantZhongTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.00001)];
    [self.view addSubview:self.wantZhongTable];
}





#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        return 4;
    }else{
        if (self.model.yangZhiPeiSongIsChoose) {
            return 3;
        }else{
            return 1;
        }
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NYNEarthZuDiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthZuDiTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.mianJiCount = self.model.chooseEarthCount;
            farmLiveTableViewCell.shiChangCount = self.model.earthCycleCount;
            
            NSString *str1 = [NSString stringWithFormat:@"%.2f元",self.model.chooseEarthCount * self.model.earthCycleCount * [self.earthPriceStr doubleValue]];
            NSString *str2 = [NSString stringWithFormat:@"（%.2f/%@）",[self.earthPriceStr doubleValue],self.earthUnit];
            NSString *sss = [NSString stringWithFormat:@"%@%@",str1,str2];
          
            
            
            farmLiveTableViewCell.priceTotleLabel.attributedText = [MyControl CreateNSAttributedString:sss thePartOneIndex:NSMakeRange(0, str1.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:15] andPartTwoIndex:NSMakeRange(str1.length, str2.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:12]];
            
            __weak typeof(self)weakSelf = self;
            __weak typeof(farmLiveTableViewCell)weakFarmLiveTableViewCell = farmLiveTableViewCell;

            farmLiveTableViewCell.mianjiBlock = ^(NSString *strValue) {
                //种子个数
                _titleString  = farmLiveTableViewCell.mianJiCountLabel.text;
                
                if ([strValue isEqualToString:@"+"]) {
                    
                    
                    weakSelf.model.chooseEarthCount++;
                    
                }else{
                    if (weakSelf.model.chooseEarthCount ==0) {


                    }else{
                        weakSelf.model.chooseEarthCount--;
                    }
               
                }
                // weakSelf.model.earthCycleCount
                
                NSString *str1 = [NSString stringWithFormat:@"%.2f元",weakSelf.model.chooseEarthCount * [weakSelf.earthPriceStr doubleValue]];
                NSString *str2 = [NSString stringWithFormat:@"（%.2f/%@）",[weakSelf.earthPriceStr doubleValue],weakSelf.earthUnit];
                NSString *sss = [NSString stringWithFormat:@"%@%@",str1,str2];
                
                weakFarmLiveTableViewCell.priceTotleLabel.attributedText = [MyControl CreateNSAttributedString:sss thePartOneIndex:NSMakeRange(0, str1.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:13] andPartTwoIndex:NSMakeRange(str1.length, str2.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:12]];
                
                [weakSelf reloadPrice];
                //刷新配送的cell
                NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:0 inSection:3]; //刷新第0段第2行
                
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathA,nil] withRowAnimation:UITableViewRowAnimationNone];
                
                //刷新某一个section
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                //产品加工刷新
                NSIndexPath *indexPathB = [NSIndexPath indexPathForRow:3 inSection:2]; //刷新第0段第2行
                
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathB,nil] withRowAnimation:UITableViewRowAnimationNone];
    
//                NSIndexPath *indexPathB = [NSIndexPath indexPathForRow:0 inSection:1]; //刷新第0段第1行
//                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathB,nil] withRowAnimation:UITableViewRowAnimationNone];
                
                
            };
            
            
            
            farmLiveTableViewCell.shichangBlock = ^(NSString *strValue) {
              _cycleString = farmLiveTableViewCell.shiChangCountLabel.text;
                weakSelf.model.cycTime =[_cycleString intValue];
                if ([strValue isEqualToString:@"+"]) {
                    weakSelf.model.earthCycleCount++;
                  
                    
                }else{
                    if (weakSelf.model.earthCycleCount == 1) {
                        
                    }else{
                        weakSelf.model.earthCycleCount--;
                  
                    }
                }
                
                NSString *str1 = [NSString stringWithFormat:@"%.2f元",weakSelf.model.chooseEarthCount  * [weakSelf.earthPriceStr doubleValue]];
                NSString *str2 = [NSString stringWithFormat:@"（%.2f/%@）",[weakSelf.earthPriceStr doubleValue],weakSelf.earthUnit];
                NSString *sss = [NSString stringWithFormat:@"%@%@",str1,str2];
                
                weakFarmLiveTableViewCell.priceTotleLabel.attributedText = [MyControl CreateNSAttributedString:sss thePartOneIndex:NSMakeRange(0, str1.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:15] andPartTwoIndex:NSMakeRange(str1.length, str2.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:12]];
                
                [weakSelf reloadPrice];
            };
            
            return farmLiveTableViewCell;
        }
        else{
            NYNZuDiZhongZhiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNZuDiZhongZhiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            self.whoTextField = farmLiveTableViewCell.whoTF;
            self.forWhoTextField = farmLiveTableViewCell.forWhoTF;
            self.whatTextField = farmLiveTableViewCell.ZhiWuTF;
            farmLiveTableViewCell.doLabel.text = @"种的";
            return farmLiveTableViewCell;
        }
        
        
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.titleLabel.text = @"种植土地";
            //self.selectModel.selectCount
    
            farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"%@",self.selectModel.name];
            //self.selectModel.selectCount *
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[self.selectModel.price doubleValue]*[_titleString doubleValue]*[_cycleString intValue]];
            
            return farmLiveTableViewCell;
        }
        else{
            NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
            }

            farmLiveTableViewCell.titleLabel.text = @"种植方案";
            farmLiveTableViewCell.contentLabel.text = self.model.yangZhiFangAnNameStr;
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",self.model.yangZhiFangAnTotlePriceStr];
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
                
                farmLiveTableViewCell.zhanweiLabel.text = self.model.yangZhiGuanJiaNameStr;
                farmLiveTableViewCell.zhanweiLabel.textColor = Color252827;
                farmLiveTableViewCell.zhanweiLabel.hidden = NO;
                farmLiveTableViewCell.priceLabel.hidden = YES;
                farmLiveTableViewCell.contentLabel.hidden = YES;
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
                farmLiveTableViewCell.priceLabel.text = self.model.defaultMonitor;

                
                if (self.model.jianKongIsChoose) {
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
                    [self reloadPrice];
                    farmLiveTableViewCell.priceLabel.text =  [NSString stringWithFormat:@"%d",[self.model.defaultMonitor intValue]];
                }else{
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
                    farmLiveTableViewCell.priceLabel.text = 0;
                     [self reloadPrice];
                    
                }
               
                /*reloadPrice*/
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
                farmLiveTableViewCell.contentLabel.text = self.model.defaultSignboardName;
                farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%@元",self.model.defaultSignboardPrice];
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
                farmLiveTableViewCell.contentLabel.text = self.model.yangZhiJiaGongNameStr;
                farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[self.model.yangZhiJiaGongPriceStr doubleValue] * self.model.chooseEarthCount];
                
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
                farmLiveTableViewCell.titleLabel.text = @"外太空生物";
                farmLiveTableViewCell.contentLabel.text = @"外太空生物";
                farmLiveTableViewCell.priceLabel.text = @"外太空生物";
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
                farmLiveTableViewCell.cellLabel.text = [NSString stringWithFormat:@"（%.2f/㎡）",[self.model.freight doubleValue]];
                farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[self.model.freight doubleValue] * self.model.chooseEarthCount];
                
                if (self.model.yangZhiPeiSongIsChoose) {
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
                
                
                
                farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"配送地址:%@",self.model.defaultUserAddressTitle];
                if (self.model.peiSongDiZhiIsChoose) {
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_selected");
                }else{
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_unchecked");
                }
                
                farmLiveTableViewCell.block = ^{
                    myselfGetBool=NO;
                    self.model.peiSongDiZhiIsChoose = YES;
                    
                    NSIndexPath *idp = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                    NSIndexPath *idp1 = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
                    [self.wantZhongTable reloadRowsAtIndexPaths:@[idp1,idp] withRowAnimation:UITableViewRowAnimationNone];
                };
                
                NSIndexPath *idp = [NSIndexPath indexPathForRow:2 inSection:indexPath.section];
                [self.wantZhongTable reloadRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationNone];
                NSIndexPath *idp1 = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [self.wantZhongTable reloadRowsAtIndexPaths:@[idp1] withRowAnimation:UITableViewRowAnimationNone];
                return farmLiveTableViewCell;
            }
                break;
            case 2:
            {
                NYNChoosePeiSongAddressTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChoosePeiSongAddressTableViewCell class]) owner:self options:nil].firstObject;
                }
//                farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"爱心捐赠:%@",@"暂无数据"];
                
                farmLiveTableViewCell.dizhiLabel.hidden=YES;
                
                farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"亲自到场收取"];
                if (myselfGetBool) {
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_selected");
                    self.model.peiSongDiZhiIsChoose = NO;
               
                }else{
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"mine_icon_unchecked");
                    self.model.peiSongDiZhiIsChoose = YES;
                    
                }
                NSIndexPath *idp = [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
                [self.wantZhongTable reloadRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationNone];
                
                return farmLiveTableViewCell;
            }
                break;
            default:
            {
                NYNChoosePeiSongAddressTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChoosePeiSongAddressTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.contentLabel.text = @"外星人";
                
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
            return JZHEIGHT(86);
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
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            //种植种子，之前项目里面是种植种子，我拿到的时候需求是种植土地，为了防止后期加上去，暂时不删除
//            NYNChooseSeedViewController *vc = [[NYNChooseSeedViewController alloc]init];
//            vc.seedArr = self.seedArr;
//
//            vc.selectModel = self.selectModel;
//
//            __weak typeof(self)weakSelf = self;
//            vc.seedBack = ^(NYNXuanZeZhongZiModel *model) {
//

//                weakSelf.selectModel = model;
//                [weakSelf seedChange];
//                NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:2];
//                NSIndexPath *path1 = [NSIndexPath indexPathForRow:0 inSection:3];
//                [weakSelf.wantZhongTable reloadRowsAtIndexPaths:@[path,path1] withRowAnimation:UITableViewRowAnimationNone];
//            };
//
//            [self.navigationController pushViewController:vc animated:YES];
            //选择土地种植
                        __weak typeof(self)weakSelf = self;
            ChooseLandViewController * landVC = [[ChooseLandViewController alloc]init];
             landVC.selectModel = self.selectModel;
            landVC.farmID = _farmID;
            
            [landVC getTitle:@"选择作物种植土地" type:@"land"];
            landVC.selectBlock= ^(NYNXuanZeZhongZiModel *model){
                weakSelf.selectModel = model;
             //   [weakSelf seedChange];
                
                [self reloadPrice];
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wantZhongTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                
            };
            
            
             [self.navigationController pushViewController:landVC animated:YES];
            
            
        }
        else{
            //种植方案
            NYNZhongZhiNewFangAnViewController *vc = [[NYNZhongZhiNewFangAnViewController alloc]init];
            vc.chuShiHuaModel = [self.model copy];
//            vc.yangZhiCount = self.selectModel.selectCount;
            self.selectModel.selectCount =[_cycleString intValue];
            vc.yangZhiCount = [_titleString intValue];
            vc.zhongzhiTime =self.model.earthCycleCount;
            
            
            
            __weak typeof(self) WeakSelf = self;
            __strong typeof(WeakSelf.model) strongModel = WeakSelf.model;
            vc.fangAnDataBack = ^(NSMutableArray *arr, int cycleTime,NSString * title) {
                  self.model.yangZhiFangAnNameStr = title;
                strongModel.zhongZiMoArr = arr;
                strongModel.isDefaultTemplate = NO;
                strongModel.cycTime = [_cycleString intValue];
                [WeakSelf reloadPrice];
            
                [WeakSelf.wantZhongTable reloadData];
            };
   
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            //执行管家
            NYNChooseGuanJiaViewController *vc = [[NYNChooseGuanJiaViewController alloc]init];
            vc.farmID = self.farmID;
            __weak typeof(self)weakSelf = self;
            vc.guanJiaBlcok = ^(NYNGuanJiaModel *model) {
                self.model.farmManagerId = model.ID;
                self.model.yangZhiGuanJiaNameStr = model.name;
                
                NSIndexPath *ss = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wantZhongTable reloadRowsAtIndexPaths:@[ss] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1){
            self.model.jianKongIsChoose = !self.model.jianKongIsChoose;
            
            NSIndexPath *ss = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            [self.wantZhongTable reloadRowsAtIndexPaths:@[ss] withRowAnimation:UITableViewRowAnimationNone];
            
        }
        else if (indexPath.row == 2){
            //标志标识
            NYNChooseBiaoShiPaiViewController *vc = [[NYNChooseBiaoShiPaiViewController alloc]init];
            vc.farmID = self.farmID;
            __weak __typeof(self)weakSelf = self;
            vc.type = @"0";
            
            vc.chooseBlock = ^(NYNBiaoShiPaiModel *model) {
                
                weakSelf.model.defaultSignboardName = model.name;
                weakSelf.model.defaultSignboardPrice = model.price;
                weakSelf.model.yangZhiBiaoZhiIDStr = model.ID;
                
                [weakSelf reloadPrice];

                
                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wantZhongTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (indexPath.row == 3){
            //产品加工
            NYNChanPinJiaGongViewController *vc = [[NYNChanPinJiaGongViewController alloc]init];
            vc.productId = self.farmID;
            [vc setProductId:self.earthID  type:@"0"];
            __weak __typeof(self)weakSelf = self;
            vc.returnBlock = ^(NYNChanPinJiaGongModel *model) {
                weakSelf.model.yangZhiJiaGongNameStr = model.farmArtName;
                weakSelf.model.yangZhiJiaGongPriceStr = [NSString stringWithFormat:@"%@",model.price];
                weakSelf.model.yangZhiJiaGongIDStr = model.ID;
                
                [weakSelf reloadPrice];

                
                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wantZhongTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (indexPath.row == 4){
            //作物保险
            NYNBaoXianGouMaiViewController *vc = [[NYNBaoXianGouMaiViewController alloc]init];
            //保险的回调用blcok 暂时不启用
            __weak __typeof(self)weakSelf = self;
            vc.baoXianDataBack = ^(NSString *s) {
                [weakSelf reloadPrice];

            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else{
            
        }
    }else{
        if (indexPath.row == 0) {
            self.model.yangZhiPeiSongIsChoose = !self.model.yangZhiPeiSongIsChoose;
            
            [self reloadPrice];
            
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
            
            [self.wantZhongTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
            
        }
        if (indexPath.row == 1) {
            NYNMeAdressViewController *vc = [[NYNMeAdressViewController alloc]init];
            __weak typeof(self) weakSelf = self;
            vc.addressClickBlock = ^(NYNMeAddressModel *model) {
                self.model.peiSongDiZhiIsChoose = NO;
                self.model.aiXinJuanZengIsChoose = NO;
                self.model.peiSongDiZhiIsChoose = YES;
                self.model.defaultUserAddressTitle = model.address;
                self.model.defaultUserAddressId = model.ID;
                NSIndexPath *idp = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wantZhongTable reloadRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationNone];
                
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 2) {
            //爱心捐赠
//            NYNAiXinJuanZengViewController *vc = [[NYNAiXinJuanZengViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
            
              myselfGetBool = YES;
            self.model.peiSongDiZhiIsChoose = NO;
            NSIndexPath *idp = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            NSIndexPath *idp1 = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
            [self.wantZhongTable reloadRowsAtIndexPaths:@[idp1,idp] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

#pragma 种子发生变化
- (void)seedChange{
//种子的详情信息
    [self showLoadingView:@""];

    [NYNNetTool InitDataWithparams:@{@"farmingId":self.selectModel.ID} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        NSLog(@"-------------%@",success);
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            NYNChuShiHuaModel *model = [NYNChuShiHuaModel mj_objectWithKeyValues:success[@"data"]];
            model.isDefaultTemplate = YES;
            self.model = model;
            
            self.model.jianKongIsChoose = YES;
            
            float f = self.selectModel.selectCount / [self.selectModel.cname intValue];
            int newInt = (int)f;
            int a;
            if (newInt - f > 0) {
                a = ceil(f);
            }else{
                a = newInt;
            }
            self.model.chooseEarthCount = a;
            self.model.earthCycleCount = [self.selectModel.cycleTime intValue];
            
            self.model.yangZhiCountStr = 1;
            self.model.yangZhiFangAnNameStr = @"省心方案";
            self.model.yangZhiFangAnTotlePriceStr = 0;
            
            self.model.yangZhiGuanJiaNameStr = @"系统自动分配";
            
            self.model.zhongZhiJianKongPriceStr = @"0.00";
            
            self.model.yangZhiBiaoZhiNameStr = self.model.defaultSignboardName;
            self.model.yangZhiBiaoZhiIDStr = self.model.defaultSignboardId;
            self.model.yangZhiBiaoZhiPriceStr = self.model.defaultSignboardPrice;
            
            self.model.farmManagerId = @"-1";
            
//            self.model.yangZhiJiaGongNameStr = @"请选择";
            self.model.yangZhiJiaGongIDStr = @"-1";
            self.model.yangZhiJiaGongPriceStr = @"0.00";
            
//            self.model.yangZhiBaoXianNameStr = @"请选择";
            self.model.yangZhiBaoXianIDStr = @"-1";
            self.model.yangZhiJiaGongPriceStr = @"0.00";
            
            self.model.yangZhiPeiSongIsChoose = YES;
            
            self.model.peiSongDiZhiIsChoose = YES;
            self.model.aiXinJuanZengIsChoose = NO;
            
            //获取默认方案数据
            [NYNNetTool GetMoRenFangAnWithparams:@{@"productId":self.selectModel.ID} isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                if([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]){
                    [model.zhongMoArr removeAllObjects];
                    
                    NSArray *arr = [NSArray arrayWithArray:success[@"data"][@"artOrderItemResults"]];
                    NSMutableArray *moLieBiaoArr = [[NSMutableArray alloc]init];
                    
                    for (NSDictionary *dic in arr) {
                        NYNYangZhiFangAnModel *subModel = [NYNYangZhiFangAnModel mj_objectWithKeyValues:dic];;
                        
                        [moLieBiaoArr addObject:subModel];
                    }
                    
                    NYNYangZhiFangAnModel *moShiFeiModel = [[NYNYangZhiFangAnModel alloc]init];
                    moShiFeiModel.ctype = @"1";
                    
                    NYNYangZhiFangAnModel *moSixMaModel = [[NYNYangZhiFangAnModel alloc]init];
                    moSixMaModel.ctype = @"6";
                    
                    //创建周期model  前台手动增加一个cellmodel
                    NYNYangZhiFangAnModel *moZhouQiModel = [[NYNYangZhiFangAnModel alloc]init];
                    moZhouQiModel.ctype = @"3";
                    moZhouQiModel.checked = @"1";
                    [model.zhongMoArr addObject:moZhouQiModel];
                    
                    for (NYNYangZhiFangAnModel *subM in moLieBiaoArr) {
                        if ([subM.ctype isEqualToString:@"1"]) {
                            [moShiFeiModel.subArr addObject:subM];
                        }
                        else if ([subM.ctype isEqualToString:@"6"]){
                            [moSixMaModel.subArr addObject:subM];
                        }
                        else{
                            [model.zhongMoArr addObject:subM];
                            if ([subM.ctype isEqualToString:@"2"]) {
                                subM.chooseDate = [NSDate date];
                            }
                        }
                    }
                    
                    moShiFeiModel.checked = @"1";
                    moSixMaModel.checked = @"1";
                    
                    moShiFeiModel.count = @"0";
                    moSixMaModel.count = @"0";
                    
                    
                    for (int i = 0; i < moSixMaModel.subArr.count; i++) {
                        NYNYangZhiFangAnModel *caoMD = moSixMaModel.subArr[i];
                        if (i == 0) {
                            caoMD.checked = @"1";
                        }else{
                            caoMD.checked = @"0";
                        }
                    }
                    
                    for (int i = 0; i < moShiFeiModel.subArr.count; i++) {
                        NYNYangZhiFangAnModel *caoMD = moShiFeiModel.subArr[i];
                        if (i == 0) {
                            caoMD.checked = @"1";
                        }else{
                            caoMD.checked = @"0";
                        }
                    }
                    
                    //最后将这个数据加入
                    if (moSixMaModel.subArr.count > 0) {
                        //这个是ctype=6
                        [model.zhongMoArr addObject:moSixMaModel];
                    }
                    
                    if (moShiFeiModel.subArr.count > 0) {
                        //这个是ctype=1
                        [model.zhongMoArr addObject:moShiFeiModel];
                    }
                    
                    
                    
                    //获取自定义方案数据
                    [NYNNetTool GetZiDingYiFangAnWithparams:@{@"productId":self.selectModel.ID,@"type":@"order"} isTestLogin:YES progress:^(NSProgress *progress) {
                        
                    } success:^(id success) {
                        if (([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"])) {
                            
                            
                            NSArray *arr = [NSArray arrayWithArray:success[@"data"]];
                            NSMutableArray *ziLieBiaoArr = [[NSMutableArray alloc]init];
                            
                            for (NSDictionary *dic in arr) {
                                NYNYangZhiFangAnModel *subModel = [NYNYangZhiFangAnModel mj_objectWithKeyValues:dic];;
                                
                                [ziLieBiaoArr addObject:subModel];
                            }
                            
                            NYNYangZhiFangAnModel *ziShiFeiModel = [[NYNYangZhiFangAnModel alloc]init];
                            ziShiFeiModel.ctype = @"1";
                            
                            NYNYangZhiFangAnModel *ziSixMaModel = [[NYNYangZhiFangAnModel alloc]init];
                            ziSixMaModel.ctype = @"6";
                            
                            //创建周期model  前台手动增加一个cellmodel
                            NYNYangZhiFangAnModel *ziZhouQiModel = [[NYNYangZhiFangAnModel alloc]init];
                            ziZhouQiModel.ctype = @"3";
                            ziZhouQiModel.checked = @"1";
                            [model.zhongZiMoArr addObject:ziZhouQiModel];
                            
                            for (NYNYangZhiFangAnModel *subM in ziLieBiaoArr) {
                                if ([subM.ctype isEqualToString:@"1"]) {
                                    [ziShiFeiModel.subArr addObject:subM];
                                }
                                else if ([subM.ctype isEqualToString:@"6"]){
                                    [ziSixMaModel.subArr addObject:subM];
                                }
                                else{
                                    [model.zhongZiMoArr addObject:subM];
                                    if ([subM.ctype isEqualToString:@"2"]) {
                                        subM.chooseDate = [NSDate date];
                                    }
                                }
                            }
                            
                            ziShiFeiModel.checked = @"1";
                            ziShiFeiModel.checked = @"1";
                            
                            ziShiFeiModel.count = @"0";
                            ziShiFeiModel.count = @"0";
                            
                            
                            for (int i = 0; i < ziSixMaModel.subArr.count; i++) {
                                NYNYangZhiFangAnModel *caoMD = ziSixMaModel.subArr[i];
                                if (i == 0) {
                                    caoMD.checked = @"1";
                                }else{
                                    caoMD.checked = @"0";
                                }
                            }
                            
                            for (int i = 0; i < ziShiFeiModel.subArr.count; i++) {
                                NYNYangZhiFangAnModel *caoMD = ziShiFeiModel.subArr[i];
                                if (i == 0) {
                                    caoMD.checked = @"1";
                                }else{
                                    caoMD.checked = @"0";
                                }
                            }
                            
                            //最后将这个数据加入
                            if (ziSixMaModel.subArr.count > 0) {
                                //这个是ctype=6
                                [model.zhongZiMoArr addObject:ziSixMaModel];
                            }
                            
                            if (ziShiFeiModel.subArr.count > 0) {
                                //这个是ctype=1
                                [model.zhongZiMoArr addObject:ziShiFeiModel];
                            }
                            
                            [self reloadPrice];
                            
                            [self.wantZhongTable reloadData];
                            JZLog(@"");
                        }else{
                            [self showTextProgressView:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",success[@"msg"]]]];
                            
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
                [self hideLoadingView];
                
            }];
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",success[@"msg"]]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
    
}



#pragma 懒加载
-(UITableView *)wantZhongTable{
    if (!_wantZhongTable) {
        _wantZhongTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(45)) style:UITableViewStyleGrouped];
    }
    return _wantZhongTable;
}

@end
