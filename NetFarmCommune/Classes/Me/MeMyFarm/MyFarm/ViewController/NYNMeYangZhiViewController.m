//
//  NYNMeYangZhiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeYangZhiViewController.h"
#import "NYNMeYangZhiTableViewCell.h"
#import "NYNMeFarmModel.h"
#import "NYNMyFarmZhongZhiViewController.h"
#import "NYNZuDiZhongZhiViewController.h"
#import "NYNMyFarmYangZhiViewController.h"
#import "NYNMyFarmYangZhiJiHuaViewController.h"


@interface NYNMeYangZhiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *meYangZhiTable;

@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation NYNMeYangZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pageNo = 1;
    self.pageSize = 10;
    
    [self.view addSubview:self.meYangZhiTable];
    self.meYangZhiTable.delegate = self;
    self.meYangZhiTable.dataSource = self;
    self.meYangZhiTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.meYangZhiTable.showsVerticalScrollIndicator = NO;
    self.meYangZhiTable.showsHorizontalScrollIndicator = NO;
    
    self.meYangZhiTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.dataArr removeAllObjects];
        
        self.pageNo = 1;
        [self getZhongZhiData];
        
    }];
    
    self.meYangZhiTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNo = 1 + self.pageNo;
        
        [self getZhongZhiData];
        
    }];
    [self getZhongZhiData];
    
}

- (void)endRefresh{
    [self.meYangZhiTable.mj_footer endRefreshing];
    [self.meYangZhiTable.mj_header endRefreshing];
}


- (void)getZhongZhiData{
    [self showLoadingView:@""];
    [NYNNetTool YangZhiWithparams:@{@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize)} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNMeFarmModel *model = [NYNMeFarmModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
                
            }
            [self.meYangZhiTable reloadData];
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self endRefresh];
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeFarmModel *model = self.dataArr[indexPath.section];
    
    //    NYNmeYangZhiTableViewCell
    NYNMeYangZhiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeYangZhiTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.model = model;
    farmLiveTableViewCell.indexPath = indexPath;
    
    __weak typeof(self)weakSelf = self;
    farmLiveTableViewCell.jinDuClickback = ^(NSIndexPath *indexPath) {
        NYNMeFarmModel *model = self.dataArr[indexPath.section];
        
        NYNMyFarmYangZhiJiHuaViewController *vc = [[NYNMyFarmYangZhiJiHuaViewController alloc]init];
        vc.orderId = model.orderId;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    farmLiveTableViewCell.detelClickback = ^(NSIndexPath *indexPath) {
        
        
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"确定删除吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //TODO:
        }];
        [sheet addAction:cancelAction];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self showLoadingView:@""];
            [NYNNetTool MyFarmDetelDealWithparams:model.orderId isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                    [self.dataArr removeObject:model];
                    
                    //                    NSIndexPath *ip = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                    //                    [self.meZhongZhiTable deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationFade];
                    [self.meYangZhiTable deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
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
        
        
        
    };
    
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(200);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(11))];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return JZHEIGHT(11);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(0.0001))];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return JZHEIGHT(0.0001);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeFarmModel *model = self.dataArr[indexPath.section];
    
    NYNMyFarmYangZhiViewController *vc = [[NYNMyFarmYangZhiViewController alloc]init];
    vc.oderId = model.orderId;
    vc.vcName = @"动物资料";
//    vc.myFarmType = @"0";

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)meYangZhiTable{
    if (!_meYangZhiTable) {
        _meYangZhiTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44 - 61) style:UITableViewStyleGrouped];
    }
    return  _meYangZhiTable;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
@end
