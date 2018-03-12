//
//  NYNMeDealDaiShouHuoViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeDealDaiShouHuoViewController.h"
#import "NYNMeDealDaiShouHuoTableViewCell.h"
#import "GoodsDealModel.h"

@interface NYNMeDealDaiShouHuoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *MeDealAlltable;
@property(nonatomic,strong)NSMutableArray * dataListArr;


@end

@implementation NYNMeDealDaiShouHuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self setTable];
    [self getData];
    
}


//获取消费订单数据
-(void)getData{
    
    NSDictionary * ns =  @{@"pageNo":@"1",@"pageSize":@"10",@"type":@"general",@"status":@"shipped"};;
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
            [self hideLoadingView];
            
        }
    } failure:^(NSError *failure){
        
        
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
    return self.dataListArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeDealDaiShouHuoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeDealDaiShouHuoTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.ccblock = ^(NSInteger i) {
        
    };
    farmLiveTableViewCell.model = _dataListArr[indexPath.row];
    
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
