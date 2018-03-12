//
//  NYNMeHelpViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/20.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeHelpViewController.h"
#import "NYNMeHelpTableViewCell.h"
#import "NYNMeYiJianFanKuiViewController.h"

@interface NYNMeHelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *shuoMingTable;
@end

@implementation NYNMeHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"帮助说明";
    
    UIButton *fanKuiYiJian = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(60), JZHEIGHT(14))];
    [fanKuiYiJian setTitle:@"意见反馈" forState:0];
    fanKuiYiJian.titleLabel.font = JZFont(14);
    UIBarButtonItem *ss = [[UIBarButtonItem alloc]initWithCustomView:fanKuiYiJian];
    self.navigationItem.rightBarButtonItem = ss;
    [fanKuiYiJian addTarget:self action:@selector(fankui) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.shuoMingTable];
    self.shuoMingTable.delegate = self;
    self.shuoMingTable.dataSource = self;
    self.shuoMingTable.showsVerticalScrollIndicator = NO;
    self.shuoMingTable.showsHorizontalScrollIndicator = NO;
    self.shuoMingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMeHelpTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeHelpTableViewCell class]) owner:self options:nil].firstObject;
    }
    return farmLiveTableViewCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(110);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
        return v;
    }else{
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(6))];
        return v;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }else{
        return JZHEIGHT(6);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)shuoMingTable{
    if (!_shuoMingTable) {
        _shuoMingTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStyleGrouped];
    }
    return _shuoMingTable;
}

- (void)fankui{
    NYNMeYiJianFanKuiViewController *vc = [[NYNMeYiJianFanKuiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
