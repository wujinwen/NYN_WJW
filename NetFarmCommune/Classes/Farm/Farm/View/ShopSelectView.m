//
//  ShopSelectView.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "ShopSelectView.h"

@interface ShopSelectView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableview;

@property(nonatomic,strong)NSArray * dataArray;

@property(nonatomic,strong)NSString * SelectStr;

@end

@implementation ShopSelectView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initiaInterface];
    }
    return self;
    
}

-(void)initiaInterface{
    _dataArray = [[NSArray alloc]init];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.8f;
    [self addSubview:self.tableview];
}

-(void)getData:(NSArray *)array{
    _dataArray = array;
    _tableview.frame = CGRectMake(0, 0, 80, 4*30);
    [self.tableview reloadData];
}

#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (cell ==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 60, 30)];
    lab.font = JZFont(14);
    lab.text = _dataArray[indexPath.row][@"name"];
    [cell.contentView addSubview:lab];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delagate selectCellClick:_dataArray[indexPath.row][@"name"] selectID:_dataArray[indexPath.row][@"id"] selectIndex:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.rowHeight = 30;
        _tableview.dataSource=self;
        _tableview.tableFooterView =[[UIView alloc]init];
    }
    return _tableview;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
}

@end
