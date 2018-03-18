//
//  NYNPlayDeController.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/15.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNPlayDeController.h"
#import "NYNMatchModel.h"
#import "NYNMatchNoCell.h"

@interface NYNPlayDeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)NYNMatchModel *dataModel;

@end

@implementation NYNPlayDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    
    self.title = @"比赛信息";
    NSDictionary * locDic = JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"] ?: @"";
    NSString *lon =locDic[@"lon"] ?: @"";
    
    [NYNNetTool MatchDeId:self.ID Params:@{@"longitude":lon,@"latitude":lat} isTestLogin:NO progress:^(NSProgress *Progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            _dataModel = [NYNMatchModel mj_objectWithKeyValues:success[@"data"]];
            [self.tableview reloadData];
            NSLog(@"比赛数据%@",success);
        }else{
            self.bakcView.hidden = NO;
            [self.tableview addSubview:self.bakcView];
        }
    } failure:^(NSError *failure) {
        
    }];
}

#pragma mark--UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 7;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 2;
    }else{
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3 && indexPath.row == 1) {
        NYNMatchNoCell *cell = [[NYNMatchNoCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
        [cell letfTitle:@"比赛名称" rightTitle:@"还是；u 的客户反馈合适的；发发发"];
        return cell;
    }else if(indexPath.section ==4 && indexPath.row == 1){
        NYNMatchNoCell *cell = [[NYNMatchNoCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
        [cell letfTitle:@"比赛名称" rightTitle:@"还是；u 的客户反馈合适的；发发发"];
        return cell;
    }else{
        NYNMatchNoCell *cell = [[NYNMatchNoCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
        [cell letfTitle:@"比赛名称" rightTitle:@"还是；u 的客户反馈合适的；发发发"];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3 && indexPath.row == 1) {
        return 200;
    }else if(indexPath.section ==4 && indexPath.row == 1){
        return 200;
    }else{
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vie = [[UIView alloc]init];
    vie.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return vie;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT/2) style:UITableViewStylePlain];
        _tableview.delegate  =self;
        _tableview.dataSource  =self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.rowHeight=JZHEIGHT(304);
        _tableview.separatorStyle =UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
