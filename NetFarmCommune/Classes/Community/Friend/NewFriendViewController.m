//
//  NewFriendViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NewFriendViewController.h"
#import "NewFrendTableViewCell.h"
#import "NYNNetTool.h"
#import "NewFriendModel.h"

@interface NewFriendViewController ()<UITableViewDataSource,UITableViewDelegate,friendRequsetDlegate>

@property(nonatomic,strong)UITableView * tableview;
@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;

@property(nonatomic,strong)NSMutableArray * dataArr;


@end

@implementation NewFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区";
    [self.view addSubview:self.tableview];
    [self setRequsetData];
    
    _pageSize = 10;
    _pageNo=1;
    
    _dataArr = [NSMutableArray array];
    
    
    [self setRequsetData];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArr removeAllObjects];
        self.pageNo = 1;
        [self setRequsetData];
        
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNo = 1 + self.pageNo;
        
        [self setRequsetData];
        
    }];
    
    
    
}
- (void)endRefresh{
    [self.tableview.mj_footer endRefreshing];
    [self.tableview.mj_header endRefreshing];
}

#pragma mark--friendRequsetDlegate
//拒绝
- (void)friendRequsetRequse:(UIButton*)btn  userId:(NSString*)userId{
    
    [self DealRequst:@"refused" userid:userId];
}
//同意
- (void)friendAgreeRequse:(UIButton*)btn  userId:(NSString*)userId{
    [self DealRequst:@"agree" userid:userId];

    
}
-(void)DealRequst:(NSString*)status userid:(NSString*)userid{
    [NYNNetTool GetNewFriendParams:@{ @"id":userid,@"status":status} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
        
    } failure:^(NSError *failure) {
        [self hideLoadingView];
        
        
    }];
    
}
//好友请求
-(void)setRequsetData{
    [NYNNetTool GetNewFriendParams:@{ @"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize)} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NewFriendModel * model = [NewFriendModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
                
            }
            [self.tableview reloadData];
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self endRefresh];
        [self hideLoadingView];
        
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}

#pragma mark--UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewFrendTableViewCell * friendTVCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (friendTVCell == nil) {
        friendTVCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NewFrendTableViewCell class]) owner:self options:nil].firstObject;
    }
    NewFriendModel * model= _dataArr[indexPath.row];
    friendTVCell.frinedModel = model;
    
    friendTVCell.delegate =self;
    
    
    
    return friendTVCell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 55)];
    titleView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel * newLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    newLabel.textColor = [UIColor blackColor];
    newLabel.text = @"好友通知";
    newLabel.font = [UIFont systemFontOfSize:16];
    [titleView addSubview:newLabel];
    return titleView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
    
}


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-45-60) style:UITableViewStylePlain];
        _tableview.dataSource=self;
        _tableview.delegate =self;
        _tableview.rowHeight=70;
    }
    return _tableview;
    
}

@end
