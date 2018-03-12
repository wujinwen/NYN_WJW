//
//  FTCultivateViewController.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/24.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTCultivateViewController.h"
#import "FTCultivateTableViewCell.h"
#import "NYNCultivateDetailViewController.h"
#import "NYNCategoryPageModel.h"
#import "NYNWantYangZhiViewController.h"

@interface FTCultivateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *CultivateTable;
//@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation FTCultivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createCultivateTable];
    
    self.pageNo = 1;
    self.pageSize = 10;
    
    NSDictionary *postDic = @{@"farmId":self.farmId,@"categoryId":self.categoryId,@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize]};
    [NYNNetTool PageCategoryResquestWithparams:postDic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        JZLog(@"");
    } failure:^(NSError *failure) {
        
    }];
}

- (void)createCultivateTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.CultivateTable.delegate = self;
    self.CultivateTable.dataSource = self;
    self.CultivateTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.CultivateTable.showsVerticalScrollIndicator = NO;
    self.CultivateTable.showsHorizontalScrollIndicator = NO;
    
    self.CultivateTable.scrollEnabled = YES;
    
    [self.view addSubview:self.CultivateTable];
}


- (void)updateData{
    [self showLoadingView:@""];

    //养殖
    NSDictionary *postDic = @{@"farmId":self.farmId,@"type":@"grow",@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize]};
    [NYNNetTool PageCategoryResquestWithparams:postDic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        [self.dataArr removeAllObjects];

        NSArray *arr = [NSArray arrayWithArray:success[@"data"]];
        for (NSDictionary *d in arr) {
            NYNCategoryPageModel *model = [NYNCategoryPageModel mj_objectWithKeyValues:d];
            [self.dataArr addObject:model];
        }
        [self.CultivateTable reloadData];
        
        if (self.dateUp) {
            self.dateUp(@"控制器数据回调");
        }
        
        self.CultivateTable.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(100) * self.dataArr.count);
        [self hideLoadingView];
        
        
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FTCultivateTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTCultivateTableViewCell class]) owner:self options:nil].firstObject;
    }
    NYNCategoryPageModel *model = self.dataArr[indexPath.row];
    farmLiveTableViewCell.model = model;
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(100);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //养殖订单
//    NYNCultivateDetailViewController *vc = [[NYNCultivateDetailViewController alloc]init];
    
    NYNCategoryPageModel *model = self.dataArr[indexPath.row];
//
//    vc.ID = self.farmId;
//    vc.productID = model.ID;
//
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    NYNWantYangZhiViewController *vc = [[NYNWantYangZhiViewController alloc]init];
    vc.farmID =self.farmId;
    vc.yangzhiID = model.ID;
    vc.unitPrice = [model.price doubleValue];
    vc.unit = model.unitName;
    vc.proName = model.name;
    
    
//    NSMutableArray *rr = [[NSMutableArray alloc]init];
//    for (NSDictionary *dic in self.dataModel.productImages) {
//        [rr addObject:dic[@"imgUrl"]];
//    }
//
    
   // vc.picName = [rr firstObject];
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma 懒加载
-(UITableView *)CultivateTable
{
    //scroll  cellheight  table暂定1000

    if (!_CultivateTable) {
        _CultivateTable = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT/2, SCREENWIDTH, 300) style:UITableViewStylePlain];
//        _CultivateTable.userInteractionEnabled = NO;
    }
    return _CultivateTable;
}

//-(NSMutableArray *)dataArr{
//    if (!_dataArr) {
//        _dataArr = [[NSMutableArray alloc]init];
//    }
//    return  _dataArr;
//}
@end
