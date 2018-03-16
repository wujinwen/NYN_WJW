//
//  DetailsViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "DetailsViewController.h"
#import "ProMessegeTViewCell.h"
@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-40-64);
}

#pragma maek--UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataaArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataaArray[indexPath.row];
    if ([[dic allKeys]  containsObject: @"img"]) {
        ProMessegeTViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"ProMessegeTViewCell"];
        if (!cell) {
            cell = [[ProMessegeTViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProMessegeTViewCell"];
        }
        if (![dic[@"imgUrl"] isEqualToString:@""]) {
            [cell.imageview sd_setImageWithURL:[NSURL URLWithString:dic[@"imgUrl"]] placeholderImage:[UIImage imageNamed:@"占位图"]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell  * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text =dic[@"text"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataaArray[indexPath.row];
    if ([[dic allKeys]  containsObject: @"img"]) {
        return 50;//计算text高度
    }else{
        return 200;
    }
}

-(void)setModel:(NYNMarketListModel *)model{
    _model=model;
    _dataaArray = [[NSMutableArray alloc]init];
    [_dataaArray addObject:@{@"text":model.intro}];
    for (NSDictionary *dic in model.intros) {
        [_dataaArray addObject:@{@"img":dic[@"imgUrl"]}];
        [_dataaArray addObject:@{@"text":dic[@"intro" ]}];
    }
    [self.tableView reloadData];
}
@end
