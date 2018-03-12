
//
//  NYNEarthDetailViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/7.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNEarthDetailViewController.h"
#import "NYNEarthDetailHeaderTableViewCell.h"
#import "NYNEarthDataTableViewCell.h"
#import "NYNEarthLocationViewTableViewCell.h"
#import "NYNEarthZuDiTableViewCell.h"
#import "NYNChooseTableViewCell.h"
#import "NYNEarthDetailTableViewCell.h"
#import "NYNDetailContentTableViewCell.h"
#import "NYNGouMaiView.h"
#import "NYNChooseSeedTableViewCell.h"

#import "NYNWantZhongZhiViewController.h"
#import "NYNTuDiXiangQingModel.h"
#import "NYNXuanZeZhongZiModel.h"

#import "NYNMoreDisViewController.h"
#import "NYNWantZhongZhiNewViewController.h"

@interface NYNEarthDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *earthDetailTable;
@property (nonatomic,strong) UIButton *bottomView;

@property (nonatomic,strong) NYNTuDiXiangQingModel *dataModel;
@property (nonatomic,strong) NSMutableArray *seedDataArr;
@end

@implementation NYNEarthDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [NSString stringWithFormat:@"%@土地详情",self.titleStr];
    
    [self showLoadingView:@""];
    [NYNNetTool ProductQueryResquestWithparams:self.productID isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NYNTuDiXiangQingModel *model = [NYNTuDiXiangQingModel mj_objectWithKeyValues:success[@"data"]];
        self.dataModel = model;
        NSDictionary *dic = @{@"farmId":self.ID,@"pageNo":@"1",@"pageSize":@"100"};
        
        JZLog(@"=====%@",model.productImages);
        [NYNNetTool SearchSeedResquestWithparams:dic isTestLogin:NO progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            [self.seedDataArr removeAllObjects];
            
            NSArray *dataAR = [NSArray arrayWithArray:success[@"data"]];
            for (NSDictionary *dc in dataAR) {
                NYNXuanZeZhongZiModel *seedModel = [NYNXuanZeZhongZiModel mj_objectWithKeyValues:dc];
                seedModel.selectCount = 1;
                [self.seedDataArr addObject:seedModel];
                
            }
            NYNXuanZeZhongZiModel *selectModel = self.seedDataArr.firstObject;
            selectModel.isChoose = YES;
            [self createearthDetailTable];
            
            [self.view addSubview:self.bottomView];
            
            [self hideLoadingView];
        } failure:^(NSError *failure) {
            [self hideLoadingView];

        }];
        
        

    } failure:^(NSError *failure) {
        [self hideLoadingView];

    }];
    

}

- (void)createearthDetailTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.earthDetailTable.delegate = self;
    self.earthDetailTable.dataSource = self;
    self.earthDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.earthDetailTable.showsVerticalScrollIndicator = NO;
    self.earthDetailTable.showsHorizontalScrollIndicator = NO;
    self.earthDetailTable.backgroundColor = Colore3e3e3;
    
    [self.view addSubview:self.earthDetailTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 1;
    }else if (section == 2) {
        return 1;
    }else{
        return 0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NYNEarthDetailHeaderTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthDetailHeaderTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.urlImages = self.dataModel.productImages;
            
            return farmLiveTableViewCell;
        }
        else if (indexPath.row == 1){
            NYNEarthDataTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthDataTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.nameLabel.text = self.dataModel.farm[@"name"];
            farmLiveTableViewCell.pricelabel.text = [NSString stringWithFormat:@"%@/㎡/天 ",self.dataModel.price];
            farmLiveTableViewCell.updateTimeLabel.text = [NSString stringWithFormat:@"更新日期 %@",[MyControl timeWithTimeIntervalString:self.dataModel.saleDate]];
            farmLiveTableViewCell.kucunLabel.text = [NSString stringWithFormat:@"库存  %@/%@㎡",self.dataModel.stock,self.dataModel.maxStock];
            return farmLiveTableViewCell;
        }
        else{
            NYNEarthLocationViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthLocationViewTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.dataModel.farm[@"province"],self.dataModel.farm[@"city"],self.dataModel.farm[@"area"],self.dataModel.farm[@"address"]];
            
//            farmLiveTableViewCell.juliLabel.text = [NSString stringWithFormat:@"%@",];
            
            __weak typeof(self)WeakSelf = self;
            farmLiveTableViewCell.callBlock = ^(NSString *ss) {
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",WeakSelf.dataModel.farm[@"phone"]];
                UIWebView *callWebview = [[UIWebView alloc] init];
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebview];
            };
            return farmLiveTableViewCell;
        }
        
        
        
    }
//    else if (indexPath.section == 1){
//        if (indexPath.row == 0) {
//            NYNEarthZuDiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//            if (farmLiveTableViewCell == nil) {
//                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthZuDiTableViewCell class]) owner:self options:nil].firstObject;
//            }
//            return farmLiveTableViewCell;
//        }
//        else{
//            NYNChooseTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//            if (farmLiveTableViewCell == nil) {
//                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChooseTableViewCell class]) owner:self options:nil].firstObject;
//            }
//            return farmLiveTableViewCell;
//        }
//    }
    else if (indexPath.section == 1){
        NYNEarthDetailTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthDetailTableViewCell class]) owner:self options:nil].firstObject;
        }
//        intro
        farmLiveTableViewCell.contentLabel.text = [NSString stringWithFormat:@"%@",self.dataModel.intro];
        
        
        farmLiveTableViewCell.constHeight.constant = [MyControl getTextHeight:[NSString stringWithFormat:@"%@",self.dataModel.intro] andWith:SCREENWIDTH - 20 andFontSize:13]+ JZHEIGHT(30);
        return farmLiveTableViewCell ;
    }
    else if (indexPath.section == 2){
        NYNChooseSeedTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChooseSeedTableViewCell class]) owner:self options:nil].firstObject;
        }
        farmLiveTableViewCell.chooseSeedDataArr = self.seedDataArr;
        
//        farmLiveTableViewCell.
        return farmLiveTableViewCell;
    }
    else{
        NYNDetailContentTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNDetailContentTableViewCell class]) owner:self options:nil].firstObject;
        }
        return farmLiveTableViewCell;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return JZHEIGHT(171);
        }
        else if (indexPath.row == 1){
            return JZHEIGHT(71);
        }
        else{
            return JZHEIGHT(36);
        }
        
    }
//    else if (indexPath.section == 1){
//        if (indexPath.row == 0) {
//            return JZHEIGHT(86);
//        }
//        else{
//            return JZHEIGHT(41);
//        }
//    }
    else if (indexPath.section == 1){
        
        return [MyControl getTextHeight:[NSString stringWithFormat:@"%@",self.dataModel.intro] andWith:SCREENWIDTH - 20 andFontSize:13] + JZHEIGHT(80);
    }
    else if (indexPath.section == 2){
        return JZHEIGHT(397 -70);
    }
    else{
        return JZHEIGHT(201);
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : JZHEIGHT(5))];
    
    if (section == 3) {
        
        
        headerView.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46));
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(5), SCREENWIDTH, JZHEIGHT(41))];
        backView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:backView];
        
        UILabel *pingJiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, -JZHEIGHT(2.5), JZWITH(150), headerView.height)];
        pingJiaLabel.text = @"评价(0)";
        pingJiaLabel.font = JZFont(14);
        pingJiaLabel.textColor = Color252827;
        [backView addSubview:pingJiaLabel];
        
        UIImageView *jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(7), (pingJiaLabel.height - JZHEIGHT(15)) / 2, JZWITH(7), JZHEIGHT(11))];
        jiantou.image = Imaged(@"mine_icon_more");
        [backView addSubview:jiantou];
        
        UILabel *quanping = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(160) - JZWITH(10), -JZHEIGHT(2.5), JZWITH(150), headerView.height)];
        quanping.textColor = Color252827;
        quanping.text = @"全部评论";
        quanping.font = JZFont(13);
        quanping.textAlignment = 2;
        [backView addSubview:quanping];
        
        UIView *xiaV = [[UIView alloc]initWithFrame:CGRectMake(0, headerView.height - JZHEIGHT(0.5), SCREENWIDTH, JZHEIGHT(0.5))];
        xiaV.backgroundColor = Colore3e3e3;
        UIButton *headerActionButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backView.width, backView.height)];
        [headerActionButton addTarget:self action:@selector(goDis) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:headerActionButton];
        
        [backView addSubview:xiaV];
    }

    JZLog(@"=================%f",headerView.height);

    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.00001;
    }else if(section == 1){
        return JZHEIGHT(5);
    }else if(section == 2){
        return JZHEIGHT(5);
    }else if(section == 3){
        return JZHEIGHT(5+41);
    }else{
        return JZHEIGHT(0.00001);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


#pragma 懒加载
-(UITableView *)earthDetailTable
{
    
    if (!_earthDetailTable) {
        _earthDetailTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(45)) style:UITableViewStyleGrouped];
    }
    return _earthDetailTable;
}

-(UIButton *)bottomView{
    if (!_bottomView ) {
        _bottomView = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) - 64, SCREENWIDTH, JZHEIGHT(45))];
        [_bottomView setTitle:@"下一步" forState:0];
        [_bottomView setTitleColor:[UIColor whiteColor] forState:0];
        _bottomView.titleLabel.font = JZFont(14);
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"9ecc5b"];
        [_bottomView addTarget:self action:@selector(goZhong) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

- (void)goZhong{
    JZLog(@"种植");
    
    NYNWantZhongZhiNewViewController *vc = [[NYNWantZhongZhiNewViewController alloc]init];
    vc.seedArr = self.seedDataArr;
    vc.farmID = self.ID;
    vc.earthID = self.dataModel.ID;
    vc.earthUnit = self.dataModel.unitName;
    vc.earthPriceStr =  self.dataModel.price;
    NSMutableArray *rr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.dataModel.productImages) {
        [rr addObject:dic[@"imgUrl"]];
    }
    
    
    vc.picName = [rr firstObject];
//    [vc changeSeed];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goDis{
    JZLog(@"到评价界面");
    NYNMoreDisViewController *vc = [[NYNMoreDisViewController alloc]init];
    vc.farmId = self.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSMutableArray *)seedDataArr{
    if (!_seedDataArr) {
        _seedDataArr = [[NSMutableArray alloc]init];
    }
    return _seedDataArr;
}
@end
