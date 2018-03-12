//
//  NYNMeMyWalletViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeMyWalletViewController.h"
#import "NYNWalletTableViewCell.h"
#import "NYNWalletDetailViewController.h"
#import "NYNWalletChongZhiViewController.h"
#import "NYNWalletTiXianViewController.h"
#import "NYNGouMaiWangNongBiViewController.h"

@interface NYNMeMyWalletViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *walletTable;
@end

@implementation NYNMeMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNav];
    
    [self createTable];
    

    
}

- (void)setNav{
    self.title = @"我的钱包";
    
    UIButton *mingziButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(30), JZHEIGHT(14))];
    [mingziButton setTitle:@"明细" forState:0];
    [mingziButton setTitleColor:[UIColor whiteColor] forState:0];
    mingziButton.titleLabel.font = JZFont(14);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:mingziButton];
    self.navigationItem.rightBarButtonItem =  item;
    
    [mingziButton addTarget:self action:@selector(kanMingXi) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)createTable{

    [self.view addSubview:self.walletTable];
    self.walletTable.delegate = self;
    self.walletTable.dataSource = self;
    self.walletTable.showsVerticalScrollIndicator = NO;
    self.walletTable.showsHorizontalScrollIndicator = NO;
    self.walletTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNWalletTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNWalletTableViewCell class]) owner:self options:nil].firstObject;
    }
    return farmLiveTableViewCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46) * 3)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *yueImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(11), JZHEIGHT(14), JZWITH(16), JZHEIGHT(16))];
    yueImageView.image = Imaged(@"mine_icon_balance");
    [headerView addSubview:yueImageView];
    
    UILabel *yueLabel = [[UILabel alloc]initWithFrame:CGRectMake(yueImageView.right + JZWITH(10), JZHEIGHT(17), JZWITH(80), JZHEIGHT(13))];
    yueLabel.textColor = Color252827;
    yueLabel.font = JZFont(14);
    yueLabel.text = @"我的余额";
    [headerView addSubview:yueLabel];
    
    UILabel *yueDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(yueLabel.right + JZWITH(20), JZHEIGHT(18), JZWITH(100), JZHEIGHT(11))];
    yueDetailLabel.text = @"200.00元";
    yueDetailLabel.font = JZFont(13);
    yueDetailLabel.textColor = Color686868;
    [headerView addSubview:yueDetailLabel];
    
    UIButton *yueTiXianButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10 + 46) * 2, JZHEIGHT(13), JZWITH(46), JZHEIGHT(21))];
    [yueTiXianButton setTitle:@"提现" forState:0];
    [yueTiXianButton setTitleColor:Colorfa9e19 forState:0];
    yueTiXianButton.backgroundColor = [UIColor whiteColor];
    yueTiXianButton.titleLabel.font = JZFont(12);
    yueTiXianButton.layer.borderWidth = .5;
    yueTiXianButton.layer.borderColor = Colorfa9e19.CGColor;
    [yueTiXianButton addTarget:self action:@selector(yueTiXianButtonClik:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:yueTiXianButton];
    
    
    UIButton *yueChongZhiButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10 + 46), JZHEIGHT(13), JZWITH(46), JZHEIGHT(21))];
    [yueChongZhiButton setTitle:@"充值" forState:0];
    [yueChongZhiButton setTitleColor:Colorfa9e19 forState:0];
    yueChongZhiButton.backgroundColor = [UIColor whiteColor];
    yueChongZhiButton.titleLabel.font = JZFont(12);
    yueChongZhiButton.layer.borderWidth = .5;
    yueChongZhiButton.layer.borderColor = Colorfa9e19.CGColor;
    [headerView addSubview:yueChongZhiButton];
    [yueChongZhiButton addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineOnde = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(45.5), SCREENWIDTH, .4)];
    lineOnde.backgroundColor = Colore3e3e3;
    [headerView addSubview:lineOnde];
    
    UIImageView *nongbiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(11), lineOnde.bottom + JZHEIGHT(14), JZWITH(16), JZHEIGHT(16))];
    nongbiImageView.image = Imaged(@"farm_icon_gold");
    [headerView addSubview:nongbiImageView];
    
    UILabel *nongbiLabel = [[UILabel alloc]initWithFrame:CGRectMake(nongbiImageView.right + JZWITH(10), lineOnde.bottom +JZHEIGHT(17), JZWITH(80), JZHEIGHT(13))];
    nongbiLabel.textColor = Color252827;
    nongbiLabel.font = JZFont(14);
    nongbiLabel.text = @"我的网农币";
    [headerView addSubview:nongbiLabel];
    
    UILabel *nongbiDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(nongbiLabel.right + JZWITH(20), lineOnde.bottom +JZHEIGHT(18), JZWITH(100), JZHEIGHT(11))];
    nongbiDetailLabel.text = @"3500个";
    nongbiDetailLabel.font = JZFont(13);
    nongbiDetailLabel.textColor = Color686868;
    [headerView addSubview:nongbiDetailLabel];
    
    
    UIButton *nongbiChongZhiButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10 + 46), lineOnde.bottom +JZHEIGHT(13), JZWITH(46), JZHEIGHT(21))];
    [nongbiChongZhiButton setTitle:@"提现" forState:0];
    [nongbiChongZhiButton setTitleColor:Colorfa9e19 forState:0];
    nongbiChongZhiButton.backgroundColor = [UIColor whiteColor];
    nongbiChongZhiButton.titleLabel.font = JZFont(12);
    nongbiChongZhiButton.layer.borderWidth = .5;
    nongbiChongZhiButton.layer.borderColor = Colorfa9e19.CGColor;
    [headerView addSubview:nongbiChongZhiButton];
    [nongbiChongZhiButton addTarget:self action:@selector(tixian) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineTwo = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(45.5 + 46), SCREENWIDTH, .4)];
    lineTwo.backgroundColor = Colore3e3e3;
    [headerView addSubview:lineTwo];
    
    UIImageView *jinquanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(11), lineTwo.bottom + JZHEIGHT(14), JZWITH(16), JZHEIGHT(16))];
    jinquanImageView.image = Imaged(@"farm_icon_cash");
    [headerView addSubview:jinquanImageView];
    
    UILabel* jinquanLabel = [[UILabel alloc]initWithFrame:CGRectMake(jinquanImageView.right + JZWITH(10), lineTwo.bottom +JZHEIGHT(17), JZWITH(80), JZHEIGHT(13))];
    jinquanLabel.textColor = Color252827;
    jinquanLabel.font = JZFont(14);
    jinquanLabel.text = @"我的代金券";
    [headerView addSubview:jinquanLabel];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return JZHEIGHT(46) * 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(130);
}
//提现按钮点击
-(void)yueTiXianButtonClik:(UIButton*)sender{
    
}
-(UITableView *)walletTable{
    if (!_walletTable) {
        _walletTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    }
    return _walletTable;
}

- (void)kanMingXi{
    NYNWalletDetailViewController *vc = [[NYNWalletDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)chongzhi{
    NYNWalletChongZhiViewController *vc = [[NYNWalletChongZhiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//NYNWalletTiXianViewController
- (void)tixian{
    NYNWalletTiXianViewController *vc = [[NYNWalletTiXianViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
