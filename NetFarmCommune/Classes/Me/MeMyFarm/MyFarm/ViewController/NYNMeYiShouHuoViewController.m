//
//  NYNMeYiShouHuoViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeYiShouHuoViewController.h"
#import "NYNMeYiShouHuoTableViewCell.h"
#import "NYNMeFarmModel.h"
#import "NYNMyFarmPingJiaViewController.h"
#import "NYNMyFarmSuYuanViewController.h"


@interface NYNMeYiShouHuoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *meyiShouHuoTable;

@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation NYNMeYiShouHuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pageNo = 1;
    self.pageSize = 10;
    
    [self.view addSubview:self.meyiShouHuoTable];
    self.meyiShouHuoTable.delegate = self;
    self.meyiShouHuoTable.dataSource = self;
    self.meyiShouHuoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.meyiShouHuoTable.showsVerticalScrollIndicator = NO;
    self.meyiShouHuoTable.showsHorizontalScrollIndicator = NO;
    
    
    self.meyiShouHuoTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.dataArr removeAllObjects];
        
        self.pageNo = 1;
        [self getZhongZhiData];
        
    }];
    
    self.meyiShouHuoTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNo = 1 + self.pageNo;
        
        [self getZhongZhiData];
        
    }];
    [self getZhongZhiData];
    
    
}


- (void)endRefresh{
    [self.meyiShouHuoTable.mj_footer endRefreshing];
    [self.meyiShouHuoTable.mj_header endRefreshing];
}

- (void)getZhongZhiData{
    [self showLoadingView:@""];
    [NYNNetTool MyFarmCompletWithparams:@{@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize)} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNMeFarmModel *model = [NYNMeFarmModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
                
            }
            [self.meyiShouHuoTable reloadData];
            
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

    
    //    NYNmeyiShouHuoTableViewCell
    NYNMeYiShouHuoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeYiShouHuoTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.model = model;

    __weak typeof(self) weakSelf = self;
    farmLiveTableViewCell.suYuanBack = ^(NSIndexPath *indexPath) {
        NYNMyFarmSuYuanViewController *vc = [[NYNMyFarmSuYuanViewController alloc]init];
        NYNMeFarmModel *model = self.dataArr[indexPath.section];
        vc.model = model;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    farmLiveTableViewCell.pingJiaBack = ^(NSIndexPath *indexPath) {
        NYNMyFarmPingJiaViewController *vc = [[NYNMyFarmPingJiaViewController alloc]init];
        NYNMeFarmModel *model = self.dataArr[indexPath.section];
        vc.model = model;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(101);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)meyiShouHuoTable{
    if (!_meyiShouHuoTable) {
        _meyiShouHuoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44 - 61) style:UITableViewStyleGrouped];
    }
    return  _meyiShouHuoTable;
}


-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
@end
