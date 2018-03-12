//
//  NYNMeDealDaiFuKuanViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//待付款controller

#import "NYNMeDealDaiFuKuanViewController.h"
#import "NYNMeDealDaiFuKuanTableViewCell.h"
#import "GoodsDealModel.h"
#import "BuyPlayViewController.h"

@interface NYNMeDealDaiFuKuanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *MeDealAlltable;
@property(nonatomic,strong)NSMutableArray *dataListArr;

@property (nonatomic,assign) int pageNo;



@end

@implementation NYNMeDealDaiFuKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        _pageNo =1;
    [self setTable];
    [self getData];

    _dataListArr = [[NSMutableArray alloc]init];
    //上拉刷新
    self.MeDealAlltable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
}

-(void)setTable{
    [self.view addSubview:self.MeDealAlltable];
    self.MeDealAlltable.delegate = self;
    self.MeDealAlltable.dataSource = self;
    self.MeDealAlltable.showsVerticalScrollIndicator = NO;
    self.MeDealAlltable.showsHorizontalScrollIndicator = NO;
    self.MeDealAlltable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
//获取消费待支付订单数据
-(void)getData{
    
    NSDictionary * ns =  @{@"pageNo":@(_pageNo),@"pageSize":@"10",@"type":@"general",@"status":@"pendingPayment"};;
    [NYNNetTool ConsumeWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                GoodsDealModel*model = [GoodsDealModel mj_objectWithKeyValues:dic];
//                //添加数据
                [self.dataListArr addObject:model];
                
            }
            [self.MeDealAlltable reloadData];
            
        }else if ([NSString stringWithFormat:@"%@",success[@"401"]]){
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            [self hideLoadingView];
            
        }
    } failure:^(NSError *failure){
        
        
    }];
    
}
//删除订单
-(void)garbageClickInteger:(NSString*)select state:(NSString *) state index:(NSInteger)index{
    
    //'pendingPayment', 'canceled', 'completed','received','denied'这些状态可以删除，其他的状态为不可删除状态
  
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"确定删除吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [sheet addAction:cancelAction];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [NYNNetTool MyFarmDetelDealWithparams:select isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                    [self.dataListArr removeObjectAtIndex:index];
                    
                    
                    //                        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationLeft];
                    
                    //           [self.tbFirst deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.indexpath] withRowAnimation:UITableViewRowAnimationFade];
                    [self.MeDealAlltable reloadData];
                    
                    
                }else{
                    
                    [self showTextProgressView:[NSString  stringWithFormat:@"%@",success[@"msg"]]];
                }
                [self hideLoadingView];
            } failure:^(NSError *failure) {
                [self hideLoadingView];
            }];
            
        }];
        [sheet addAction:confirmAction];
        
        [self presentViewController:sheet animated:YES completion:^{
            // TODO
        }];
    
    
    
    
    
}
//上拉刷新
-(void)refreshFooter{
    _pageNo++;
    [self getData];
      [self.MeDealAlltable.mj_footer endRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataListArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeDealDaiFuKuanTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeDealDaiFuKuanTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.model =self.dataListArr[indexPath.row];
    
    farmLiveTableViewCell.ccblock = ^(NSInteger i,GoodsDealModel * model) {
        if (i==2) {
            //删除订单
            [self garbageClickInteger:model.ID state:model.status index:indexPath.row];
            
        }else if (i==3){
            //付款
            BuyPlayViewController * buyVC = [[BuyPlayViewController alloc]init];
            NYNMarketListModel * lictModel = [[NYNMarketListModel alloc]init];
            lictModel.ID = model.orderItems[0][@"productId"];
            lictModel.intro = model.orderItems[0][@"cname"];
            lictModel.images = model.orderItems[0][@"thumbnail"];
            buyVC.countString=model.orderItems[0][@"quantity"];
            lictModel.unitName =model.orderItems[0][@"unitName"];
            lictModel.name =model.orderItems[0][@"name"];
            lictModel.price = model.amount;
            lictModel.panduanBool = @"1";
            
            buyVC.farmId = model.farmId;
            buyVC.yunfeiPrice = [model.freight doubleValue];
            lictModel.farm[@"name"]=model.farm[@"name"];
            lictModel.farm[@"images"] =model.farm[@"img"];
            buyVC.lictModel=lictModel;
            
            [self.navigationController pushViewController:buyVC animated:YES];
        }
        
    };
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(194);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(11))];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.00001)];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return JZHEIGHT(11);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}


- (UITableView *)MeDealAlltable{
    if (!_MeDealAlltable) {
        _MeDealAlltable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - 44) style:UITableViewStyleGrouped];
    }
    return _MeDealAlltable;
}
@end
