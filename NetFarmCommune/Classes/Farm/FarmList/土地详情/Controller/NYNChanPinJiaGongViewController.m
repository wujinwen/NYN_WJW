//
//  NYNChanPinJiaGongViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChanPinJiaGongViewController.h"
#import "NYNChanPinTableViewCell.h"
#import "NYNChanPinJiaGongModel.h"

@interface NYNChanPinJiaGongViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *chooseChanPinTable;
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;

@end

@implementation NYNChanPinJiaGongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"产品加工";
    self.pageNo = 1;
    self.pageSize = 10;
    
//    for (int i = 0; i < 10; i++) {
//        NYNChanPinJiaGongModel *model = [[NYNChanPinJiaGongModel alloc]init];
//        model.isChoose = NO;
//        [self.dataArr addObject:model];
//    }
    
    [self createchooseChanPinTable];
    
  
}



-(void)setProductId:(NSString *)productId type:(NSString *)type{
    
    
    NSDictionary *dic = @{@"farmingId":productId,@"pageNo":@"1",@"pageSize":@"10",@"type":type};
    [self showLoadingView:@""];
    [NYNNetTool GetJiaGongFangShiWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            for (NSDictionary *dic in success[@"data"]) {
                NYNChanPinJiaGongModel *model = [NYNChanPinJiaGongModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            [self.chooseChanPinTable reloadData];
        }else{
            
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];

}

- (void)createchooseChanPinTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.chooseChanPinTable.delegate = self;
    self.chooseChanPinTable.dataSource = self;
    self.chooseChanPinTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chooseChanPinTable.showsVerticalScrollIndicator = NO;
    self.chooseChanPinTable.showsHorizontalScrollIndicator = NO;
    
    self.chooseChanPinTable.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.chooseChanPinTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
    
    [self.view addSubview:self.chooseChanPinTable];
    

}

- (void)refreshData{
//    [self.chooseChanPinTable.mj_header beginRefreshing];

    self.pageNo = 1;
    self.pageSize = 10;
    NSDictionary *dic = @{@"productId":self.productId,@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize]};
//    [self showLoadingView:@""];
    [NYNNetTool GetJiaGongFangShiWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            [self.dataArr removeAllObjects];
            for (NSDictionary *dic in success[@"data"]) {
                NYNChanPinJiaGongModel *model = [NYNChanPinJiaGongModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            [self.chooseChanPinTable reloadData];
        }else{
            
        }
//        [self hideLoadingView];
        [self endRefresh];

    } failure:^(NSError *failure) {
        [self endRefresh];
    }];
}

- (void)moreData{
//    [self.chooseChanPinTable.mj_header beginRefreshing];
    self.pageNo ++;
    
    NSDictionary *dic = @{@"productId":self.productId,@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize]};
    //    [self showLoadingView:@""];
    [NYNNetTool GetJiaGongFangShiWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//            [self.dataArr removeAllObjects];
            for (NSDictionary *dic in success[@"data"]) {
                NYNChanPinJiaGongModel *model = [NYNChanPinJiaGongModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            [self.chooseChanPinTable reloadData];
        }else{
            
        }
        //        [self hideLoadingView];
        [self endRefresh];
        
    } failure:^(NSError *failure) {
        [self endRefresh];
    }];
}

- (void)endRefresh{
    [self.chooseChanPinTable.mj_footer endRefreshing];
    [self.chooseChanPinTable.mj_header endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNChanPinTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChanPinTableViewCell class]) owner:self options:nil].firstObject;
    }
    NYNChanPinJiaGongModel *model = self.dataArr[indexPath.section];
    if (model.isChoose) {
        farmLiveTableViewCell.chooseImageView.image = [UIImage imageNamed:@"farm_icon_selected4"];
    }else{
        farmLiveTableViewCell.chooseImageView.image = [UIImage imageNamed:@"farm_icon_notselected3"];

    }
    farmLiveTableViewCell.titleLabel.text = model.farmArtName;
    farmLiveTableViewCell.contentLabel.text = model.intro;
    farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%@元",model.price];
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(101);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ?  0.0001 : 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    FTEarthDetailViewController *vc = [[FTEarthDetailViewController alloc]init];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
    
    NYNChanPinJiaGongModel *model = self.dataArr[indexPath.section];
    model.isChoose = !model.isChoose;
    
    NSIndexSet *ss = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.chooseChanPinTable reloadSections:ss withRowAnimation:UITableViewRowAnimationNone];
    
    if (self.returnBlock) {
        self.returnBlock(model);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(UITableView *)chooseChanPinTable{
    if (!_chooseChanPinTable) {
        _chooseChanPinTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStyleGrouped];
    }
    return _chooseChanPinTable;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
@end
