//
//  NYNShouHouViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/21.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNShouHouViewController.h"
#import "NYNMeDealShouHouTableViewCell.h"

@interface NYNShouHouViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *MeDealAlltable;

@end

@implementation NYNShouHouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.MeDealAlltable];
    
    self.title = @"我的售后";

    
    
    [self setTable];

}

-(void)setTable{
    [self.view addSubview:self.MeDealAlltable];

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeDealShouHouTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeDealShouHouTableViewCell class]) owner:self options:nil].firstObject;
    }
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(194 + 55);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, section == 0 ? 0.00001 : JZHEIGHT(11))];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.00001)];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.00001;
    }else{
        return JZHEIGHT(11);

    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}


- (UITableView *)MeDealAlltable{
    if (!_MeDealAlltable) {
        _MeDealAlltable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStyleGrouped];
        _MeDealAlltable.delegate = self;
        _MeDealAlltable.dataSource = self;
        _MeDealAlltable.showsVerticalScrollIndicator = NO;
        _MeDealAlltable.showsHorizontalScrollIndicator = NO;
        _MeDealAlltable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _MeDealAlltable;
}
@end
