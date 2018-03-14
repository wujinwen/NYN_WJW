//
//  NYNZhongZhiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNZhongZhiViewController.h"
#import "FTZhongZhiTableViewCell.h"
#import "NYNEarthDetailViewController.h"
#import "NYNEarthDetailViewController.h"
#import "NYNCategoryPageModel.h"
#import "Masonry.h"
#import "ZWPullMenuModel.h"
#import "NYNWantZhongZhiNewViewController.h"
@interface NYNZhongZhiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *ZhongZhiTable;
@end

@implementation NYNZhongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createZhongZhiTable];
    self.pageNo = 1;
    self.pageSize = 10;
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateData];
}

- (void)stop{
    self.ZhongZhiTable.scrollEnabled = NO;
}

- (void)star{
    self.ZhongZhiTable.scrollEnabled = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

//收到通知,刷新页面
- (void)didReceiveReloadNotification:(NSNotification *)notification {
    ZWPullMenuModel * model = notification.userInfo[@"model"];
    self.categoryId = model.id;
    self.farmId = model.farmId;
    self.pageNo = 1;
    self.pageSize = 100;
    [self.dataArr removeAllObjects];
    [self.ZhongZhiTable reloadData];
    [self updateData];
}

- (void)updateData{
    [self showLoadingView:@""];
   //后台重构，新接口
        NSDictionary *postDic = @{@"farmId":self.farmId,@"type":@"plant",@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize]};
        [NYNNetTool PageCategoryResquestWithparams:postDic isTestLogin:NO progress:^(NSProgress *progress) {
    
        } success:^(id success) {
            NSLog(@"--------代种数据%@",success);
            [self.dataArr removeAllObjects];
            
            if ([success[@"code"] integerValue] == 200 && [[NSArray arrayWithArray:success[@"data"]] count]>0) {
                NSArray *arr = [NSArray arrayWithArray:success[@"data"]];
                for (NSDictionary *d in arr) {
                    NYNCategoryPageModel *model = [NYNCategoryPageModel mj_objectWithKeyValues:d];
                    [self.dataArr addObject:model];
                }
                [self.ZhongZhiTable reloadData];
                if (self.dateUp) {
                    self.dateUp(@"1");
                }
                if (self.dataCount) {
                    self.dataCount((int)(self.dataArr.count));
                }
            }else{
                self.bakcView.hidden = NO;
                [self.ZhongZhiTable addSubview:self.bakcView];
            }
            [self hideLoadingView];
        } failure:^(NSError *failure) {
            [self hideLoadingView];
        }];
}

- (void)createZhongZhiTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.ZhongZhiTable.delegate = self;
    self.ZhongZhiTable.dataSource = self;
    self.ZhongZhiTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.ZhongZhiTable];
}



#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FTZhongZhiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTZhongZhiTableViewCell class]) owner:self options:nil].firstObject;
    }
    NYNCategoryPageModel *model = self.dataArr[indexPath.row];
    farmLiveTableViewCell.model = model;
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(100);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNCategoryPageModel *model = self.dataArr[indexPath.row];
    NYNWantZhongZhiNewViewController *vc1 = [[NYNWantZhongZhiNewViewController alloc]init];
    vc1.farmID = model.farm[@"id"];
    [self.navigationController pushViewController:vc1 animated:YES];
    vc1.earthID = model.ID;
    vc1.earthUnit = model.unitName;
    vc1.earthPriceStr =  model.price;
}

#pragma 懒加载
-(UITableView *)ZhongZhiTable
{
    if (!_ZhongZhiTable) {
        _ZhongZhiTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT/2) style:UITableViewStylePlain];
    }
    return _ZhongZhiTable;
}

@end
