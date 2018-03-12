//
//  NYNBaoXianGouMaiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNBaoXianGouMaiViewController.h"
#import "NYNBaoXianTableViewCell.h"
#import "NYNGouMaiBaoXianModel.h"

@interface NYNBaoXianGouMaiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *chooseChanPinTable;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation NYNBaoXianGouMaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"保险购买";
    
    for (int i = 0; i < 10; i++) {
        NYNGouMaiBaoXianModel *model = [[NYNGouMaiBaoXianModel alloc]init];
        [self.dataArr addObject:model];
    }
    
    [self createchooseChanPinTable];
    
}
- (void)createchooseChanPinTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.chooseChanPinTable.delegate = self;
    self.chooseChanPinTable.dataSource = self;
    self.chooseChanPinTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chooseChanPinTable.showsVerticalScrollIndicator = NO;
    self.chooseChanPinTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.chooseChanPinTable];
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
    NYNBaoXianTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNBaoXianTableViewCell class]) owner:self options:nil].firstObject;
    }
    
    NYNGouMaiBaoXianModel *model = self.dataArr[indexPath.section];
    
    if (model.isChoose) {
        farmLiveTableViewCell.chooseImageView.image = [UIImage imageNamed:@"farm_icon_selected4"];
    }else{
        farmLiveTableViewCell.chooseImageView.image = [UIImage imageNamed:@"farm_icon_notselected3"];
        
    }
    
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(157);
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
    
    NYNGouMaiBaoXianModel *model = self.dataArr[indexPath.section];
    model.isChoose = !model.isChoose;
    
    NSIndexSet *ss = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.chooseChanPinTable reloadSections:ss withRowAnimation:UITableViewRowAnimationNone];
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
