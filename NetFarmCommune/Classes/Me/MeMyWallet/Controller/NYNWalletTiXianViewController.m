//
//  NYNWalletTiXianViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/14.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNWalletTiXianViewController.h"
#import "NYNMeChongZhiTableViewCell.h"
#import "NYNWalletChooseModel.h"
#import "NYNChooseAndPayViewController.h"

@interface NYNWalletTiXianViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *WalletTiXiantable;
@property (nonatomic,strong) NSMutableArray *modelArr;

@end

@implementation NYNWalletTiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 2; i++) {
        NYNWalletChooseModel *model = [[NYNWalletChooseModel alloc]init];
        if (i == 0) {
            model.iconName = @"mine_icon_zhifubao";
            model.contentStr = @"支付宝";
            model.isChoose = NO;
        }
        if (i == 1) {
            model.iconName = @"mine_wx";
            model.contentStr = @"微信";
            model.isChoose = NO;
        }

        [self.modelArr addObject:model];
    }
    
    self.title = @"提现";
    
    [self createTable];
}

- (void)createTable{
    [self.view addSubview:self.WalletTiXiantable];
    self.WalletTiXiantable.showsHorizontalScrollIndicator = NO;
    self.WalletTiXiantable.showsVerticalScrollIndicator = NO;
    self.WalletTiXiantable.delegate = self;
    self.WalletTiXiantable.dataSource = self;
    self.WalletTiXiantable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.WalletTiXiantable.backgroundColor = Colore3e3e3;
    self.WalletTiXiantable.scrollEnabled = NO;
    
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46 + 11))];
//    headerView.backgroundColor = Colore3e3e3;
//    
//    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46))];
//    topView.backgroundColor = [UIColor whiteColor];
//    [headerView addSubview:topView];
//    
//    UILabel *jineLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), 0, JZWITH(40), topView.height)];
//    jineLabel.text = @"金额";
//    jineLabel.font = JZFont(13);
//    jineLabel.textColor = [UIColor blackColor];
//    [topView addSubview:jineLabel];
//    
//    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(jineLabel.right + JZWITH(30), 0, JZWITH(150), topView.height)];
//    tf.placeholder = @"请输入充值金额";
//    tf.font = JZFont(13);
//    [topView addSubview:tf];
//    
//    self.WalletTiXiantable.tableHeaderView  = headerView;
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46))];
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH - 20, JZHEIGHT(46))];
    tishiLabel.text = @"提示：提现后将在24小时内到账";
    tishiLabel.font = JZFont(12);
    tishiLabel.textColor = Color888888;
    [footerView addSubview:tishiLabel];
    self.WalletTiXiantable.tableFooterView = footerView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeChongZhiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeChongZhiTableViewCell class]) owner:self options:nil].firstObject;
    }
    NYNWalletChooseModel *model = self.modelArr[indexPath.section];
    
        farmLiveTableViewCell.chooseImageView.hidden= YES;
        farmLiveTableViewCell.iconImageView.image = Imaged(model.iconName);
        farmLiveTableViewCell.contentLabel.text = model.contentStr;

    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(46);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, section == 0 ? 0.00001 : JZHEIGHT(11))];
    headerView.backgroundColor = Colore3e3e3;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0.00001 : JZHEIGHT(11);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NYNChooseAndPayViewController *vc = [[NYNChooseAndPayViewController alloc]init];
        vc.chooseMethodStr = @"选择支付宝";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NYNChooseAndPayViewController *vc = [[NYNChooseAndPayViewController alloc]init];
        vc.chooseMethodStr = @"选择为你心";

        [self.navigationController pushViewController:vc animated:YES];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)WalletTiXiantable{
    if (!_WalletTiXiantable) {
        _WalletTiXiantable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 ) style:UITableViewStylePlain];
    }
    return _WalletTiXiantable;
}

-(NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [[NSMutableArray alloc]init];
    }
    return _modelArr;
}

@end
