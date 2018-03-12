//
//  NYNFarmViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/5/31.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNFarmViewController.h"
#import "FTFarmListTableViewCell.h"
#import "NYNFarmChooseButton.h"
#import "NYNFarmCellModel.h"
#import "FTEarthDetailViewController.h"
#import "FTWisdomFarmViewController.h"
#import "NYNSrollSelectButton.h"

#import "PersonalCenterVC.h"
#import "NYNiConModel.h"
#import "FTNavigationViewController.h"
#import "FTLoginViewController.h"
#import "ShopSelectView.h"
#import "FTSearchViewController.h"

@interface NYNFarmViewController ()<UITableViewDelegate,UITableViewDataSource,ShopSelectViewDelagate>

{
    NSString * type;
}
@property (nonatomic,strong) UITableView *farmTable;

@property (nonatomic,strong) NSMutableArray *farmDataArr;

//1开始
@property (nonatomic,assign) int pageNo;

//1-100
@property (nonatomic,assign) int pageSize;

//当前选择
@property (nonatomic,assign) int selectIndex;

//选择bt的数组
@property (nonatomic,strong) NSMutableArray *btArr;

@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *uppics;
@property (nonatomic,strong) NSArray *downpics;
@property (nonatomic,strong) NSArray *selectUppics;
@property (nonatomic,strong) NSArray *selectDownpics;

@property (nonatomic,strong) NSMutableDictionary *postDic;

//选择view
@property (nonatomic,strong) UIView *selecteBackView;
@property (nonatomic,strong) UIView *backView;

//下部滑动scollView
@property (nonatomic,strong) UIScrollView *scrollViewBack;

//高级里面的数据数组
@property (nonatomic,strong) NSMutableArray *bannerSelectDataArr;

//低级选项的button数组   全部 种植  养殖 这些
@property (nonatomic,strong) NSMutableArray *ziCellButtonArr;
@property(nonatomic,strong)UILabel *  cityNameLabel;

@property(nonatomic,strong)ShopSelectView * shopView;

@property(nonatomic,strong) UIButton * zhuansuFarmBTN;

@property(nonatomic,strong)NYNFarmChooseButton *zhuanshuBtn;




@end

@implementation NYNFarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self configData];

     [self createHomeUI];
    [self showLoadingView:@""];
    [NYNNetTool BusinessResquestWithparams:@{} isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            //主营数据
            self.bannerSelectDataArr = [NSMutableArray arrayWithArray:success[@"data"]];
            [self configData];
            
//            NSDictionary *locationDic = JZFetchMyDefault(@"location");
            NSDictionary * locDic = JZFetchMyDefault(SET_Location);
            NSString *lat = locDic[@"lat"] ?: @"";
            NSString *lon =locDic[@"lon"] ?: @"";
            NSString *province = locDic[@"province"] ?: @"";
            NSString *city = locDic[@"city"] ?: @"";
            
//
//            NSString *province = userModel.location[@"province"] ?: @"";
//            NSString *city = userModel.location[@"city"] ?: @"";
            
            NSDictionary *dic = @{@"longitude":lon?:@"",@"latitude":lat?:@"",@"sort":@"normal",@"pageNo":[NSString stringWithFormat:@"%d",self.pageNo],@"pageSize":[NSString stringWithFormat:@"%d",self.pageSize],@"province":province,@"city":city,@"orderBy":@"asc"};
            
            self.postDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
            NSString * str =self.bannerSelectDataArr[0][@"twoChildren"][0][@"id"];
            
            
            [self.postDic setObject:str forKey:@"categoryId"];

            [self getFarmPageDataWithDic:self.postDic type:@"farm"];
            
            [self createHomeUI];
            
            [self createTable];
                [self setNav];
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];

    }];
}



#pragma mark--ShopSelectViewDelagate 导航栏左侧按钮点击
-(void)selectCellClick:(NSString * )str selectID:(NSString*)selectID selectIndex:(NSString *)selectIndex{
    if ([str isEqualToString:@"生态农业"]) {
        _scrollViewBack.frame=CGRectMake(0, JZHEIGHT(0), SCREENWIDTH-JZWITH(140), JZHEIGHT(41));
    }else{
          _scrollViewBack.frame=CGRectMake(0, JZHEIGHT(0), SCREENWIDTH-JZWITH(70), JZHEIGHT(41));
    }
    _cityNameLabel.text=str;
    _shopView.hidden=YES;
    _selectIndex = selectIndex.intValue;
    
    NSArray * arr =self.bannerSelectDataArr[selectIndex.integerValue][@"twoChildren"];
    
    if (arr.count>0) {
        int  selectId = [self.bannerSelectDataArr[selectIndex.integerValue][@"twoChildren"][0][@"id"] intValue];
          [self.postDic setObject:@(selectId) forKey:@"categoryId"];
    }else{
        return;
        
    }
    
  
    
//    [self getFarmPageDataWithDic:self.postDic type:@"type"];
    
     [self getFarmPageDataWithDic:self.postDic type:@"farm"];
}

//专属农场
-(void)zhuanshuClick:(UIButton*)sender{
    for (NYNSrollSelectButton *bt in self.ziCellButtonArr) {
        
        bt.textLabel.textColor = Color686868;
        
    }
    _zhuanshuBtn.textLabel.textColor =Color90b659;
    
    [self getFarmPageDataWithDic:self.postDic type:@"enterprise"];

    
}

-(void)configData{
    self.pageNo = 1;
    self.pageSize = 10;
    
    self.titles = @[@"综合排序",@"人气",@"距离"];
    self.uppics = @[@"",@"farm_icon_screen1",@"farm_icon_screen1",@""];
    self.downpics = @[@"",@"farm_icon_screen5",@"farm_icon_screen5"];
    self.selectUppics = @[@"",@"farm_icon_screen3",@"farm_icon_screen3"];
    self.selectDownpics = @[@"",@"farm_icon_screen4",@"farm_icon_screen4"];
}

- (void)setNav{
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    nav.backgroundColor = KNaviBarTintColor;
    [self.view addSubview:nav];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, nav.width, nav.height)];
    backImageView.image = Imaged(@"public_title bar");
    [nav addSubview:backImageView];
    
    UIButton *locationButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 32, JZWITH(60), 20)];
    locationButton.backgroundColor = [UIColor clearColor];
    
    _cityNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, JZWITH(60), JZHEIGHT(20))];
    _cityNameLabel.text = self.bannerSelectDataArr[0][@"name"];
    _cityNameLabel.font = JZFont(13);
    _cityNameLabel.textColor = [UIColor whiteColor];
    _cityNameLabel.userInteractionEnabled = NO;
    [locationButton addSubview:_cityNameLabel];
    
    UIImageView *rightImageItem = [[UIImageView alloc]initWithFrame:CGRectMake(_cityNameLabel.right + JZWITH(5), 7, JZWITH(10), 6)];
    rightImageItem.image = Imaged(@"public_icon_select");
    rightImageItem.userInteractionEnabled = NO;
    [locationButton addSubview:rightImageItem];
    
    [locationButton addTarget:self action:@selector(pushToBusiness) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:locationButton];
    
    
    UILabel *ttLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH - JZWITH(100)) / 2, 20, JZWITH(100), 44)];
    ttLabel.text = @"农场";
    ttLabel.textAlignment = 1;
    ttLabel.textColor = [UIColor whiteColor];
    ttLabel.font = [UIFont boldSystemFontOfSize:18];
    [nav addSubview:ttLabel];
    //搜索
    UIButton *saoyisao = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(316), 32, JZWITH(22), JZWITH(18))];
    [nav addSubview:saoyisao];
    [saoyisao addTarget:self action:@selector(codeScan) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *sao = [[UIImageView alloc]initWithFrame:CGRectMake(0, JZWITH(0), saoyisao.width, saoyisao.height)];
    sao.image = Imaged(@"public_icon_Search3");
    sao.userInteractionEnabled = NO;
    [saoyisao addSubview:sao];
    

//
//    UIButton *xiaoxi = [[UIButton alloc]initWithFrame:CGRectMake(JZWITH(346), 31, JZWITH(20), JZWITH(20))];
//    [nav addSubview:xiaoxi];
//    [xiaoxi addTarget:self action:@selector(goMes) forControlEvents:UIControlEventTouchUpInside];
//
//    UIImageView *xiao = [[UIImageView alloc]initWithFrame:CGRectMake(0, JZWITH(0), xiaoxi.width, xiaoxi.height)];
//    xiao.image = Imaged(@"public_icon_message");
//    xiao.userInteractionEnabled = NO;
//    [xiaoxi addSubview:xiao];
}

- (void)createHomeUI{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, JZHEIGHT(82))];
    backView.backgroundColor = Colore3e3e3;
    [self.view addSubview:backView];
    _backView = backView;
    
    UIView *selecteBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(41 ))];
    selecteBackView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:selecteBackView];
    selecteBackView.clipsToBounds = NO;
    _selecteBackView = selecteBackView;
    


    
     CGFloat btWith = SCREENWIDTH / 3;
     NYNFarmChooseButton *bt =[[NYNFarmChooseButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-80, 0, 100, selecteBackView.height)];
      bt.textLabel.text = @"排序";
       bt.titleLabel.font=[UIFont systemFontOfSize:14];
       bt.indexFB=3;
     [bt addTarget:self action:@selector(clickBT:) forControlEvents:UIControlEventTouchUpInside];
     [selecteBackView addSubview:bt];
    
    
    
    NYNFarmChooseButton *bt1 =[[NYNFarmChooseButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-JZWITH(140), 0, JZWITH(70), selecteBackView.height)];
    bt1.textLabel.frame = CGRectMake(0, 0, bt1.frame.size.width, bt1.frame.size.height);
    bt1.textLabel.text = @"专属农场";
  
    bt1.titleLabel.font=[UIFont systemFontOfSize:14];
    bt1.titleLabel.textAlignment =NSTextAlignmentRight;
    
    bt1.indexFB=2;
    [bt1 addTarget:self action:@selector(zhuanshuClick:) forControlEvents:UIControlEventTouchUpInside];
    [selecteBackView addSubview:bt1];
    
    _zhuanshuBtn = bt1;
    
    
    
    //清空所有数据
    [self.btArr removeAllObjects];
    
    for (int i = 0; i < 3; i ++) {
        NYNFarmChooseButton * chooseBt =[[NYNFarmChooseButton alloc]initWithFrame:CGRectMake(0 + btWith * i, JZWITH(41.5), btWith, selecteBackView.height)];
        chooseBt.textLabel.text = self.titles[i];
        chooseBt.hidden=YES;
        chooseBt.picImageView.image = Imaged(self.uppics[i]);
        chooseBt.indexFB = i;
        [chooseBt addTarget:self action:@selector(clickBT:) forControlEvents:UIControlEventTouchUpInside];
        [selecteBackView addSubview:chooseBt];
        selecteBackView.backgroundColor = [UIColor whiteColor];
        if (i == 0) {
//            [chooseBt setTitleColor:Color90b659 forState:UIControlStateNormal] ;
            chooseBt.textLabel.textColor =  Color90b659;
        }

        [self.btArr addObject:chooseBt];
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(btWith * 3, 14, 0.5, 13)];
    lineView.backgroundColor = RGB_COLOR(193, 193, 193);
    [selecteBackView addSubview:lineView];
    
    UIScrollView *scrollViewBack = [[UIScrollView alloc]init];
     scrollViewBack.frame=CGRectMake(0, JZHEIGHT(0), SCREENWIDTH-JZHEIGHT(140), JZHEIGHT(41));
    scrollViewBack.backgroundColor = [UIColor whiteColor];
    [backView addSubview:scrollViewBack];
//    (JZWITH(50) + JZWITH(13)) * 7 + 65
    scrollViewBack.contentSize = CGSizeMake((JZWITH(50) + JZWITH(13)) + JZWITH(120) * self.bannerSelectDataArr.count, 0);
    scrollViewBack.hidden = NO;
    scrollViewBack.scrollEnabled = YES;
    self.scrollViewBack = scrollViewBack;
    scrollViewBack.userInteractionEnabled = YES;
    scrollViewBack.showsVerticalScrollIndicator = NO;
    scrollViewBack.showsHorizontalScrollIndicator = NO;
    _scrollViewBack=scrollViewBack;
    
 
    
    
    NSArray *picsArr = @[@"farm_icon_all",@"farm_icon_plant",@"farm_icon_breed",@"farm_icon_restaurant",@"farm_icon_hotel",@"farm_icon_orchard",@"farm_icon_Shop"];
    NSArray *titlesArr = @[@"全部",@"种植",@"养殖",@"餐饮",@"住宿",@"果园",@"农产品"];
    NSMutableArray * str=[[NSMutableArray alloc]init];
    if (self.bannerSelectDataArr.count>0) {
        str =(self.bannerSelectDataArr.firstObject)[@"twoChildren"];
        for (int i = 0; i < str.count+1; i++) {
        if ( i == 0) {
            NYNSrollSelectButton *bt = [[NYNSrollSelectButton alloc]initWithFrame:CGRectMake( JZWITH(10) + (JZWITH(70) + JZWITH(5)) * i, 0, JZWITH(60), scrollViewBack.height)];
            bt.picImageView.image = Imaged(picsArr[i]);
            bt.textLabel.text = titlesArr[i];
            bt.tagger = i;
            [scrollViewBack addSubview:bt];
            
            [bt addTarget:self action:@selector(gaoJiClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.ziCellButtonArr addObject:bt];
            
//            bt.hidden = YES;
            
            bt.textLabel.textColor = Color90b659;
            
        }
        else{
            NYNSrollSelectButton *bt = [[NYNSrollSelectButton alloc]initWithFrame:CGRectMake(JZWITH(10) + (JZWITH(70) + JZWITH(5)) * (i), 0, JZWITH(70), scrollViewBack.height)];
            [bt.picImageView sd_setImageWithURL:[NSURL URLWithString:VALID_STRING((self.bannerSelectDataArr.firstObject)[@"icon"])] placeholderImage:PlaceImage];
            
            if (str.count != 0) {
                bt.textLabel.text = str[i-1][@"name"];
            }
            
            //                bt.tagger = [(self.bannerSelectDataArr[i])[@"id"] intValue];
            //别问我为什么-1,没问题就行了
            bt.tagger=i-1;
            
            [scrollViewBack addSubview:bt];
            
            [bt addTarget:self action:@selector(gaoJiClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.ziCellButtonArr addObject:bt];
            
            if (i == 0) {
                
                bt.textLabel.textColor =Color90b659;
            }
            
            
        }
    }
    }
    
  

    
  
}

- (void)createTable{
    self.farmTable.delegate = self;
    self.farmTable.dataSource = self;
    self.farmTable.showsVerticalScrollIndicator = NO;
    self.farmTable.showsHorizontalScrollIndicator = NO;
    self.farmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.farmTable];
    
    self.farmTable.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.farmTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


- (void)headerRefresh{
//    [self.farmDataArr removeAllObjects];
    
    self.pageNo = 1;
    [self.postDic setObject:[NSString stringWithFormat:@"%d",self.pageNo] forKey:@"pageNo"];
    [self getFarmPageDataWithDic:self.postDic type:@"farm"];
}

- (void)endRefresh{
    [self.farmTable.mj_footer endRefreshing];
    [self.farmTable.mj_header endRefreshing];
}


#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.farmDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FTFarmListTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FTFarmListTableViewCell class]) owner:self options:nil].firstObject;
    }
    
    farmLiveTableViewCell.model = self.farmDataArr[indexPath.row];
    return farmLiveTableViewCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JZHEIGHT(100);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoModel *userMD = userInfoModel;
    if (!userMD.isLogin) {
        FTNavigationViewController *nav = [[FTNavigationViewController alloc]initWithRootViewController:[FTLoginViewController new]];;
        
        [self presentViewController:nav animated:YES completion:^{
            JZLog(@"请先登录");
        }];
        return;
    }
     __weak typeof(self) weakSelf = self;
     NYNFarmCellModel *model = self.farmDataArr[indexPath.row];
    //农场直播详情
    [NYNNetTool GetFarmLiveInfoWithparams:@{@"farmId":model.Id} isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NSLog(@"---------------%@",success);
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
       
            
            
            PersonalCenterVC *vc = [PersonalCenterVC new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = model.Id;
            NSArray * arr =success[@"data"];
            if (arr.count>0) {
                vc.playUrl = success[@"data"][0][@"rtmpPull"];
                vc.LiveID= success[@"data"][0][@"id"];
            }
            
            
            vc.farmName = model.name;
            vc.ctype = @"farm";
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else{
            
        }
    } failure:^(NSError *failure) {
        
        
    }];
    
    
   
    
//    PersonalCenterVC *vc = [PersonalCenterVC new];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.ID = model.Id;
//    vc.farmName = model.name;
////    vc.playUrl=model
//    vc.ctype = @"farm";
//
//    [self.navigationController pushViewController:vc animated:YES];
    
}



-(UITableView *)farmTable{
    if (!_farmTable) {
        _farmTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+JZHEIGHT(41)+JZHEIGHT(5), SCREENWIDTH, SCREENHEIGHT - (64 + JZHEIGHT(41) + JZHEIGHT(5) + 50)) style:UITableViewStylePlain];
        _farmTable.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _farmTable;
}

-(NSMutableArray *)btArr{
    if (!_btArr) {
        _btArr = [[NSMutableArray alloc]init];
    }
    return _btArr;
}

- (NSMutableArray *)farmDataArr{
    if (!_farmDataArr) {
        _farmDataArr = [[NSMutableArray alloc]init];
    }
    return _farmDataArr;
}

- (NSMutableDictionary *)postDic{
    if (!_postDic) {
        _postDic = [[NSMutableDictionary alloc]init];
    }
    return _postDic;
}

//左边一级业务选择
- (void)pushToBusiness{
     _shopView=[[ShopSelectView alloc]initWithFrame:CGRectMake(0, JZWITH(64), JZWITH(100), 40*self.bannerSelectDataArr.count)];
    [_shopView getData:self.bannerSelectDataArr];
    _shopView.delagate = self;
    
    [self.view addSubview:_shopView];

    [self.view bringSubviewToFront:_shopView];
    
 
}

//右边搜索
- (void)codeScan{
    
    FTSearchViewController * search =[[FTSearchViewController alloc]init];
    
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
   
}


//获取数据
- (void)getFarmPageDataWithDic:(NSDictionary *)dic  type:(NSString *)type{
       [self.farmDataArr removeAllObjects];
    
      [self showLoadingView:@""];
      [self.postDic setObject:type forKey:@"type"];
    
    
    [NYNNetTool FarmPageResquestWithparams:dic isTestLogin:NO progress:^(NSProgress *progress) {
    
    } success:^(id success) {
        [self.farmDataArr removeAllObjects];
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
                NYNFarmCellModel *model = [NYNFarmCellModel mj_objectWithKeyValues:dic];
                [self.farmDataArr addObject:model];
            }
            
            [self.farmTable reloadData];
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        

        
        [self hideLoadingView];
        
        [self endRefresh];
    } failure:^(NSError *failure) {
    
        [self hideLoadingView];
        
        [self endRefresh];
    }];
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
    
    self.pageNo = 1;
    
    switch (sender.indexFB) {
        case 0:
        {
            sender.isAsc = !sender.isAsc;
            if (sender.isAsc) {
                sender.picImageView.image = Imaged(self.selectUppics[0]);
                [self.postDic setObject:@"normal" forKey:@"sort"];
                [self.postDic setObject:@"asc" forKey:@"orderBy"];

                
            }else{
                sender.picImageView.image = Imaged(self.selectDownpics[0]);
                [self.postDic setObject:@"normal" forKey:@"sort"];
                [self.postDic setObject:@"desc" forKey:@"orderBy"];
            }
        }
            break;
        case 1:
        {
            sender.isAsc = !sender.isAsc;
            if (sender.isAsc) {
                sender.picImageView.image = Imaged(self.selectUppics[1]);
                [self.postDic setObject:@"grade" forKey:@"sort"];
                [self.postDic setObject:@"asc" forKey:@"orderBy"];
                
            }else{
                sender.picImageView.image = Imaged(self.selectDownpics[1]);
                [self.postDic setObject:@"grade" forKey:@"sort"];
                [self.postDic setObject:@"desc" forKey:@"orderBy"];
            }
        }
            break;
        case 2:
        {
            sender.isAsc = !sender.isAsc;
            if (sender.isAsc) {
                sender.picImageView.image = Imaged(self.selectUppics[2]);
                
                [self.postDic setObject:@"position" forKey:@"sort"];
                [self.postDic setObject:@"asc" forKey:@"orderBy"];
            }else{
                sender.picImageView.image = Imaged(self.selectDownpics[2]);
                
                [self.postDic setObject:@"position" forKey:@"sort"];
                [self.postDic setObject:@"desc" forKey:@"orderBy"];
            }
        }
            break;
        case 3:
        {
            
            sender.isAsc = !sender.isAsc;
            
            if (sender.isAsc) {
                sender.textLabel.textColor = RGB_COLOR(56, 57, 56);
                for (NYNSrollSelectButton *bt in self.ziCellButtonArr) {
                    bt.textLabel.textColor = Color686868;
                }
                
            }else{
                sender.textLabel.textColor = Color90b659;
                
            }
            
            if (!sender.isAsc) {
                [UIView animateWithDuration:.5 animations:^{
                    self.farmTable.frame = CGRectMake(0, 64+JZHEIGHT(41)+JZHEIGHT(5)+JZHEIGHT(41), SCREENWIDTH, SCREENHEIGHT - (64 + JZHEIGHT(41) + JZHEIGHT(5) + 50) - JZHEIGHT(41));
                    _selecteBackView.frame = self.backView.bounds;
                }];
                
                for (int i = 0 ; i < self.btArr.count; i ++) {
                    [self.btArr[i] setHidden:NO];
                }
            }else{
                [UIView animateWithDuration:.5 animations:^{
                self.farmTable.frame = CGRectMake(0, 64+JZHEIGHT(41)+JZHEIGHT(5), SCREENWIDTH, SCREENHEIGHT - (64 + JZHEIGHT(41) + JZHEIGHT(5) + 50));
                    _selecteBackView.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(41 ));

                }];
                
                for (int i = 0 ; i < self.btArr.count; i ++) {
                    [self.btArr[i] setHidden:YES];
                }
            }

            
        }
            break;
        default:
            break;
    }
    
    //这里删除掉   没删除是全部  删除按分类来
    //    [self.postDic removeObjectForKey:@"mainBusiness"];

    
//    [self.postDic setObject:@"0" forKey:@"mainBusiness"];
//    if (sender.indexFB == 3) {
//
//    }else{
        [self.postDic setObject:[NSString stringWithFormat:@"%d",self.pageNo] forKey:@"pageNo"];
        [self getFarmPageDataWithDic:self.postDic type:@"farm"];
    
    
    
//    }

}


- (void)loadMoreData{
    //分页查询农场
    self.pageNo ++;
    [self.postDic setObject:[NSString stringWithFormat:@"%d",self.pageNo] forKey:@"pageNo"];
    
    [self showLoadingView:@""];
    [self.postDic setObject:@"farm" forKey:@"type"];
    [NYNNetTool FarmPageResquestWithparams:self.postDic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if (![success[@"data"] isKindOfClass:[NSArray class]]) return;
        for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
            NYNFarmCellModel *model = [NYNFarmCellModel mj_objectWithKeyValues:dic];
            [self.farmDataArr addObject:model];
        }
        
        [self.farmTable reloadData];
        
        [self endRefresh];
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
        [self endRefresh];

    }];
}

- (void)refreshData{
//    @"type":@"farm"
    [self showLoadingView:@""];
    [self.farmTable.mj_header beginRefreshing];
    [self.postDic setObject:@"farm" forKey:@"type"];
    [NYNNetTool FarmPageResquestWithparams:self.postDic isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        [self.farmDataArr removeAllObjects];
        
        for (NSDictionary *dic in [NSArray arrayWithArray:success[@"data"]]) {
            NYNFarmCellModel *model = [NYNFarmCellModel mj_objectWithKeyValues:dic];
            [self.farmDataArr addObject:model];
        }
        
        [self.farmTable reloadData];
        [self endRefresh];
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
        [self endRefresh];

    }];
}
//农场二级分类点击
- (void)gaoJiClick:(NYNSrollSelectButton *)sender{
    _zhuanshuBtn.textLabel.textColor =Color686868;
    for (NYNSrollSelectButton *bt in self.ziCellButtonArr) {
        
        bt.textLabel.textColor = Color686868;
        
    }
    
    sender.textLabel.textColor = Color90b659;

    
    [self.farmDataArr removeAllObjects];
    
    NSArray * twoChildren = self.bannerSelectDataArr[_selectIndex][@"twoChildren"];
    if (twoChildren.count <= sender.tagger) {
        return;
    }
    NSString * str =[NSString stringWithFormat:@"%d",[self.bannerSelectDataArr[_selectIndex][@"twoChildren"][sender.tagger][@"id"] intValue]];
    // NSString * str =[NSString stringWithFormat:@"%d",sender.tagger];
    [self.postDic setObject:str forKey:@"categoryId"];
    
    self.pageNo = 1;
    [self.postDic setObject:[NSString stringWithFormat:@"%d",self.pageNo] forKey:@"pageNo"];
    [self getFarmPageDataWithDic:self.postDic type:@"type"];
}

-(NSMutableArray *)bannerSelectDataArr{
    if (!_bannerSelectDataArr) {
        _bannerSelectDataArr = [[NSMutableArray alloc]init];
    }
    return _bannerSelectDataArr;
}

-(NSMutableArray *)ziCellButtonArr{
    if (!_ziCellButtonArr) {
        _ziCellButtonArr = [[NSMutableArray alloc]init];
    }
    return _ziCellButtonArr;
}
@end
