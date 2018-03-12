//
//  ArchivesViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/2.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "ArchivesViewController.h"
#import "ArchivesTableViewCell.h"

@interface ArchivesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSArray * titleArray;



@end

@implementation ArchivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"土地档案";
    [self.view addSubview:self.tableView];
    
    [self creatUI];
    
    
 
}

-(void)creatUI{
    _titleArray = @[@"档案编码",@"土地编号",@"土地面积",@"土地租价",@"租赁日期",@"土地归属",@"土地地址",@"有效日期"];
    
    
}


#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArchivesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ArchivesTableViewCell class]) owner:self options:nil].firstObject;
    }
    cell.titleLabel.text=_titleArray[indexPath.row];
    
    return cell;
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView = [[UIView alloc]init];
        
        
    }
    return _tableView;

}

@end
