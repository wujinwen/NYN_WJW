//
//  NYNLeaseDeController.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNLeaseDeController.h"
#import "NYNLeImgCell.h"
#import "NYNLeNameCell.h"
#import "NYNAddresCell.h"
#import "NYNLeMJCell.h"
#import "NYNMonthCell.h"
#import "NYNInstCell.h"

@interface NYNLeaseDeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic,copy) NSDictionary *dicData;
@property (nonatomic,copy) UIButton *sureBtn;
@end

@implementation NYNLeaseDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自家菜地";
    [self.view addSubview:self.tableView];
    
    NSDictionary * locDic =JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"];
    NSString *lon = locDic[@"lon"];
    NSDictionary * dic = @{@"latitude":lat,@"longitude":lon};
    [NYNNetTool activeLeaseDeId:self.ID Params:dic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            _dicData = success[@"data"];
        }else{

        }
        [self hideLoadingView];
        [self.tableView reloadData];
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
    }];
    
    _sureBtn = [NYNYCCommonCtrl commonButtonWithFrame:CGRectZero title:@"付款" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] backgroundImage:[UIImage imageNamed:@""] target:self action:@selector(addClick)];
    _sureBtn.backgroundColor = SureColor;
    [self.view addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(49);
        make.width.mas_equalTo(SCREENWIDTH);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}


- (void)addClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 180;
    }else if(indexPath.section == 0 && indexPath.row == 5){
        return 80;
    }else if(indexPath.section == 1){
        return 200;
    }else{
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row ==0) {
        NYNLeImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNLeImgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        return cell;
    }else if (indexPath.section == 0 && indexPath.row ==1) {
        NYNLeNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseNamecell"];
        if (!cell) {
            cell = [[NYNLeNameCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseNamecell"];
        }
        return cell;
    }
    else if (indexPath.section == 0 && indexPath.row ==2) {
        NYNAddresCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNAddresCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        return cell;
    }
    else if (indexPath.section == 0 && indexPath.row ==3) {
        NYNLeMJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNLeMJCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell setData:@[@"土地面积",@"20㎡"]];
        return cell;
    }
    else if (indexPath.section == 0 && indexPath.row ==4) {
        NYNLeMJCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNLeMJCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell setData:@[@"租赁价格",@"10.00元/月"]];
        return cell;
    }
    else if (indexPath.section == 0 && indexPath.row ==5) {
        NYNMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMonthCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        return cell;
    }
    else if (indexPath.section == 1 && indexPath.row ==0) {
        NYNInstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNInstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        return cell;
    }
    else {
        return nil;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vie = [[UIView alloc]init];
    vie.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return vie;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vie = [[UIView alloc]init];
    return vie;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64-49) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
