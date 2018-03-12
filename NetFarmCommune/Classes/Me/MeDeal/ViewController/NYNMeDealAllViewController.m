//
//  NYNMeDealAllViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeDealAllViewController.h"
#import "NYNMeDealAllTableViewCell.h"
#import "GoodsDealModel.h"
#import "AftersalesViewController.h"
#import "WuLiuViewController.h"
#import "NYNPayViewController.h"
#import "AftersalesViewController.h"
#import "NYNDealModel.h"
#import "BuyPlayViewController.h"
@interface NYNMeDealAllViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *MeDealAlltable;
@property(nonatomic,strong)NSMutableArray *dataListArr;
@property(nonatomic,assign)int pageNo;


@end

@implementation NYNMeDealAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataListArr=[[NSMutableArray alloc]init];
    
    _pageNo=1;
    
    [self setTable];
    [self getData];
    
   self.MeDealAlltable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooterData)];
}


//获取消费订单数据
-(void)getData{
    
    NSDictionary * ns =  @{@"pageNo":[NSString stringWithFormat:@"%d",_pageNo],@"pageSize":@"10",@"type":@"general"};;
    [NYNNetTool ConsumeWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            if (!([NSArray arrayWithArray:success[@"data"]].count>0)) {
                return ;
                
            }
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                    GoodsDealModel*model = [GoodsDealModel mj_objectWithKeyValues:dic];
              
               
                  //添加数据
                     [self.dataListArr addObject:model];
                
            }
                    [self.MeDealAlltable reloadData];
    
        }else if ([NSString stringWithFormat:@"%@",success[@"401"]]){
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
       
        
    } failure:^(NSError *failure){
        
        
    }];
    
}


//删除订单
-(void)garbageClickInteger:(NSString*)select state:(NSString *) state index:(NSInteger)index{
    
      //'pendingPayment', 'canceled', 'completed','received','denied'这些状态可以删除，其他的状态为不可删除状态
    if ([state isEqualToString:@"pendingPayment"]||
        [state isEqualToString:@"canceled"]||
        [state isEqualToString:@"completed"]||
        [state isEqualToString:@"received"]||
        [state isEqualToString:@"denied"]) {
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
    }else{
        [self showTextProgressView:@"此订单状态不能删除"];
        [self hideLoadingView];
        
        return;
    }
    
  
  
    
}

//申请退款
-(void)apply:(GoodsDealModel*)goodModel{
    AftersalesViewController * aferVC = [[AftersalesViewController alloc]init];
    aferVC.goodsDealModel = goodModel;
    
    [self.navigationController pushViewController:aferVC animated:YES];
    
}



//下拉刷新
-(void)refreshFooterData{
    _pageNo ++;
    [self getData];
    [self.MeDealAlltable.mj_footer endRefreshing];

}

-(void)payMonenyfarmId:(NSString*)farmId ID:(NSString*)ID{
    //购买支付
    BuyPlayViewController *buyvc = [[BuyPlayViewController alloc]init];
    
    [self.navigationController pushViewController:buyvc animated:YES];
    
    

    
}
//确认收货
-(void)sureShouHuo:(NSString*)ID{
    
    [NYNNetTool ReceiveWithparams:ID isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
        
            [self.MeDealAlltable reloadData];
            [self showTextProgressView:@"收货成功"];
            [self hideLoadingView];
            
        }else{
           [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"data"]]];
        }
        
     [self hideLoadingView];
    } failure:^(NSError *failure) {
       [self hideLoadingView];
    }];
}

-(void)setTable{
    [self.view addSubview:self.MeDealAlltable];
    self.MeDealAlltable.delegate = self;
    self.MeDealAlltable.dataSource = self;
    self.MeDealAlltable.showsVerticalScrollIndicator = NO;
    self.MeDealAlltable.showsHorizontalScrollIndicator = NO;
    self.MeDealAlltable.separatorStyle = UITableViewCellSeparatorStyleNone;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataListArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NYNMeDealAllTableViewCell *)extracted:(UITableView * _Nonnull)tableView {
    NYNMeDealAllTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    return farmLiveTableViewCell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeDealAllTableViewCell * farmLiveTableViewCell = [self extracted:tableView];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeDealAllTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.goodsDealModel = _dataListArr[indexPath.section];
    farmLiveTableViewCell.indexpath =indexPath.section;

    //这里判断的想吐
    farmLiveTableViewCell.ccblock = ^(NSInteger i,NSString * state ,NSString * orderId ,NSInteger index,GoodsDealModel * goodsDealModel) {
        switch (i) {
            case 0:
            {
                if ([state isEqualToString:@"received"]) {
                    //申请退款
                    [self apply:goodsDealModel];
                }
            }
                
                break;
            case 1:
            {
                if ([state isEqualToString:@"shipped"]) {
                    [self apply:goodsDealModel];
                }else if ([state isEqualToString:@"received"]){
                    //已收货
                    WuLiuViewController * wuliuVC =[[WuLiuViewController alloc]init];
                    [wuliuVC getWuliuDataUserId:orderId];
                    [self.navigationController pushViewController:wuliuVC animated:YES];
                }
                
            }
                break;
            case 2:
            {
                if ([state isEqualToString:@"shipped"]) {

                    WuLiuViewController * wuliuVC =[[WuLiuViewController alloc]init];
                    [wuliuVC getWuliuDataUserId:orderId];
                    
                    [self.navigationController pushViewController:wuliuVC animated:YES];
                }else if ([state isEqualToString:@"pendingShipment"]){
                    //申请退款
                    [self apply:goodsDealModel];
                    
                }else if ([state isEqualToString:@"received"]){
                    //已收货 删除订单
                  [self garbageClickInteger:orderId state:state index:index ];
                }
            }
               
                
                break;
            case 3:
            {
                if ([state isEqualToString:@"shipped"]) {
                    //确认收货
                    [self sureShouHuo:orderId];
                    
                    
                    
                }else if ([state isEqualToString:@"canceled"]){
                      [self garbageClickInteger:orderId state:state index:index ];
                    
                }else if ([state isEqualToString:@"pendingShipment"]){
                    WuLiuViewController * wuliuVC =[[WuLiuViewController alloc]init];
                        [wuliuVC getWuliuDataUserId:orderId];
                    [self.navigationController pushViewController:wuliuVC animated:YES];
                }else if ([state isEqualToString:@"pendingPayment"]){
                    //付款
                    BuyPlayViewController * buyVC = [[BuyPlayViewController alloc]init];
                    NYNMarketListModel * lictModel = [[NYNMarketListModel alloc]init];
                    lictModel.ID = goodsDealModel.orderItems[0][@"productId"];
                    lictModel.intro = goodsDealModel.orderItems[0][@"cname"];
                    lictModel.images = goodsDealModel.orderItems[0][@"thumbnail"];
                    buyVC.countString=goodsDealModel.orderItems[0][@"quantity"];
                    lictModel.unitName =goodsDealModel.orderItems[0][@"unitName"];
                    lictModel.name =goodsDealModel.orderItems[0][@"name"];
                    lictModel.price = goodsDealModel.amount;
                    lictModel.panduanBool = @"1";
                    
                    buyVC.farmId = goodsDealModel.farmId;
                    buyVC.yunfeiPrice = [goodsDealModel.freight doubleValue];
                    lictModel.farm[@"name"]=goodsDealModel.farm[@"name"];
                    lictModel.farm[@"images"] =goodsDealModel.farm[@"img"];
                    buyVC.lictModel=lictModel;
                    
                    [self.navigationController pushViewController:buyVC animated:YES];
                }
                
                break;
            }
              
                
                
                
            default:
                break;
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
