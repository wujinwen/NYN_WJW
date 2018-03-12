//
//  NYNWantZhongZhiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNWantZhongZhiViewController.h"

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

#import "NYNSelectFangAnModel.h"
#import "NYNGouMaiView.h"
#import "NYNFangAnListModel.h"
#import "NYNZhongZhiFangAnModel.h"
#import "NYNMeAdressViewController.h"
#import "NYNChuShiHuaModel.h"
#import "NYNGuanJiaModel.h"
#import "NYNDealModel.h"

@interface NYNWantZhongZhiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *wangtZhongTable;
@property (nonatomic,strong) NYNGouMaiView* bottomView;

@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) NSMutableArray *detailArr;
@property (nonatomic,strong) NSMutableArray *priceArr;

@property (nonatomic,strong) NYNSelectFangAnModel *fangAnModel;

@property (nonatomic,assign) BOOL jianKongIsChoose;
@property (nonatomic,assign) BOOL peiSongIsChoose;
@property (nonatomic,assign) BOOL fanganIsChoose;
@property (nonatomic,assign) BOOL biaoshiIsChoose;
@property (nonatomic,assign) BOOL jiaGgongIsChoose;
@property (nonatomic,assign) BOOL baoXianIsChoose;
@property (nonatomic,assign) BOOL guanJiaIsChoose;

@property (nonatomic,assign) double zhongziPrice;
@property (nonatomic,assign) double fangAnPrice;
@property (nonatomic,assign) double jianKongPrice;
@property (nonatomic,assign) double biaoZhiPrice;
@property (nonatomic,assign) double jiagongPrice;
@property (nonatomic,assign) double baoxianPrice;
@property (nonatomic,assign) double peisongPrice;

@property (nonatomic,assign) int mianjiCount;
@property (nonatomic,assign) int shichangCount;
@property (nonatomic,assign) double zuDiPrice;

@property (nonatomic,strong) NYNZhongZhiFangAnModel *moDataModel;
@property (nonatomic,strong) NSMutableArray *moFangAnArr;

@property (nonatomic,assign) double moPrice;

@property (nonatomic,assign) double nowTotlePrice;

//@property (nonatomic,copy) NSString *xuanZhongDePeiSongStr;
//@property (nonatomic,copy) NSString *xuanZhongAiXinSongStr;

@property (nonatomic,strong) NYNMeAddressModel *diZhiModel;
@property (nonatomic,strong) NYNMeAddressModel *aiXinModel;

@property (nonatomic,strong) NYNChuShiHuaModel *chuShiHuaModel;

@property (nonatomic,strong) UITextField *whoTF;
@property (nonatomic,strong) UITextField *forWhoTF;
@property (nonatomic,strong) UITextField *whatTF;
@property (nonatomic,strong) NSString *farmManagerId;

@property (nonatomic,assign) BOOL isDefaultTemplate;

@property (nonatomic,strong) NSMutableDictionary *fangAnChooseDic;
@end

@implementation NYNWantZhongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self chushihuaWithID:self.selectModel.ID];
    
    self.diZhiModel.address = @"我的默认收货地址";
    self.aiXinModel.address = @"张彩芳";
    self.title = @"租地种植";
    
    self.titleArr = @[@"执行管家",@"监控摄像",@"标志标识",@"产品加工",@"作物保险"].mutableCopy;
    self.detailArr = @[@"",@"",@"待选择",@"待选择",@"待选择"].mutableCopy;
    self.priceArr = @[@"系统自动分配",@"¥0.00",@"¥0.00",@"¥0.00",@"¥0.00"].mutableCopy;
    self.jianKongIsChoose = YES;
    self.peiSongIsChoose = YES;
    
    self.fangAnModel.fangAnName = @"省心方案";
    self.fangAnModel.fangAnPrice = @"0";
    
    //初始化默认是省心方案
    self.isDefaultTemplate = YES;
    
    [self createwangtZhongTable];
    
    self.bottomView = [[NYNGouMaiView alloc]init];
    [self.bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) -64, SCREENWIDTH, JZHEIGHT(45))];
    [self.bottomView.goumaiBT setTitle:@"付款" forState:0];
    __weak typeof(self)weakSelf = self;
    self.bottomView.goumaiBlock = ^(NSString *strValue) {
        
        if (weakSelf.whoTF.text.length < 1 || weakSelf.forWhoTF.text.length < 1 || weakSelf.whatTF.text.length < 1) {
            [weakSelf showTipsView:@"请填写土地名称！"];
            [weakSelf removeTipsView];
        }
        
        NSString *nameStr = [NSString stringWithFormat:@"%@为%@种的%@",weakSelf.whoTF.text,weakSelf.forWhoTF.text,weakSelf.whatTF.text];
        
        [weakSelf showLoadingView:@""];
        
   
//        int managerId = (int)weakSelf.farmManagerId;
//        int managerId = (int)weakSelf.farmManagerId;

        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:nameStr forKey:@"name"];
        [dic setObject:@([weakSelf.farmManagerId integerValue]) forKey:@"farmManagerId"];
        [dic setObject:@([weakSelf.diZhiModel.ID integerValue]) forKey:@"userAddressId"];
        [dic setObject:weakSelf.isDefaultTemplate ? @1 : @0 forKey:@"isDefaultTemplate"];
        [dic setObject:@([weakSelf.farmID integerValue]) forKey:@"farmId"];
        [dic setObject:weakSelf.peiSongIsChoose ? @1 : @0 forKey:@"isDelivery"];
        [dic setObject:@([weakSelf.farmID integerValue]) forKey:@"cycleTime"];
        
        [dic setObject:@"grow" forKey:@"type"];

        
        NSMutableArray *itemModels = [[NSMutableArray alloc]init];
        
        //类型  主要，eg: 土地（禽畜、集市产品）
        NSMutableDictionary *tuDiDic = @{@"productId":@([weakSelf.earthID integerValue]),@"type":@"MAJOR",@"quantity":@(weakSelf.mianjiCount),@"duration":@(weakSelf.shichangCount),@"interval":@1}.mutableCopy;
        //类型
        NSMutableDictionary *zhongZiDic = @{@"productId":@([weakSelf.selectModel.ID integerValue]),@"type":@"MINOR",@"quantity":@(weakSelf.selectModel.selectCount),@"duration":@1,@"interval":@1}.mutableCopy;
        //类型  这里摄像头没有  默认为0
//        NSMutableDictionary *sheXiangTouDic = @{@"productId":@"0",@"type":@"PRODUCT",@"quantity":@"0",@"duration":@"1",@"interval":@"1"}.mutableCopy;

        //类型  标志标识  标识牌数量为1
        NSMutableDictionary *biaoZhiPaiDic = @{@"productId":@([weakSelf.chuShiHuaModel.defaultSignboardId integerValue]),@"type":@"PRODUCT",@"quantity":@1,@"duration":@1,@"interval":@1}.mutableCopy;
//        //类型  产品加工  标识牌数量为1
//        NSMutableDictionary *chanPinJiaGongDic = @{@"productId":weakSelf.chuShiHuaModel.defaultSignboardId,@"type":@"PLAN_PRODUCT",@"quantity":@"1",@"duration":@"1",@"executeDate":@"0",@"interval":@"1"}.mutableCopy;
        
        [itemModels addObject:tuDiDic];
        [itemModels addObject:zhongZiDic];
//        [itemModels addObject:sheXiangTouDic];
        
        if (weakSelf.chuShiHuaModel.defaultSignboardId.length > 0) {
            [itemModels addObject:biaoZhiPaiDic];
        }
        
        if (!weakSelf.isDefaultTemplate) {
            [itemModels addObjectsFromArray:weakSelf.fangAnDicArr];
        }
        
//        [itemModels addObject:chanPinJiaGongDic];
        
        //类型  保险 暂时没有  留在这
//        NSMutableDictionary *MINORDic = @{@"productId":@"3",@"type":@"MINOR",@"quantity":@"5"}.mutableCopy;
        
        //这里提示一下  地址  管家  在上一层参数里面已传
//        NSMutableDictionary *PlanDic = @{@"productId":@"1",@"type":@"PLAN
//                                         ",@"quantity":@"1",@"countItemModels":@[@{@"title":@"播种",@"executeDate":@"1499065665"}]}.mutableCopy;
        
        
//        NSMutableDictionary *PLANDic = @{@"productId":@"3",@"type":@"PLAN",@"quantity":@"2",@"countItemModels":@[@{@"title":@"第一次浇水",@"executeDate":@"1499152065"},@{@"title":@"第二次浇水",@"executeDate":@"1501830465"},@{@"title":@"第三次浇水",@"executeDate":@"1504508865"}]}.mutableCopy;
//        NSMutableDictionary *PLANTwoDic = @{@"productId":@"4",@"type":@"PLAN",@"quantity":@"3",@"duration":@"5",@"interval":@"1"}.mutableCopy;
//        [itemModels addObject:MajorDic];
//        [itemModels addObject:MINORDic];
//        [itemModels addObject:PlanDic];
//        [itemModels addObject:PLANDic];
//        [itemModels addObject:PLANTwoDic];
//
        [dic setObject:itemModels forKey:@"itemModels"];

        NSDictionary *cc = @{@"data":[MyControl dictionaryToJson:dic]};
        [NYNNetTool AddDealWithYangZhiZhongZhiWithparams:cc isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            NYNDealModel *model = [NYNDealModel mj_objectWithKeyValues:success[@"data"]];
            
            NYNQueRenDingDanViewController *vc = [[NYNQueRenDingDanViewController alloc]init];
            vc.model = model;
            vc.type = @"0";
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
            [weakSelf hideLoadingView];
        } failure:^(NSError *failure) {
            [weakSelf hideLoadingView];

        }];
        
        
        
 
    };
    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"%.2f",self.nowTotlePrice];
    
    [self.view addSubview:self.bottomView];
    
    
    
    ADD_NTF_OBJ(@"changeSeed", @selector(changeSeed), nil);
    
    ADD_NTF_OBJ(@"feiMoRenFangAn", @selector(feiMoRenFangAn),nil);
    
    [self reloadMoRenData];
    
}
    


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)changeSeed{
    //存种子的逻辑写在这里的  每次进入页面  循环数组的数据  找到选中的种子模型
    for (NYNXuanZeZhongZiModel *selectModel in self.seedArr) {
        if (selectModel.isChoose == YES) {
            self.selectModel =selectModel;
        }
    }
    
    float f = self.selectModel.selectCount / [self.selectModel.cname intValue];
    int newInt = (int)f;
    int a;
    if (newInt - f > 0) {
        a = ceil(f);
    }else{
        a = newInt;
    }
    
    self.mianjiCount = a;
    self.shichangCount = [self.selectModel.cycleTime intValue];
    self.zuDiPrice = [self.earthPriceStr doubleValue];
    
    //    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    //    [self.wangtZhongTable reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    [self.wangtZhongTable reloadData];
    
    self.zhongziPrice = [self.selectModel.price doubleValue] * self.selectModel.selectCount;
    self.fangAnPrice = [self.fangAnModel.fangAnPrice doubleValue];
    self.jianKongPrice = 0.0;
    //    self.biaoZhiPrice;
    //    self.jiagongPrice;
    self.baoxianPrice = 0.00;
//    self.peisongPrice = 15.0;
    
    [self reloadTotlePrice];
    
    [self reloadMoRenData];
    
    [self chushihuaWithID:self.selectModel.ID];
}

- (void)createwangtZhongTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.wangtZhongTable.delegate = self;
    self.wangtZhongTable.dataSource = self;
    self.wangtZhongTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.wangtZhongTable.showsVerticalScrollIndicator = NO;
    self.wangtZhongTable.showsHorizontalScrollIndicator = NO;
    
    self.wangtZhongTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.00001)];
    [self.view addSubview:self.wangtZhongTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        return 5;
    }else{
        return 3;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NYNEarthZuDiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthZuDiTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.mianJiCount = self.mianjiCount;
            farmLiveTableViewCell.shiChangCount = self.shichangCount;
            
            NSString *str1 = [NSString stringWithFormat:@"¥ %.2f",self.mianjiCount * self.shichangCount * [self.earthPriceStr doubleValue]];
            NSString *str2 = [NSString stringWithFormat:@"（¥ %.2f/%@）",[self.earthPriceStr doubleValue],self.selectModel.unitName];
            NSString *sss = [NSString stringWithFormat:@"%@%@",str1,str2];
            
            farmLiveTableViewCell.priceTotleLabel.attributedText = [MyControl CreateNSAttributedString:sss thePartOneIndex:NSMakeRange(0, str1.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:15] andPartTwoIndex:NSMakeRange(str1.length, str2.length) withColor:Color686868 withFont:[UIFont systemFontOfSize:12]];
            
            __weak typeof(self)weakSelf = self;
            farmLiveTableViewCell.mianjiBlock = ^(NSString *strValue) {
                
                if ([strValue isEqualToString:@"+"]) {
                    weakSelf.mianjiCount++;
                }else{
                    if (weakSelf.mianjiCount == 1) {
                        
                    }else{
                        weakSelf.mianjiCount--;
                    }
                }
                [weakSelf reloadTotlePrice];
                
                [weakSelf.wangtZhongTable reloadData];
            };
            
            farmLiveTableViewCell.shichangBlock = ^(NSString *strValue) {
                if ([strValue isEqualToString:@"+"]) {
                    weakSelf.shichangCount++;

                }else{
                    if (weakSelf.shichangCount == 1) {
                        
                    }else{
                        weakSelf.shichangCount--;
                    }
                }
                
                [weakSelf reloadTotlePrice];
                
                [weakSelf.wangtZhongTable reloadData];

            };
            
            return farmLiveTableViewCell;
        }
        else{
            NYNZuDiZhongZhiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNZuDiZhongZhiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            self.whoTF = farmLiveTableViewCell.whoTF;
            self.forWhoTF = farmLiveTableViewCell.forWhoTF;
            self.whatTF = farmLiveTableViewCell.ZhiWuTF;
            farmLiveTableViewCell.doLabel.text = @"种的";
            return farmLiveTableViewCell;
        }
        
        
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.titleLabel.text = @"选择种子";
            farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"%@ X%d",self.selectModel.name,self.selectModel.selectCount];
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",self.selectModel.selectCount * [self.selectModel.price doubleValue]];

            return farmLiveTableViewCell;
        }
        else{
            NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabel.text = @"种植方案";
            farmLiveTableViewCell.contentLabel.text = self.fangAnModel.fangAnName;
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%@元",self.fangAnModel.fangAnPrice];
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
                farmLiveTableViewCell.titleLabel.text = self.titleArr[indexPath.row];
                farmLiveTableViewCell.contentLabel.text = self.detailArr[indexPath.row];
                
                farmLiveTableViewCell.zhanweiLabel.text = self.priceArr[indexPath.row];
                farmLiveTableViewCell.zhanweiLabel.textColor = Color252827;
                farmLiveTableViewCell.zhanweiLabel.hidden = NO;
                farmLiveTableViewCell.priceLabel.hidden = YES;
//                farmLiveTableViewCell.priceLabel.text = self.priceArr[indexPath.row];
//                farmLiveTableViewCell.priceLabel.textColor = Color252827;
//                farmLiveTableViewCell.contentLabel.frame = CGRectMake(farmLiveTableViewCell.contentLabel.frame.origin.x - 100, farmLiveTableViewCell.contentLabel.top, farmLiveTableViewCell.contentLabel.width, farmLiveTableViewCell.contentLabel.height);
//                farmLiveTableViewCell.priceLabel.frame = CGRectMake(farmLiveTableViewCell.priceLabel.x, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//                farmLiveTableViewCell.peiceLeadingWith.constant = -100;
//                farmLiveTableViewCell.contentWith.constant = 10;
                return farmLiveTableViewCell;
            }
                break;
            case 1:
            {
                NYNSheXiangJianKongTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNSheXiangJianKongTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.titleLabel.text = self.titleArr[indexPath.row];
//                farmLiveTableViewCell.contentLabel.text = self.detailArr[indexPath.row];
                farmLiveTableViewCell.priceLabel.text = self.priceArr[indexPath.row];
                
                if (self.jianKongIsChoose) {
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
                }else{
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");

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
                farmLiveTableViewCell.titleLabel.text = self.titleArr[indexPath.row];
                farmLiveTableViewCell.contentLabel.text = self.detailArr[indexPath.row];
                farmLiveTableViewCell.priceLabel.text = self.priceArr[indexPath.row];
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
                farmLiveTableViewCell.titleLabel.text = self.titleArr[indexPath.row];
                farmLiveTableViewCell.contentLabel.text = self.detailArr[indexPath.row];
                farmLiveTableViewCell.priceLabel.text = self.priceArr[indexPath.row];
                farmLiveTableViewCell.xingLabel.hidden = YES;
                return farmLiveTableViewCell;
            }
                break;
            case 4:
            {
                NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.titleLabel.text = self.titleArr[indexPath.row];
                farmLiveTableViewCell.contentLabel.text = self.detailArr[indexPath.row];
                farmLiveTableViewCell.priceLabel.text = self.priceArr[indexPath.row];
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
                farmLiveTableViewCell.contentLabel.text = @"自然灾害险";
                farmLiveTableViewCell.priceLabel.text = @"¥5.00";
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
                farmLiveTableViewCell.cellLabel.text = @"（¥1.00/㎡）";
                farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",self.peisongPrice];

                if (self.peiSongIsChoose) {
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
                
                if (self.peiSongIsChoose) {
                    self.diZhiModel.dingDanIsChoose = YES;
                }else{
                    self.diZhiModel.dingDanIsChoose = NO;
                }
                
                farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"配送地址:%@",self.diZhiModel.address];
                if (self.diZhiModel.dingDanIsChoose) {
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
                farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"爱心捐赠:%@",self.aiXinModel.address];

                return farmLiveTableViewCell;
            }
                break;
            default:
            {
                NYNChoosePeiSongAddressTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChoosePeiSongAddressTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"爱心捐赠:%@",self.aiXinModel.address];
                
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
            NYNChooseSeedViewController *vc = [[NYNChooseSeedViewController alloc]init];
            vc.seedArr = self.seedArr;
            
            vc.selectModel = self.selectModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            NYNZhongZhiFangAnViewController *vc = [[NYNZhongZhiFangAnViewController alloc]init];
            vc.selectModel = self.selectModel;
            vc.zhongZhiZhouQi = self.selectModel.cycleTime;

            
            __weak typeof(self) WeakSelf = self;
            vc.bbblock = ^(double price, NSString *type,NSMutableArray *mArr) {
                WeakSelf.fangAnDicArr = mArr;
                if ([type isEqualToString:@"0"]) {
                    WeakSelf.fangAnModel.fangAnName = @"省心方案";
                    WeakSelf.isDefaultTemplate = NO;
                }else{
                    WeakSelf.fangAnModel.fangAnName = @"自定义方案";
                    WeakSelf.isDefaultTemplate = NO;

                }
                WeakSelf.fangAnModel.fangAnPrice = [NSString stringWithFormat:@"%.2f",price];
                WeakSelf.fangAnPrice = price;
                NSIndexPath *idx = [NSIndexPath indexPathForRow:1 inSection:1];
                [WeakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[idx] withRowAnimation:UITableViewRowAnimationNone];
                [WeakSelf reloadTotlePrice];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            NYNChooseGuanJiaViewController *vc = [[NYNChooseGuanJiaViewController alloc]init];
            vc.farmID = self.farmID;
            __weak typeof(self)weakSelf = self;
            vc.guanJiaBlcok = ^(NYNGuanJiaModel *model) {
                [self.priceArr replaceObjectAtIndex:indexPath.row withObject:model.name];
                self.farmManagerId = model.ID;
                
                NSIndexPath *ss = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[ss] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1){
            self.jianKongIsChoose = !self.jianKongIsChoose;
            NSIndexPath *ss = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            [self.wangtZhongTable reloadRowsAtIndexPaths:@[ss] withRowAnimation:UITableViewRowAnimationNone];
            
            [self reloadTotlePrice];

        }
        else if (indexPath.row == 2){
            NYNChooseBiaoShiPaiViewController *vc = [[NYNChooseBiaoShiPaiViewController alloc]init];
            vc.farmID = self.farmID;
            __weak __typeof(self)weakSelf = self;
            vc.type = @"0";
            
            vc.chooseBlock = ^(NYNBiaoShiPaiModel *model) {
                
                weakSelf.detailArr[indexPath.row] = model.name;
                weakSelf.priceArr[indexPath.row] = [NSString stringWithFormat:@"%@元",model.price];
                weakSelf.biaoZhiPrice = [model.price doubleValue];
                weakSelf.chuShiHuaModel.defaultSignboardId = model.ID;
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:vc animated:YES];

        }
        else if (indexPath.row == 3){
            NYNChanPinJiaGongViewController *vc = [[NYNChanPinJiaGongViewController alloc]init];
            vc.productId = self.selectModel.ID;
            [vc setProductId:self.selectModel.ID type:@"0"];
            
            __weak __typeof(self)weakSelf = self;
            vc.returnBlock = ^(NYNChanPinJiaGongModel *model) {
                weakSelf.detailArr[indexPath.row] = model.farmArtName;
                weakSelf.priceArr[indexPath.row] = [NSString stringWithFormat:@"%@元",model.price];
                weakSelf.jiagongPrice = [model.price doubleValue];
                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (indexPath.row == 4){
            NYNBaoXianGouMaiViewController *vc = [[NYNBaoXianGouMaiViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else{
            
        }
    }else{
        if (indexPath.row == 0) {
            self.peiSongIsChoose = !self.peiSongIsChoose;
            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            [self.wangtZhongTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        
            [self reloadTotlePrice];

            
        }
        if (indexPath.row == 1) {
            NYNMeAdressViewController *vc = [[NYNMeAdressViewController alloc]init];
            __weak typeof(self) weakSelf = self;
            vc.addressClickBlock = ^(NYNMeAddressModel *model) {
                weakSelf.diZhiModel = model;
                self.diZhiModel.dingDanIsChoose = NO;
                self.aiXinModel.dingDanIsChoose = NO;
                model.dingDanIsChoose = YES;
                NSIndexPath *idp = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [weakSelf.wangtZhongTable reloadRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationNone];
                
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
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


-(NYNSelectFangAnModel *)fangAnModel{
    if (!_fangAnModel) {
        _fangAnModel = [[NYNSelectFangAnModel alloc]init];
    }
    return _fangAnModel;
}


- (void)reloadTotlePrice{
    double totlePrice = 0.00;
    
    totlePrice = totlePrice + self.mianjiCount * self.shichangCount * self.zuDiPrice;
    totlePrice = totlePrice + self.zhongziPrice;
    totlePrice = totlePrice + self.fangAnPrice;
    totlePrice = totlePrice + self.biaoZhiPrice;
    totlePrice = totlePrice + self.jiagongPrice;
    totlePrice = totlePrice + self.baoxianPrice;
    JZLog(@"租地：%f\n种子:%f\n方案:%f\n监控:%f\n标识:%f\n加工:%f\n保险:%f\n配送:%f\n",self.mianjiCount * self.shichangCount * self.zuDiPrice,self.zhongziPrice,self.fangAnPrice,self.jianKongPrice,self.biaoZhiPrice,self.jiagongPrice,self.baoxianPrice,self.peisongPrice);
    if (self.jianKongIsChoose) {
        totlePrice = totlePrice + self.jianKongPrice;
    }
    
    if (self.peiSongIsChoose) {
        totlePrice = totlePrice + self.peisongPrice;
    }
    JZLog(@"总价%f",totlePrice);

    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"%.2f元",totlePrice];
    self.nowTotlePrice = totlePrice;
    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"%.2f",self.nowTotlePrice];

}

- (void)reloadMoRenData{
    [NYNNetTool GetMoRenFangAnWithparams:@{@"productId":self.selectModel.ID} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]){
            
            
            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]){
                
                [self.moFangAnArr removeAllObjects];
                
                for (int i = 0; i < 5; i++) {
                    NYNFangAnListModel *model = [[NYNFangAnListModel alloc]init];
                    model.ctype = [NSString stringWithFormat:@"%d",i];
                    [self.moFangAnArr addObject:model];
                    
                    for (NSDictionary *ziDic in [NSArray arrayWithArray:success[@"data"][@"artOrderItemResults"]]) {
                        NYNFangAnListModel *subModel = [NYNFangAnListModel mj_objectWithKeyValues:ziDic];
                        
                        if ([subModel.ctype isEqualToString:model.ctype]) {
                            [model.subArr addObject:subModel];
                            
                            if ([subModel.checked isEqualToString:@"1"]) {
                                subModel.cellChoose = YES;
                            }else{
                                subModel.cellChoose = NO;
                            }
                        }
                    }
                }
                
                
                for (NYNFangAnListModel *model in self.moFangAnArr) {
                    if ([model.ctype isEqualToString:@"2"]) {
                        NYNFangAnListModel *smodel = [model.subArr firstObject];
                        self.moDataModel.boZhongPrice = [smodel.price doubleValue];
                    }
                    if ([model.ctype isEqualToString:@"3"]) {
                        NYNFangAnListModel *smodel = [model.subArr firstObject];
                        self.moDataModel.boZhongZhouQiPrice = [smodel.price doubleValue];
                        self.moDataModel.boZhongZhouQiCount = [smodel.duration intValue];
                    }
                    if ([model.ctype isEqualToString:@"1"]) {
                        NYNFangAnListModel *smodel = [model.subArr firstObject];
                        smodel.cellChoose = YES;
                        self.moDataModel.shiFeiPrice = [smodel.price doubleValue];
                        self.moDataModel.shiFeiCount = [smodel.count intValue];
                    }
                    if ([model.ctype isEqualToString:@"0"]) {
                        NYNFangAnListModel *smodel = [model.subArr firstObject];
                        self.moDataModel.jiaoShuiPrice = [smodel.price doubleValue];
                        self.moDataModel.jiaoShuiCount = [smodel.count intValue];
                    }
                    if ([model.ctype isEqualToString:@"4"]) {
                        NYNFangAnListModel *smodel = [model.subArr firstObject];
                        self.moDataModel.paiZhaoPrice = [smodel.price doubleValue];
                        
                        self.moDataModel.paizhaocishuCount = [smodel.count intValue];
                        self.moDataModel.paizhaozhouqiCount = [smodel.duration intValue];
                        self.moDataModel.paizhaojiangeCount = [smodel.interval intValue];
                        
                    }
                }
                
                [self reloadMoPrice];
                
            }else{
                [self showLoadingView:@"msg"];
            }
            [self hideLoadingView];
            
        }else{
            [self showLoadingView:@"msg"];
        }
        [self hideLoadingView];

        
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}

-(NYNZhongZhiFangAnModel *)moDataModel{
    if (!_moDataModel) {
        _moDataModel = [[NYNZhongZhiFangAnModel alloc]init];
        
        _moDataModel.boZhongIsChoose = YES;
        _moDataModel.zhouqiIsChoose = YES;
        _moDataModel.shiFeiIsChoose = YES;
        _moDataModel.jiaoShuiIsChoose = YES;
        _moDataModel.paiZhaoIsChoose = YES;
        _moDataModel.chooseDate = [NSDate date];
        _moDataModel.boZhongCount = self.selectModel.selectCount ;
        
        _moDataModel.shiFeiCount = 0;
        _moDataModel.jiaoShuiCount = 0;
        
        _moDataModel.paizhaocishuCount = 0;
        _moDataModel.paizhaozhouqiCount = 0;
        _moDataModel.paizhaojiangeCount = 0;
    }
    
    return _moDataModel;
}

-(NSMutableArray *)moFangAnArr{
    if (!_moFangAnArr) {
        _moFangAnArr = [[NSMutableArray alloc]init];
    }
    return _moFangAnArr;
}

- (void)reloadMoPrice{
    self.moPrice = 0;
    if (self.moDataModel.boZhongIsChoose) {
        self.moPrice = self.moPrice + 1 * self.moDataModel.boZhongPrice * self.selectModel.selectCount;
        
        JZLog(@"1bozhong:%f",1 * self.moDataModel.boZhongPrice * self.selectModel.selectCount);
    }
    if (self.moDataModel.zhouqiIsChoose) {
        
    }
    if (self.moDataModel.shiFeiIsChoose) {
        self.moPrice = self.moPrice + self.moDataModel.shiFeiCount * self.moDataModel.shiFeiPrice * self.selectModel.selectCount;
        JZLog(@"1shifei:%f",self.moDataModel.shiFeiCount * self.moDataModel.shiFeiPrice * self.selectModel.selectCount);
        
    }
    if (self.moDataModel.jiaoShuiIsChoose) {
        self.moPrice = self.moPrice + self.moDataModel.jiaoShuiCount * self.moDataModel.jiaoShuiPrice * self.selectModel.selectCount;
        JZLog(@"1jiaoshui:%f",self.moDataModel.jiaoShuiCount * self.moDataModel.jiaoShuiPrice * self.selectModel.selectCount);
        
    }
    if (self.moDataModel.paiZhaoIsChoose) {
        if (self.moDataModel.paizhaojiangeCount > 0) {
            self.moPrice = self.moPrice + (self.moDataModel.paizhaocishuCount * (self.moDataModel.paizhaozhouqiCount / self.moDataModel.paizhaojiangeCount)) * self.moDataModel.paiZhaoPrice ;
            
            int ss = self.moDataModel.paizhaozhouqiCount / self.moDataModel.paizhaojiangeCount;
            JZLog(@"1paizhao:%f",(self.moDataModel.paizhaocishuCount * (self.moDataModel.paizhaozhouqiCount / self.moDataModel.paizhaojiangeCount)) * self.moDataModel.paiZhaoPrice);
            
        }else{
            
            self.moPrice = self.moPrice + (self.moDataModel.paizhaocishuCount) * self.moDataModel.paiZhaoPrice ;
            
            JZLog(@"1paizhao:%f",(self.moDataModel.paizhaocishuCount) * self.moDataModel.paiZhaoPrice );
        }
    }
    
    self.fangAnPrice = self.moPrice;
    self.fangAnModel.fangAnPrice = [NSString stringWithFormat:@"%.2f",self.moPrice];
    self.moPrice = 0;
    NSIndexPath *is = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.wangtZhongTable reloadRowsAtIndexPaths:@[is] withRowAnimation:UITableViewRowAnimationNone];
    
    [self reloadTotlePrice];
}


-(NYNMeAddressModel *)diZhiModel{
    if (!_diZhiModel) {
        _diZhiModel = [[NYNMeAddressModel alloc]init];
    }
    return _diZhiModel;
}

-(NYNMeAddressModel *)aiXinModel{
    if (!_aiXinModel) {
        _aiXinModel = [[NYNMeAddressModel alloc]init];
    }
    return _aiXinModel;
}

- (void)chushihuaWithID:(NSString *)seedID{
    
    [self showLoadingView:@""];
    [NYNNetTool InitDataWithparams:@{@"productId":seedID} isTestLogin:YES progress:^(NSProgress *progress) {
    
    } success:^(id success) {
        JZLog(@"");
        if ([[NSString stringWithFormat:@"%@",success[@"msg"]] isEqualToString:@"success"]) {
            NYNChuShiHuaModel *model = [NYNChuShiHuaModel mj_objectWithKeyValues:success[@"data"]];
            self.chuShiHuaModel = model;
            
            self.diZhiModel.address = model.defaultUserAddressTitle;
            self.diZhiModel.ID = model.defaultUserAddressId;
            self.aiXinModel.address = @"张彩芳";
            
            self.peisongPrice = [model.freight doubleValue];
            
//            if (model.defaultSignboardId.length > 5) {
//                model.defaultSignboardId = @"";
//            }
            
            self.titleArr = @[@"执行管家",@"监控摄像",@"标志标识",@"产品加工",@"作物保险"].mutableCopy;
            self.detailArr = @[@"",@"",[NSString stringWithFormat:@"%@",model.defaultSignboardName],@"待选择",@"待选择"].mutableCopy;
            self.priceArr = @[@"系统自动分配",@"¥0.00",[NSString stringWithFormat:@"%@",model.defaultSignboardPrice],@"¥0.00",@"¥0.00"].mutableCopy;
            
            //初始化判断数据
            self.fanganIsChoose = NO;
            self.guanJiaIsChoose = YES;
            self.jianKongIsChoose = YES;
            
            if (model.defaultSignboardName.length > 0) {
                self.biaoshiIsChoose = YES;
            }else{
                self.biaoshiIsChoose = NO;
            }
            self.jiaGgongIsChoose = NO;
            self.baoXianIsChoose = NO;
            
            if (model.defaultUserAddressTitle.length > 0) {
                self.peiSongIsChoose = YES;
            }else{
                self.peiSongIsChoose = NO;
            }
            
            self.biaoZhiPrice = [model.defaultSignboardPrice doubleValue];
            
            //这个初始化这个参数
            self.farmManagerId = @"-1";
//            self.fangAnModel.fangAnName = @"省心方案";
//            self.fangAnModel.fangAnPrice = model.defaultTemplateAmount;
            
            [self.wangtZhongTable reloadData];
            
            [self reloadTotlePrice];
        }else{
            [self showTextProgressView:@"初始化数据失败!"];
        }
        [self hideLoadingView];
        
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}

-(NSMutableDictionary *)fangAnChooseDic{
    if (!_fangAnChooseDic) {
        _fangAnChooseDic = [[NSMutableDictionary alloc]init];
    }
    return _fangAnChooseDic;
}

- (void)feiMoRenFangAn{
    //通知得到非默认方案
    self.isDefaultTemplate = NO;
    
}
@end
