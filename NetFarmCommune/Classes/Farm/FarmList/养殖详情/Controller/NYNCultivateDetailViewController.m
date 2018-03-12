//
//  NYNCultivateDetailViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/13.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNCultivateDetailViewController.h"
#import "NYNEarthDetailHeaderTableViewCell.h"
#import "NYNEarthDataTableViewCell.h"
#import "NYNEarthLocationViewTableViewCell.h"
#import "NYNEarthZuDiTableViewCell.h"
#import "NYNChooseTableViewCell.h"
#import "NYNEarthDetailTableViewCell.h"
#import "NYNDetailContentTableViewCell.h"
#import "NYNGouMaiView.h"
#import "NYNWantYangZhiViewController.h"

#import "NYNWantZhongZhiViewController.h"
#import "NYNTuDiXiangQingModel.h"

#import "NYNMoreDisViewController.h"

@interface NYNCultivateDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *CultivateDetailTable;
@property (nonatomic,strong) UIButton *bottomView;
@property (nonatomic,strong) NYNTuDiXiangQingModel* dataModel;
@end

@implementation NYNCultivateDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"养殖详情";
    
    
    
    [self showLoadingView:@""];
    [NYNNetTool ProductQueryResquestWithparams:self.productID isTestLogin:NO progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NYNTuDiXiangQingModel *model = [NYNTuDiXiangQingModel mj_objectWithKeyValues:success[@"data"]];
        self.dataModel = model;
//        NSDictionary *dic = @{@"farmId":self.ID,@"pageNo":@"1",@"pageSize":@"100"};
        
//        [NYNNetTool SearchSeedResquestWithparams:dic isTestLogin:NO progress:^(NSProgress *progress) {
//            
//        } success:^(id success) {
//            [self.seedDataArr removeAllObjects];
//            
//            NSArray *dataAR = [NSArray arrayWithArray:success[@"data"]];
//            for (NSDictionary *dc in dataAR) {
//                NYNXuanZeZhongZiModel *seedModel = [NYNXuanZeZhongZiModel mj_objectWithKeyValues:dc];
//                seedModel.selectCount = 1;
//                [self.seedDataArr addObject:seedModel];
//                
//            }
//            NYNXuanZeZhongZiModel *selectModel = self.seedDataArr.firstObject;
//            selectModel.isChoose = YES;
//            [self createearthDetailTable];
//            
//            [self.view addSubview:self.bottomView];
//            
//            [self hideLoadingView];
//        } failure:^(NSError *failure) {
//            [self hideLoadingView];
//            
//        }];
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            [self createCultivateDetailTable];
            [self.view addSubview:self.bottomView];
        }else{
            [self showTipsView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }

        [self hideLoadingView];
        
    } failure:^(NSError *failure) {
        [self hideLoadingView];
        
    }];
    

}

- (void)createCultivateDetailTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.CultivateDetailTable.delegate = self;
    self.CultivateDetailTable.dataSource = self;
    self.CultivateDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.CultivateDetailTable.showsVerticalScrollIndicator = NO;
//    self.CultivateDetailTable.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:self.CultivateDetailTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
//    else if (section == 1) {
//        return 2;
//    }
    else if (section == 1) {
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
            
            farmLiveTableViewCell.nameLabel.text = self.dataModel.name;
            farmLiveTableViewCell.pricelabel.text = [NSString stringWithFormat:@"%@/%@元",self.dataModel.price,self.dataModel.unitName];
            farmLiveTableViewCell.updateTimeLabel.text = [NSString stringWithFormat:@"更新日期 %@",[MyControl timeWithTimeIntervalString:self.dataModel.saleDate]];
            farmLiveTableViewCell.kucunLabel.text = [NSString stringWithFormat:@"库存  %@",self.dataModel.stock];
            return farmLiveTableViewCell;
        }
        else{
            NYNEarthLocationViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNEarthLocationViewTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.dataModel.farm[@"province"],self.dataModel.farm[@"city"],self.dataModel.farm[@"area"],self.dataModel.farm[@"address"]];
            
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
        farmLiveTableViewCell.biaoTiLabel.text = @"养殖说明";
        
        farmLiveTableViewCell.constHeight.constant = [MyControl getTextHeight:[NSString stringWithFormat:@"%@",self.dataModel.intro] andWith:SCREENWIDTH - 20 andFontSize:13] + JZHEIGHT(30);
        return farmLiveTableViewCell;
    }else{
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
        CGFloat h = [MyControl getTextHeight:[NSString stringWithFormat:@"%@",self.dataModel.intro] andWith:SCREENWIDTH - 20 andFontSize:13] + JZHEIGHT(80);
        
        return h;
    }else{
        return JZHEIGHT(201);
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : JZHEIGHT(5))];
    
    if (section == 2) {
        
        
        headerView.frame = CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(46));
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(5), SCREENWIDTH, JZHEIGHT(41))];
        backView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:backView];
        
        UILabel *pingJiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, JZWITH(150), headerView.height)];
        pingJiaLabel.text = @"评价(0)";
        pingJiaLabel.font = JZFont(14);
        pingJiaLabel.textColor = Color252827;
        [backView addSubview:pingJiaLabel];
        
        UIImageView *jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10) - JZWITH(7), (pingJiaLabel.height - JZHEIGHT(11)) / 2, JZWITH(7), JZHEIGHT(11))];
        jiantou.image = Imaged(@"mine_icon_more");
        [backView addSubview:jiantou];
        
        UILabel *quanping = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(160) - JZWITH(10), 0, JZWITH(150), headerView.height)];
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
    }
//    else if(section == 2){
//        return JZHEIGHT(5);
//    }
    else if(section == 2){
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
-(UITableView *)CultivateDetailTable
{
    
    if (!_CultivateDetailTable) {
        _CultivateDetailTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(45)) style:UITableViewStyleGrouped];
    }
    return _CultivateDetailTable;
}

-(UIButton *)bottomView{
    if (!_bottomView ) {
        _bottomView = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - 46 - 64, SCREENWIDTH, 46)];
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

    NYNWantYangZhiViewController *vc = [[NYNWantYangZhiViewController alloc]init];
    vc.farmID = self.ID;
    vc.yangzhiID = self.dataModel.ID;
    vc.unitPrice = [self.dataModel.price doubleValue];
    vc.unit = self.dataModel.unitName;
    vc.proName = self.dataModel.name;
    
    
    NSMutableArray *rr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.dataModel.productImages) {
        [rr addObject:dic[@"imgUrl"]];
    }
    
    
    vc.picName = [rr firstObject];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)goDis{
    JZLog(@"到评价界面");
    NYNMoreDisViewController *vc = [[NYNMoreDisViewController alloc]init];
    vc.farmId = self.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
