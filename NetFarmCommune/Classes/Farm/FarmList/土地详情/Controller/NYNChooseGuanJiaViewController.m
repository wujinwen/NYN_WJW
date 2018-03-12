//
//  NYNChooseGuanJiaViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNChooseGuanJiaViewController.h"
#import "NYNChooseGuanJiaTableViewCell.h"
#import "NYNGuanJiaModel.h"

@interface NYNChooseGuanJiaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *chooseGuanJiaTable;

@property (nonatomic,strong) NSMutableArray *guanJiaDataArr;
@end

@implementation NYNChooseGuanJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"选择管家";
    [self createchooseGuanJiaTable];

    [self showLoadingView:@""];

    
    [NYNNetTool GetGuanJiasWithparams:@{@"farmId":self.farmID} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            [self.guanJiaDataArr removeAllObjects];
            for (NSDictionary *dic in success[@"data"]) {
                NYNGuanJiaModel *model = [NYNGuanJiaModel mj_objectWithKeyValues:dic];
                [self.guanJiaDataArr addObject:model];
            }
            [self.chooseGuanJiaTable reloadData];
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError * failure) {
        JZLog(@"");
        [self hideLoadingView];

    }];
}

- (void)createchooseGuanJiaTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.chooseGuanJiaTable.delegate = self;
    self.chooseGuanJiaTable.dataSource = self;
    self.chooseGuanJiaTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chooseGuanJiaTable.showsVerticalScrollIndicator = NO;
    self.chooseGuanJiaTable.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.chooseGuanJiaTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.guanJiaDataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNChooseGuanJiaTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (farmLiveTableViewCell == nil) {
        farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNChooseGuanJiaTableViewCell class]) owner:self options:nil].firstObject;
    }
    
    NYNGuanJiaModel *model = self.guanJiaDataArr[indexPath.section];
    farmLiveTableViewCell.nameLabel.text = model.name;
    
    CGFloat nameLabelWith = [MyControl getTextWith:model.name andHeight:13 andFontSize:15] + 10;
    farmLiveTableViewCell.nameWidth.constant = nameLabelWith;
    
   
    farmLiveTableViewCell.nianLingLabel.text = [NSString stringWithFormat:@"%d岁", [model.age intValue] ];
    farmLiveTableViewCell.nianLingImageVIEW.image = ([model.sex isEqualToString:@"1"]) ? (Imaged(@"farm_icon_male1.png")):(Imaged(@"farm_icon_female1.png"));
    farmLiveTableViewCell.contentLabel.text = model.intro;
    farmLiveTableViewCell.contengHeight.constant = [MyControl getTextHeight:model.intro andWith:(SCREENWIDTH - 40) andFontSize:13];
    return farmLiveTableViewCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NYNGuanJiaModel *model = self.guanJiaDataArr[indexPath.section];

    return JZHEIGHT(60) + [MyControl getTextHeight:model.intro andWith:(SCREENWIDTH - 40) andFontSize:13];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : 5)];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ?  0.0001 : 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    FTEarthDetailViewController *vc = [[FTEarthDetailViewController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    NYNGuanJiaModel *model = self.guanJiaDataArr[indexPath.section];

    if (self.guanJiaBlcok) {
        self.guanJiaBlcok(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(UITableView *)chooseGuanJiaTable{
    if (!_chooseGuanJiaTable) {
        _chooseGuanJiaTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStyleGrouped];
    }
    return _chooseGuanJiaTable;
}


-(NSMutableArray *)guanJiaDataArr{
    if (!_guanJiaDataArr) {
        _guanJiaDataArr = [[NSMutableArray alloc]init];
    }
    return _guanJiaDataArr;
}
@end
