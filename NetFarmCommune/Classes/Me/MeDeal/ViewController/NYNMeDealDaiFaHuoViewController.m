//
//  NYNMeDealDaiFaHuoViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeDealDaiFaHuoViewController.h"
#import "NYNMeDealDaiFaHuoTableViewCell.h"
#import "GoodsDealModel.h"
#import "AftersalesViewController.h"
#import "WuLiuViewController.h"
@interface NYNMeDealDaiFaHuoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *MeDealAlltable;

@property(nonatomic,strong)NSMutableArray *dataListArr;

@property (nonatomic,assign) int pageNo;


@end

@implementation NYNMeDealDaiFaHuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataListArr = [[NSMutableArray alloc]init];
        _pageNo=1;
    
    [self setTable];
    [self getData];

    
    //上拉刷新
    self.MeDealAlltable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
}


//获取消费订单数据
-(void)getData{
    
    NSDictionary * ns =  @{@"pageNo":@(_pageNo),@"pageSize":@"10",@"type":@"general",@"status":@"pendingShipment"};;
    [NYNNetTool ConsumeWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
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
-(void)refreshFooter{
    _pageNo++;
    [self getData];
     [self.MeDealAlltable.mj_footer endRefreshing];
    
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
    return self.dataListArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeDealDaiFaHuoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeDealDaiFaHuoTableViewCell class]) owner:self options:nil].firstObject;
    }
    __weak typeof(self) weakSelf = self;
    farmLiveTableViewCell.ccblock = ^(NSInteger i,GoodsDealModel * goodsDealModel) {
        if (i ==2) {
            //申请退款
            AftersalesViewController * afterVC = [[AftersalesViewController alloc]init];
             afterVC.goodsDealModel = goodsDealModel;
            [weakSelf.navigationController pushViewController:afterVC animated:YES];
        }else if (i==3){
            //查看物流
            WuLiuViewController * wuliuVC =[[WuLiuViewController alloc]init];
                 [wuliuVC getWuliuDataUserId:goodsDealModel.ID];
            [wuliuVC.navigationController pushViewController:wuliuVC animated:YES];
            
        }
        
    };
    farmLiveTableViewCell.goodsDealModel = _dataListArr[indexPath.row];
    
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
        _MeDealAlltable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64- 44) style:UITableViewStyleGrouped];
    }
    return _MeDealAlltable;
}
@end
