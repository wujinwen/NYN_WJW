//
//  RootsViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/18.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "RootsViewController.h"
#import "RootsTableViewCell.h"

@interface RootsViewController (){
    CGSize _cellSize;
}


@property(nonatomic,strong)NSMutableArray *data;


@end

@implementation RootsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSArray alloc]init];
        _cellSize = CGSizeMake((SCREENWIDTH-80)/3, (SCREENWIDTH-80)/3);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    
}




-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
    
    
}

#pragma mark--UITableViewDataSource,UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RootsTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"RootsTableViewCell"];
    if (!cell) {
        cell = [[RootsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RootsTableViewCell"];
        
    }
 

    if (_dataArray.count>0) {
        cell.farmLabel.text=_dataArray[indexPath.row][@"farmName"];
          cell.timeLabel.text = [MyControl timeWithTimeIntervalString:_dataArray[indexPath.row][@"createDate"]] ;
        [cell.headImageView sd_setImageWithURL:_dataArray[indexPath.row][@"imgUrl"] placeholderImage:[UIImage imageNamed:@"占位图"]];
        
        
        cell.peopleLabel.text = [NSString stringWithFormat:@"执行人:%@",_dataArray[indexPath.row][@"managerName"]];
        
        NSData *jsonData = [_dataArray[indexPath.row][@"imgs"] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
         cell.size = _cellSize;
        cell.picArr = dic;
        _data = [dic mutableCopy];
        
    }
   
   
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    int rowheight = 110;

    NSArray * arr = self.data;
    if (arr.count < 1) {
        return rowheight;
    }else if (arr.count <= 3) {
        return rowheight + _cellSize.height;
    }else if (arr.count <= 6) {
        return rowheight + _cellSize.height*2+15;
    }else {
        return rowheight + _cellSize.height*3+15*2;
    }
}


@end
