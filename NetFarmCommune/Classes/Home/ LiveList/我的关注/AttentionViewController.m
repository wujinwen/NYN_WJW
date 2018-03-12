//
//  AttentionViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "AttentionViewController.h"

#import "AttentionTableViewCell.h"

@interface AttentionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;



@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}



#pragma mark--UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionTableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AttentionTableViewCell class]) owner:self options:nil].firstObject;
        
        
    }
    return cell;
    
}






-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource =self;
        _tableView.rowHeight=90;
        
        
        
    }
    return _tableView;
    
}

@end
