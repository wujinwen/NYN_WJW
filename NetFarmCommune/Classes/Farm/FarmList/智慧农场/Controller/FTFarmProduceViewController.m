//
//  FTFarmProduceViewController.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/24.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTFarmProduceViewController.h"
#import "FTFarmProduceTableViewCell.h"
#import "NYNNongChanPinDetailViewController.h"

@interface FTFarmProduceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *FarmProduceTable;
//@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation FTFarmProduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createFarmProduceTable];
    self.pageNo = 1;
    self.pageSize = 10;
    

}



- (void)updateData{
    [self showLoadingView:@""];
    
    NSDictionary *postDic = @{@"farmId":self.farmId,@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize]};
    [NYNNetTool ProductQueryWithparams:postDic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        [self.dataArr removeAllObjects];
        
        NSArray *arr = [NSArray arrayWithArray:success[@"data"]];
        for (NSDictionary *d in arr) {
            NYNCategoryPageModel *model = [NYNCategoryPageModel mj_objectWithKeyValues:d];
            [self.dataArr addObject:model];
        }
        [self.FarmProduceTable reloadData];
        JZLog(@"");
        if (self.dateUp) {
            self.dateUp(@"控制器数据回调");
        }
        
        self.FarmProduceTable.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(100) * self.dataArr.count);

        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}

- (void)createFarmProduceTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.FarmProduceTable.delegate = self;
    self.FarmProduceTable.dataSource = self;
    self.FarmProduceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.FarmProduceTable.showsVerticalScrollIndicator = NO;
    self.FarmProduceTable.showsHorizontalScrollIndicator = NO;
    
    self.FarmProduceTable.scrollEnabled = YES;
    
    [self.view addSubview:self.FarmProduceTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FTFarmProduceTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTFarmProduceTableViewCell class]) owner:self options:nil].firstObject;
    }
    
    NYNCategoryPageModel *model = self.dataArr[indexPath.row];
    farmLiveTableViewCell.model = model;
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(100);
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    //    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(40))];
//    headerView.backgroundColor = [UIColor whiteColor];
//    
//    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(10))];
//    v.backgroundColor = BackGroundColor;
//    [headerView addSubview:v];
//    
//    UIView *lienV = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(50) - 0.5, SCREENWIDTH, 0.5)];
//    lienV.backgroundColor = BackGroundColor;
//    [headerView addSubview:lienV];
//    
//    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(24), JZWITH(150), JZHEIGHT(13))];
//    titleLabel.font = JZFont(13);
//    titleLabel.textColor = RGB56;
//    
//    
//    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(358), JZHEIGHT(25), JZWITH(7), JZHEIGHT(13))];
//    
//    [headerView addSubview:titleLabel];
//    [headerView addSubview:imageV];
//    
//    switch (section) {
//        case 0:
//        {
//            titleLabel.text = @"全部动物";
//        }
//            break;
//        case 1:
//        {
//            titleLabel.text = @"养殖套餐";
//            
//        }
//            break;
//        case 2:
//        {
//            titleLabel.text = @"用户评价";
//            
//        }
//            break;
//        default:
//            break;
//    }
//    return headerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return JZHEIGHT(50);
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
//    return footerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.0001;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNNongChanPinDetailViewController *vc = [[NYNNongChanPinDetailViewController alloc]init];
    vc.ID = self.farmId;

    [self.navigationController pushViewController:vc animated:YES];
}


#pragma 懒加载
-(UITableView *)FarmProduceTable
{
    //scroll  cellheight  table暂定1000
    
    if (!_FarmProduceTable) {
        _FarmProduceTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    }
    return _FarmProduceTable;
}
//-(NSMutableArray *)dataArr{
//    if (!_dataArr) {
//        _dataArr = [[NSMutableArray alloc]init];
//    }
//    return  _dataArr;
//}

@end
