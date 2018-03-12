//
//  FTPayViewController.m
//  FarmerTreasure
//
//  Created by 123 on 2017/4/25.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import "FTPayViewController.h"

#import "FTPayOneTableViewCell.h"
#import "FTPayTwoTableViewCell.h"


@interface FTPayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *payTable;

@end

@implementation FTPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createpayTable];
    [self createDealBottom];

}

- (void)createpayTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.payTable.delegate = self;
    self.payTable.dataSource = self;
    self.payTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.payTable.showsVerticalScrollIndicator = NO;
    self.payTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.payTable];
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
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 3) {
        FTPayOneTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTPayOneTableViewCell class]) owner:self options:nil].firstObject;
        }
        return farmLiveTableViewCell;
    }else{
        FTPayTwoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTPayTwoTableViewCell class]) owner:self options:nil].firstObject;
        }
        return farmLiveTableViewCell;
    }


    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(41);
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
//    return headerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return section == 0 ?  0.0001 : 5;
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


#pragma table
-(UITableView *)payTable{
    if (!_payTable) {
        _payTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    }
    return _payTable;
}

- (void)createDealBottom{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45), SCREENWIDTH, JZHEIGHT(45))];
    [self.view addSubview:bottomView];
    
    //    UIImageView *imgV= [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(22), JZHEIGHT(13), JZWITH(21), JZHEIGHT(21))];
    //    imgV.image = PlaceImage;
    //    [bottomView addSubview:imgV];
    //    imgV.backgroundColor = BackGroundColor;
    
    NSString *price = @"12";
    NSString *lastPrice = [NSString stringWithFormat:@"合计：¥%@",price];
    
    CGFloat  lastPriceWith = [lastPrice boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, JZHEIGHT(45)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}  context:nil].size.width;
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, lastPriceWith, JZHEIGHT(45))];
    priceLabel.font = [UIFont systemFontOfSize:13];
    priceLabel.text = lastPrice;
    [bottomView addSubview:priceLabel];
    
    //    UIButton *jiarugouwuche = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(171), 0, JZWITH(85), JZHEIGHT(45))];
    //    jiarugouwuche.backgroundColor = KNaviBarTintColor;
    //    [jiarugouwuche setTitle:@"加入购物车" forState:0];
    //    [jiarugouwuche setTitleColor:[UIColor whiteColor] forState:0];
    //    jiarugouwuche.titleLabel.font = JZFont(12);
    //    [jiarugouwuche addTarget:self action:@selector(addGouwu) forControlEvents:UIControlEventTouchUpInside];
    //    [bottomView addSubview:jiarugouwuche];
    
    UIButton *lijizudi = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(85), 0, JZWITH(85), JZHEIGHT(45))];
    lijizudi.backgroundColor = KNaviBarTintColor;
    [lijizudi setTitle:@"立即租地" forState:0];
    [lijizudi setTitleColor:[UIColor whiteColor] forState:0];
    lijizudi.titleLabel.font = JZFont(12);
    [lijizudi addTarget:self action:@selector(goPay) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:lijizudi];
    
}


- (void)goPay{
    JZLog(@"付款");
    
}
@end
