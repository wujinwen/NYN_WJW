//
//  MyPlayViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "MyPlayViewController.h"
#import "PayViewTableViewCell.h"

@interface MyPlayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;


@end

@implementation MyPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.title=@"我的比赛";
}
-(void)getData{
    
    
    
}
#pragma mark--UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([PayViewTableViewCell class]) owner:self options:nil].firstObject;
        
    }
    return cell;
    
    
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-60) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.rowHeight=160;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
    
}
@end
