//
//  PayDealViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/26.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "PayDealViewController.h"

@interface PayDealViewController ()

@property(nonatomic,strong)UITableView * tableView;


@end

@implementation PayDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

-(UITableView *)tableView{
    if (!_tableView) {
//        _tableView = [[UITableView alloc]initWithFrame:self.view.frame.size style:UITableViewStylePlain];
//        _tableView.delegate=self;
        
    }
    return _tableView;
    
}

@end
