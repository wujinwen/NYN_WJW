//
//  FTFarmFlockViewController.m
//  FarmerTreasure
//
//  Created by 123 on 17/4/24.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTFarmFlockViewController.h"
#import "FTFarmFlockTableViewCell.h"

@interface FTFarmFlockViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *FarmFlockTable;

@end

@implementation FTFarmFlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createFarmFlock];

}

- (void)createFarmFlock{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.FarmFlockTable.delegate = self;
    self.FarmFlockTable.dataSource = self;
    self.FarmFlockTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.FarmFlockTable.showsVerticalScrollIndicator = NO;
    self.FarmFlockTable.showsHorizontalScrollIndicator = NO;
    
    self.FarmFlockTable.scrollEnabled = YES;
    
    [self.view addSubview:self.FarmFlockTable];
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FTFarmFlockTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTFarmFlockTableViewCell class]) owner:self options:nil].firstObject;
    }
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
    
}


#pragma 懒加载
-(UITableView *)FarmFlockTable
{
    //scroll  cellheight  table暂定1000
    
    if (!_FarmFlockTable) {
        _FarmFlockTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    }
    return _FarmFlockTable;
}

@end
