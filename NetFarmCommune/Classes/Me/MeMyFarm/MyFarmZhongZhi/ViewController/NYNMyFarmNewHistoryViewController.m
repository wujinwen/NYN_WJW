//
//  NYNMyFarmNewHistoryViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/22.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMyFarmNewHistoryViewController.h"
#import "NYNNewTaskTableViewCell.h"
#import "NYNMyFarmTaskHistoryModel.h"

@interface NYNMyFarmNewHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *newTaskTable;
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;

@end

@implementation NYNMyFarmNewHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"任务记录";
    self.pageNo = 1;
    self.pageSize = 10;
    
    [self setTable];
    
    self.newTaskTable.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.newTaskTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
    
    [self.newTaskTable.mj_header beginRefreshing];
}

- (void)refreshData{

    self.pageNo = 1;
    self.pageSize = 10;
    NSMutableDictionary *dic = @{@"orderId":self.orderId,@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize)}.mutableCopy;
    [self getDataWithDic:dic];
}

- (void)moreData{
    self.pageNo = self.pageNo + 1;
    NSMutableDictionary *dic = @{@"orderId":self.orderId,@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize)}.mutableCopy;
    [self getDataWithDic:dic];
}

- (void)getDataWithDic:(NSMutableDictionary *)dic{
    
    [self showLoadingView:@""];
    [NYNNetTool MyFarmNewTaskHistoryWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
    
    } success:^(id success) {
    
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"] ) {
            for (NSDictionary *dic in success[@"data"]) {
                NYNMyFarmTaskHistoryModel *model = [NYNMyFarmTaskHistoryModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            [self.newTaskTable reloadData];

        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self hideLoadingView];
        [self endrefresh];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
        [self endrefresh];

    }];
}


- (void)endrefresh{
    [self.newTaskTable.mj_header endRefreshing];
    [self.newTaskTable.mj_footer endRefreshing];
}

- (void)setTable{
    self.newTaskTable.delegate = self;
    self.newTaskTable.dataSource = self;
    self.newTaskTable.showsVerticalScrollIndicator = NO;
    self.newTaskTable.showsHorizontalScrollIndicator = YES;
    self.newTaskTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.newTaskTable];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
            NYNNewTaskTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNNewTaskTableViewCell class]) owner:self options:nil].firstObject;
            }
    
    
    NYNMyFarmTaskHistoryModel *model = self.dataArr[indexPath.row];
    farmLiveTableViewCell.model = model;
            return farmLiveTableViewCell;
            
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(66);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UITableView *)newTaskTable{
    if (!_newTaskTable) {
        _newTaskTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    }
    return _newTaskTable;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
@end
