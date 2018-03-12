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
    _dataaArray = [[NSArray alloc]init];
    
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    
}
#pragma maek--UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataaArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ProMessegeTViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"ProMessegeTViewCell"];
    if (!cell) {
        cell = [[ProMessegeTViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProMessegeTViewCell"];
        
    }
    if (_dataaArray.count>0) {
        
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:_dataaArray[indexPath.row][@"imgUrl"]] placeholderImage:[UIImage imageNamed:@"占位图"]];
        cell.textView.text =_dataaArray[indexPath.row][@"intro"];
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}

-(void)setModel:(NYNMarketListModel *)model{
    _model=model;
    
    _dataaArray=model.intros;
    [self.tableView reloadData];
    
    
    
}
@end
