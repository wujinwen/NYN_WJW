//
//  NYNMoreDisViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMoreDisViewController.h"
#import "NYNDetailContentTableViewCell.h"

@interface NYNMoreDisViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *disTable;
@end

@implementation NYNMoreDisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"更多评价";
    [self createdisTable];
    
}

- (void)createdisTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.disTable.delegate = self;
    self.disTable.dataSource = self;
    self.disTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.disTable.showsVerticalScrollIndicator = NO;
    self.disTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.disTable];
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
    NYNDetailContentTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNDetailContentTableViewCell class]) owner:self options:nil].firstObject;
    }
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(201);
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
    
//    FTEarthDetailViewController *vc = [[FTEarthDetailViewController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma 懒加载
-(UITableView *)disTable
{
    if (!_disTable) {
        _disTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    }
    return _disTable;
}

@end
