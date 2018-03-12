//
//  FindGrounpVController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "FindGrounpVController.h"

@interface FindGrounpVController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableview;


@end

@implementation FindGrounpVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"查找群组";
}


#pragma mark---<UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
}




-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.tableFooterView = [[UIView alloc]init];
        
    }
    return _tableview;
    
}


@end
