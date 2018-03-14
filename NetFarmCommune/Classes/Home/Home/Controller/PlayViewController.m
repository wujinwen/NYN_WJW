//
//  PlayViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "PlayViewController.h"
#import "SGPageView.h"
#import "MyPlayViewController.h"
#import "PayViewTableViewCell.h"
#import "PlayTitleView.h"
#import "NYNNetTool.h"
#import "NYNGameModel.h"

@interface PlayViewController ()<UITableViewDelegate,UITableViewDataSource,PlayTitleViewClickDelagate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)PlayTitleView * playView;
@property(nonatomic,strong)NSMutableArray * totleArray;
@property(nonatomic,assign)int pageNo;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"比赛专栏";
    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:0.8];
    
    _pageNo = 1;
    UIButton *zhiboButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [zhiboButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [zhiboButton setTitle:@"我的" forState:UIControlStateNormal];
    UIBarButtonItem *rb = [[UIBarButtonItem alloc]initWithCustomView:zhiboButton];
    self.navigationItem.rightBarButtonItem = rb;
    [self initiaInterface];
    [self getMatchData:@"signUp"];
}

-(void)initiaInterface{
       [self.view addSubview:self.playView];
       [self.view addSubview:self.tableView];
}
#pragma mark--PlayTitleViewClickDelagate
-(void)playSelectButtonClick:(NSInteger)tag{
    switch (tag) {
        case 0://报名中
                [self getMatchData:@"signUp"];
            break;
        case 1://比赛中
                [self getMatchData:@"going"];
            break;
        case 2://距离最近
             [self getMatchData:@"position"];
            break;
        default:
            break;
    }
}

//状态：signUp-报名中，going-比赛中，end-已结束 position-距离 popularity-人气
-(void)getMatchData:(NSString*)status{
    self.bakcView.hidden = YES;
    [self.totleArray removeAllObjects];
    NSDictionary * locDic =JZFetchMyDefault(SET_Location);
    
    NSString *lat = locDic[@"lat"];
    NSString *lon = locDic[@"lon"];
    
    NSString *province =  locDic[@"province"] ?: @"";
    NSString *city =  locDic[@"city"] ?: @"";
    NSDictionary * dic = @{@"latitude":lat,@"longitude":lon,@"orderType":status,@"pageNo":[NSString stringWithFormat:@"%d",_pageNo],@"pageSize":@"10",@"orderBy":@"asc"};
    [NYNNetTool MatchQueryPageParams:dic isTestLogin:NO progress:^(NSProgress *progress) {

    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"] && [[NSArray arrayWithArray:success[@"data"]] count]>0) {
            
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNGameModel *model = [NYNGameModel mj_objectWithKeyValues:dic];
                [self.totleArray addObject:model];
            }
        }else{
            self.bakcView.hidden = NO;
            [self.tableView addSubview:self.bakcView];
        }
        [self hideLoadingView];
        [self.tableView reloadData];
    } failure:^(NSError *failure) {

        [self hideLoadingView];
    }];
}

#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _totleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([PayViewTableViewCell class]) owner:self options:nil].firstObject;
    }
    cell.model=_totleArray[indexPath.row];
    return cell;
}

//导航栏右侧点击
-(void)push:(UIButton*)sender{
    MyPlayViewController * myVC = [[MyPlayViewController alloc]init];
    [self.navigationController pushViewController:myVC animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+34+10, SCREENWIDTH, SCREENHEIGHT-64-49-(40+34+10)) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.rowHeight=155;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(PlayTitleView *)playView{
    if (!_playView) {
        _playView = [[PlayTitleView alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 40)];
        _playView.delagete = self;
    }
    return _playView;
}

-(NSMutableArray *)totleArray{
    if (!_totleArray) {
        _totleArray = [[NSMutableArray alloc]init];
    }
    return _totleArray;
}

@end
