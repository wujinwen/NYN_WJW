//
//  NYNZiJiZhongViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNZiJiZhongViewController.h"
#import "NYNZiJiZhongTableViewCell.h"

#import "NYNZiJiModel.h"

@interface NYNZiJiZhongViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *ziJiZhongTable;
@property (nonatomic,assign) BOOL priceIsUp;
@property (nonatomic,strong) UIButton *priceUpButton;
@property (nonatomic,strong) UIButton *distanceButton;
@property (nonatomic,assign) int pageNo;

@property(nonatomic,strong)NSMutableArray * dataListArr;
@end

@implementation NYNZiJiZhongViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"自己种";
    
    [self.view addSubview:self.ziJiZhongTable];
    self.ziJiZhongTable.delegate = self;
    self.ziJiZhongTable.dataSource = self;
    self.ziJiZhongTable.showsVerticalScrollIndicator = YES;
    self.ziJiZhongTable.showsHorizontalScrollIndicator = YES;
    self.ziJiZhongTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(41 + 5))];
//    Color90b659
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *jiageShunXuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (SCREENWIDTH - 1) / 2, JZHEIGHT(41))];
    [jiageShunXuButton setTitle:@"价格排序 ↑" forState:0];
    [jiageShunXuButton setTitleColor:Color90b659 forState:0];
    jiageShunXuButton.titleLabel.font = JZFont(14);
    [headerView addSubview:jiageShunXuButton];
    jiageShunXuButton.backgroundColor = [UIColor whiteColor];
    UIView *shuView = [[UIView alloc]initWithFrame:CGRectMake(jiageShunXuButton.right , JZHEIGHT(10), 1, JZHEIGHT(21))];
    shuView.backgroundColor = Colore3e3e3;
    [headerView addSubview:shuView];
    
    UIButton *juliButton = [[UIButton alloc]initWithFrame:CGRectMake(shuView.right, 0, (SCREENWIDTH - 1) / 2, JZHEIGHT(41))];
    [juliButton setTitle:@"距离最近" forState:0];
    [juliButton setTitleColor:Color383938 forState:0];
    juliButton.titleLabel.font = JZFont(14);
    [headerView addSubview:juliButton];
    juliButton.backgroundColor = [UIColor whiteColor];
    jiageShunXuButton.tag = 101;
    juliButton.tag = 102;
    [jiageShunXuButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [juliButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.priceUpButton = jiageShunXuButton;
    self.distanceButton = juliButton;
    self.priceIsUp = YES;
    self.ziJiZhongTable.tableHeaderView = headerView;
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, juliButton.height, SCREENWIDTH, JZHEIGHT(5))];
    bottomView.backgroundColor = Colore3e3e3;
    [headerView addSubview:bottomView];
    
   
    
    
}

- (void)click:(UIButton *)sender{
    [self.priceUpButton setTitleColor:Color383938 forState:0];
    [self.distanceButton setTitleColor:Color383938 forState:0];
    
    if (sender.tag == 101) {
        self.priceIsUp = !self.priceIsUp;
        if (self.priceIsUp) {
            [self.priceUpButton setTitle:@"价格排序 ↑" forState:0];

        }else{
            [self.priceUpButton setTitle:@"价格排序 ↓" forState:0];

        }
            [self seedSearch:@"price" orderBy:@"asc"];
    }else{
            [self seedSearch:@"position" orderBy:@"asc"];
    }
    
    [sender setTitleColor:Color90b659 forState:0];
    
    
}

-(void)setNameString:(NSString *)nameString{
    _nameString = nameString;
    _pageNo = 1;
    
     [self seedSearch:@"price" orderBy:@"asc"];
}

//自己种
-(void)seedSearch:(NSString*)orderType orderBy:(NSString*)orderBy{
    [self.dataListArr removeAllObjects];
    

    
    NSDictionary * locDic =JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"] ?: @"";
    NSString *lon =locDic[@"lon"] ?: @"";

    
    
    NSDictionary * dic =@{@"name":_nameString,@"orderType":orderType,@"orderBy":orderBy,@"longitude":lon,@"latitude":lat,@"pageNo":[NSString stringWithFormat:@"%d",_pageNo],@"pageSize":@"10"};
    
    [NYNNetTool SearchSeedParams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
          if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
        for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
            NYNZiJiModel *model = [NYNZiJiModel mj_objectWithKeyValues:dic];
//
//            //添加数据
           [self.dataListArr addObject:model];
            
     
            
            
        }
        //刷新数据
        [self.ziJiZhongTable reloadData];
        
        }else{
              [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
          }
    }failure:^(NSError *failure) {
           [self hideLoadingView];
    }];
    
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NYNZiJiZhongTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNZiJiZhongTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.model=_dataListArr[indexPath.row];
    
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(60);
}



-(UITableView *)ziJiZhongTable{
    if (!_ziJiZhongTable) {
        _ziJiZhongTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    }
    return _ziJiZhongTable;
}
-(NSMutableArray *)dataListArr{
    if (!_dataListArr) {
        _dataListArr = [[NSMutableArray alloc]init];
        
    }
    return _dataListArr;

}
@end
