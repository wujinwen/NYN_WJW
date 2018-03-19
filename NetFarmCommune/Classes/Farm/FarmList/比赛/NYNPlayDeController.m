//
//  NYNPlayDeController.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/15.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNPlayDeController.h"

#import "NYNMatchNoCell.h"

@interface NYNPlayDeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableview;
@property (nonatomic,copy) NSDictionary *dicData;
@property (nonatomic,copy) UIButton *sureBtn;

@end

@implementation NYNPlayDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    
    self.title = @"比赛信息";
    NSDictionary * locDic = JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"] ?: @"";
    NSString *lon =locDic[@"lon"] ?: @"";
    
    [NYNNetTool MatchDeId:self.ID Params:@{@"longitude":lon,@"latitude":lat} isTestLogin:NO progress:^(NSProgress *Progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            _dicData = success[@"data"];
            [self.tableview reloadData];
            NSLog(@"比赛数据%@",success);
        }else{
//            self.bakcView.hidden = NO;
//            [self.tableview addSubview:self.bakcView];
        }
    } failure:^(NSError *failure) {
        
    }];
    
    _sureBtn = [NYNYCCommonCtrl commonButtonWithFrame:CGRectZero title:@"报名" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] backgroundImage:[UIImage imageNamed:@""] target:self action:@selector(addClick)];
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

#pragma mark--UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 7;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 2;
    }else{
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"比赛名称" rightTitle:_dicData[@"name"]];
        return cell;
    }else if(indexPath.section ==1 && indexPath.row == 0){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"举办方" rightTitle:_dicData[@"farm"][@"name"]];
        return cell;
    }else if(indexPath.section ==1 && indexPath.row == 1){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"比赛地址" rightTitle:_dicData[@"address"]];
        return cell;
    }
    else if(indexPath.section ==1 && indexPath.row == 2){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"报名时间" rightTitle:[NSString stringWithFormat:@"%@至%@",[MyControl timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_dicData[@"signUpStartDate"]]],[MyControl timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_dicData[@"signUpEndDate"]]]]];
        return cell;
    }
    else if(indexPath.section ==1 && indexPath.row == 3){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"比赛时间" rightTitle:[NSString stringWithFormat:@"%@至%@",[MyControl timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_dicData[@"startDate"]]],[MyControl timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_dicData[@"endDate"]]]]];
        return cell;
    }
    else if(indexPath.section ==1 && indexPath.row == 4){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"比赛人数" rightTitle:[NSString stringWithFormat:@"%@/%@",_dicData[@"stock"],_dicData[@"maxStock"]]];
        return cell;
    }
    else if(indexPath.section ==1 && indexPath.row == 5){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"报名费用" rightTitle:[NSString stringWithFormat:@"%@元",_dicData[@"price"]]];
        return cell;
    }
    else if(indexPath.section ==1 && indexPath.row == 6){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"联系方式" rightTitle:_dicData[@"phone"]];
        return cell;
    }
    else if(indexPath.section ==2 && indexPath.row == 0){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"比赛奖励" rightTitle:_dicData[@"awardsDesc"]];
        return cell;
    }
    else if(indexPath.section ==2 && indexPath.row == 1){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"" rightTitle:_dicData[@"awardsDesc"]];
        return cell;
    }
    else if(indexPath.section ==3 && indexPath.row == 0){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"比赛详情" rightTitle:@""];
        return cell;
    }
    else if(indexPath.section ==3 && indexPath.row == 1){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"" rightTitle:_dicData[@"details"]];
        return cell;
    }
    else if(indexPath.section ==4 && indexPath.row == 0){
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"相关图片" rightTitle:@""];
        return cell;
    }
    else{
        NYNMatchNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaseImgcell"];
        if (!cell) {
            cell = [[NYNMatchNoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"leaseImgcell"];
        }
        [cell letfTitle:@"比赛名称" rightTitle:_dicData[@"images"]];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3 && indexPath.row == 1) {
        return 200;
    }else if(indexPath.section ==4 && indexPath.row == 1){
        return 200;
    }else{
        return 50;
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

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - 49) style:UITableViewStyleGrouped];
        _tableview.delegate  =self;
        _tableview.dataSource  =self;
        _tableview.separatorStyle =UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
