//
//  NYNMeQiYeZhuanShuViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeQiYeZhuanShuViewController.h"
#import "NYNMeQiYeTableViewCell.h"
#import "NYNMeFarmModel.h"
#import "NYNMyFarmZhongZhiViewController.h"

@interface NYNMeQiYeZhuanShuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *meQIYeZhuanShuTable;

@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation NYNMeQiYeZhuanShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pageNo = 1;
    self.pageSize = 10;
    
    
    [self.view addSubview:self.meQIYeZhuanShuTable];
    self.meQIYeZhuanShuTable.delegate = self;
    self.meQIYeZhuanShuTable.dataSource = self;
    self.meQIYeZhuanShuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.meQIYeZhuanShuTable.showsVerticalScrollIndicator = NO;
    self.meQIYeZhuanShuTable.showsHorizontalScrollIndicator = NO;
    
    
    self.meQIYeZhuanShuTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.dataArr removeAllObjects];
        
        self.pageNo = 1;
        [self getZhongZhiData];
        
    }];
    
    self.meQIYeZhuanShuTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNo = 1 + self.pageNo;
        
        [self getZhongZhiData];
        
    }];
    [self getZhongZhiData];
}


- (void)endRefresh{
    [self.meQIYeZhuanShuTable.mj_footer endRefreshing];
    [self.meQIYeZhuanShuTable.mj_header endRefreshing];
}


- (void)getZhongZhiData{
    [self showLoadingView:@""];
    [NYNNetTool MyFarmZhuanShuWithparams:@{@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize)} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNMeFarmModel *model = [NYNMeFarmModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
                
            }
            [self.meQIYeZhuanShuTable reloadData];
            
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
    //    NYNmeQIYeZhuanShuTableViewCell
    NYNMeQiYeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeQiYeTableViewCell class]) owner:self options:nil].firstObject;
    }
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(158);
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
    NYNMyFarmZhongZhiViewController *vc = [[NYNMyFarmZhongZhiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)meQIYeZhuanShuTable{
    if (!_meQIYeZhuanShuTable) {
        _meQIYeZhuanShuTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44 - 61) style:UITableViewStyleGrouped];
    }
    return  _meQIYeZhuanShuTable;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
@end
