//
//  LeaseDealViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "LeaseDealViewController.h"
#import "LeaseTableViewCell.h"
#import "TudiDealModel.h"
#import "ArchivesViewController.h"

@interface LeaseDealViewController ()<UITableViewDataSource,UITableViewDelegate,LeaseTableViewCellDelagete>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * totalArray;




@end

@implementation LeaseDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self getData];
    

}

//查询专属土地订单
-(void)getData{
   NSDictionary *dic = @{@"pageNo":@"1",@"pageSize":@"10"};
    [NYNNetTool AddEnterpriseWithparams: dic isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            TudiDealModel * model =[TudiDealModel mj_objectWithKeyValues:success[@"data"]];
        
            //添加数据
            [self.totalArray addObject:model];
            
            
            
        }else if ([NSString stringWithFormat:@"%@",success[@"401"]]){
            
        }
    } failure:^(NSError *failure){
        
        
    }];
}
#pragma mark--LeaseTableViewCellDelagete
//租赁档案
-(void)LeaseArchivesDidselect:(UIButton*)sender{
    ArchivesViewController * archVC =[[ArchivesViewController alloc]init];
    [self.navigationController pushViewController:archVC animated:YES];
    
    
    
}


#pragma mark--UITableViewDataSource,UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _totalArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LeaseTableViewCell class]) owner:self options:nil].firstObject;
        
    }
    if (_totalArray.count>0) {
         cell.model = _totalArray[indexPath.row];
    }
   
    cell.delegate=self;
    
    return cell;
    
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-44) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[[UIView alloc]init];
        _tableView.rowHeight=200;
        
    }
    return _tableView;
    
}
@end
