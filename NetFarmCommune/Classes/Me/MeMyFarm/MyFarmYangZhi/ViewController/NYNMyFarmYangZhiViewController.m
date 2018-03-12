//
//  NYNMyFarmYangZhiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/24.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMyFarmYangZhiViewController.h"
#import "NYNMyFarmTuDiZiLiaoTableViewCell.h"
#import "NYNMyFarmTuDiZiLiaoModel.h"
#import "NYNMyFarmTuDiZengSongViewController.h"
@interface NYNMyFarmYangZhiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myFarmZhongTable;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NYNMyFarmTuDiZiLiaoModel *model;

@end

@implementation NYNMyFarmYangZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.vcName;
    
    self.titleArr = @[@[@"档案编号",@"动物编号"],@[@"养殖动物",@"动物单价",@"动物归属",@"养殖地址"],@[@"动物名片",@"执行管家"]];
    [self setTable];
    
    UIButton *zengSong = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(46) - 64, SCREENWIDTH, JZHEIGHT(46))];
    [zengSong setTitle:@"把动物赠送给好友" forState:0];
    zengSong.backgroundColor = Color90b659;
    [zengSong setTitleColor:[UIColor whiteColor] forState:0];
    zengSong.titleLabel.font = JZFont(14);
    [zengSong addTarget:self action:@selector(zengsong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zengSong];
    
    [self showLoadingView:@""];
    [NYNNetTool MyFarmSearchTuDiZiLiaoWithparams:self.oderId isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            NYNMyFarmTuDiZiLiaoModel *model = [NYNMyFarmTuDiZiLiaoModel mj_objectWithKeyValues:success[@"data"]];
            self.model = model;
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self.myFarmZhongTable reloadData];
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
        
    }];
    
}

- (void)setTable{
    [self.view addSubview:self.myFarmZhongTable];
    self.myFarmZhongTable.delegate = self;
    self.myFarmZhongTable.dataSource = self;
    self.myFarmZhongTable.showsVerticalScrollIndicator = NO;
    self.myFarmZhongTable.showsHorizontalScrollIndicator = NO;
    self.myFarmZhongTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 4;
        }
            break;
        case 2:
        {
            return 2;
        }
            break;
        default:
        {
            return 0;
        }
            break;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNMyFarmTuDiZiLiaoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmTuDiZiLiaoTableViewCell class]) owner:self options:nil].firstObject;
    }
    farmLiveTableViewCell.titleLabel.text = self.titleArr[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            farmLiveTableViewCell.detailLabel.text = self.model.orderSn;
            
        }else{
            farmLiveTableViewCell.detailLabel.text = self.model.majorProductSn;
            
        }
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            farmLiveTableViewCell.detailLabel.text = [NSString stringWithFormat:@"%@㎡",self.model.majorProductQuantity];
            
        }else if (indexPath.row == 1){
            farmLiveTableViewCell.detailLabel.text = [NSString stringWithFormat:@"¥%@/㎡/天",self.model.majorProductPrice];
            
        }else if (indexPath.row == 2){
            farmLiveTableViewCell.detailLabel.text = self.model.farmName;
            
        }else{
            farmLiveTableViewCell.detailLabel.text = self.model.farmAddress;
            
        }
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            farmLiveTableViewCell.detailLabel.text = self.model.majorProductName;
            
        }else{
            farmLiveTableViewCell.detailLabel.text = self.model.managerName;
            
        }
    }
    
    
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(46);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, section == 0 ? 0.00001 : JZHEIGHT(11))];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.00001)];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0.00001 : JZHEIGHT(11);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)myFarmZhongTable{
    if (!_myFarmZhongTable) {
        _myFarmZhongTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(46)) style:UITableViewStyleGrouped];
    }
    return _myFarmZhongTable;
}


- (void)zengsong{
    JZLog(@"将土地赠送给好友");
    NYNMyFarmTuDiZengSongViewController *vc = [[NYNMyFarmTuDiZengSongViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
