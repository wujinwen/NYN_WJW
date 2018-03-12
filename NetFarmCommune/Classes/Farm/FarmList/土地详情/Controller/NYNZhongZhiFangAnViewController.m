//
//  NYNZhongZhiFangAnViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNZhongZhiFangAnViewController.h"
#import "NYNGouMaiView.h"
#import "FTJZSegumentView.h"

#import "NYNFangAnHeaderViewTableViewCell.h"
#import "NYNBoZhongRiQiTableViewCell.h"
#import "NYNZhongZhiZhouQiTableViewCell.h"
#import "NYNShengWuFeiTableViewCell.h"
#import "NYNShiFeiCiShuTableViewCell.h"
#import "NYNMeiCiPaiZhaoTableViewCell.h"

#import "NYNFangAnListModel.h"

#import "NYNZhongZhiFangAnModel.h"
#import "JZDatePickerView.h"

#import "NYNDIYTableViewCell.h"
#import "NYNJiaoShuiCiShuViewController.h"


@interface NYNZhongZhiFangAnViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *ZhongZhiFangAnTable;
@property (nonatomic,strong) NYNGouMaiView* bottomView;

@property (nonatomic,copy) NSString *type;

@property (nonatomic,strong) NSMutableArray *moFangAnArr;
@property (nonatomic,strong) NSMutableArray *ziFangAnArr;

@property (nonatomic,strong) NYNZhongZhiFangAnModel *moDataModel;
@property (nonatomic,strong) NYNZhongZhiFangAnModel *ziDataModel;

@property (nonatomic,strong) JZDatePickerView *pickerView;

@property (nonatomic,assign) double totlePrice;
@end

@implementation NYNZhongZhiFangAnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showTextProgressView:@"获取数据中"];
    
    [NYNNetTool GetZiDingYiFangAnWithparams:@{@"productId":self.selectModel.ID,@"type":@"order"} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            [self.ziFangAnArr removeAllObjects];
            
            for (int i = 0; i < 5; i++) {
                NYNFangAnListModel *model = [[NYNFangAnListModel alloc]init];
                model.ctype = [NSString stringWithFormat:@"%d",i];
                [self.ziFangAnArr addObject:model];
                
                for (NSDictionary *ziDic in [NSArray arrayWithArray:success[@"data"]]) {
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
            
            for (NYNFangAnListModel *model in self.ziFangAnArr) {
                if ([model.ctype isEqualToString:@"2"]) {
                    NYNFangAnListModel *smodel = [model.subArr firstObject];
                    self.ziDataModel.boZhongPrice = [smodel.price doubleValue];
                }
                if ([model.ctype isEqualToString:@"3"]) {
                    NYNFangAnListModel *smodel = [model.subArr firstObject];
                    self.ziDataModel.boZhongZhouQiPrice = [smodel.price doubleValue];
                    self.ziDataModel.boZhongZhouQiCount = [smodel.duration intValue];

                }
                if ([model.ctype isEqualToString:@"1"]) {
                    NYNFangAnListModel *smodel = [model.subArr firstObject];
                    smodel.cellChoose = YES;
                    self.ziDataModel.shiFeiPrice = [smodel.price doubleValue];
                    self.ziDataModel.shiFeiCount = [smodel.count intValue];

                    
                }
                if ([model.ctype isEqualToString:@"0"]) {
                    NYNFangAnListModel *smodel = [model.subArr firstObject];
                    self.ziDataModel.jiaoShuiPrice = [smodel.price doubleValue];
                    self.ziDataModel.jiaoShuiCount = [smodel.count intValue];
                }
                if ([model.ctype isEqualToString:@"4"]) {
                    NYNFangAnListModel *smodel = [model.subArr firstObject];
                    self.ziDataModel.paiZhaoPrice = [smodel.price doubleValue];
                    
                    
                    self.ziDataModel.paizhaocishuCount = [smodel.count intValue];
                    self.ziDataModel.paizhaozhouqiCount = [smodel.duration intValue];
                    self.ziDataModel.paizhaojiangeCount = [smodel.interval intValue];
                    
                }
            }
            
            [NYNNetTool GetMoRenFangAnWithparams:@{@"productId":self.selectModel.ID} isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                
                
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
                    
                    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(50))];
                    headerView.backgroundColor = [UIColor whiteColor];
                    [self.view addSubview:headerView];
                    
                    FTJZSegumentView *ss = [[FTJZSegumentView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headerView.height)];
                    
                    __weak typeof(self)WeakSelf = self;
                    ss.buttonAction = ^(UISegmentedControl *sender) {
                        [WeakSelf showLoadingView:@""];
                        
                        if (sender.selectedSegmentIndex == 0) {
                            WeakSelf.type = @"0";
                            [WeakSelf.ZhongZhiFangAnTable reloadData];
                            
                            [WeakSelf hideLoadingView];
                        }else{
                            WeakSelf.type = @"1";
                            [WeakSelf.ZhongZhiFangAnTable reloadData];

                            [WeakSelf hideLoadingView];
                        }
                        
                        [self reloadTotlePrice];
                    };
                    [headerView addSubview:ss];
                    
                    
                    
                    UIView* xiaLineView = [[UIView alloc]initWithFrame:CGRectMake(0, headerView.height - 0.5, SCREENWIDTH, 0.5)];
                    xiaLineView.backgroundColor = Colore3e3e3;
                    [headerView addSubview:xiaLineView];
                    
                    [self createZhongZhiFangAnTable];
                    
                    self.bottomView = [[NYNGouMaiView alloc]init];
                    [self.bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) -64, SCREENWIDTH, JZHEIGHT(45))];
                    [self.bottomView.goumaiBT setTitle:@"确定" forState:0];
                    [self.bottomView.jiaGouWuCheBT setTitle:@"确定" forState:0];

                    __weak typeof(self)weakSelf = self;
                    self.bottomView.goumaiBlock = ^(NSString *strValue) {
                        
                        if ([weakSelf.type isEqualToString:@"1"]) {
                            if (weakSelf.moDataModel.paizhaocishuCount < 1 || weakSelf.moDataModel.paizhaojiangeCount < 1 || weakSelf.moDataModel.paizhaozhouqiCount < 1 ) {
                                [weakSelf showTextProgressView:@"先完善数据！"];
                                [weakSelf hideLoadingView];
                                return ;
                            }
                        }else{
                            if (weakSelf.moDataModel.paizhaocishuCount < 1 || weakSelf.moDataModel.paizhaojiangeCount < 1 || weakSelf.moDataModel.paizhaozhouqiCount < 1 ) {
                                [weakSelf showTextProgressView:@"先完善数据！"];
                                [weakSelf hideLoadingView];

                                return ;
                            }
                        }
                        
                        
                        
                        //        NYNPayViewController *vc = [[NYNPayViewController alloc]init];
                        //        [weakSelf.navigationController pushViewController:vc animated:YES];
//                        if (weakSelf.bbblock) {
//                            weakSelf.bbblock(weakSelf.totlePrice);
//                        }
                        
                        NSMutableArray *muArr = [[NSMutableArray alloc]init];
                        if ([weakSelf.type isEqualToString:@"0"]) {
                            
                        if (weakSelf.moDataModel.boZhongIsChoose) {
                            NYNFangAnListModel *model;
                            for (NYNFangAnListModel *PPmodel in weakSelf.moFangAnArr) {
                                if ([PPmodel.ctype isEqualToString:@"2"]) {
                                    model = PPmodel;
                                }
                            }
                                NYNFangAnListModel *cmodel = model.subArr[0];
                                NSDictionary *d = @{@"productId":@([cmodel.artProductId integerValue]),
                                                    @"type":@"PLAN",
                                                    @"quantity":@(weakSelf.selectModel.selectCount),
                                                    @"countItemModels":@[@{@"title":@"播种",@"executeDate":[MyControl timeToTimeCode:weakSelf.moDataModel.chooseDate]}]};
                                [muArr addObject:d];
                            }
                            
//                        if (weakSelf.moDataModel.zhouqiIsChoose) {
//                                NYNFangAnListModel *model = weakSelf.moFangAnArr[1];
//                                NYNFangAnListModel *cmodel = model.subArr[0];
//                                NSDictionary *d = @{@"productId":@([cmodel.artProductId integerValue]),
//                                                    @"type":@"PLAN",
//                                                    @"quantity":@(weakSelf.moDataModel.boZhongZhouQiCount),
//                                                    @"duration":@(weakSelf.moDataModel.boZhongZhouQiCount),
//                                                    @"interval":@(weakSelf.moDataModel.boZhongZhouQiCount),
//                                                    @"duration":@""};
//                                [muArr addObject:d];
//                            }
                        
                        if (weakSelf.moDataModel.shiFeiIsChoose) {
                            NYNFangAnListModel *model;
                            for (NYNFangAnListModel *PPmodel in weakSelf.moFangAnArr) {
                                if ([PPmodel.ctype isEqualToString:@"1"]) {
                                    model = PPmodel;
                                }
                            }
                            
                            NYNFangAnListModel *nowCellModel;
                            for (NYNFangAnListModel *cmodel in model.subArr) {
                                if (cmodel.cellChoose) {
                                    nowCellModel = cmodel;
                                }
                            }
                            NSDictionary *d = @{@"productId":@([nowCellModel.artProductId integerValue]),
                                                @"type":@"PLAN",
                                                @"quantity":@(weakSelf.moDataModel.shiFeiCount)};
                            [muArr addObject:d];
                        }
                        
                        if (weakSelf.moDataModel.jiaoShuiIsChoose) {
                            NYNFangAnListModel *model;
                            for (NYNFangAnListModel *PPmodel in weakSelf.moFangAnArr) {
                                if ([PPmodel.ctype isEqualToString:@"0"]) {
                                    model = PPmodel;
                                }
                            }
                            
                            NYNFangAnListModel *nowCellModel = model.subArr.firstObject;
//                            for (NYNFangAnListModel *cmodel in model.subArr) {
//                                if (cmodel.cellChoose) {
//                                    nowCellModel = cmodel;
//                                }
//                            }
                            NSDictionary *d = @{@"productId":@([nowCellModel.artProductId integerValue]),
                                                @"type":@"PLAN",
                                                @"quantity":@(weakSelf.moDataModel.jiaoShuiCount)};
                            [muArr addObject:d];
                        }
                        
                        
                        if (weakSelf.moDataModel.paiZhaoIsChoose) {
                            NYNFangAnListModel *cmodel;
                            for (NYNFangAnListModel *model in weakSelf.moFangAnArr) {
                                if ([model.ctype isEqualToString:@"4"]) {
                                    cmodel = [model.subArr firstObject];
                                }
                            }
                            
                            NSDictionary *d = @{@"productId":@([cmodel.artProductId integerValue]),
                                                @"type":@"PLAN",
                                                @"quantity":@(weakSelf.moDataModel.paizhaocishuCount),
                                                @"interval":@(weakSelf.moDataModel.paizhaojiangeCount),
                                                @"duration":@(weakSelf.moDataModel.paizhaozhouqiCount)
                            };
                            [muArr addObject:d];
                        }
                            
                            
                            NYNFangAnListModel *MD;
                            for (NYNFangAnListModel *PPmodel in weakSelf.moFangAnArr) {
                                if ([PPmodel.ctype isEqualToString:@"0"]) {
                                    MD = PPmodel;
                                }
                            }
                            for (int i = 0; i < MD.subArr.count; i++) {
                                if (i == 0) {
                                    
                                }else{
                                    NYNFangAnListModel *model = weakSelf.moFangAnArr[i];
                                    if ([model.checked isEqualToString:@"1"]) {
                                        NSDictionary *d = @{@"productId":@([model.artProductId integerValue]),
                                                            @"type":@"PLAN",
                                                            @"quantity":@([model.count integerValue])
                                                            };
                                        [muArr addObject:d];

                                    }
                                }
                            }

                        }else{
                            
                            if (weakSelf.ziDataModel.boZhongIsChoose) {
                                
                                NYNFangAnListModel *model;
                                for (NYNFangAnListModel *PPmodel in weakSelf.ziFangAnArr) {
                                    if ([PPmodel.ctype isEqualToString:@"2"]) {
                                        model = PPmodel;
                                    }
                                }
                                
                                NYNFangAnListModel *cmodel = model.subArr[0];
                                NSDictionary *d = @{@"productId":@([cmodel.artProductId integerValue]),
                                                    @"type":@"PLAN",
                                                    @"quantity":@(weakSelf.selectModel.selectCount),
                                                    @"countItemModels":@[@{@"title":@"播种",@"executeDate":[MyControl timeToTimeCode:weakSelf.ziDataModel.chooseDate]}]};
                                [muArr addObject:d];
                            }
                            
//                            if (weakSelf.ziDataModel.zhouqiIsChoose) {
//                                NYNFangAnListModel *model = weakSelf.ziFangAnArr[1];
//                                NYNFangAnListModel *cmodel = model.subArr[0];
//                                NSDictionary *d = @{@"productId":@([cmodel.artProductId integerValue]),
//                                                    @"type":@"PLAN",
//                                                    @"quantity":@(weakSelf.ziDataModel.boZhongZhouQiCount),
//                                                    @"duration":@(weakSelf.ziDataModel.boZhongZhouQiCount),
//                                                    @"interval":@(weakSelf.ziDataModel.boZhongZhouQiCount),
//                                                    @"duration":@""};
//                                [muArr addObject:d];
//                            }
                            
                            if (weakSelf.ziDataModel.shiFeiIsChoose) {
                                
                                NYNFangAnListModel *model;
                                for (NYNFangAnListModel *PPmodel in weakSelf.ziFangAnArr) {
                                    if ([PPmodel.ctype isEqualToString:@"1"]) {
                                        model = PPmodel;
                                    }
                                }
                                
                                NYNFangAnListModel *nowCellModel;
                                for (NYNFangAnListModel *cmodel in model.subArr) {
                                    if (cmodel.cellChoose) {
                                        nowCellModel = cmodel;
                                    }
                                }
                                NSMutableDictionary *d = @{@"productId":@([nowCellModel.artProductId integerValue]),
                                                    @"type":@"PLAN",
                                                    @"quantity":@(weakSelf.ziDataModel.shiFeiCount)}.mutableCopy;
                                if (weakSelf.ziDataModel.shiFeiDataArr.count > 0) {
                                    [d setObject:weakSelf.ziDataModel.shiFeiDataArr forKey:@"countItemModels"];
                                }
                                [muArr addObject:d];
                            }
                            
                            if (weakSelf.ziDataModel.jiaoShuiIsChoose) {
                                
                                NYNFangAnListModel *model ;
                                for (NYNFangAnListModel *PPmodel in weakSelf.ziFangAnArr) {
                                    if ([PPmodel.ctype isEqualToString:@"0"]) {
                                        model = PPmodel;
                                    }
                                }
                                
                                NYNFangAnListModel *nowCellModel  = model.subArr.firstObject;
//                                for (NYNFangAnListModel *cmodel in model.subArr) {
//                                    if (cmodel.cellChoose) {
//                                        nowCellModel = cmodel;
//                                    }
//                                }
                                NSMutableDictionary *d = @{@"productId":@([nowCellModel.artProductId integerValue]),
                                                    @"type":@"PLAN",
                                                    @"quantity":@(weakSelf.ziDataModel.jiaoShuiCount)}.mutableCopy;
                                if (weakSelf.ziDataModel.jiaoShuiArr.count > 0) {
                                    [d setObject:weakSelf.ziDataModel.jiaoShuiDataArr forKey:@"countItemModels"];
                                }
                                [muArr addObject:d];
                            }
                            
                            
                            if (weakSelf.ziDataModel.paiZhaoIsChoose) {
                                
                                
                                NYNFangAnListModel *cmodel;
                                for (NYNFangAnListModel *model in weakSelf.ziFangAnArr) {
                                    if ([model.ctype isEqualToString:@"4"]) {
                                        cmodel = [model.subArr firstObject];
                                    }
                                }
                                
                                NSDictionary *d = @{@"productId":@([cmodel.artProductId integerValue]),
                                                    @"type":@"PLAN",
                                                    @"quantity":@(weakSelf.ziDataModel.paizhaocishuCount),
                                                    @"interval":@(weakSelf.ziDataModel.paizhaojiangeCount),
                                                    @"duration":@(weakSelf.ziDataModel.paizhaozhouqiCount)
                                                    };
                                [muArr addObject:d];
                            }
                            
                            
                            NYNFangAnListModel *MD;
                            for (NYNFangAnListModel *PPmodel in weakSelf.ziFangAnArr) {
                                if ([PPmodel.ctype isEqualToString:@"0"]) {
                                    MD = PPmodel;
                                }
                            }
                            for (int i = 0; i < MD.subArr.count; i++) {
                                if (i == 0) {
                                    
                                }else{
                                    NYNFangAnListModel *model = MD.subArr[i];
                                    if ([model.checked isEqualToString:@"1"]) {
                                        NSDictionary *d = @{@"productId":@([model.artProductId integerValue]),
                                                            @"type":@"PLAN",
                                                            @"quantity":@([model.count integerValue])
                                                            };
                                        [muArr addObject:d];
                                        
                                    }
                                }
                            }
                            
                        }
                    
                        
                        if (weakSelf.bbblock) {
                            weakSelf.bbblock(weakSelf.totlePrice,weakSelf.type,muArr);
                        }
                        
                        POST_NTF(@"feiMoRenFangAn", nil);
                        
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                
                    };
                    [self.view addSubview:self.bottomView];
                    
                    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(80))];
                    footerView.backgroundColor = Colore3e3e3;
                    self.ZhongZhiFangAnTable.tableFooterView = footerView;
                    
                    UILabel *textLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREENWIDTH - 20, footerView.height - 20)];
                    textLB.text = @"提示：您选择了施肥，浇水次数后，农场会根据种植经验和作物实 况进行合理分配施肥，浇水时间，如果您想自己制定，可点击自定 义方案进行制定。";
                    textLB.font = JZFont(12);
                    textLB.textColor = Color888888;
                    textLB.numberOfLines = 0;
                    [footerView addSubview:textLB];
                    
                    
                    
                    [self reloadTotlePrice];

                }else{
                    [self showLoadingView:@"msg"];
                }
                [self hideLoadingView];
                
                //这里最后创建pickerview
                [self.view addSubview:self.pickerView];
                __weak typeof(self) weakSelf = self;
                self.pickerView.MakeClick = ^(NSDate *date) {
                    if ([weakSelf.type isEqualToString:@"0"]) {
                        weakSelf.moDataModel.chooseDate = weakSelf.pickerView.nowDate;
                    }else{
                        weakSelf.ziDataModel.chooseDate = weakSelf.pickerView.nowDate;
                    }
                    
                    NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
                    [weakSelf.ZhongZhiFangAnTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                };
                
                
            } failure:^(NSError *failure) {
                [self hideLoadingView];
            }];
        }else{
            [self showLoadingView:@"msg"];

            [self hideLoadingView];
        }

    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
    
    
    self.title = @"租地种植";
    self.type = @"0";
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self reloadTotlePrice];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

- (void)createZhongZhiFangAnTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.ZhongZhiFangAnTable.delegate = self;
    self.ZhongZhiFangAnTable.dataSource = self;
    self.ZhongZhiFangAnTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.ZhongZhiFangAnTable.showsVerticalScrollIndicator = NO;
    self.ZhongZhiFangAnTable.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:self.ZhongZhiFangAnTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self.type isEqualToString:@"0"]) {
        int i = 0;
        for (NYNFangAnListModel *model in self.moFangAnArr) {
            if ([model.ctype isEqualToString:@"0"]) {
                i = i + (int)model.subArr.count - 1;
            }
        }
        return self.moFangAnArr.count + i;
    }else{
        int i = 0;
        for (NYNFangAnListModel *model in self.moFangAnArr) {
            if ([model.ctype isEqualToString:@"0"]) {
                i = i + (int)model.subArr.count - 1;
            }
        }
        return self.ziFangAnArr.count + i;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.type isEqualToString:@"0"]) {
        if (section == 0) {
            return 2;
        }else if (section == 1) {
            return 1;
        }else if (section == 2) {
            NYNFangAnListModel *nowModel = [NYNFangAnListModel new];
            nowModel.subArr = @[].mutableCopy;
            
            for (NYNFangAnListModel *model in self.moFangAnArr) {
                if ([model.ctype isEqualToString:@"1"]) {
                    nowModel = model;
                }
            }
            
            return nowModel.subArr.count + 2;
        }else if (section == 3) {
            return 2;
        }else if (section == 4){
            return 4;
        }else{
            return 2;
        }

    }else{
        if (section == 0) {
            return 2;
        }else if (section == 1) {
            return 1;
        }else if (section == 2) {
            NYNFangAnListModel *nowModel = [NYNFangAnListModel new];
            nowModel.subArr = @[].mutableCopy;
            
            for (NYNFangAnListModel *model in self.ziFangAnArr) {
                if ([model.ctype isEqualToString:@"1"]) {
                    nowModel = model;
                }
            }
            return nowModel.subArr.count + 2;
        }else if (section == 3) {
            return 2;
        }else if (section == 4){
            return 4;
        }else{
            return 2;
        }
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NYNFangAnListModel *nowModel0 = [NYNFangAnListModel new];
    NYNFangAnListModel *nowModel1 = [NYNFangAnListModel new];
    NYNFangAnListModel *nowModel2 = [NYNFangAnListModel new];
    NYNFangAnListModel *nowModel3 = [NYNFangAnListModel new];
    NYNFangAnListModel *nowModel4 = [NYNFangAnListModel new];

    if ([self.type isEqualToString:@"0"]){
        for (NYNFangAnListModel *model in self.moFangAnArr) {
            if ([model.ctype isEqualToString:@"2"]) {
                nowModel0 = [model.subArr firstObject];
            }
            else if ([model.ctype isEqualToString:@"3"]){
                nowModel1 = [model.subArr firstObject] ;
            }
            else if ([model.ctype isEqualToString:@"1"]){
                nowModel2 = model;
            }
            else if ([model.ctype isEqualToString:@"0"]){
                nowModel3 = [model.subArr firstObject];
            }
            else{
                nowModel4 = [model.subArr firstObject];
            }
        }

    }else{
        for (NYNFangAnListModel *model in self.ziFangAnArr) {
            if ([model.ctype isEqualToString:@"2"]) {
                nowModel0 = [model.subArr firstObject];
            }
            else if ([model.ctype isEqualToString:@"3"]){
                nowModel1 = [model.subArr firstObject] ;
            }
            else if ([model.ctype isEqualToString:@"1"]){
                nowModel2 = model;
            }
            else if ([model.ctype isEqualToString:@"0"]){
                nowModel3 = [model.subArr firstObject];
            }
            else{
                nowModel4 = [model.subArr firstObject];
            }
        }

    }
    
    NYNZhongZhiFangAnModel *nowDataModel;
    if ([self.type isEqualToString:@"0"]) {
        nowDataModel = self.moDataModel;
    }else{
        nowDataModel = self.ziDataModel;
    }
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@（￥%@/%@）",nowModel0.categoryName,nowModel0.price,nowModel0.unitName];
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[nowModel0.price doubleValue] * self.selectModel.selectCount];
            
            if (nowDataModel.boZhongIsChoose) {
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
            }else{
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");

            }
            
            return farmLiveTableViewCell;
        }
        else{
            NYNBoZhongRiQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNBoZhongRiQiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",nowModel0.unionTitle];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设置格式：zzz表示时区
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            //NSDate转NSString
            NSString *currentDateString = [dateFormatter stringFromDate:nowDataModel.chooseDate];
            farmLiveTableViewCell.riqiLabel.text = currentDateString;
            
            return farmLiveTableViewCell;
        }
        
        
        
    }
    
    else if (indexPath.section == 1){
            NYNZhongZhiZhouQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNZhongZhiZhouQiTableViewCell class]) owner:self options:nil].firstObject;
            }
        
        
        
        if ([self.type isEqualToString:@"0"]) {
            farmLiveTableViewCell.countLabel.text = [NSString stringWithFormat:@"%d",self.moDataModel.boZhongCount];
            farmLiveTableViewCell.count = self.moDataModel.boZhongCount;

        }else{
            farmLiveTableViewCell.countLabel.text = [NSString stringWithFormat:@"%d",self.ziDataModel.boZhongCount];
            farmLiveTableViewCell.count = self.ziDataModel.boZhongCount;

        }
        
        __weak typeof(self)WeakSelf = self;
//        __block nowDataModel.boZhongCount = self.zhongZhiZhouQi;
        
//        __strong typeof(nowDataModel) strongnowDataModel = nowDataModel;
        farmLiveTableViewCell.clickBlock = ^(int count) {
            if ([WeakSelf.type isEqualToString:@"0"]) {
                WeakSelf.moDataModel.boZhongCount = count;
                JZLog(@"%d",WeakSelf.moDataModel.boZhongCount);

            }else{
                WeakSelf.ziDataModel.boZhongCount = count;
                JZLog(@"%d",WeakSelf.ziDataModel.boZhongCount);

            }
            
        };
        if (nowDataModel.zhouqiIsChoose) {
            farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
        }else{
            farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
            
        }
            return farmLiveTableViewCell;
        
    }
    
    else if (indexPath.section == 2){
        
        NYNFangAnListModel *firstModel = [nowModel2.subArr firstObject];

        
        if (indexPath.row == 0) {
            NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            
            
            NYNFangAnListModel *choosessModel;
            for (NYNFangAnListModel *nowModel in nowModel2.subArr) {
                if (nowModel.cellChoose) {
                    choosessModel = nowModel;
                }
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@（￥%@/%@）",firstModel.categoryName,choosessModel.price,firstModel.unitName];
            
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f元",[choosessModel.price doubleValue] * self.selectModel.selectCount * nowDataModel.shiFeiCount]];
            
            if (nowDataModel.shiFeiIsChoose) {
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
            }else{
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
                
            }
            
            return farmLiveTableViewCell;

        }
        
        else if (indexPath.row == (nowModel2.subArr.count + 2 - 1)){
            if ([self.type isEqualToString:@"0"]) {
                NYNShiFeiCiShuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShiFeiCiShuTableViewCell class]) owner:self options:nil].firstObject;
                }
                
                //            [farmLiveTableViewCell reloadInputViews];
                farmLiveTableViewCell.iconLabel.text = @"施肥次数";
                
                farmLiveTableViewCell.count = nowDataModel.shiFeiCount;
                
                __weak typeof(self)weakSelf = self;
                farmLiveTableViewCell.tfInputBlock = ^(int count) {
                    if ([weakSelf.type isEqualToString:@"0"]) {
                        weakSelf.moDataModel.shiFeiCount = count;
                    }else{
                        weakSelf.ziDataModel.shiFeiCount = count;
                    }
                    NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                    [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
                    [weakSelf reloadTotlePrice];
                };
                
                return farmLiveTableViewCell;
            }else{
                NYNDIYTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNDIYTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.iconLabel.text = @"施肥次数";
                farmLiveTableViewCell.countLabel.text = [NSString stringWithFormat:@"%d次",nowDataModel.shiFeiCount];
                __weak typeof(self)weakSelf = self;
                
                farmLiveTableViewCell.cellClick = ^(NSString *str) {
                    NYNJiaoShuiCiShuViewController *vc = [[NYNJiaoShuiCiShuViewController alloc]init];
                    vc.clickBack = ^(NSMutableArray *chooseArr,NSMutableArray *chooseDataArr) {
                        nowDataModel.shiFeiCount = (int)chooseArr.count;
                        NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                        NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];

                        [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[index,index1] withRowAnimation:UITableViewRowAnimationNone];
                        nowDataModel.shiFeiArr = chooseArr;
                        nowDataModel.shiFeiDataArr = chooseDataArr;
                        [self reloadTotlePrice];
               
                    };
                    
                    vc.monthArr = nowDataModel.shiFeiArr;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                };
                return farmLiveTableViewCell;

            }
        }
        else{
            NYNShengWuFeiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShengWuFeiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            
            
            NYNFangAnListModel *nowModel;
            if (indexPath.row - 1 < nowModel2.subArr.count) {
                nowModel = nowModel2.subArr[indexPath.row - 1];
            }
            
//            nowDataModel.shiFeiPrice = [nowModel.price doubleValue];
            
            if (nowModel.cellChoose) {
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected4");
            }else{
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected");
            }
            
            __weak typeof(self)WeakSelf = self;
            farmLiveTableViewCell.cellClick = ^(NSString *s) {
                for (NYNFangAnListModel *md in nowModel2.subArr) {
                    md.cellChoose = NO;
                }
                nowModel.cellChoose = YES;
                [WeakSelf.ZhongZhiFangAnTable reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                
                [self reloadTotlePrice];
            };
            
            
            
            farmLiveTableViewCell.iconLabel.text = nowModel.farmArtName;
            farmLiveTableViewCell.danWeiLabel.text = [NSString stringWithFormat:@"¥%@/%@",nowModel.price,nowModel.unitName];
            
            return farmLiveTableViewCell;
        }
        
        
//        switch (indexPath.row) {
//            case 0:
//            {
//                NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//                if (farmLiveTableViewCell == nil) {
//                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
//                }
//                return farmLiveTableViewCell;
//            }
//                break;
//            case 1:
//            {
//                NYNShengWuFeiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//                if (farmLiveTableViewCell == nil) {
//                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShengWuFeiTableViewCell class]) owner:self options:nil].firstObject;
//                }
//                return farmLiveTableViewCell;
//            }
//                break;
//            case 2:
//            {
//                NYNShengWuFeiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//                if (farmLiveTableViewCell == nil) {
//                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShengWuFeiTableViewCell class]) owner:self options:nil].firstObject;
//                }
//                return farmLiveTableViewCell;
//            }
//                break;
//            case 3:
//            {
//                NYNShiFeiCiShuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//                if (farmLiveTableViewCell == nil) {
//                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShiFeiCiShuTableViewCell class]) owner:self options:nil].firstObject;
//                }
//                return farmLiveTableViewCell;
//            }
//                break;
//            default:
//            {
//                NYNShengWuFeiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//                if (farmLiveTableViewCell == nil) {
//                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShengWuFeiTableViewCell class]) owner:self options:nil].firstObject;
//                }
//                return farmLiveTableViewCell;
//            }
//                break;
//                
//                
//        }
        
        
    }
    else if (indexPath.section == 3){
        
        switch (indexPath.row) {
            case 0:
            {
                NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
                }
                
                farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@（￥%@/%@）",nowModel3.categoryName,nowModel3.price,nowModel3.unitName];
                farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[nowModel3.price floatValue] * nowDataModel.jiaoShuiCount * self.selectModel.selectCount];
                
                if (nowDataModel.jiaoShuiIsChoose) {
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
                }else{
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
                    
                }
                
                return farmLiveTableViewCell;
            }
                break;
            default:
            {
                if ([self.type isEqualToString:@"0"]) {

                
                NYNShiFeiCiShuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShiFeiCiShuTableViewCell class]) owner:self options:nil].firstObject;
                }
                
                farmLiveTableViewCell.iconLabel.text = nowModel3.countTitle;
                farmLiveTableViewCell.daweiLabel.text = @"次";
//                farmLiveTableViewCell
                
                farmLiveTableViewCell.count = nowDataModel.jiaoShuiCount;
                
                __weak typeof(self)weakSelf = self;
                farmLiveTableViewCell.tfInputBlock = ^(int count) {
                    if ([weakSelf.type isEqualToString:@"0"]) {
                        weakSelf.moDataModel.jiaoShuiCount = count;
                    }else{
                        weakSelf.ziDataModel.jiaoShuiCount = count;
                    }
                    
                    NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                    [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
                    
                    [weakSelf reloadTotlePrice];
                };
                
                return farmLiveTableViewCell;
                    
                }else{
                    NYNDIYTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                    if (farmLiveTableViewCell == nil) {
                        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNDIYTableViewCell class]) owner:self options:nil].firstObject;
                    }
                    
                    farmLiveTableViewCell.iconLabel.text = @"浇水次数";
                    farmLiveTableViewCell.countLabel.text = [NSString stringWithFormat:@"%d次",nowDataModel.jiaoShuiCount];

                    __weak typeof(self)weakSelf = self;
                    
                    farmLiveTableViewCell.cellClick = ^(NSString *str) {
                        NYNJiaoShuiCiShuViewController *vc = [[NYNJiaoShuiCiShuViewController alloc]init];
                        
                        vc.clickBack = ^(NSMutableArray *chooseArr,NSMutableArray *chooseDataArr) {
                            nowDataModel.jiaoShuiCount = (int)chooseArr.count;
                            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                            NSIndexPath *index1 = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];

                            [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[index,index1] withRowAnimation:UITableViewRowAnimationNone];
                            nowDataModel.jiaoShuiArr = chooseArr;
                            nowDataModel.jiaoShuiDataArr = chooseDataArr;
                            [self reloadTotlePrice];
                        };
                        vc.type = @"0";
                        
                        vc.monthArr = nowDataModel.jiaoShuiArr;

                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    };
                    
                    return farmLiveTableViewCell;
                }
            }
                break;
        }
        
        
    }
    else if (indexPath.section == 4){
        
        switch (indexPath.row) {
            case 0:
            {
                NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
                }
                
                farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@（￥%@/%@）",nowModel4.categoryName,nowModel4.price,nowModel4.unitName];
//                NSString *str1 = [NSString stringWithFormat:@"¥%.2f",[nowModel4.price doubleValue]* (nowDataModel.paizhaozhouqiCount / nowDataModel.paizhaojiangeCount * nowDataModel.paizhaocishuCount)];
//                NSString *str2 = ([NSString stringWithFormat:@"¥%.2f",[nowModel4.price doubleValue]* (nowDataModel.paizhaozhouqiCount / nowDataModel.paizhaojiangeCount * nowDataModel.paizhaocishuCount)]);
//                NSString *srr = [NSString stringWithFormat:@"%@",(nowDataModel.paizhaozhouqiCount = 0) ? str1 : str2];
                NSString *srr;
                if ((nowDataModel.paizhaojiangeCount > 0)) {
                    srr = ([NSString stringWithFormat:@"¥%.2f",[nowModel4.price doubleValue]* (nowDataModel.paizhaozhouqiCount / nowDataModel.paizhaojiangeCount * nowDataModel.paizhaocishuCount)]);
                }else{
                    srr = [NSString stringWithFormat:@"¥%.2f",[nowModel4.price doubleValue]* nowDataModel.paizhaocishuCount];
                }
                
                farmLiveTableViewCell.priceLabel.text = srr;
                JZLog(@"======================================%@",srr);
                if (nowDataModel.paiZhaoIsChoose) {
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
                }else{
                    farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
                    
                }
                
                return farmLiveTableViewCell;
            }
                break;
            case 1:
            {
                NYNMeiCiPaiZhaoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeiCiPaiZhaoTableViewCell class]) owner:self options:nil].firstObject;
                }
                farmLiveTableViewCell.iconLabel.text = nowModel4.countTitle;
                farmLiveTableViewCell.danweiLabel.text= nowModel4.unitName;
                farmLiveTableViewCell.count = nowDataModel.paizhaocishuCount;
                
                
                __weak typeof(self)WeakSelf = self;
                farmLiveTableViewCell.clickBlock = ^(int count) {
                    nowDataModel.paizhaocishuCount = count;
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                    [WeakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
                    
                    [self reloadTotlePrice];
                };
                
                return farmLiveTableViewCell;
            }
                break;
            case 2:
            {
                NYNMeiCiPaiZhaoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeiCiPaiZhaoTableViewCell class]) owner:self options:nil].firstObject;
                }
                
                farmLiveTableViewCell.iconLabel.text = nowModel4.intervalTitle;
                farmLiveTableViewCell.danweiLabel.text= @"天";
                
                farmLiveTableViewCell.count = nowDataModel.paizhaojiangeCount;

                __weak typeof(self)weakSelf = self;
                __weak typeof(farmLiveTableViewCell)weakfarmLiveTableViewCell = farmLiveTableViewCell;

                farmLiveTableViewCell.clickBlock = ^(int count) {
                    nowDataModel.paizhaojiangeCount = count;
                    
                    if (nowDataModel.paizhaojiangeCount > nowDataModel.paizhaozhouqiCount) {
                        nowDataModel.paizhaojiangeCount = nowDataModel.paizhaozhouqiCount;
                        [weakSelf showTipsView:@"拍照间隔时间不能大于拍照周期时间"];
                        

                    }
                    weakfarmLiveTableViewCell.count = nowDataModel.paizhaojiangeCount;
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                    [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
                    [self reloadTotlePrice];
                    
                };
                
                return farmLiveTableViewCell;
            }
                break;
            default:
            {
                NYNMeiCiPaiZhaoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeiCiPaiZhaoTableViewCell class]) owner:self options:nil].firstObject;
                }
                
                farmLiveTableViewCell.iconLabel.text = nowModel4.durationTitle;
                farmLiveTableViewCell.danweiLabel.text= @"天";
                
                farmLiveTableViewCell.count = nowDataModel.paizhaozhouqiCount;
                
                __weak typeof(self)weakSelf = self;
                __weak typeof(farmLiveTableViewCell)weakfarmLiveTableViewCell = farmLiveTableViewCell;
                
                
//                __block ss = -1;
                farmLiveTableViewCell.clickBlock = ^(int count) {
                    nowDataModel.paizhaozhouqiCount = count;
                    

                    
                    if (nowDataModel.paizhaojiangeCount >= nowDataModel.paizhaozhouqiCount) {
                        nowDataModel.paizhaojiangeCount = nowDataModel.paizhaozhouqiCount;
                        
//                        JZLog(@"ssssssssss%d",ss);
//                        [weakSelf showTipsView:@"拍照间隔时间不能大于拍照周期时间"];
                        
//                        weakfarmLiveTableViewCell.count = nowDataModel.paizhaojiangeCount;

                        
                    }
                    
//                    if (ss > 0 ) {
//                        nowDataModel.paizhaojiangeCount = ss;
//                    }
//                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
//                    [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
                    NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
                    [weakSelf.ZhongZhiFangAnTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                    [self reloadTotlePrice];
                };
                
                return farmLiveTableViewCell;
            }
                break;
        }
        
    }
    else{
        {
            
            switch (indexPath.row) {
                case 0:
                {
                    NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                    if (farmLiveTableViewCell == nil) {
                        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
                    }
                    NYNFangAnListModel *cModel;
                    if ([self.type isEqualToString:@"0"]) {
                        NYNFangAnListModel *nowModel = self.moFangAnArr[0];
                        cModel = nowModel.subArr[indexPath.section - 4];
                    }else{
                        NYNFangAnListModel *nowModel = self.ziFangAnArr[0];
                        cModel = nowModel.subArr[indexPath.section - 4];
                    }
                    farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@（￥%@/%@）",cModel.categoryName,cModel.price,cModel.unitName];
                    farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[cModel.price floatValue] * self.selectModel.selectCount * [cModel.count intValue]];
                    
                    if ([cModel.checked isEqualToString:@"1"]) {
                        farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
                    }else{
                        farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
                        
                    }
                    
                    return farmLiveTableViewCell;
                }
                    break;
                default:
                {
                    if ([self.type isEqualToString:@"0"]) {
                        
                        
                        NYNShiFeiCiShuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                        if (farmLiveTableViewCell == nil) {
                            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShiFeiCiShuTableViewCell class]) owner:self options:nil].firstObject;
                        }
                        
                        NYNFangAnListModel *cModel;
                        if ([self.type isEqualToString:@"0"]) {
                            NYNFangAnListModel *nowModel = self.moFangAnArr[0];
                            cModel = nowModel.subArr[indexPath.section - 4];
                        }else{
                            NYNFangAnListModel *nowModel = self.ziFangAnArr[0];
                            cModel = nowModel.subArr[indexPath.section - 4];
                        }
                        
                        farmLiveTableViewCell.iconLabel.text = cModel.countTitle;
                        farmLiveTableViewCell.daweiLabel.text = @"次";
                        
                        farmLiveTableViewCell.count = [cModel.count intValue];
                        
                        __weak typeof(self)weakSelf = self;
                        farmLiveTableViewCell.tfInputBlock = ^(int count) {
                            cModel.count = [NSString stringWithFormat:@"%d",count];
                            
                            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                            [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
                            
                            [weakSelf reloadTotlePrice];
                        };
                        
                        return farmLiveTableViewCell;
                        
                    }else{
                        NYNShiFeiCiShuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                        if (farmLiveTableViewCell == nil) {
                            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShiFeiCiShuTableViewCell class]) owner:self options:nil].firstObject;
                        }
                        
                        NYNFangAnListModel *cModel;
                        if ([self.type isEqualToString:@"0"]) {
                            NYNFangAnListModel *nowModel = self.moFangAnArr[0];
                            cModel = nowModel.subArr[indexPath.section - 4];
                        }else{
                            NYNFangAnListModel *nowModel = self.ziFangAnArr[0];
                            cModel = nowModel.subArr[indexPath.section - 4];
                        }
                        
                        farmLiveTableViewCell.iconLabel.text = cModel.countTitle;
                        farmLiveTableViewCell.daweiLabel.text = @"次";
                        
                        farmLiveTableViewCell.count = [cModel.count intValue];
                        
                        __weak typeof(self)weakSelf = self;
                        farmLiveTableViewCell.tfInputBlock = ^(int count) {
                            cModel.count = [NSString stringWithFormat:@"%d",count];
                            
                            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                            [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
                            
                            [weakSelf reloadTotlePrice];
                        };
                        
                        return farmLiveTableViewCell;
                        };
                        

                }
                    break;
            }
            
            
        }
        
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(45);
    
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
//    if (indexPath.section == 0)
    
    if ([self.type isEqualToString:@"0"]) {

        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                self.moDataModel.boZhongIsChoose = !self.moDataModel.boZhongIsChoose;
            }
            else if(indexPath.row == 1){
                [self showPickerView];
            }
        }
        else if (indexPath.section == 1){
            if (indexPath.row == 0) {
            self.moDataModel.zhouqiIsChoose = !self.moDataModel.zhouqiIsChoose;
            }
            
        }
        else if (indexPath.section == 2){
            if (indexPath.row == 0) {
            self.moDataModel.shiFeiIsChoose = !self.moDataModel.shiFeiIsChoose;
            }
        }
        else if (indexPath.section == 3){
            if (indexPath.row == 0) {
            self.moDataModel.jiaoShuiIsChoose = !self.moDataModel.jiaoShuiIsChoose;
            }
        }
        else if (indexPath.section == 4){
            if (indexPath.row == 0) {
            self.moDataModel.paiZhaoIsChoose = !self.moDataModel.paiZhaoIsChoose;
            }
        }
        else {
            if (indexPath.row == 0) {
                NYNFangAnListModel *nowModel = self.moFangAnArr[0];
                NYNFangAnListModel *cModel = nowModel.subArr[indexPath.section - 4];

                if ([cModel.checked isEqualToString:@"1"]) {
                    cModel.checked = @"0";
                }else{
                    cModel.checked = @"1";
                }
            }
        }
    }else{
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
            self.ziDataModel.boZhongIsChoose = !self.ziDataModel.boZhongIsChoose;
            }
            else if(indexPath.row == 1){
                [self showPickerView];
            }
        }
        else if (indexPath.section == 1){
            if (indexPath.row == 0) {
            self.ziDataModel.zhouqiIsChoose = !self.ziDataModel.zhouqiIsChoose;
            }
        }
        else if (indexPath.section == 2){
            if (indexPath.row == 0) {
            self.ziDataModel.shiFeiIsChoose = !self.ziDataModel.shiFeiIsChoose;
            }
        }
        else if (indexPath.section == 3){
            if (indexPath.row == 0) {
            self.ziDataModel.jiaoShuiIsChoose = !self.ziDataModel.jiaoShuiIsChoose;
            }
        }
        else if (indexPath.section == 4){
            if (indexPath.row == 0) {
            self.ziDataModel.paiZhaoIsChoose = !self.ziDataModel.paiZhaoIsChoose;
            }
        }
        else{
            if (indexPath.row == 0) {
                NYNFangAnListModel *nowModel = self.ziFangAnArr[0];
                NYNFangAnListModel *cModel = nowModel.subArr[indexPath.section - 4];
                
                if ([cModel.checked isEqualToString:@"1"]) {
                    cModel.checked = @"0";
                }else{
                    cModel.checked = @"1";
                }
            }
        }
    }
    [self.ZhongZhiFangAnTable reloadData];
    
    [self reloadTotlePrice];
    
}



#pragma 懒加载
-(UITableView *)ZhongZhiFangAnTable
{
    if (!_ZhongZhiFangAnTable) {
        _ZhongZhiFangAnTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(45) - 50) style:UITableViewStyleGrouped];
    }
    return _ZhongZhiFangAnTable;
}


-(NSMutableArray *)moFangAnArr{
    if (!_moFangAnArr) {
        _moFangAnArr = [[NSMutableArray alloc]init];
    }
    return _moFangAnArr;
}

-(NSMutableArray *)ziFangAnArr{
    if (!_ziFangAnArr) {
        _ziFangAnArr = [[NSMutableArray alloc]init];
    }
    return _ziFangAnArr;
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
        _moDataModel.boZhongCount = [self.zhongZhiZhouQi intValue];
        
        _moDataModel.shiFeiCount = 0;
        _moDataModel.jiaoShuiCount = 0;
        
        _moDataModel.paizhaocishuCount = 0;
        _moDataModel.paizhaozhouqiCount = 0;
        _moDataModel.paizhaojiangeCount = 0;
    }
    
    return _moDataModel;
}

-(NYNZhongZhiFangAnModel *)ziDataModel{
    if (!_ziDataModel) {
        _ziDataModel = [[NYNZhongZhiFangAnModel alloc]init];
        
        _ziDataModel.boZhongIsChoose = YES;
        _ziDataModel.zhouqiIsChoose = YES;
        _ziDataModel.shiFeiIsChoose = YES;
        _ziDataModel.jiaoShuiIsChoose = YES;
        _ziDataModel.paiZhaoIsChoose = YES;
        _ziDataModel.chooseDate = [NSDate date];
        _ziDataModel.boZhongCount = [self.zhongZhiZhouQi intValue];
        
        _ziDataModel.shiFeiCount = 0;
        _ziDataModel.jiaoShuiCount = 0;

        _ziDataModel.paizhaocishuCount = 0;
        _ziDataModel.paizhaozhouqiCount = 0;
        _ziDataModel.paizhaojiangeCount = 0;
    }
    return _ziDataModel;
}

- (JZDatePickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[JZDatePickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, JZHEIGHT(200))];
        _pickerView.backgroundColor = [UIColor whiteColor];
    }

    return _pickerView;
}

//- (void)hidePickerView{
//    [self.pickerView hidePickerView];
//    
//
//    
//}

- (void)showPickerView{
    [self.pickerView showPickerView];
}


- (void)reloadTotlePrice{
    self.totlePrice = 0;

    if ([self.type isEqualToString:@"0"]) {
        
        if (self.moDataModel.boZhongIsChoose) {
            self.totlePrice = self.totlePrice + 1 * self.moDataModel.boZhongPrice * self.selectModel.selectCount;
            
            JZLog(@"1bozhong:%f",1 * self.moDataModel.boZhongPrice * self.selectModel.selectCount);
        }
        if (self.moDataModel.zhouqiIsChoose) {

        }
        if (self.moDataModel.shiFeiIsChoose) {
            self.totlePrice = self.totlePrice + self.moDataModel.shiFeiCount * self.moDataModel.shiFeiPrice * self.selectModel.selectCount;
            JZLog(@"1shifei:%f",self.moDataModel.shiFeiCount * self.moDataModel.shiFeiPrice * self.selectModel.selectCount);

        }
        if (self.moDataModel.jiaoShuiIsChoose) {
            self.totlePrice = self.totlePrice + self.moDataModel.jiaoShuiCount * self.moDataModel.jiaoShuiPrice * self.selectModel.selectCount;
            JZLog(@"1jiaoshui:%f",self.moDataModel.jiaoShuiCount * self.moDataModel.jiaoShuiPrice * self.selectModel.selectCount);

        }
        if (self.moDataModel.paiZhaoIsChoose) {
            if (self.moDataModel.paizhaojiangeCount > 0) {
                            self.totlePrice = self.totlePrice + (self.moDataModel.paizhaocishuCount * (self.moDataModel.paizhaozhouqiCount / self.moDataModel.paizhaojiangeCount)) * self.moDataModel.paiZhaoPrice ;
                
                int ss = self.moDataModel.paizhaozhouqiCount / self.moDataModel.paizhaojiangeCount;
                JZLog(@"1paizhao:%f",(self.moDataModel.paizhaocishuCount * (self.moDataModel.paizhaozhouqiCount / self.moDataModel.paizhaojiangeCount)) * self.moDataModel.paiZhaoPrice);

            }else{

                self.totlePrice = self.totlePrice + (self.moDataModel.paizhaocishuCount) * self.moDataModel.paiZhaoPrice ;
                
                JZLog(@"1paizhao:%f",(self.moDataModel.paizhaocishuCount) * self.moDataModel.paiZhaoPrice );

            }


        }
        
        if (self.moFangAnArr.count > 0) {
            NYNFangAnListModel *nowModel = self.moFangAnArr[0];
            for (int i = 0; i < nowModel.subArr.count; i++) {
                NYNFangAnListModel *subModel = nowModel.subArr[i];
                if (i == 0) {
                    
                }else{
                    if ([subModel.checked isEqualToString:@"1"]) {
                        self.totlePrice = self.totlePrice + [subModel.price floatValue] * self.selectModel.selectCount * [subModel.count intValue];
                        
                        
                        JZLog(@"%d====后面加的:%.2f",i,[subModel.price floatValue] * self.selectModel.selectCount * [subModel.count intValue]);
                        
                    }
                }
            }
        }else{
        
        }
        

        
        
    }else{
        if (self.ziDataModel.boZhongIsChoose) {
            self.totlePrice = self.totlePrice + self.selectModel.selectCount * self.ziDataModel.boZhongPrice;
            
            JZLog(@"%f",1 * self.ziDataModel.boZhongPrice * self.selectModel.selectCount);

        }
        if (self.ziDataModel.zhouqiIsChoose) {
            
        }
        if (self.ziDataModel.shiFeiIsChoose) {
            self.totlePrice = self.totlePrice + self.ziDataModel.shiFeiCount * self.ziDataModel.shiFeiPrice * self.selectModel.selectCount ;
            JZLog(@"%f",self.ziDataModel.shiFeiCount * self.ziDataModel.shiFeiPrice * self.selectModel.selectCount);

        }
        if (self.ziDataModel.jiaoShuiIsChoose) {
            self.totlePrice = self.totlePrice + self.ziDataModel.jiaoShuiCount * self.ziDataModel.jiaoShuiPrice * self.selectModel.selectCount;
            JZLog(@"%f",self.ziDataModel.jiaoShuiCount * self.ziDataModel.jiaoShuiPrice);

        }
        if (self.ziDataModel.paiZhaoIsChoose) {
            if (self.ziDataModel.paizhaojiangeCount > 0) {
                self.totlePrice = self.totlePrice + (self.ziDataModel.paizhaocishuCount * (self.ziDataModel.paizhaozhouqiCount / self.ziDataModel.paizhaojiangeCount)) * self.ziDataModel.paiZhaoPrice;
                JZLog(@"%f",(self.ziDataModel.paizhaocishuCount * (self.ziDataModel.paizhaozhouqiCount / self.ziDataModel.paizhaojiangeCount)) * self.ziDataModel.paiZhaoPrice);

            }else{
                self.totlePrice = self.totlePrice + (self.ziDataModel.paizhaocishuCount) * self.ziDataModel.paiZhaoPrice ;
                JZLog(@"%f",(self.ziDataModel.paizhaocishuCount) * self.ziDataModel.paiZhaoPrice);

            }

        }
        
        if (self.ziFangAnArr.count > 0) {
            NYNFangAnListModel *nowModel = self.ziFangAnArr[0];
            for (int i = 0; i < nowModel.subArr.count; i++) {
                NYNFangAnListModel *subModel = nowModel.subArr[i];
                if (i == 0) {
                    
                }else{
                    if ([subModel.checked isEqualToString:@"1"]) {
                        self.totlePrice = self.totlePrice + [subModel.price floatValue] * self.selectModel.selectCount * [subModel.count intValue];
                        JZLog(@"%d====后面加的:%.2f",i,[subModel.price floatValue] * self.selectModel.selectCount * [subModel.count intValue]);
                        
                    }
                }
            }
        }else{
        
        }
        

        
    }

    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"¥%.2f",self.totlePrice];
    
}
@end
