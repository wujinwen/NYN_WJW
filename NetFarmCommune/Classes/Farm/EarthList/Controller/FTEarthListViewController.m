//
//  FTEarthListViewController.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/21.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTEarthListViewController.h"
#import "FTEarthListTableViewCell.h"
#import "FTEarthDetailViewController.h"

@interface FTEarthListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *earthListTable;

@end

@implementation FTEarthListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createEarthListTable];

}

- (void)createEarthListTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.earthListTable.delegate = self;
    self.earthListTable.dataSource = self;
    self.earthListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.earthListTable.showsVerticalScrollIndicator = NO;
    self.earthListTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.earthListTable];
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
    FTEarthListTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTEarthListTableViewCell class]) owner:self options:nil].firstObject;
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
    
    FTEarthDetailViewController *vc = [[FTEarthDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma 懒加载
-(UITableView *)earthListTable
{
    if (!_earthListTable) {
        _earthListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, -JZHEIGHT(34.5), SCREENWIDTH, SCREENHEIGHT - 44 - 50 - JZHEIGHT(39)) style:UITableViewStyleGrouped];
    }
    return _earthListTable;
}

@end
