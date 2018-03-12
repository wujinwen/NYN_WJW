//
//  NYNZhuSuViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNZhuSuViewController.h"
#import "NYNZhuSuTableViewCell.h"
#import "NYNZhuSuDetailViewController.h"

@interface NYNZhuSuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *ZhuSuTable;
@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation NYNZhuSuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createZhuSuTable];
    self.pageNo = 1;
    self.pageSize = 10;
//    NSDictionary *postDic = @{@"farmId":self.farmId,@"categoryId":self.categoryId,@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize]};
//    [NYNNetTool PageCategoryResquestWithparams:postDic isTestLogin:NO progress:^(NSProgress *progress) {
//        
//    } success:^(id success) {
//        JZLog(@"");
//    } failure:^(NSError *failure) {
//        
//    }];
//    
}

- (void)updateData{
    [self showLoadingView:@""];
    
    NSDictionary *postDic = @{@"farmId":self.farmId,@"categoryId":self.categoryId,@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize]};
    [NYNNetTool PageCategoryResquestWithparams:postDic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        [self.dataArr removeAllObjects];
        
        NSArray *arr = [NSArray arrayWithArray:success[@"data"]];
        for (NSDictionary *d in arr) {
            NYNCategoryPageModel *model = [NYNCategoryPageModel mj_objectWithKeyValues:d];
            [self.dataArr addObject:model];
        }
        [self.ZhuSuTable reloadData];
        JZLog(@"");
        
        if (self.dateUp) {
            self.dateUp(@"控制器数据回调");
        }
        self.ZhuSuTable.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(100) * self.dataArr.count);

        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}

- (void)createZhuSuTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.ZhuSuTable.delegate = self;
    self.ZhuSuTable.dataSource = self;
    self.ZhuSuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.ZhuSuTable.showsVerticalScrollIndicator = NO;
    self.ZhuSuTable.showsHorizontalScrollIndicator = NO;
    
    self.ZhuSuTable.scrollEnabled = YES;
    
    [self.view addSubview:self.ZhuSuTable];
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
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNZhuSuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNZhuSuTableViewCell class]) owner:self options:nil].firstObject;
    }
    NYNCategoryPageModel *model = self.dataArr[indexPath.row];
    farmLiveTableViewCell.model = model;
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(100);
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    //    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(40))];
//    headerView.backgroundColor = [UIColor whiteColor];
//
//    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(10))];
//    v.backgroundColor = BackGroundColor;
//    [headerView addSubview:v];
//
//    UIView *lienV = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(50) - 0.5, SCREENWIDTH, 0.5)];
//    lienV.backgroundColor = BackGroundColor;
//    [headerView addSubview:lienV];
//
//
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(24), JZWITH(150), JZHEIGHT(13))];
//    titleLabel.font = JZFont(13);
//    titleLabel.textColor = RGB56;
//
//
//    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(358), JZHEIGHT(25), JZWITH(7), JZHEIGHT(13))];
//
//    [headerView addSubview:titleLabel];
//    [headerView addSubview:imageV];
//
//    switch (section) {
//        case 0:
//        {
//            titleLabel.text = @"全部动物";
//        }
//            break;
//        case 1:
//        {
//            titleLabel.text = @"养殖套餐";
//
//        }
//            break;
//        case 2:
//        {
//            titleLabel.text = @"用户评价";
//
//        }
//            break;
//        default:
//            break;
//    }
//    return headerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return JZHEIGHT(50);
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
    NYNZhuSuDetailViewController *vc = [[NYNZhuSuDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma 懒加载
-(UITableView *)ZhuSuTable
{
    //scroll  cellheight  table暂定1000
    
    if (!_ZhuSuTable) {
        _ZhuSuTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
//        _ZhuSuTable.userInteractionEnabled = NO;

    }
    return _ZhuSuTable;
}


//-(NSMutableArray *)dataArr{
//    if (!_dataArr) {
//        _dataArr = [[NSMutableArray alloc]init];
//    }
//    return  _dataArr;
//}
@end
