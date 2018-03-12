//
//  NYNWalletDetailViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNWalletDetailViewController.h"
#import "NYNWalletDetailTableViewCell.h"
#import "NYNWalletChongZhiViewController.h"

@interface NYNWalletDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *walletDetail;
@end

@implementation NYNWalletDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"明细";
    
    [self createTable];
}

- (void)createTable{
    [self.view addSubview:self.walletDetail];
    self.walletDetail.delegate = self;
    self.walletDetail.dataSource = self;
    self.walletDetail.showsVerticalScrollIndicator = NO;
    self.walletDetail.showsHorizontalScrollIndicator = NO;
    self.walletDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNWalletDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNWalletDetailTableViewCell class]) owner:self options:nil].firstObject;
    }
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(61);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UITableView *)walletDetail{
    if (!_walletDetail) {
        _walletDetail = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    }
    return _walletDetail;
}
@end
