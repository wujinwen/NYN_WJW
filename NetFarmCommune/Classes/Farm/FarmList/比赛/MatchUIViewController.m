//
//  MatchUIViewController.m
//  NYNTest
//
//  Created by wzw on 18/3/14.
//  Copyright © 2018年 TF. All rights reserved.
//

#import "MatchUIViewController.h"
#import "NYNMatchCell.h"
#import "NYNMatchModel.h"
#import "NYNPlayDeController.h"

@interface MatchUIViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat rowHeight;
    BOOL isDisplay;//显示
}
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)NSMutableArray * allArray;

@property(nonatomic,strong)NSString * countString;
@end

@implementation MatchUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
}

-(void)getDataFarmIDString:(NSString *)str{
    rowHeight = 120;
    [self.view addSubview:self.tableview];
    _allArray=[[NSMutableArray alloc]init];
    NSDictionary * dic = @{@"farmId":str,@"pageNo":@"1",@"pageSize":@"10"};
    [NYNNetTool PageCategoryMatchResquestWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"] && [[NSArray arrayWithArray:success[@"data"]] count]>0) {
            
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNMatchModel *model = [NYNMatchModel mj_objectWithKeyValues:dic];
                [self.allArray addObject:model];
            }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _allArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NYNMatchCell *farmLiveTableViewCell = [[NYNMatchCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    return farmLiveTableViewCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNPlayDeController *vc = [[NYNPlayDeController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
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


@end
