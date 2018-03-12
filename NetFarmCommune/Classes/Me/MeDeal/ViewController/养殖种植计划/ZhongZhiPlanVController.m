//
//  ZhongZhiPlanVController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/29.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "ZhongZhiPlanVController.h"
#import "NYNXuanZeZhongZiTableViewCell.h"
#import "NYNChoosePeiSongAddressTableViewCell.h"
#import "NYNMyFarmZuZhongThreeTableViewCell.h"
#import "NYNZuDiZhonZhiModel.h"
#import "PlanViewController.h"
#import "NYNMyFarmXinRenWuViewController.h"
@interface ZhongZhiPlanVController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArray;

@property(nonatomic,strong)NYNZuDiZhonZhiModel * model;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSString * cycleTime;
@end

@implementation ZhongZhiPlanVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    
    self.title  =@"养殖计划";
    [self.view addSubview:self.tableView];
    [self getCreatUI];
    

    
    UIButton *zhiboButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [zhiboButton addTarget:self action:@selector(onClickedOKbtn:) forControlEvents:UIControlEventTouchUpInside];
    zhiboButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [zhiboButton setTitle:@"新任务" forState:UIControlStateNormal];
    UIBarButtonItem *rb = [[UIBarButtonItem alloc]initWithCustomView:zhiboButton];
    self.navigationItem.rightBarButtonItem = rb;


    
    
    [NYNNetTool PlantOrderJihuaWithparams:self.orderId isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NSLog(@"%@",success);
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            _dataArray =success[@"data"][@"orderItems"];
            _cycleTime =success[@"data"][@"cycleTime"];
            
            NYNZuDiZhonZhiModel *model = [NYNZuDiZhonZhiModel mj_objectWithKeyValues:success[@"data"]];
            self.model=model;
            [self.tableView reloadData];
            
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
    
    
}
//新任务
-(void)onClickedOKbtn:(UIButton*)sender{

    
    NYNMyFarmXinRenWuViewController *vc = [[NYNMyFarmXinRenWuViewController alloc]init];
    vc.productId = self.model.minorProductId;
//    vc.productId = self.orderId;
    vc.yangZhiCount = [self.model.minorProductQuantity intValue];
    vc.cycTime = [self.model.cycleTime intValue];
    vc.orderId = self.orderId;
    vc.typeStr = @"0";
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)getCreatUI{
    
    _titleArray = @[@"养殖数量",@"养殖周期",@"养殖场地",@"标志标识",@"执行管家",@"养殖方案"];
    
    
}
#pragma mark--UITableViewDelegate,UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 6;
    }else if (section==2){
        return 2;
    }else{
           return 1;
    }

    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NYNXuanZeZhongZiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNXuanZeZhongZiTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.indexpath =indexPath.section;
    
    if (indexPath.section==0) {
       
        farmLiveTableViewCell.zhanweiLabel.textColor = Color252827;
        farmLiveTableViewCell.zhanweiLabel.hidden = NO;
        farmLiveTableViewCell.priceLabel.hidden = YES;
        farmLiveTableViewCell.contentLabel.hidden = YES;
        farmLiveTableViewCell.rowImageView.hidden=YES;
   
        if (_styleString ==500) {
             farmLiveTableViewCell.titleLabel.text = @"作物名片";
        }else{
            farmLiveTableViewCell.titleLabel.text = @"动物名片";
        }
        farmLiveTableViewCell.model = self.model;

  
    }else if (indexPath.section==1){
           farmLiveTableViewCell.priceLabel.hidden = YES;
           farmLiveTableViewCell.contentLabel.hidden = YES;
         NSMutableDictionary * dic = [self.model mj_keyValues];
        if (indexPath.row ==0) {
            if ([dic[@"orderType"] isEqualToString:@"plant"]) {
               farmLiveTableViewCell.titleLabel.text = @"种植数量";

            }else if ([dic[@"orderType"] isEqualToString:@"grow"]){
                farmLiveTableViewCell.titleLabel.text = @"养殖数量";
            }
            farmLiveTableViewCell.zhongziLabel.hidden = NO;
            
            farmLiveTableViewCell.zhongziLabel.text = [NSString stringWithFormat:@"%@m²",dic[@"majorProductQuantity"]];
            
        }else if (indexPath.row == 1){
            if ([dic[@"orderType"] isEqualToString:@"plant"]) {
                farmLiveTableViewCell.titleLabel.text = @"种植周期";

            }else if ([dic[@"orderType"] isEqualToString:@"grow"]){
                farmLiveTableViewCell.titleLabel.text = @"cycleTime";
            }
            farmLiveTableViewCell.zhongziLabel.hidden = NO;
             farmLiveTableViewCell.zhongziLabel.text = [NSString stringWithFormat:@"%@天",dic[@"majorProductQuantity"]];
        }else if (indexPath.row == 2){
            if ([dic[@"orderType"] isEqualToString:@"plant"]) {
                farmLiveTableViewCell.titleLabel.text = @"种植土地";
                
            }else if ([dic[@"orderType"] isEqualToString:@"grow"]){
                farmLiveTableViewCell.titleLabel.text = @"养殖土地";
            }
           
            
        }else if (indexPath.row ==3){
            farmLiveTableViewCell.contentLabel.hidden=NO;
            farmLiveTableViewCell.priceLabel.hidden = NO;
            
             farmLiveTableViewCell.titleLabel.text = @"标志标识";
      
            
        }else if (indexPath.row ==4){
              farmLiveTableViewCell.titleLabel.text = @"执行管家";
            farmLiveTableViewCell.priceLabel.hidden = NO;
             farmLiveTableViewCell.priceLabel.text =dic[@"managerName"] ;
        }else if (indexPath.row==5){
              farmLiveTableViewCell.titleLabel.text = @"种植方案";
              farmLiveTableViewCell.contentLabel.text = dic[@"monitorPrice"];
        }

        
        farmLiveTableViewCell.titleLabel.text = _titleArray[indexPath.row];

        farmLiveTableViewCell.zhanweiLabel.textColor = Color252827;
        farmLiveTableViewCell.zhanweiLabel.hidden = NO;
     
     
       farmLiveTableViewCell.rowImageView.hidden=YES;
        
    farmLiveTableViewCell.model = _model;
        
    }else if (indexPath.section==2){
        farmLiveTableViewCell.zhanweiLabel.textColor = Color252827;
        farmLiveTableViewCell.zhanweiLabel.hidden = NO;
         farmLiveTableViewCell.xingLabel.hidden=YES;
        farmLiveTableViewCell.rowImageView.hidden=YES;
        farmLiveTableViewCell.zhongziLabel.hidden = YES;
        
    //  NSMutableDictionary * dic = [_model mj_keyValues];
        if (indexPath.row ==1) {
              farmLiveTableViewCell.priceLabel.hidden = NO;
               farmLiveTableViewCell.contentLabel.hidden = YES;
             farmLiveTableViewCell.titleLabel.text = @"监控服务";
         
        }else{
             farmLiveTableViewCell.titleLabel.text = @"产品加工";

                farmLiveTableViewCell.priceLabel.hidden = YES;
               farmLiveTableViewCell.contentLabel.hidden = NO;
        }

       
    }
    
    else if (indexPath.section==3){
        farmLiveTableViewCell.zhongziLabel.hidden = NO;
        
        farmLiveTableViewCell.titleLabel.text = @"收货地址";
        
        farmLiveTableViewCell.zhanweiLabel.textColor = Color252827;
        farmLiveTableViewCell.zhanweiLabel.hidden = NO;
        farmLiveTableViewCell.priceLabel.hidden = YES;
        farmLiveTableViewCell.contentLabel.hidden = YES;
        farmLiveTableViewCell.rowImageView.hidden=YES;
          farmLiveTableViewCell.model = self.model;

    }
        return farmLiveTableViewCell;;
    
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row==5) {
            //种植方案
            PlanViewController * planVC = [[PlanViewController alloc]init];
            planVC.dataArray=_dataArray;
            
            [self.navigationController pushViewController:planVC animated:YES];
            
        }
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor lightGrayColor];
    footView.alpha=0.5;
    
    return footView;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 9;
    
}



#pragma mark---setter

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-60) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight=60;
        
        _tableView.tableFooterView=[[UIView alloc]init];
        
        
        
    }
    return _tableView;
    
}



@end
