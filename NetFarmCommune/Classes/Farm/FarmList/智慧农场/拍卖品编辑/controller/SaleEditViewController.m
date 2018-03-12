//
//  SaleEditViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/23.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "SaleEditViewController.h"
#import "SaleOneTableViewCell.h"
#import "SaleTwoTableViewCell.h"
#import "SaleThreeTableViewCell.h"

@interface SaleEditViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableview;






@end

@implementation SaleEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _farmName;
    [self.view addSubview:self.tableview];
    
}


#pragma mark---UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section ==1 || section==2) {
        return 1;
    }else if (section == 3){
        return 5;
    }
    return 0;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SaleOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SaleOneTableViewCell"];
        if (cell == nil) {
            cell = [[SaleOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SaleOneTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (indexPath.section ==1){

            SaleTwoTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"SaleTwoTableViewCell" ];
            if (cell == nil) {
                cell = [[SaleTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SaleTwoTableViewCell"];
            }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        
    }else if (indexPath.section ==2){
        SaleThreeTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"SaleThreeTableViewCell" ];
        if (cell == nil) {
            cell = [[SaleThreeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SaleThreeTableViewCell"];
        }
               cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        SaleTwoTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"SaleTwoTableViewCell" ];
        if (cell == nil) {
            cell = [[SaleTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SaleTwoTableViewCell"];
        }
        return cell;
    }
    return nil;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor darkGrayColor];
    footView.alpha = 0.5;
    return footView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return JZWITH(200);
    }else if (indexPath.section ==1){
        return JZWITH(200);
        
    }else{
         return JZWITH(200);
    }
    return 0;
    
}






#pragma mark--懒加载
-(UITableView *)tableview{
    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.delegate=self;
        _tableview.dataSource = self;
        
        
    }
    return _tableview;
    
}


@end
