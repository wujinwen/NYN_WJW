//
//  NEInfoViewController.m
//  NetworkEngineer
//
//  Created by 123 on 2017/5/16.
//  Copyright © 2017年 com.NetworkEngineer. All rights reserved.
//

#import "NEInfoViewController.h"
#import "NEinfoTableViewCell.h"

@interface NEInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *InfoTable;

@property (nonatomic,strong) NSArray *imags;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *contents;
@end

@implementation NEInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *imags = @[@"占位图",@"占位图",@"占位图"];
    NSArray *titles = @[@"开心农场",@"系统消息",@"系统消息"];
    NSArray *contents = @[@"你种植的花菜可以收获啦……",@"你种植的花菜可以收获啦……",@"你种植的花菜可以收获啦……"];
    self.imags = imags;
    self.titles = titles;
    self.contents = contents;
    
    self.title = @"我的消息";
    [self createInfoTable];
    
}

- (void)createInfoTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.InfoTable.delegate = self;
    self.InfoTable.dataSource = self;
    self.InfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.InfoTable.showsVerticalScrollIndicator = NO;
    self.InfoTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.InfoTable];
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
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NEinfoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NEinfoTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.headerImageView.image = Imaged(self.imags[indexPath.row]);
    farmLiveTableViewCell.titleLabel.text = self.titles[indexPath.row];
    farmLiveTableViewCell.contentLabel.text = self.contents[indexPath.row];
    
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(67.5);
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
    

}

#pragma 懒加载
-(UITableView *)InfoTable
{
    if (!_InfoTable) {
        _InfoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    }
    return _InfoTable;
}

@end
