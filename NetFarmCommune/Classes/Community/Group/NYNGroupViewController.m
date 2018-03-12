//
//  NYNGroupViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNGroupViewController.h"
#import "NYNGroupTableViewCell.h"
#import "GrounpModel.h"


@interface NYNGroupViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * groupTableVC;
@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;

@property(nonatomic,strong)NSMutableArray * dataArr;



@end

@implementation NYNGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.groupTableVC];
    
    self.pageNo = 1;
    self.pageSize =10;
    _dataArr = [NSMutableArray array];
    [self setData];
    
    self.groupTableVC.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArr removeAllObjects];
        self.pageNo = 1;
        [self setData];
        
    }];
    self.groupTableVC.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNo = 1 + self.pageNo;
        
        [self setData];
        
    }];

}
- (void)endRefresh{
    [self.groupTableVC.mj_footer endRefreshing];
    [self.groupTableVC.mj_header endRefreshing];
}
//群组数据请求
-(void)setData{
  
    [NYNNetTool GetQunZunParams:@{@"userId":@([userInfoModel.ID intValue]),@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize)} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
        for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                GrounpModel *model = [GrounpModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
             
             }
              [self.groupTableVC reloadData];
        }else{
             [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
      
        [self endRefresh];
        [self hideLoadingView];

    } failure:^(NSError *failure) {
        [self hideLoadingView];

        
    }];

}

#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNGroupTableViewCell * groupTVCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (groupTVCell == nil) {
        groupTVCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNGroupTableViewCell class]) owner:self options:nil].firstObject;
    }
    GrounpModel *model = _dataArr[indexPath.row];
    groupTVCell.moedel = model;
    
    return groupTVCell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 55)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel * newLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    newLabel.textColor = [UIColor blackColor];
    newLabel.text = @"入群申请";
    newLabel.font = [UIFont systemFontOfSize:16];
    [titleView addSubview:newLabel];
    return titleView;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
    
}


-(UITableView *)groupTableVC{
    if (!_groupTableVC) {
        _groupTableVC = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-60-45) style:UITableViewStylePlain];
        _groupTableVC.delegate = self;
        _groupTableVC.dataSource = self;
        _groupTableVC.tableFooterView = [[UIView alloc]init];
        _groupTableVC.rowHeight=70;
        
        
    }
    return _groupTableVC;
    
}

@end
