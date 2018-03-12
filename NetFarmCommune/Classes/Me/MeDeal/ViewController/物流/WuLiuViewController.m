
//  WuLiuViewController.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/31.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "WuLiuViewController.h"
#import "WuLiuTableViewCell.h"
#import "WuLiuOneTableViewCell.h"
#import "WuLiuModel.h"
@interface WuLiuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableivew;


@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * expressItemsArr;


@end

@implementation WuLiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    _expressItemsArr = [[NSMutableArray alloc]init];

    self.title =@"查看物流";
    [self.view addSubview:self.tableivew];

    
    
}

//物流
-(void)getWuliuDataUserId:(NSString*)userId{
    
    NSDictionary * ns =  @{@"orderId":userId};;
    [NYNNetTool ShippingParams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                WuLiuModel*model = [WuLiuModel mj_objectWithKeyValues:success[@"data"]];
                //添加数据
                [self.dataArray addObject:model];
            
            _expressItemsArr = success[@"data"][@"expressItems"];
            
            
            
          [self.tableivew reloadData];
            
        }else if ([NSString stringWithFormat:@"%@",success[@"401"]]){
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        
    } failure:^(NSError *failure){
        
        
    }];
    
    
}

#pragma mark---UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return _expressItemsArr.count;
        
    }
    return 0;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        WuLiuOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WuLiuOneTableViewCell class]) owner:self options:nil].firstObject;
        }

        
        if (_dataArray.count>0) {
            cell.model = _dataArray[indexPath.row];
        }
        return cell;
    }else{
        WuLiuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WuLiuTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        if (indexPath.row ==0) {
            cell.addressLabel.textColor = Color90b659;
            cell.cycleView.frame = CGRectMake(19, 0, 17, 17);
            cell.cycleView.backgroundColor =Color90b659;
            cell.cycleView.alpha=0.5;
            
            cell.smartCyclView.backgroundColor =Color90b659;
            cell.smartCyclView.hidden = YES;
            
             cell.timeLabel.textColor = Color90b659;
        }
        if (_dataArray.count>0) {
           cell.expressArray = _expressItemsArr[indexPath.row];
        }
        
   

        
        return cell;
        
    }
   
    
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 54)];
        UILabel * lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 8)];
        lineLabel.backgroundColor=Colorededed;
        [headerView addSubview:lineLabel];
        
        UILabel * wuliuLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, SCREENWIDTH, 46)];
        
        wuliuLabel.text=@"物流跟踪";
        wuliuLabel.textColor = [UIColor blackColor];
        wuliuLabel.font=[UIFont systemFontOfSize:15];
        [headerView addSubview:wuliuLabel];
        
        
        return  headerView;
        
    }
    return nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 54;
    }
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 113;
    }else{
        return 55;
    }
 
    
}

-(UITableView *)tableivew{
    if (!_tableivew) {
        _tableivew=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-60) style:UITableViewStylePlain];
        _tableivew.delegate=self;
        _tableivew.dataSource=self;
        _tableivew.tableFooterView=[[UIView alloc]init];
     _tableivew.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableivew;
    
}



@end
