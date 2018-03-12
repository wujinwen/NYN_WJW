//
//  NYNCollectionBiSaiViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNCollectionBiSaiViewController.h"
#import "NYNMeBiSaiTableViewCell.h"

@interface NYNCollectionBiSaiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *BiSaiTable;
@end

@implementation NYNCollectionBiSaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.BiSaiTable];
    self.BiSaiTable.delegate = self;
    self.BiSaiTable.dataSource = self;
    self.BiSaiTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.BiSaiTable.showsVerticalScrollIndicator = NO;
    self.BiSaiTable.showsHorizontalScrollIndicator = NO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        NYNMeBiSaiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeBiSaiTableViewCell class]) owner:self options:nil].firstObject;
        }
        return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(101);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(11))];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return JZHEIGHT(11);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(0.0001))];
    v.backgroundColor = Colore3e3e3;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return JZHEIGHT(0.0001);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)BiSaiTable{
    if (!_BiSaiTable) {
        _BiSaiTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44 - 64) style:UITableViewStylePlain];
    }
    return  _BiSaiTable;
}
@end
