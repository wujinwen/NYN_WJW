//
//  NYNMarketViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/5/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMarketViewController.h"
#import "NYNJiShiDataModel.h"
#import "NYNLeiDataModel.h"
#import "NYNPinZhongDataModel.h"
#import "NYNJiShiHeaderView.h"
#import "NYNMarketTableViewCell.h"
#import "NYNZiJiZhongViewController.h"

#import "NYNMarketCagoryModel.h"
#import "NYNMarketListModel.h"
#import "GoodsDealVController.h"

@interface NYNMarketViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *jiShiTable;
@property (nonatomic,strong) NYNJiShiDataModel *marketModel;

@property (nonatomic,strong) NSMutableArray *titleCategoryArray;

@property (nonatomic,strong) NYNMarketCagoryModel *nowSelectModel;

@property (nonatomic,strong) NSMutableDictionary *postDic;

@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageSize;


@property(nonatomic,strong)NSString * farmString;//传给自己种界面



@property (nonatomic,strong) NSMutableArray *dataListArr;//cell个数
@end

@implementation NYNMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"集市";
    
    //初始化数据
    self.pageNo = 1;
    self.pageSize = 10;
    
    [self showLoadingView:@""];
    //集市分类
    [NYNNetTool GetJiShiCategoryWithparams:@{} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
//        NYNMarketCagoryModel
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            [self.titleCategoryArray removeAllObjects];
            
            NSMutableArray *arr = [NSMutableArray arrayWithArray:success[@"data"]];
            self.titleCategoryArray = [NYNMarketCagoryModel mj_objectArrayWithKeyValuesArray:arr];
//            for (NSDictionary *dic in arr) {
//                NYNMarketCagoryModel *model = [NYNMarketCagoryModel mj_objectWithKeyValues:dic];
//                [self.titleCategoryArray addObject:model];
//            }
            NYNMarketCagoryModel *fDmodel = [self.titleCategoryArray firstObject];
//            fDmodel.children = fDmodel.productCategories;
            for (NYNMarketCagoryModel * model in self.titleCategoryArray) {
                if (model.productCategories.count > 0) {
                    model.productCategories = [NYNMarketCagoryModel mj_objectArrayWithKeyValuesArray:model.productCategories];
                }
            }
           
            self.nowSelectModel =  [NYNMarketCagoryModel mj_objectWithKeyValues:[fDmodel.productCategories firstObject]];
            
            [self createUI];
            
//
            NSDictionary * locDic = JZFetchMyDefault(SET_Location);
            NSString *lat = locDic[@"lat"] ?: @"";
            NSString *lon =locDic[@"lon"] ?: @"";
            self.postDic = @{@"categoryId":self.nowSelectModel.ID,
                             @"orderType":@"normal",
                             @"orderBy":@"asc",
                             @"longitude":lon?:@"",
                             @"latitude":lat?:@"",
                             @"onlyPreSale":@0,
                             @"pageNo":@(self.pageNo),
                             @"pageSize":@(self.pageSize),
                             }.mutableCopy;
            //调用集市数据
            [self reloadTablewithDic:self.postDic];
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
    }];
}
//停止刷新
- (void)endrefresh{

    [self.jiShiTable.mj_footer endRefreshing];
    [self.jiShiTable.mj_header endRefreshing];

}

- (void)reloadTablewithDic:(NSDictionary *)dic{
    
    [self showLoadingView:@""];
    //查询集市产品
    [NYNNetTool ChaXunMarketDataWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {

    } success:^(id success) {
        NSLog(@"%@",success);
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                 _farmString =success[@"data"][0][@"name"];
                NYNMarketListModel *model = [NYNMarketListModel mj_objectWithKeyValues:dic];
               
                //添加数据
                [self.dataListArr addObject:model];
            
            }
            //刷新数据
            [self.jiShiTable reloadData];
            
            [self endrefresh];
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
    }];
}

- (void)createUI{
    [self.view addSubview:self.jiShiTable];
    self.jiShiTable.delegate = self;
    self.jiShiTable.dataSource = self;
    self.jiShiTable.showsHorizontalScrollIndicator = NO;
    self.jiShiTable.showsVerticalScrollIndicator = NO;
    self.jiShiTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NYNJiShiHeaderView *v = [[NYNJiShiHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(130))];
    //这里给数据
    v.marketModel.titleArr = self.titleCategoryArray;
    //这里开始界面创建
    [v gogo];
    __weak typeof(v)weakv = v;
    __weak typeof(self)weakSelf = self;
    v.didMoreClick = ^(BOOL isMore) {
        if (isMore) {
            [UIView animateWithDuration:0.5 animations:^{
                weakv.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(141+41));
//                weakSelf.jiShiTable.tableHeaderView = weakv;
                weakSelf.jiShiTable.frame = CGRectMake(0, JZHEIGHT(141+41), SCREENWIDTH, SCREENHEIGHT - 50 - 64 - JZHEIGHT(182));
                
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                weakv.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(130));
//                weakSelf.jiShiTable.tableHeaderView = weakv;
                weakSelf.jiShiTable.frame = CGRectMake(0, JZHEIGHT(130), SCREENWIDTH, SCREENHEIGHT - 50 - 64 - JZHEIGHT(130));

            }];
        }
    };
    
    
    v.backModelClick = ^(NYNMarketCagoryModel *model ,NSInteger indexPath) {
        
        [self.dataListArr removeAllObjects];
        self.pageNo = 1;
        
        //这里回传模型
        [weakSelf.postDic setObject:model.ID forKey:@"categoryId"];
        [weakSelf.postDic setObject:@(self.pageNo) forKey:@"pageNo"];
        [weakSelf.postDic setObject:@(self.pageSize) forKey:@"pageSize"];

        [self.dataListArr removeAllObjects];
        [weakSelf reloadTablewithDic:self.postDic];
        _farmString=model.name;
        

    };
    
    v.categoryClick = ^(NYNMarketCagoryModel *model) {
        [self.dataListArr removeAllObjects];
        
        
        self.pageNo = 1;
        
        //这里回传模型
        
        [weakSelf.postDic setObject:@(self.pageNo) forKey:@"pageNo"];
        [weakSelf.postDic setObject:@(self.pageSize) forKey:@"pageSize"];
         [weakSelf.postDic setObject:model.ID forKey:@"categoryId"];
        
        [self.dataListArr removeAllObjects];
        [weakSelf reloadTablewithDic:self.postDic];
    };
    
    v.paiXuClick = ^(NSMutableDictionary *dic) {
        
        [weakSelf.postDic setObject:dic[@"onlyPreSale"] forKey:@"onlyPreSale"];

        if ([[NSString stringWithFormat:@"%@",dic[@"orderType"]] isEqualToString:@"yushou"]) {
            
        }else{
            [weakSelf.postDic setObject:dic[@"orderType"] forKey:@"orderType"];
            [weakSelf.postDic setObject:dic[@"orderBy"] forKey:@"orderBy"];

        }
        
        [self.dataListArr removeAllObjects];
        [weakSelf reloadTablewithDic:self.postDic];
    };
    
//    self.jiShiTable.tableHeaderView = v;
    
    [self.view addSubview:v];
    
    UIImageView *zijiZhogIV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(15 + 61), JZHEIGHT(489), JZWITH(61), JZHEIGHT(61))];
    zijiZhogIV.image = Imaged(@"market_button1_2");
    [self.view addSubview:zijiZhogIV];
    zijiZhogIV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ziJiZhong)];;
    [zijiZhogIV addGestureRecognizer:tap];
    
    self.jiShiTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.dataListArr removeAllObjects];
        
        self.pageNo = 1;
        [self.postDic setObject:@(self.pageNo) forKey:@"pageNo"];
        [self.postDic setObject:@(self.pageSize) forKey:@"pageSize"];
        
        [self reloadTablewithDic:self.postDic];
        
    }];
    
    self.jiShiTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNo = 1 + self.pageNo;
        [self.postDic setObject:@(self.pageNo) forKey:@"pageNo"];
        [self.postDic setObject:@(self.pageSize) forKey:@"pageSize"];
        
        [weakSelf reloadTablewithDic:self.postDic];
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//NYNMarketTableViewCell
    NYNMarketTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMarketTableViewCell class]) owner:self options:nil].firstObject;
    }
    if (self.dataListArr.count>0) {
        NYNMarketListModel *model = self.dataListArr[indexPath.row];
        farmLiveTableViewCell.maketModel = model;
        
        if ([model.saleType isEqualToString:@"PRESALE"]) {
            
        }else{
            farmLiveTableViewCell.yuShouLabel.hidden = YES;
        }

    }

 
    return farmLiveTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JZHEIGHT(101);
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      NYNMarketListModel *model = self.dataListArr[indexPath.row];
    //点击进去商品订单
    GoodsDealVController * goodsVC = [[GoodsDealVController alloc]init];
    goodsVC.productId =model.ID;
    goodsVC.farmId = model.farmId;
    
     goodsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodsVC animated:YES];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 60;
    }
    return 0;
    
}


- (UITableView *)jiShiTable{
    if (!_jiShiTable) {
        _jiShiTable = [[UITableView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(130), SCREENWIDTH, SCREENHEIGHT - 50 - 64 - JZHEIGHT(130)) style:UITableViewStylePlain];
    }
    return _jiShiTable;
}

//懒加载
-(NYNJiShiDataModel *)marketModel{
    if (!_marketModel) {
        _marketModel = [[NYNJiShiDataModel alloc]init];
        
        NSArray *titleArr = @[@"蔬菜",@"肉类",@"水产",@"瓜果",@"花草"];
        NSArray *categoryArr = @[@[@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜",@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜",@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜"],@[@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜",@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜",@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜"],@[@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜",@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜",@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜"],@[@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜",@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜",@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜"],@[@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜",@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜",@"大白菜",@"卷心菜",@"瓜果菜",@"黑三彩",@"IOS菜"]];

        
        
        for (int i = 0; i < titleArr.count; i++) {
            NSString *leiName = titleArr[i];
            NYNLeiDataModel *leiModel = [[NYNLeiDataModel alloc]init];
            leiModel.LeiName = leiName;
            [_marketModel.titleArr addObject:leiModel];
            
            NSArray *cateArr = categoryArr[i];
            
            for (int j = 0; j < cateArr.count; j++) {
                NSString *pinName = cateArr[j];
                NYNPinZhongDataModel *pinModel = [[NYNPinZhongDataModel alloc]init];
                pinModel.pinName = pinName;
                
                [leiModel.leiArr addObject:pinModel];
            }

        }
    }
    return _marketModel;
}


- (void)ziJiZhong{
    JZLog(@"自己种");
    
    NYNZiJiZhongViewController *vc = [NYNZiJiZhongViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.nameString =_farmString;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSMutableArray *)titleCategoryArray{
    if (!_titleCategoryArray) {
        _titleCategoryArray = [[NSMutableArray alloc]init];
    }
    return _titleCategoryArray;
}

-(NSMutableDictionary *)postDic{
    if (!_postDic) {
        _postDic = [[NSMutableDictionary alloc]init];
    }
    return _postDic;
}


- (NSMutableArray *)dataListArr{
    if (!_dataListArr) {
        _dataListArr = [[NSMutableArray alloc]init];
    }
    return _dataListArr;
}
@end
