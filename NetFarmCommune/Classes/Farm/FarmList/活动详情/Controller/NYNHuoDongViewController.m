//
//  NYNHuoDongViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNHuoDongViewController.h"
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
#import "NYNActivityModel.h"
#import "NYNMoneyCell.h"
#import "NYNAdressCell.h"
#import "NYNWhoCell.h"
#import "NYNAcDeCell.h"

@interface NYNHuoDongViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NYNActivityModel *dataModel;
}
@property (nonatomic,strong) UITableView *huoDongTable;
@property (nonatomic,strong) NYNGouMaiView *bottomView;

@end

@implementation NYNHuoDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"活动详情";
    
    [self createhuoDongTable];
    [self.view addSubview:self.bottomView];
    NSDictionary * locDic = JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"] ?: @"";
    NSString *lon =locDic[@"lon"] ?: @"";
    
    [NYNNetTool ActiveDeId:self.ID Params:@{@"longitude":lon,@"latitude":lat} isTestLogin:NO progress:^(NSProgress *Progress) {
    } success:^(id success) {
        JZLog(@"%@", success);
        dataModel = [NYNActivityModel mj_objectWithKeyValues:success[@"data"]];
        [self.huoDongTable reloadData];
    } failure:^(NSError *failure) {
        
    }];
}

- (void)createhuoDongTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.huoDongTable.delegate = self;
    self.huoDongTable.dataSource = self;
    self.huoDongTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.huoDongTable.showsVerticalScrollIndicator = NO;
    self.huoDongTable.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.huoDongTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row == 0) {
            NYNEarthDetailHeaderTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"imgCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthDetailHeaderTableViewCell class]) owner:self options:nil].firstObject;
            }
            NSMutableArray *imgArr = [[NSMutableArray alloc]init];
            if (dataModel != nil) {
                if ([(NSArray *)dataModel.farm[@"images"] count] == 0) {
                    [imgArr addObject:[NSString jsonImg:dataModel.images ]];
                }
                else{
                    imgArr = (NSMutableArray *)dataModel.farm[@"images"];
                }
                [farmLiveTableViewCell setUrlImages:imgArr];
            }
           
            return farmLiveTableViewCell;
        }
        else if (indexPath.row == 1){
            NYNEarthDataTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"deCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthDataTableViewCell class]) owner:self options:nil].firstObject;
            }
            if (dataModel != nil) {
                [farmLiveTableViewCell setModel:dataModel];
            }
            return farmLiveTableViewCell;
        }
        else if (indexPath.row == 2) {
            NYNAdressCell *farmLiveTableViewCell = [[NYNAdressCell alloc]initWithStyle:0 reuseIdentifier:@"addCell"];
            
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NYNAdressCell alloc]initWithStyle:0 reuseIdentifier:@"addCell"];
            }
            farmLiveTableViewCell.model = dataModel;
            return farmLiveTableViewCell;
        }
        else if (indexPath.row == 3) {
            NYNMoneyCell *farmLiveTableViewCell = [[NYNMoneyCell alloc]initWithStyle:0 reuseIdentifier:@"moneyCell"];
            
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NYNMoneyCell alloc]initWithStyle:0 reuseIdentifier:@"moneyCell"];
            }
            farmLiveTableViewCell.model = dataModel;
            return farmLiveTableViewCell;
        }
        else if (indexPath.row == 4) {
            NYNWhoCell *farmLiveTableViewCell = [[NYNWhoCell alloc]initWithStyle:0 reuseIdentifier:@"whoCell"];
            
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NYNWhoCell alloc]initWithStyle:0 reuseIdentifier:@"whoCell"];
            }
            farmLiveTableViewCell.model = dataModel;
            return farmLiveTableViewCell;

        }
       else {
           NYNAcDeCell *farmLiveTableViewCell = [[NYNAcDeCell alloc]initWithStyle:0 reuseIdentifier:@"acDeCell"];
           
           if (farmLiveTableViewCell == nil) {
               farmLiveTableViewCell = [[NYNAcDeCell alloc]initWithStyle:0 reuseIdentifier:@"acDeCell"];
           }
           farmLiveTableViewCell.model = dataModel;
           return farmLiveTableViewCell;        }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0) {
            return JZHEIGHT(171);
        }
        else if (indexPath.row == 1){
            return JZHEIGHT(70);
        } else if (indexPath.row == 2){
            return 80;
        }
        else if (indexPath.row == 3){
            return 50;
        }
        else if (indexPath.row == 4){
            return 80;
        }
        else{
            return 200;
        }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,0.0001 )];
    
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
        return 0.00001;

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
-(UITableView *)huoDongTable
{
    
    if (!_huoDongTable) {
        _huoDongTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 -JZHEIGHT(45)) style:UITableViewStyleGrouped];
    }
    return _huoDongTable;
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
