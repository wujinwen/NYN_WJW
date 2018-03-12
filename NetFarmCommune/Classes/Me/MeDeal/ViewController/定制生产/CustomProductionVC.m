//
//  CustomProductionVC.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//定制生产

#import "CustomProductionVC.h"
#import "CustomProductTVCell.h"
#import "CustomModel.h"
#import "ZhongZhiPlanVController.h"

#import "NYNDealModel.h"
#import "BuyPlayViewController.h"
#import "NYNDealModel.h"
#import "NYNPayViewController.h"
#import "FuckPayViewController.h"
#import "GrowViewController.h"
@interface CustomProductionVC ()<UITableViewDelegate,UITableViewDataSource,CustomProductClickDelagate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray *dataListArr;
@property(nonatomic,assign)int pageNo;
@property(nonatomic,assign)NSInteger selectTag;//点击选择的button
@property(nonatomic,strong)NYNDealModel * dealModel;

@property(nonatomic,strong)NSMutableArray *ListArr;

@end

@implementation CustomProductionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _dataListArr = [[NSMutableArray alloc]init];
    _ListArr = [[NSMutableArray alloc]init];
    
    [self setupPageView];
    [self.view addSubview:self.tableView];
    _selectTag=500;
    
    _pageNo = 1;
    [self getData:500];
    //上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
//    //下拉刷新
//        self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
}

//-(void)headerRefresh{
//    _pageNo =1;
//
//      [self.tableView.mj_header beginRefreshing];
//      [self getData:(int)_selectTag];
//
//     [self.tableView.mj_header endRefreshing];
//}
-(void)getData:(int)selectTag{
        _pageNo = 1;

    NSDictionary * ns = [[NSDictionary alloc]init];
    
    if (selectTag == 500) {
       ns = @{@"type":@"plant",@"pageNo":[NSString stringWithFormat:@"%d",_pageNo],@"pageSize":@"10"};

    }else if (selectTag == 501){
       ns = @{@"type":@"grow",@"pageNo":[NSString stringWithFormat:@"%d",_pageNo],@"pageSize":@"10"};
    }else{
         ns = @{@"status":@"received",@"pageNo":[NSString stringWithFormat:@"%d",_pageNo],@"pageSize":@"10"};
    }
    _selectTag = selectTag;
    
    [NYNNetTool YangZhiWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        NSLog(@"%@",success);
            [self.dataListArr removeAllObjects];
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
//上拉刷新
-(void)refreshFooter{
    _pageNo++;
//    [self getData:_pageNo];

      NSDictionary * ns = [[NSDictionary alloc]init];
    if (_selectTag == 500) {
        ns = @{@"type":@"plant",@"pageNo":[NSString stringWithFormat:@"%d",_pageNo],@"pageSize":@"10"};
    }else if (_selectTag == 501){
        ns = @{@"type":@"grow",@"pageNo":[NSString stringWithFormat:@"%d",_pageNo],@"pageSize":@"10"};
    }else{
        ns = @{@"status":@"received",@"pageNo":[NSString stringWithFormat:@"%d",_pageNo],@"pageSize":@"10"};
    }
    [NYNNetTool YangZhiWithparams: ns isTestLogin:YES progress:^(NSProgress *progress) {
    } success:^(id success){
        NSLog(@"%@",success);
    [self.tableView.mj_footer endRefreshing];
        if ((![NSArray arrayWithArray:success[@"data"]].count)>0) {
            return ;
            
        }
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
          [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)setupPageView {
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    titleView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
     NSArray *titleArr = @[@"代种", @"代养", @"已收获"];
    for (int i = 0; i<3; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        btn.frame=CGRectMake(SCREENWIDTH/3*i, 0, SCREENWIDTH/3, 44);
        btn.tag=500+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
        
        if (i == 0) {
            [btn setTitleColor:Color90b659 forState:UIControlStateNormal] ;
        }else{

             [btn setTitleColor:Color686868 forState:UIControlStateNormal] ;
        }
    }

    
}



#pragma mark--CustomProductClickDelagate

//种植计划
-(void)planClickIndex:(NSInteger)indexpath orderId:(NSString *)orderId{
    ZhongZhiPlanVController * zhongzhiVC = [[ZhongZhiPlanVController alloc]init];
    zhongzhiVC.orderId  =orderId;
    
//    zhongzhiVC.model=_dataListArr[indexpath];
     //判断种植养殖
    zhongzhiVC.styleString=_selectTag;
    
    
    [self.navigationController pushViewController:zhongzhiVC animated:YES];
    
    
}
//删除订单
-(void)garbageClickInteger:(NSInteger)select state:(NSString *)state index:(NSInteger)index{
      //'pendingPayment', 'canceled', 'completed','received','denied'这些状态可以删除，其他的状态为不可删除状态
    if ([state isEqualToString:@"pendingPayment"]||
        [state isEqualToString:@"canceled"]||
        [state isEqualToString:@"completed"]||
        [state isEqualToString:@"received"]||
        [state isEqualToString:@"denied"]) {
        
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"确定删除吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [sheet addAction:cancelAction];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self showLoadingView:@""];
            //[NSString stringWithFormat:@"%ld",(long)integer]
            NSLog(@"-----------%ld",select);
            
            [NYNNetTool MyFarmDetelDealWithparams:[NSString stringWithFormat:@"%ld",select] isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                            [self.dataListArr removeObjectAtIndex:index];
                    
                    
//                        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationLeft];
                   [self.tableView reloadData];
//                                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
                    
                }else{
                    
                    [self showTextProgressView:[NSString  stringWithFormat:@"%@",success[@"msg"]]];
                }
                [self hideLoadingView];
            } failure:^(NSError *failure) {
                [self hideLoadingView];
            }];
            
        }];
        [sheet addAction:confirmAction];
        
        [self presentViewController:sheet animated:YES completion:^{
            // TODO
        }];
    }else{
         [self showTextProgressView:@"此订单状态不能删除"];
        [self hideLoadingView];
        
        return;
        
    }
}
//去付款
-(void)payMoneyClick:(NSInteger)idnex model:(CustomModel *)model state:(NSString *)state{

    
    if ([state isEqualToString:@"pendingPayment"]) {
        //这里是tm最智障的地方，不要问为什么
        FuckPayViewController * goumaiVc=[[FuckPayViewController alloc]init];
        goumaiVc.typeStr=@"NORMAL";
        goumaiVc.model = model;
        //    goumaiVc.countString=weakSelf.countString;
        [self.navigationController pushViewController:goumaiVc animated:YES];
        
    }else if ([state isEqualToString:@"growing"]){
        //查看进度
        GrowViewController* vc = [[GrowViewController alloc]init];
        vc.orderID = [NSString stringWithFormat:@"%ld",(long)idnex];
        
        
         [self.navigationController pushViewController:vc animated:YES];
        
        
    }
}
-(void)plantClick:(NSString *)phone{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"%@", phone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
    
}

#pragma mark---UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataListArr.count;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomProductTVCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CustomProductTVCell class]) owner:self options:nil].firstObject;
        
    }
    cell.delegate=self;
    cell.planIndex = (NSInteger)indexPath.row;
    cell.selectInteger =_selectTag;

    cell.customModel = self.dataListArr[indexPath.row];
    
    if (_selectTag ==502) {
        cell.pingjiaButton.hidden = NO;
        [cell.payBtn setTitle:@"溯源" forState:UIControlStateNormal];
        
        
    }
    return cell;
    
}

//种植养殖发货button点击事件

-(void)btnClick:(UIButton*)sender{
    
    for (int i = 0; i<3;i++) {
          UIButton *myButton = (UIButton *)[self.view viewWithTag:(500+i)];
        if ( myButton.tag == sender.tag){
            
            [myButton setTitleColor:Color90b659 forState:UIControlStateNormal] ;
            
        }else{
           [myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        }
        if (sender.tag == 501) {
            [self getData:501];

        }else if (sender.tag == 502){
              [self getData:502];
            
        }else if (sender.tag ==500){
            [self getData:500];
            
        }
        
        
    }

    
    
    
    
    
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT-44-50-30-30) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.rowHeight=200;
        
    }
    return _tableView;
    
}
-(NSMutableArray *)dataListArr{
    if (!_dataListArr) {
        _dataListArr = [[NSMutableArray alloc]init];
        
    }
    return _dataListArr;
    
}
@end
