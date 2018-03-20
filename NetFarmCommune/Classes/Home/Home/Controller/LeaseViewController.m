//
//  LeaseViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "LeaseViewController.h"
#import "LeaseTableViewCell.h"
#import "NYNFarmChooseButton.h"
#import "NYNActivityModel.h"
#import "NYNLeaseDeController.h"

#import "LeaseTuTableViewCell.h"
@interface LeaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *uppics;
@property (nonatomic,strong) NSArray *selectUppics;
@property (nonatomic,strong) NSArray *selectDownpics;

@property(nonatomic,strong)UITableView * leaseTableView;

@property(nonatomic,strong)NSMutableArray *btArr;
@property (nonatomic,assign) int pageNo;

@property(nonatomic,strong)NSMutableArray * leaseArray;

@end

@implementation LeaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
      _pageNo = 1;
    [self configData];

    [self.view addSubview:self.leaseTableView];
    [self creatHeadTitle];
    
    [self activityListData:@"normal" orderBy:@"asc"];
}

-(void)configData{
    self.titles = @[@"综合排序",@"价格",@"面积",@"距离"];
    self.uppics = @[@"",@"farm_icon_screen1",@"farm_icon_screen1",@"farm_icon_screen1"];
    self.selectUppics = @[@"",@"farm_icon_screen3",@"farm_icon_screen3",@"farm_icon_screen3"];
    self.selectDownpics = @[@"",@"farm_icon_screen4",@"farm_icon_screen4",@"farm_icon_screen4"];
}
- (void)clickBT:(NYNFarmChooseButton *)sender{
    if (sender.indexFB == 3) {
        
    }else{
        for (int i = 0; i < self.btArr.count; i++) {
            if (i == 3) {
                continue;
            }
            
            NYNFarmChooseButton *bt = self.btArr[i];
            
            bt.textLabel.textColor = Color686868;
            
            bt.picImageView.image = Imaged(self.uppics[i]);
        }
        sender.textLabel.textColor = Color90b659;
    }
    //清空数据
    switch (sender.indexFB) {
        case 0:
        {
                sender.isAsc = !sender.isAsc;
            if (sender.isAsc) {
               [self activityListData:@"normal" orderBy:@"asc"];
                
            }else{
                 [self activityListData:@"normal" orderBy:@"desc"];
            }
            
        }
            break;
            
            
        case 1:
        {
            sender.isAsc = !sender.isAsc;
            if (sender.isAsc) {
                sender.picImageView.image = Imaged(self.uppics[1]);
                [self activityListData:@"price" orderBy:@"asc"];
                
            }else{
                sender.picImageView.image = Imaged(self.selectDownpics[1]);
                
                [self activityListData:@"price" orderBy:@"desc"];
            }
            
        }
            
            break;
        case 2:
        {
            sender.isAsc = !sender.isAsc;
            if (sender.isAsc) {
                sender.picImageView.image = Imaged(self.uppics[2]);
                
                [self activityListData:@"stock" orderBy:@"asc"];
            }else{
                sender.picImageView.image = Imaged(self.selectDownpics[2]);
                
                [self activityListData:@"stock" orderBy:@"desc"];
                
            }
        }
            
            break;
            
        case 3:
        {
            sender.isAsc = !sender.isAsc;
            if (sender.isAsc) {
                sender.picImageView.image = Imaged(self.selectUppics[3]);
                
                [self activityListData:@"position" orderBy:@"asc"];
            }else{
                sender.picImageView.image = Imaged(self.selectDownpics[3]);
                [self activityListData:@"position" orderBy:@"desc"];
                
            }
        }
            break;
            
            
        default:
            break;
    }
}

//租地列表
-(void)activityListData:(NSString*)orderType orderBy:(NSString*)orderBy{
//    UserInfoModel * model = userInfoModel;
    [self.leaseArray removeAllObjects];
    self.bakcView.hidden = YES;
    NSDictionary * locDic =JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"];
    NSString *lon = locDic[@"lon"];
    NSMutableDictionary *dic = @{@"longitude":lon,
                                 @"latitude":lat,
                                 @"sort":orderType,
                                 @"pageNo":[NSString stringWithFormat:@"%d",_pageNo],
                                 @"pageSize":@"10",
                                 @"orderBy":orderBy}.mutableCopy;
    [NYNNetTool EnterpriseWithparams:dic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"] && [[NSArray arrayWithArray:success[@"data"]] count]>0) {
            
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNActivityModel *model = [NYNActivityModel mj_objectWithKeyValues:dic];
                [self.leaseArray addObject:model];
            }
        }else{
            self.bakcView.hidden = NO;
            [self.leaseTableView addSubview:self.bakcView];
        }
        [self.leaseTableView reloadData];
    } failure:^(NSError *failure) {
        
    }];
}
-(void)creatHeadTitle{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 36, SCREENWIDTH, 40)];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:backView];
    UIView *selecteBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 38)];
    selecteBackView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:selecteBackView];
    selecteBackView.clipsToBounds = NO;
    
    CGFloat btWith = SCREENWIDTH / 4;
    for (int i = 0; i < 4; i ++) {
        NYNFarmChooseButton *bt =[[NYNFarmChooseButton alloc]initWithFrame:CGRectMake(0 + btWith * i, 0, btWith, selecteBackView.height)];
        bt.textLabel.text = self.titles[i];
        bt.picImageView.image = Imaged(self.uppics[i]);
        bt.indexFB = i;
        [bt addTarget:self action:@selector(clickBT:) forControlEvents:UIControlEventTouchUpInside];
        [selecteBackView addSubview:bt];
        if (i == 0) {
            bt.textLabel.textColor = Color90b659;
            bt.picImageView.image = Imaged(self.selectUppics[i]);
        }
        [self.btArr addObject:bt];
    }
}

#pragma mark--UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _leaseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LeaseTuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LeaseTuTableViewCell class]) owner:self options:nil].firstObject;
    }
    cell.model = _leaseArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNLeaseDeController *vc = [[NYNLeaseDeController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    NYNActivityModel *model = _leaseArray[indexPath.row];
    vc.ID = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)leaseTableView{
    if (!_leaseTableView) {
        _leaseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+34, SCREENWIDTH, SCREENHEIGHT-64-49-(40+34+10)) style:UITableViewStylePlain];//SCREENHEIGHT - 64 - 50-40
        _leaseTableView.delegate=self;
        _leaseTableView.dataSource=self;
        _leaseTableView.rowHeight= 110;
        _leaseTableView.tableFooterView=[[UIView alloc]init];
    }
    return _leaseTableView;
}

-(NSMutableArray *)btArr{
    if (!_btArr) {
        _btArr = [[NSMutableArray alloc]init];
    }
    return _btArr;
    
}

-(NSMutableArray *)leaseArray{
    if (!_leaseArray) {
        _leaseArray = [[NSMutableArray alloc]init];
    }
    return _leaseArray;
}

@end
