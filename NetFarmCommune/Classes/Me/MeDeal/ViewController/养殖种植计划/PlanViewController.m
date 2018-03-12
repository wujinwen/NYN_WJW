//
//  PlanViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/7.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "PlanViewController.h"
#import "NYNBoZhongRiQiTableViewCell.h"
#import "PlanHeadTableViewCell.h"
#import "PaiZhaoTableViewCell.h"
@interface PlanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * boomView;


@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"种植方案";
    

    [self.view addSubview:self.tableView];
    
    
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        //95 播种 98配送 96浇水 97拍照 102 施肥，
    NSNumber * number =_dataArray[section][@"productCategoryId"];
    
    if ( [number intValue]==95) {
        return 2;
    }else if ([number intValue]==102)
    {
        return 3;
    }else{
        return 2;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber * number =_dataArray[indexPath.section][@"productCategoryId"];
    
    if ([number intValue] ==95) {
        if (indexPath.row == 0) {
            PlanHeadTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (Cell == nil) {
                Cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PlanHeadTableViewCell class]) owner:self options:nil].firstObject;
            }
            Cell.nameLabel.text =_dataArray[indexPath.section][@"name"];
            
            Cell.priceLabel.text =[NSString stringWithFormat:@"(%@/m²)",_dataArray[indexPath.section][@"price"]];
            return Cell;
            
            
        }else if (indexPath.row ==1){
            NYNBoZhongRiQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNBoZhongRiQiTableViewCell class]) owner:self options:nil].firstObject;
            }
            return farmLiveTableViewCell;
            
        }

    }else if ([number intValue] ==102){
       
            PlanHeadTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (Cell == nil) {
                Cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PlanHeadTableViewCell class]) owner:self options:nil].firstObject;
            }
        Cell.priceLabel.hidden = YES;
        
        if (indexPath.row ==0) {
              Cell.nameLabel.text =@"施肥";
        }else if (indexPath.row==1){
            Cell.nameLabel.text =_dataArray[indexPath.section][@"name"];
             Cell.totalPriceLabel.text =[NSString stringWithFormat:@"%@/m²",_dataArray[indexPath.section][@"price"]];
        }else{
             Cell.nameLabel.text =@"施肥次数";
             Cell.totalPriceLabel.text =[NSString stringWithFormat:@"%@次",_dataArray[indexPath.section][@"quantity"]];
            
        }
        
            return Cell;
    }else if ([number intValue] ==96){
        
        PlanHeadTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (Cell == nil) {
            Cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PlanHeadTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        if (indexPath.row ==0) {
            Cell.nameLabel.text =_dataArray[indexPath.section][@"name"];
            Cell.priceLabel.text =[NSString stringWithFormat:@"(%@/m²)",_dataArray[indexPath.section][@"price"]];
            
        }else if (indexPath.row==1){
             Cell.priceLabel.hidden = YES;
            Cell.nameLabel.text =@"浇水次数";
              Cell.totalPriceLabel.text =[NSString stringWithFormat:@"%@次",_dataArray[indexPath.section][@"quantity"]];
        }
        return Cell;
        
    }
    
    else if ([number intValue] ==97){
        if (indexPath.row ==0 ) {
            PlanHeadTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (Cell == nil) {
                Cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PlanHeadTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            Cell.nameLabel.text =_dataArray[indexPath.section][@"name"];
              Cell.priceLabel.text =[NSString stringWithFormat:@"(%@/张)",_dataArray[indexPath.section][@"price"]];
            int a =[_cycleTime intValue]/ [_dataArray[indexPath.section][@"price"] intValue];
            int b = (a==0)?(a=1):a;
            
            double addPrice = b* [_dataArray[indexPath.section][@"quantity"] intValue];
            Cell.totalPriceLabel.text =[NSString stringWithFormat:@"¥%f",addPrice];
            
            return Cell;
        }else if (indexPath.row==1){
            PaiZhaoTableViewCell*Cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (Cell == nil) {
                Cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PaiZhaoTableViewCell class]) owner:self options:nil].firstObject;
            }
            Cell.jiegelabel.text =[NSString stringWithFormat:@"拍照间隔：%@/张",_dataArray[indexPath.section][@"planInterval"]];
            Cell.countLabel.text=[NSString stringWithFormat:@"每次拍照：%@/张",_dataArray[indexPath.section][@"quantity"]];
            return Cell;
        }
        
    
    }
    return nil;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45;
    
}




-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 5)];
    view.backgroundColor = Colorededed;
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
    
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

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    return _dataArray;
    
}
-(UIView *)boomView{
    if (!_boomView) {
        _boomView = [[UIView alloc]init];
        _boomView.backgroundColor=[UIColor whiteColor];
        
    }
    return _boomView;
    
}
@end
