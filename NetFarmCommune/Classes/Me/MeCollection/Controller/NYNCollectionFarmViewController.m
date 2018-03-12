//
//  NYNCollectionFarmViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNCollectionFarmViewController.h"
#import "NYNMeNongChangTableViewCell.h"
#import "NYNCollectionFarmModel.h"
#import "PersonalCenterVC.h"

@interface NYNCollectionFarmViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageNo;
    int pageSize;
}
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *MeFarmTable;
@end

@implementation NYNCollectionFarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.MeFarmTable];
    self.MeFarmTable.delegate = self;
    self.MeFarmTable.dataSource = self;
    self.MeFarmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.MeFarmTable.showsVerticalScrollIndicator = NO;
    self.MeFarmTable.showsHorizontalScrollIndicator = NO;
    
    pageNo = 1;
    pageSize = 20;
    NSDictionary *dic = @{@"type":@"farm",@"pageNo":[NSString stringWithFormat:@"%d",pageNo],@"pageSize":[NSString stringWithFormat:@"%d",pageSize]};

    [self reFreshDataWithDic:dic];
    
}

- (void)reFreshDataWithDic:(NSDictionary *)dic{
    [self showLoadingView:@""];
    [NYNNetTool GetCollectionWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNCollectionFarmModel *model = [NYNCollectionFarmModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            
            [self.MeFarmTable reloadData];
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNCollectionFarmModel *model = self.dataArr[indexPath.row];
    
    NYNMeNongChangTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeNongChangTableViewCell class]) owner:self options:nil].firstObject;
    }
//    farmLiveTableViewCell.starCount = 5;
    farmLiveTableViewCell.model = model;
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(101);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(11))];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return JZHEIGHT(11);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(0.0001))];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return JZHEIGHT(0.0001);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNCollectionFarmModel *model = self.dataArr[indexPath.row];
    
    PersonalCenterVC *vc = [PersonalCenterVC new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = model.ID;
    vc.ctype = @"farm";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)MeFarmTable{
    if (!_MeFarmTable) {
        _MeFarmTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44 - 64 ) style:UITableViewStylePlain];
    }
    return  _MeFarmTable;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
@end
