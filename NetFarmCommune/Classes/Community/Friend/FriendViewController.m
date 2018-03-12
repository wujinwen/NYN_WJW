//
//  FriendViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "FriendViewController.h"
#import "NYNFriendTableViewCell.h"
#import "NewFriendViewController.h"
#import "FrinedModel.h"
@interface FriendViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableview;
@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;
@property(nonatomic,strong)NSMutableArray * frindArr;


@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    _frindArr=[NSMutableArray array];
    [self setFriendData];
    
    _pageNo = 1;
    _pageSize=10;
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.frindArr removeAllObjects];
        self.pageNo = 1;
        [self setFriendData];
        
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNo = 1 + self.pageNo;
        
        [self setFriendData];
        
    }];
    
}

- (void)endRefresh{
    [self.tableview.mj_footer endRefreshing];
    [self.tableview.mj_header endRefreshing];
}
//获取数据
-(void)setFriendData{
    [NYNNetTool GetFriendParams:@{@"userId":@([userInfoModel.ID intValue]),@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize)} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
               FrinedModel * model = [FrinedModel mj_objectWithKeyValues:dic];
                [self.frindArr addObject:model];
                
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
    return self.frindArr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNFriendTableViewCell * friendTVCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (friendTVCell == nil) {
        friendTVCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFriendTableViewCell class]) owner:self options:nil].firstObject;
    }
     FrinedModel *model = _frindArr[indexPath.row];
     friendTVCell.model = model;
    return friendTVCell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 55)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel * newLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    newLabel.textColor = [UIColor blackColor];
    newLabel.text = @"新朋友";
    newLabel.font = [UIFont systemFontOfSize:16];
    [titleView addSubview:newLabel];
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(newLabel.frame)+9, SCREENWIDTH, 10)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [titleView addSubview:lineLabel];
    
    UILabel * lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    lineLabel1.backgroundColor = [UIColor lightGrayColor];
    [titleView addSubview:lineLabel1];
    
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesAction:)];
    [titleView addGestureRecognizer:tapGes];
    
    
    return titleView;
    
}

//新朋友点击
-(void)tapGesAction:(UITapGestureRecognizer*)tap{
    NewFriendViewController * newVC = [[NewFriendViewController alloc]init];
    [self.navigationController pushViewController:newVC animated:YES];
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.dataSource=self;
        _tableview.delegate =self;
        _tableview.rowHeight=70;
        
        
    }
    return _tableview;
    
}
@end
