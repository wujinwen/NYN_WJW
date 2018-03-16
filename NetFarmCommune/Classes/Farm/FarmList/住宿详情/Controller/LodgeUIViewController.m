//
//  LodgeUIViewController.m
//  NYNTest
//
//  Created by wzw on 18/3/14.
//  Copyright © 2018年 TF. All rights reserved.
//

#import "LodgeUIViewController.h"
#import "NYNLodgeCell.h"
#import "NYNLodgeModel.h"
#import "NYNZhuSuDetailViewController.h"

@interface LodgeUIViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat rowHeight;
    BOOL isDisplay;//显示
}
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)NSMutableArray * allArray;

@property(nonatomic,strong)NSString * countString;
@end

@implementation LodgeUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
}

-(void)getDataFarmIDString:(NSString *)str{
    rowHeight = 120;
    [self.view addSubview:self.tableview];
    _allArray=[[NSMutableArray alloc]init];
    NSDictionary * dic = @{@"farmId":str,@"pageNo":@"1",@"pageSize":@"10",@"categoryId":@"75"};
    [NYNNetTool PageCategoryOtherResquestWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"] && [[NSArray arrayWithArray:success[@"data"]] count]>0) {
            
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNLodgeModel *model = [NYNLodgeModel mj_objectWithKeyValues:dic];
                [self.allArray addObject:model];
            }
            [self.tableview reloadData];
            NSLog(@"住宿数据%@",success);
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
    
    NYNLodgeCell *farmLiveTableViewCell = [[NYNLodgeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    return farmLiveTableViewCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNZhuSuDetailViewController *vc = [[NYNZhuSuDetailViewController alloc]init];
    NYNLodgeModel *model = _allArray[indexPath.row];
    vc.Id = model.id;
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
