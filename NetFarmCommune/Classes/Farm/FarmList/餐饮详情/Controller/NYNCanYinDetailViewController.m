//
//  NYNCanYinDetailViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNCanYinDetailViewController.h"
#import "NYNEarthDetailHeaderTableViewCell.h"
#import "NYNEarthDataTableViewCell.h"
#import "NYNEarthLocationViewTableViewCell.h"
#import "NYNEarthZuDiTableViewCell.h"
#import "NYNChooseTableViewCell.h"
#import "NYNEarthDetailTableViewCell.h"
#import "NYNDetailContentTableViewCell.h"
#import "NYNSuYuanTableViewCell.h"
#import "NYNYueXiaoTableViewCell.h"
#import "NYNGouMaiTableViewCell.h"
#import "NYNGouMaiView.h"
#import "NYNNetTool.h"

@interface NYNCanYinDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *CanYinTable;
@property (nonatomic,strong) NYNGouMaiView *bottomView;
@end

@implementation NYNCanYinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.title;
    NSDictionary * locDic = JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"] ?: @"";
    NSString *lon =locDic[@"lon"] ?: @"";
    
    [NYNNetTool LogleRestaurantDeId:self.Id Params:@{@"longitude":lon,@"latitude":lat} isTestLogin:NO progress:^(NSProgress *Progress) {
        
    } success:^(id success) {
        JZLog(@"%@", success);
    } failure:^(NSError *failure) {
        
    }];
    [self createCanYinTable];
    [self.view addSubview:self.bottomView];
    
    
}

- (void)createCanYinTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.CanYinTable.delegate = self;
    self.CanYinTable.dataSource = self;
    self.CanYinTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.CanYinTable.showsVerticalScrollIndicator = NO;
    self.CanYinTable.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:self.CanYinTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        return 1;
    }else{
        return 0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NYNEarthDetailHeaderTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthDetailHeaderTableViewCell class]) owner:self options:nil].firstObject;
            }
            return farmLiveTableViewCell;
        }
        else if (indexPath.row == 1){
            NYNEarthDataTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthDataTableViewCell class]) owner:self options:nil].firstObject;
            }
            return farmLiveTableViewCell;
        }
        else{
            NYNEarthLocationViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthLocationViewTableViewCell class]) owner:self options:nil].firstObject;
            }
            return farmLiveTableViewCell;
        }
        
        
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            NYNGouMaiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNGouMaiTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.biaoTiLabel.text = @"订购数量";
            return farmLiveTableViewCell;
        }
        else{
            NYNChooseTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChooseTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabe.text = @"消费日期";
            farmLiveTableViewCell.detailTextLabel.text = @"2017-1-18 18:00";
            return farmLiveTableViewCell;
        }
    }
    //    else if (indexPath.section == 2){
    //        NYNEarthDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    //        if (farmLiveTableViewCell == nil) {
    //            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthDetailTableViewCell class]) owner:self options:nil].firstObject;
    //        }
    //        return farmLiveTableViewCell;
    //    }
    else{
        NYNEarthDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthDetailTableViewCell class]) owner:self options:nil].firstObject;
        }
        farmLiveTableViewCell.biaoTiLabel.text = @"套餐详情";
        return farmLiveTableViewCell;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return JZHEIGHT(171);
        }
        else if (indexPath.row == 1){
            return JZHEIGHT(100);
        }
        else{
            return JZHEIGHT(36);
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return JZHEIGHT(40);
        }
        else{
            return JZHEIGHT(41);
        }
    }
    //    else if (indexPath.section == 2){
    //        return JZHEIGHT(126);
    //    }
    else{
        return JZHEIGHT(201);
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : JZHEIGHT(5))];
    
    //    if (section == 2) {
    //
    //
    //        headerView.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46));
    //        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(5), SCREENWIDTH, JZHEIGHT(41))];
    //        backView.backgroundColor = [UIColor whiteColor];
    //        [headerView addSubview:backView];
    //
    //        UILabel *pingJiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, JZWITH(150), headerView.height)];
    //        pingJiaLabel.text = @"评价(154)";
    //        pingJiaLabel.font = JZFont(14);
    //        pingJiaLabel.textColor = Color252827;
    //        [backView addSubview:pingJiaLabel];
    //
    //        UIImageView *jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(7), (pingJiaLabel.height - JZHEIGHT(11)) / 2, JZWITH(7), JZHEIGHT(11))];
    //        jiantou.image = Imaged(@"mine_icon_more");
    //        [backView addSubview:jiantou];
    //
    //        UILabel *quanping = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(150) - JZWITH(10+10), 0, JZWITH(150), headerView.height)];
    //        quanping.textColor = Color252827;
    //        quanping.text = @"全部评论";
    //        quanping.font = JZFont(13);
    //        quanping.textAlignment = 2;
    //        [backView addSubview:quanping];
    //
    //        UIView *xiaV = [[UIView alloc]initWithFrame:CGRectMake(0, headerView.height - JZHEIGHT(0.5), SCREENWIDTH, JZHEIGHT(0.5))];
    //        xiaV.backgroundColor = Colore3e3e3;
    //        [backView addSubview:xiaV];
    //    }
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.00001;
    }else if(section == 1){
        return JZHEIGHT(5);
    }
    else if(section == 2){
        return JZHEIGHT(5);
    }
    else{
        return JZHEIGHT(0.00001);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma 懒加载
-(UITableView *)CanYinTable
{
    
    if (!_CanYinTable) {
        _CanYinTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(45)) style:UITableViewStyleGrouped];
    }
    return _CanYinTable;
}

-(NYNGouMaiView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NYNGouMaiView alloc]init];
        [_bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) - 64, SCREENWIDTH, JZHEIGHT(45))];
    }
    
    _bottomView.gouwucheBlock = ^(NSString *strValue) {
        
    };
    
    _bottomView.goumaiBlock = ^(NSString *strValue) {
        
    };
    
    return _bottomView;
}


@end
