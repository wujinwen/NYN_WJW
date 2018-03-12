//
//  NYNCollectionNongJiaLeViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/18.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNCollectionNongJiaLeViewController.h"
#import "NYNMeNongJiaLeTableViewCell.h"
#import "NYNCollectionFarmModel.h"

@interface NYNCollectionNongJiaLeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageNo;
    int pageSize;
}
@property (nonatomic,strong) UITableView *NongJiaLeTable;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation NYNCollectionNongJiaLeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.NongJiaLeTable];
    self.NongJiaLeTable.delegate = self;
    self.NongJiaLeTable.dataSource = self;
    self.NongJiaLeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.NongJiaLeTable.showsVerticalScrollIndicator = NO;
    self.NongJiaLeTable.showsHorizontalScrollIndicator = NO;
    
    pageNo = 1;
    pageSize = 20;
    NSDictionary *dic = @{@"type":@"farm",@"pageNo":[NSString stringWithFormat:@"%d",pageNo],@"pageSize":[NSString stringWithFormat:@"%d",pageSize]};
    
    [self reFreshDataWithDic:dic];
    
}

- (void)reFreshDataWithDic:(NSDictionary *)dic{
    [self showLoadingView:@""];
    [NYNNetTool GetCollectionWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNCollectionFarmModel *model = [NYNCollectionFarmModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            
            [self.NongJiaLeTable reloadData];
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
        
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        NYNMeNongJiaLeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeNongJiaLeTableViewCell class]) owner:self options:nil].firstObject;
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

-(UITableView *)NongJiaLeTable{
    if (!_NongJiaLeTable) {
        _NongJiaLeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44 - 64) style:UITableViewStylePlain];
    }
    return  _NongJiaLeTable;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
@end
