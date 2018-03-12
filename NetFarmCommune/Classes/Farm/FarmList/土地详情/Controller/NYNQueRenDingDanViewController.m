//
//  NYNQueRenDingDanViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNQueRenDingDanViewController.h"
#import "NYNGouMaiView.h"
#import "NYNQueDingOneTableViewCell.h"
#import "NYNQueDingTwoTableViewCell.h"
#import "NYNQueDingThreeTableViewCell.h"
#import "NYNPayViewController.h"

@interface NYNQueRenDingDanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *queDingTable;
@property (nonatomic,strong) NYNGouMaiView *bottomView;
@end

@implementation NYNQueRenDingDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    
    self.queDingTable.delegate = self;
    self.queDingTable.dataSource = self;
    self.queDingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.queDingTable.showsVerticalScrollIndicator = NO;
    self.queDingTable.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.queDingTable];
    
    [self.view addSubview:self.bottomView];
    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"%.2f元",[self.model.amount doubleValue]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 + self.model.orderItems.count + 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NYNQueDingOneTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNQueDingOneTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        [farmLiveTableViewCell.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.picName] placeholderImage:PlaceImage];
        farmLiveTableViewCell.contentLabel.text = self.model.address;
        
        return farmLiveTableViewCell;
    }
    else if (indexPath.row > 0 && indexPath.row < self.model.orderItems.count + 1 ){
        NYNQueDingTwoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNQueDingTwoTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        NYNDealListModel *model = self.model.orderItems[indexPath.row  - 1];
        [farmLiveTableViewCell.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:PlaceImage];
        farmLiveTableViewCell.lbIOne.text = model.name;
        if (indexPath.row == 1) {
            farmLiveTableViewCell.lbTwo.text = [NSString stringWithFormat:@"租赁时长:%@天",model.rate];
            farmLiveTableViewCell.lbThree.text = [NSString stringWithFormat:@"租赁面积:%@㎡",model.quantity];
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.price doubleValue] * [model.rate doubleValue] * [model.quantity doubleValue]];
            
            if ([self.type isEqualToString:@"1"]) {
                farmLiveTableViewCell.lbTwo.hidden = YES;
                farmLiveTableViewCell.lbThree.text = [NSString stringWithFormat:@"养殖数量:%@㎡",model.quantity];
            }
        }
        else if (indexPath.row == 2) {
            farmLiveTableViewCell.lbThree.text = [NSString stringWithFormat:@"种子数量：%@颗",model.quantity];
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
            
            if ([self.type isEqualToString:@"1"]) {
                farmLiveTableViewCell.lbThree.hidden = YES;
            }
            
        }
        else {
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.price doubleValue] * [model.quantity intValue]];
            
            farmLiveTableViewCell.headerImageView.hidden = YES;
        }
        return farmLiveTableViewCell;
    }
//    else if (indexPath.row == 2){
//        NYNQueDingTwoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//        if (farmLiveTableViewCell == nil) {
//            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNQueDingTwoTableViewCell class]) owner:self options:nil].firstObject;
//        }
//        return farmLiveTableViewCell;
//    }
//    else if (indexPath.row == 3){
//        NYNQueDingThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//        if (farmLiveTableViewCell == nil) {
//            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNQueDingThreeTableViewCell class]) owner:self options:nil].firstObject;
//        }
//        return farmLiveTableViewCell;
//    }
    else {
        
        if (indexPath.row ==  1 + self.model.orderItems.count ) {
            NYNQueDingThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNQueDingThreeTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%@元",self.model.programTotalPrice];
            farmLiveTableViewCell.nameLabel.text = @"方案价格";
            return farmLiveTableViewCell;
        }else{
            NYNQueDingThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNQueDingThreeTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%@元",self.model.freight];
            farmLiveTableViewCell.nameLabel.text = @"运费";
            return farmLiveTableViewCell;
        }
        

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return JZHEIGHT(41);
    }
    if (indexPath.row > 0 && indexPath.row < self.model.orderItems.count + 1) {
        return JZHEIGHT(81);
    }
    else{
        return JZHEIGHT(41);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(UITableView *)queDingTable{
    if (!_queDingTable) {
        _queDingTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - 49) style:UITableViewStylePlain];
    }
    return _queDingTable;
}

-(NYNGouMaiView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NYNGouMaiView alloc]init];
        [_bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) - 64, SCREENWIDTH, JZHEIGHT(45))];
    }
    
    __weak typeof(self) weakSelf = self;
    _bottomView.gouwucheBlock = ^(NSString *strValue) {
        JZLog(@"111");
        NYNPayViewController *vc = [[NYNPayViewController alloc]init];
        vc.model = weakSelf.model;
        vc.totlePrice = weakSelf.model.amount ;
          vc.selectBool  =YES;
        vc.typeStr = weakSelf.type;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    _bottomView.goumaiBlock = ^(NSString *strValue) {
        JZLog(@"222");
        NYNPayViewController *vc = [[NYNPayViewController alloc]init];
        vc.model = weakSelf.model;
         vc.totlePrice = weakSelf.model.amount ;
        vc.selectBool  =YES;
        
        vc.typeStr = weakSelf.type;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    return _bottomView;
}
@end
