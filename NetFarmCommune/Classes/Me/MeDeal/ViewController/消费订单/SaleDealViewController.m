//
//  SaleDealViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "SaleDealViewController.h"
#import "SaleDealTableViewCell.h"
#import "CustomModel.h"

@interface SaleDealViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,assign)int selectTag;//button点击tag

@property(nonatomic,strong)NSMutableArray * dataListArr;



@end

@implementation SaleDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    [self creatUI];
    [self.view addSubview:self.tableView];
    [self getData:@"consum"];
//    MJRefreshFooter
    
    
    
}


//获取消费订单数据
-(void)getData:(NSString*)type{
    
    NSDictionary * ns =  @{@"status":@"received",@"pageNo":@"1",@"pageSize":@"10",@"type":type};;
    [NYNNetTool ConsumeWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                CustomModel*model = [CustomModel mj_objectWithKeyValues:dic];
                //添加数据
                [self.dataListArr addObject:model];
                
            }
            [self.tableView reloadData];
        }else if ([NSString stringWithFormat:@"%@",success[@"401"]]){
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
    } failure:^(NSError *failure){
        
        
    }];
    
}




-(void)creatUI{
    NSArray * titleArr = @[@"未消费",@"已消费"];
    
    CGFloat x =SCREENWIDTH/2-60;
    for (int i =0; i<2; i++) {
        UIButton * weixiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        weixiaoBtn.frame =CGRectMake(x+60*i, 0, 70, 50);
        [weixiaoBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        weixiaoBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        
        [weixiaoBtn addTarget:self action:@selector(weixiaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        weixiaoBtn.tag=400+i;
        
        [self.view addSubview:weixiaoBtn];
        if (i==0) {
            [weixiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            weixiaoBtn.backgroundColor = Color90b659;
            
        }else{
              [weixiaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }

    
    
}


-(void)weixiaoBtnClick:(UIButton*)sender{
    for (int i =0; i<2; i++) {
         UIButton * btn =[self.view viewWithTag:400+i];
        if ( btn.tag == sender.tag){
             btn.backgroundColor = Color90b659;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
            
            
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
             btn.backgroundColor = [UIColor whiteColor];
        }
    }
   
    if (sender.tag ==400) {
        [self getData:@"consum"];
        
   
    }else if (sender.tag==401){
        [self getData:@"received"];
    }
    
    
    
    
    
}

#pragma mark---UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataListArr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SaleDealTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SaleDealTableViewCell class]) owner:self options:nil].firstObject;
        
    }
      cell.model = self.dataListArr[indexPath.row];
     return cell;
}


#pragma mark--setter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREENWIDTH, SCREENHEIGHT-100) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[[UIView alloc]init];
        _tableView.rowHeight=210;

    }
    return _tableView;
    
}
@end
