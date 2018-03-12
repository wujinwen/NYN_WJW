//
//  FTFarmListViewController.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTFarmListViewController.h"
#import "FTFarmListTableViewCell.h"
#import "FTWisdomFarmViewController.h"
#import "PersonalCenterVC.h"

@interface FTFarmListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *farmListTable;

@end

@implementation FTFarmListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createFarmListTable];
}

- (void)createFarmListTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.farmListTable.delegate = self;
    self.farmListTable.dataSource = self;
    self.farmListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.farmListTable.showsVerticalScrollIndicator = NO;
    self.farmListTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.farmListTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FTFarmListTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTFarmListTableViewCell class]) owner:self options:nil].firstObject;
    }
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(100);
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
//    return headerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return section == 0 ?  0.0001 : 5;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
//    return footerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.0001;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FTWisdomFarmViewController *vc = [[FTWisdomFarmViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma 懒加载
-(UITableView *)farmListTable
{
    if (!_farmListTable) {
        _farmListTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    }
    return _farmListTable;
}
@end
