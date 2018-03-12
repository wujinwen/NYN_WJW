//
//  CreatGroupVController.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/10.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "CreatGroupVController.h"
#import "GrounpNameTVCell.h"
#import "GrounpAreaTVCell.h"
#import "IntroduceTableVCell.h"

#import "GrounpImageTVCell.h"
#import "NYNNetTool.h"

@interface CreatGroupVController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView * tableview;


@end

@implementation CreatGroupVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建群组";
    [self.view addSubview:self.tableview];
    
    
    
}

-(void)setGrounpData{
    [NYNNetTool GreatGrounpParams:@{} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
//
//
//            }
           
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
      
        
    } failure:^(NSError *failure) {
        [self hideLoadingView];
        
        
    }];
}

#pragma mark--UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GrounpNameTVCell * groupTVCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (groupTVCell == nil) {
            groupTVCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GrounpNameTVCell class]) owner:self options:nil].firstObject;
        }
        return groupTVCell;
        
        
    }else if (indexPath.section ==1){
        GrounpAreaTVCell * areaTVCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (areaTVCell == nil) {
            areaTVCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GrounpAreaTVCell class]) owner:self options:nil].firstObject;
        }
        return areaTVCell;
        
    }else if (indexPath.section ==2){
        
        IntroduceTableVCell * IntroduceTVCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (IntroduceTVCell == nil) {
            IntroduceTVCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([IntroduceTableVCell class]) owner:self options:nil].firstObject;
        }
        return IntroduceTVCell;
        
    }else{
        GrounpImageTVCell * imageTVCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (imageTVCell == nil) {
            imageTVCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GrounpImageTVCell class]) owner:self options:nil].firstObject;
        }
        return imageTVCell;
    }
    
    return nil;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 50;
        
    }else if (indexPath.section ==1){
        return 70;
        
        
    }else if (indexPath.section==2){
        return 250;
        
    }else{
        return 150;
        
    }
//    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }else{
        return 5;
    }
    
    
}


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableview.delegate=self;
        _tableview.dataSource = self;
        
        
    }
    return _tableview;
    
}
@end
