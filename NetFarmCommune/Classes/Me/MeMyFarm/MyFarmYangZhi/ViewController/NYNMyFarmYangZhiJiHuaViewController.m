//
//  NYNMyFarmYangZhiJiHuaViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/24.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMyFarmYangZhiJiHuaViewController.h"
#import "NYNZuDiZhonZhiModel.h"
#import "FTFarmListTableViewCell.h"

#import "NYNMyFarmZuZhongOneTableViewCell.h"
#import "NYNMyFarmZuZhongTwoTableViewCell.h"
#import "NYNMyFarmZuZhongThreeTableViewCell.h"
#import "NYNMyFarmZuZhongFourTableViewCell.h"
#import "NYNMyFarmAddressTableViewCell.h"
#import "NYNMyFarmXinRenWuViewController.h"

@interface NYNMyFarmYangZhiJiHuaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *zuDiZhongZhiTable;
@property (nonatomic,strong) NYNZuDiZhonZhiModel *model;

@end

@implementation NYNMyFarmYangZhiJiHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self SetUI];
    
    [self showLoadingView:@""];
    [NYNNetTool SearchYangZhongJiHuaWithparams:self.orderId isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            NYNZuDiZhonZhiModel *model = [NYNZuDiZhonZhiModel mj_objectWithKeyValues:success[@"data"]];
            self.model = model;
            
            JZLog(@"");
            [self setTable];
            
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
    
}


- (void)SetUI{
    self.title = @"租地种植";
    
    UIButton *newButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(40), JZHEIGHT(15))];
    [newButton setTitle:@"新任务" forState:0];
    newButton.titleLabel.font = JZFont(13);
    [newButton setTitleColor:[UIColor whiteColor] forState:0];
    [newButton addTarget:self action:@selector(new) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cusView = [[UIBarButtonItem alloc]initWithCustomView:newButton];
    self.navigationItem.rightBarButtonItem = cusView;
}

- (void)setTable{
    self.zuDiZhongZhiTable.delegate = self;
    self.zuDiZhongZhiTable.dataSource = self;
    self.zuDiZhongZhiTable.showsVerticalScrollIndicator = NO;
    self.zuDiZhongZhiTable.showsHorizontalScrollIndicator = YES;
    self.zuDiZhongZhiTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.zuDiZhongZhiTable];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    else if (section == 1){
        return 2;
    }
    else if (section == 2){
        return 5;
    }
    else if (section == 3){
        return 2;
    }
    else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NYNMyFarmZuZhongTwoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongTwoTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabels.text = @"养殖数量";
            NSString *str1 = [NSString stringWithFormat:@"¥%.2f",[self.model.majorProductQuantity intValue] * [self.model.majorProductRate intValue] * [self.model.majorProductPrice doubleValue]];
            NSString *str2 = [NSString stringWithFormat:@"（¥%.2f/%@）",[self.model.majorProductPrice doubleValue],self.model.majorProductUnit];
            NSString *str = [NSString stringWithFormat:@"%@%@",str1,str2];
            
            farmLiveTableViewCell.detailLabels.attributedText = [MyControl CreateNSAttributedString:str thePartOneIndex:NSMakeRange(0, str1.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:14] andPartTwoIndex:NSMakeRange(str1.length , str2.length) withColor:Color888888 withFont:[UIFont systemFontOfSize:14]];
            

            return farmLiveTableViewCell;
            
        }else{
            NYNMyFarmZuZhongTwoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongTwoTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabels.text = @"动物名片";
            farmLiveTableViewCell.detailLabels.text = self.model.orderName;
            return farmLiveTableViewCell;
            
        }
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            NYNMyFarmZuZhongThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongThreeTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabels.text = @"动物数量";
            farmLiveTableViewCell.countLabels.text = [NSString stringWithFormat:@"%@ ×%@",self.model.majorProductName, self.model.majorProductQuantity];
            farmLiveTableViewCell.priceLabels.text = [NSString stringWithFormat:@"¥%@",self.model.majorProductPrice];
            return farmLiveTableViewCell;
            
        }else{
            NYNMyFarmZuZhongThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongThreeTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabels.text = @"养殖方案";
            farmLiveTableViewCell.countLabels.text = @"省心方案";
            farmLiveTableViewCell.priceLabels.text = [NSString stringWithFormat:@"¥%@",self.model.programTotalPrice];
            
            return farmLiveTableViewCell;
            
        }
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            NYNMyFarmZuZhongThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongThreeTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabels.text = @"执行管家";
            //            farmLiveTableViewCell.countLabels.text = @"省心方案";
            farmLiveTableViewCell.priceLabels.text = [NSString stringWithFormat:@"¥%@",self.model.managerName];
            
            return farmLiveTableViewCell;
        }
        else if (indexPath.row == 1){
            NYNMyFarmZuZhongThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongThreeTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabels.text = @"监控摄像";
            //            farmLiveTableViewCell.countLabels.text = @"省心方案";
            farmLiveTableViewCell.priceLabels.text = [NSString stringWithFormat:@"¥%@",self.model.cameraPrice];
            return farmLiveTableViewCell;
            
        }
        else if (indexPath.row == 2){
            NYNMyFarmZuZhongThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongThreeTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabels.text = @"标志标识";
            farmLiveTableViewCell.countLabels.text = [NSString stringWithFormat:@"%@",self.model.signboardName];
            farmLiveTableViewCell.priceLabels.text = [NSString stringWithFormat:@"¥%@",self.model.signboardPrice];
            return farmLiveTableViewCell;
        }
        else if (indexPath.row == 3){
            NYNMyFarmZuZhongThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongThreeTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabels.text = @"产品加工";
            farmLiveTableViewCell.countLabels.text = [NSString stringWithFormat:@"%@",self.model.processName];
            farmLiveTableViewCell.priceLabels.text = [NSString stringWithFormat:@"¥%@",self.model.processTotalPrice];
            
            return farmLiveTableViewCell;
            
        }
        else{
            NYNMyFarmZuZhongThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongThreeTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabels.text = @"动物保险";
            farmLiveTableViewCell.countLabels.text = [NSString stringWithFormat:@"%@",@"自然灾害保险"];
            farmLiveTableViewCell.priceLabels.text = [NSString stringWithFormat:@"¥%@",@"0"];
            
            return farmLiveTableViewCell;
            
        }
    }
    else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            NYNMyFarmZuZhongThreeTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongThreeTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.titleLabels.text = @"收获配送";
            farmLiveTableViewCell.countLabels.text = [NSString stringWithFormat:@"¥%@",self.model.freight];
            farmLiveTableViewCell.priceLabels.text = [NSString stringWithFormat:@"(¥%@/%@)",self.model.freight,self.model.majorProductUnit];
            
            return farmLiveTableViewCell;
            
            
        }
        else{
            NYNMyFarmZuZhongFourTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmZuZhongFourTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.nameLabel.text = [NSString stringWithFormat:@"收货人:%@",self.model.shipConsignee];
            farmLiveTableViewCell.telLabel.text = [NSString stringWithFormat:@"%@",self.model.shipPhone];
            farmLiveTableViewCell.addressLabel.text = [NSString stringWithFormat:@"%@",self.model.shipAddress];
            
            return farmLiveTableViewCell;
            
        }
    }
    else{
        NYNMyFarmAddressTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMyFarmAddressTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"合计:¥ %@",self.model.orderAmount];
        
        
        NSString *str1 = [NSString stringWithFormat:@"合计:"];
        NSString *str2 = [NSString stringWithFormat:@"¥ %@",self.model.orderAmount];
        NSString *str = [NSString stringWithFormat:@"%@%@",str1,str2];
        
        farmLiveTableViewCell.priceLabel.attributedText = [MyControl CreateNSAttributedString:str thePartOneIndex:NSMakeRange(0, str1.length) withColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:13] andPartTwoIndex:NSMakeRange(str1.length , str2.length) withColor:Colorf8491a withFont:[UIFont systemFontOfSize:15]];
        return farmLiveTableViewCell;
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return JZHEIGHT(45);
        }else{
            return JZHEIGHT(45);
        }
    }
    else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return JZHEIGHT(45);
            
        }else{
            return JZHEIGHT(70);
            
        }
        
    }
    else{
        return JZHEIGHT(45);
        
    }
    
    
    
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, section == 0 ? 0.00001 : JZHEIGHT(5))];
    v.backgroundColor = Colore3e3e3;
    return v;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,  0.00001 )];
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0.00001 : JZHEIGHT(5);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(UITableView *)zuDiZhongZhiTable{
    if (!_zuDiZhongZhiTable) {
        _zuDiZhongZhiTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStyleGrouped];
    }
    return _zuDiZhongZhiTable;
}

- (void)new{
    JZLog(@"新任务");
    NYNMyFarmXinRenWuViewController *vc = [[NYNMyFarmXinRenWuViewController alloc]init];
    vc.productId = self.model.majorProductId;
    vc.yangZhiCount = [self.model.majorProductQuantity intValue];
    vc.cycTime = [self.model.cycleTime intValue];
    vc.orderId = self.orderId;
    vc.typeStr = @"1";

    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
