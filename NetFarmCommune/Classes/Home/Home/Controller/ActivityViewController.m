//
//  ActivityViewController.m
//  NetFarmCommune
//
//  Created by manager on 2017/12/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "ActivityViewController.h"
#import "NYNFarmChooseButton.h"
#import "ActivityTableViewCell.h"
#import "NYNActivityModel.h"
#import "NYNHuoDongViewController.h"

@interface ActivityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *uppics;
@property (nonatomic,strong) NSArray *selectUppics;
@property (nonatomic,strong) NSArray *selectDownpics;
//选择bt的数组
@property (nonatomic,strong) NSMutableArray *btArr;
@property(nonatomic,strong)UITableView * activityTBView;

@property (nonatomic,strong) NSMutableArray *activityArr;
@property (nonatomic,assign) int pageNo;
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configData];
    [self creatHeadTitle];
    self.title = @"活动";
    
    _pageNo = 1;
    [self activityListData:@"popularity" orderBy:@"asc"];
    
}


-(void)configData{
    self.titles = @[@"人气",@"最新",@"距离"];
    self.uppics = @[@"farm_icon_screen1",@"farm_icon_screen1",@"farm_icon_screen1"];
    self.selectUppics = @[@"farm_icon_screen3",@"farm_icon_screen3",@"farm_icon_screen3"];
    self.selectDownpics = @[@"farm_icon_screen4",@"farm_icon_screen4",@"farm_icon_screen4"];
    [self.view addSubview:self.activityTBView];
}

-(void)creatHeadTitle{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 36, SCREENWIDTH, JZHEIGHT(41 ))];
    backView.backgroundColor = Colore3e3e3;
    [self.view addSubview:backView];
    UIView *selecteBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(41 ))];
    selecteBackView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:selecteBackView];
    selecteBackView.clipsToBounds = NO;
    
    CGFloat btWith = SCREENWIDTH / 3;
    for (int i = 0; i < 3; i ++) {
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

//活动列表

-(void)activityListData:(NSString*)orderType orderBy:(NSString*)orderBy{
    [self.activityArr removeAllObjects];
    self.bakcView.hidden = YES;
    NSDictionary * locDic =JZFetchMyDefault(SET_Location);
    NSString *lat = locDic[@"lat"] ?: @"";
    NSString *lon =locDic[@"lon"] ?: @"";
    NSMutableDictionary *dic = @{@"longitude":lon,
                                 @"latitude":lat,
                                 @"orderType":orderType,
                                 @"pageNo":[NSString stringWithFormat:@"%d",_pageNo],
                                 @"pageSize":@"10",
                                 @"orderBy":@"asc"}.mutableCopy;
    [NYNNetTool ActivityListParams:dic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]&& [[NSArray arrayWithArray:success[@"data"]] count]>0) {
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNActivityModel *model = [NYNActivityModel mj_objectWithKeyValues:dic];
                [self.activityArr addObject:model];
            }
        }else{
            self.bakcView.hidden = NO;
            [self.activityTBView addSubview:self.bakcView];
        }
        [self.activityTBView reloadData];
        
    } failure:^(NSError *failure) {
        
    }];
}
#pragma mark---UITableViewDataSource,UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _activityArr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ActivityTableViewCell class]) owner:self options:nil].firstObject;
        
    }
    cell.model=_activityArr[indexPath.row];
    
    cell.selectionStyle = UITableViewCellStyleDefault;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNHuoDongViewController * VC = [[NYNHuoDongViewController alloc]init];
    VC.hidesBottomBarWhenPushed=YES;
    //传framid
    VC.ID = [_activityArr[indexPath.row] ID];
    
    [self.navigationController pushViewController:VC animated:YES];
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
            if (!sender.isAsc) {
                sender.picImageView.image = Imaged(self.uppics[0]);
                [self activityListData:@"popularity" orderBy:@"asc"];
                
            }else{
                sender.picImageView.image = Imaged(self.selectDownpics[0]);

                 [self activityListData:@"popularity" orderBy:@"desc"];
            }
            
        }
            
            break;
        case 1:
        {
            sender.isAsc = !sender.isAsc;
            if (!sender.isAsc) {
                sender.picImageView.image = Imaged(self.uppics[1]);
                [self activityListData:@"time" orderBy:@"asc"];
            }else{
                sender.picImageView.image = Imaged(self.selectDownpics[1]);
                
          [self activityListData:@"time" orderBy:@"desc"];
       
            }
        }
            
            break;
            
        case 2:
        {
            sender.isAsc = !sender.isAsc;
            if (!sender.isAsc) {
                   sender.picImageView.image = Imaged(self.selectUppics[2]);
             [self activityListData:@"position" orderBy:@"asc"];
            }else{
                sender.picImageView.image = Imaged(self.selectDownpics[2]);
                   [self activityListData:@"position" orderBy:@"desc"];
            
            }
        }
            break;
  
            
        default:
            break;
    }
}


-(UITableView *)activityTBView{
    if (!_activityTBView) {
        
        _activityTBView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, SCREENWIDTH, SCREENHEIGHT-60-40) style:UITableViewStylePlain];
        _activityTBView.delegate=self;
        _activityTBView.dataSource=self;
        _activityTBView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _activityTBView.separatorStyle = UITableViewCellSelectionStyleNone;
        _activityTBView.rowHeight = 100;
        
        
    }
    return _activityTBView;
    
}
-(NSMutableArray *)activityArr{
    if (!_activityArr) {
        _activityArr = [[NSMutableArray alloc]init];
        
    }
    return _activityArr;
    
}

-(NSMutableArray *)btArr{
    if (!_btArr) {
        _btArr =[[NSMutableArray alloc]init];
        
    }
    return _btArr;
    
}
@end
