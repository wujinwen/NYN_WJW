//
//  NYNMyFarmXinRenWuViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/22.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMyFarmXinRenWuViewController.h"

#import "NYNGouMaiView.h"
#import "NYNYangZhiFangAnModel.h"

#import "NYNFangAnHeaderViewTableViewCell.h"
#import "NYNBoZhongRiQiTableViewCell.h"
#import "NYNZhongZhiZhouQiTableViewCell.h"
#import "NYNShengWuFeiTableViewCell.h"
#import "NYNShiFeiCiShuTableViewCell.h"
#import "NYNMeiCiPaiZhaoTableViewCell.h"
#import "NYNDIYTableViewCell.h"
#import "NYNMyFarmNewHistoryViewController.h"

#import "JZDatePickerView.h"
#import "NYNPayViewController.h"
#import "NYNDealModel.h"


@interface NYNMyFarmXinRenWuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *yangZhiFangAnTable;
@property (nonatomic,strong) NYNGouMaiView* bottomView;

//这里初始化的数据cycleTime单独放出来  不放在模型里面
@property (nonatomic,copy) NSString *cycleTime;
@property (nonatomic,strong) JZDatePickerView *pickerView;



@property (nonatomic,assign) double totlePrice;

@property (nonatomic,strong) NYNYangZhiFangAnModel *nowDateChooseModel;
@end

@implementation NYNMyFarmXinRenWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"新任务";
    [self SetUI];
    
        [self showLoadingView:@""];
    NSDictionary * dic=@{@"farmingId":self.productId,@"type":@"newTask"};
    
        [NYNNetTool GetZiDingYiFangAnWithparams:dic isTestLogin:YES progress:^(NSProgress *progress) {
    
        } success:^(id success) {
            if([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]){
                [self.dataArr removeAllObjects];
                
                NSMutableArray *lieBiaoArr = [[NSMutableArray alloc]init];
                for (NSDictionary *dc in success[@"data"]) {
                    NYNYangZhiFangAnModel *model = [NYNYangZhiFangAnModel mj_objectWithKeyValues:dc];
                    model.chooseDate = [NSDate date];

                    [lieBiaoArr addObject:model];
                }
                NYNYangZhiFangAnModel *shiFeiModel = [[NYNYangZhiFangAnModel alloc]init];
                shiFeiModel.ctype = @"1";
                shiFeiModel.chooseDate = [NSDate date];

                NYNYangZhiFangAnModel *caoNiMaModel = [[NYNYangZhiFangAnModel alloc]init];
                caoNiMaModel.ctype = @"6";
                caoNiMaModel.chooseDate = [NSDate date];

                //创建周期model  前台手动增加一个cellmodel
                NYNYangZhiFangAnModel *zhouQiModel = [[NYNYangZhiFangAnModel alloc]init];
                zhouQiModel.ctype = @"3";
                zhouQiModel.chooseDate = [NSDate date];

                
                //                    zhouQiModel.count = [NSString stringWithFormat:@"%d",self.chuShiHuaModel.cycTime];
                zhouQiModel.checked = @"1";
//                [self.dataArr addObject:zhouQiModel];
                
                for (NYNYangZhiFangAnModel *subM in lieBiaoArr) {
                    if ([subM.ctype isEqualToString:@"1"]) {
                        [shiFeiModel.subArr addObject:subM];
                    }
                    else if ([subM.ctype isEqualToString:@"6"]){
                        [caoNiMaModel.subArr addObject:subM];
                    }
                    else{
                        [self.dataArr addObject:subM];
                        
                        if ([subM.ctype isEqualToString:@"2"]) {
                            subM.chooseDate = [NSDate date];
                        }
                    }
                }
                
                caoNiMaModel.checked = @"1";
                shiFeiModel.checked = @"1";
                
                caoNiMaModel.count = @"0";
                shiFeiModel.count = @"0";
                
                for (int i = 0; i < caoNiMaModel.subArr.count; i++) {
                    NYNYangZhiFangAnModel *caoMD = caoNiMaModel.subArr[i];
                    if (i == 0) {
                        caoMD.checked = @"1";
                    }else{
                        caoMD.checked = @"0";
                    }
                }
                
                for (int i = 0; i < shiFeiModel.subArr.count; i++) {
                    NYNYangZhiFangAnModel *caoMD = shiFeiModel.subArr[i];
                    if (i == 0) {
                        caoMD.checked = @"1";
                    }else{
                        caoMD.checked = @"0";
                    }
                }
                
                //最后将这个数据加入
                if (caoNiMaModel.subArr.count > 0) {
                    //这个是ctype=6
                    [self.dataArr addObject:caoNiMaModel];
                }
                
                if (shiFeiModel.subArr.count > 0) {
                    //这个是ctype=1
                    [self.dataArr addObject:shiFeiModel];
                }
                
                [self createYangZhiFangUI];
                
                [self reloadPrice];
            }else{
                [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
    
            }
            [self hideLoadingView];
            
        } failure:^(NSError *failure) {
            [self hideLoadingView];
    
        }];

}

- (void)SetUI{
    
    UIButton *newButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(60), JZHEIGHT(15))];
    [newButton setTitle:@"任务记录" forState:0];
    newButton.titleLabel.font = JZFont(13);
    [newButton setTitleColor:[UIColor whiteColor] forState:0];
    [newButton addTarget:self action:@selector(history) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cusView = [[UIBarButtonItem alloc]initWithCustomView:newButton];
    self.navigationItem.rightBarButtonItem = cusView;
}

- (void)createYangZhiFangUI{
    
    [self createyangZhiFangAnTable];
    
    
    self.bottomView = [[NYNGouMaiView alloc]init];
    [self.bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) -64, SCREENWIDTH, JZHEIGHT(45))];
    [self.bottomView.goumaiBT setTitle:@"确定" forState:0];
    __weak typeof(self)weakSelf = self;
    self.bottomView.goumaiBlock = ^(NSString *strValue) {
        
        
//        
//        if (weakSelf.modelBack) {
//            weakSelf.modelBack(weakSelf.chuShiHuaModel);
//        }
//        
//        POST_NTF(@"yangZhiNotify", nil);
        
//        [weakSelf.navigationController popViewControllerAnimated:YES];
        
        //这里拼接订单的数据
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:[NSString stringWithFormat:@"%@",weakSelf.orderId] forKey:@"orderId"];
//        [dic setObject:[NSString stringWithFormat:@"%@",weakSelf.productId] forKey:@"productId"];
//        [dic setObject:[NSString stringWithFormat:@"%d",weakSelf.yangZhiCount] forKey:@"quantity"];
//        [dic setObject:[NSString stringWithFormat:@"%d",weakSelf.yangZhiCount] forKey:@"executeDate"];

        
        NSMutableArray *taskItemModels = [[NSMutableArray alloc]init];

        //处理数组里面的数据
        {
            for (NYNYangZhiFangAnModel *model in weakSelf.dataArr) {
                //只有选中才计算价格
                if ([model.checked isEqualToString:@"1"]) {
                    
                    NSMutableDictionary *d ;
                    
                    if ([model.ctype isEqualToString:@"0"]) {
                        d = @{@"productId":@([model.artProductId integerValue]),
                              @"quantity":@(1),@"executeDate":[MyControl timeToTimeCode:model.chooseDate]}.mutableCopy;
                    }
                    else if ([model.ctype isEqualToString:@"1"]){
                        //这里清理出来选中的子单元格
                        NYNYangZhiFangAnModel *nowSubModel;
                        for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                            if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                                nowSubModel = subFirstDataModel;
                            }
                        }
                        
                        d = @{@"productId":@([nowSubModel.artProductId integerValue]),
                              @"quantity":@(1),@"executeDate":[MyControl timeToTimeCode:model.chooseDate]}.mutableCopy;
                    }
                    else if ([model.ctype isEqualToString:@"2"]){
                        NSString *timeStr = [MyControl timeToTimeCode:model.executeDate];
                        NSArray *rr = @[@{@"title":model.categoryName,@"executeDate":timeStr}];
                        
                        d = @{@"productId":@([model.artProductId integerValue]),
                        
                              @"quantity":@(1),
                              @"counttaskItemModels":rr,@"executeDate":[MyControl timeToTimeCode:model.chooseDate]
                              }.mutableCopy;
                        
                    }
                    else if ([model.ctype isEqualToString:@"3"]){
                        d = @{@"productId":@([model.artProductId integerValue]),
                              @"quantity":@(1),@"executeDate":[MyControl timeToTimeCode:model.chooseDate]}.mutableCopy;
                    }
                    else if ([model.ctype isEqualToString:@"4"]){
                        d = @{@"productId":@([model.artProductId integerValue]),
                          
                              @"quantity":@([model.count intValue]),
                              @"duration":@(1),
                              @"interval":@(1),
                            @"executeDate":[MyControl timeToTimeCode:model.chooseDate]
                              }.mutableCopy;
                    }
                    else if ([model.ctype isEqualToString:@"6"]){
                        //这里清理出来选中的子单元格
                        NYNYangZhiFangAnModel *nowSubModel;
                        for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                            if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                                nowSubModel = subFirstDataModel;
                            }
                        }
                        
                        d = @{@"productId":@([nowSubModel.artProductId integerValue]),@"type":@"PLAN",
                              @"quantity":@1,
                              @"executeDate":[MyControl timeToTimeCode:model.chooseDate]}.mutableCopy;
                    }
                    else{
                        
                    }
                    
                    if ([model.ctype isEqualToString:@"3"]) {
                        
                    }else{
                        [taskItemModels addObject:d];
                    }
                    
                }
            }
        }
        

        [dic setObject:userInfoModel.token forKey:@"token"];
        [dic setObject:taskItemModels forKey:@"taskItemModels"];

        [weakSelf showLoadingView:@""];
        [NYNNetTool MyFarmNewAddTaskWithparams:@{@"data":[MyControl dictionaryToJson:dic]} isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                
                NYNDealModel *model = [NYNDealModel mj_objectWithKeyValues:success[@"data"]];
                NYNPayViewController *vc = [[NYNPayViewController alloc]init];
                vc.model = model;
                vc.typeStr = @"3";
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }else{
                [weakSelf showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
//                [weakSelf showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            }
            
            [weakSelf hideLoadingView];
        } failure:^(NSError *failure) {
            [weakSelf hideLoadingView];
        }];
        
        
    };
    [self.view addSubview:self.bottomView];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(80))];
    footerView.backgroundColor = Colore3e3e3;
//    self.yangZhiFangAnTable.tableFooterView = footerView;
    
    UILabel *textLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREENWIDTH - 20, footerView.height - 20)];
    textLB.text = @"提示：您选择了施肥，浇水次数后，农场会根据种植经验和作物实 况进行合理分配施肥，浇水时间，如果您想自己制定，可点击自定 义方案进行制定。";
    textLB.font = JZFont(12);
    textLB.textColor = Color888888;
    textLB.numberOfLines = 0;
    [footerView addSubview:textLB];
    
    
    
    //这里最后创建pickerview
    [self.view addSubview:self.pickerView];
    self.pickerView.MakeClick = ^(NSDate *date) {
        
        weakSelf.nowDateChooseModel.chooseDate = weakSelf.pickerView.nowDate;
        [weakSelf.yangZhiFangAnTable reloadData];
    };
}

- (void)createyangZhiFangAnTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.yangZhiFangAnTable.delegate = self;
    self.yangZhiFangAnTable.dataSource = self;
    self.yangZhiFangAnTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.yangZhiFangAnTable.showsVerticalScrollIndicator = NO;
    self.yangZhiFangAnTable.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:self.yangZhiFangAnTable];
}

    

//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    JZLog(@"%@", [NSString stringWithFormat:@"totleSectionNum:%lu",(unsigned long)self.dataArr.count]);
    
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NYNYangZhiFangAnModel *model = self.dataArr[section];
    if ([model.ctype isEqualToString:@"0"]) {
        JZLog(@"%@", [NSString stringWithFormat:@"section:%ld  rownum========2",(long)section]);
        if ([model.checked isEqualToString:@"0"]) {
            return 1;
        }
        return 2;
    }
    else if ([model.ctype isEqualToString:@"1"]){
        JZLog(@"%@", [NSString stringWithFormat:@"section:%ld  rownum========%lu",(long)section,model.subArr.count + 2]);
        if ([model.checked isEqualToString:@"0"]) {
            return 1;
        }
        return model.subArr.count + 2;
    }
    else if ([model.ctype isEqualToString:@"2"]){
        JZLog(@"%@", [NSString stringWithFormat:@"section:%ld  rownum========2",(long)section]);
        if ([model.checked isEqualToString:@"0"]) {
            return 1;
        }
        return 2;
    }
    else if ([model.ctype isEqualToString:@"3"]){
        JZLog(@"%@", [NSString stringWithFormat:@"section:%ld  rownum========1",(long)section]);
        if ([model.checked isEqualToString:@"0"]) {
            return 1;
        }
        return 1;
    }
    else if ([model.ctype isEqualToString:@"4"]){
        JZLog(@"%@", [NSString stringWithFormat:@"section:%ld  rownum========4",(long)section]);
        if ([model.checked isEqualToString:@"0"]) {
            return 1;
        }
        return 3;
    }
    else if ([model.ctype isEqualToString:@"6"]){
        JZLog(@"%@", [NSString stringWithFormat:@"section:%ld  rownum========4",(long)section]);
        if ([model.checked isEqualToString:@"0"]) {
            return 1;
        }
        return model.subArr.count + 1;
    }
    else{
        JZLog(@"%@", [NSString stringWithFormat:@"section:%ld  rownum========0",(long)section]);
        
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNYangZhiFangAnModel *model = self.dataArr[indexPath.section];
    
    if ([model.ctype isEqualToString:@"0"]) {
        
        if (indexPath.row == 0) {
            NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            
            if ([model.checked isEqualToString:@"1"]) {
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
            }else{
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
                
            }
            
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@（￥%@/%@）",model.farmArtName,model.price,model.unitName];
            double pc = [model.price doubleValue] * self.yangZhiCount ;
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",pc];
            
            return farmLiveTableViewCell;
        }else{
            NYNBoZhongRiQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNBoZhongRiQiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",@"拍照日期"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设置格式：zzz表示时区
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            //NSDate转NSString
            NSString *currentDateString = [dateFormatter stringFromDate:model.chooseDate];
            farmLiveTableViewCell.riqiLabel.text = currentDateString;
            
            __weak typeof(self)weakSelf = self;
            farmLiveTableViewCell.cellClick = ^(NSString *s) {
                weakSelf.nowDateChooseModel = model;
                [weakSelf.pickerView showPickerView];
                
            };
            
            return farmLiveTableViewCell;
        }
        
    }
    else if ([model.ctype isEqualToString:@"1"]){
        if (indexPath.row == 0) {
            NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
            }
            if ([model.checked isEqualToString:@"1"]) {
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
            }else{
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
            }
            
            //这里清理出来选中的子单元格
            NYNYangZhiFangAnModel *nowSubModel;
            for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                    nowSubModel = subFirstDataModel;
                }
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",nowSubModel.categoryName];
            
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[nowSubModel.price doubleValue] * self.yangZhiCount ];
            
            return farmLiveTableViewCell;
        }
        else if(indexPath.row == model.subArr.count + 2 - 1){
            NYNBoZhongRiQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNBoZhongRiQiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",@"拍照日期"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设置格式：zzz表示时区
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            //NSDate转NSString
            NSString *currentDateString = [dateFormatter stringFromDate:model.chooseDate];
            farmLiveTableViewCell.riqiLabel.text = currentDateString;
            
            __weak typeof(self)weakSelf = self;
            farmLiveTableViewCell.cellClick = ^(NSString *s) {
                weakSelf.nowDateChooseModel = model;
                [weakSelf.pickerView showPickerView];
                
            };
            
            return farmLiveTableViewCell;
        }
        else{
            NYNShengWuFeiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShengWuFeiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            
            
            NYNYangZhiFangAnModel *nowSubModel = model.subArr[indexPath.row - 1];
            farmLiveTableViewCell.iconLabel.text = nowSubModel.farmArtName;
            farmLiveTableViewCell.danWeiLabel.text = [NSString stringWithFormat:@"￥%@/%@",nowSubModel.price,nowSubModel.unitName];
            
            
            if ([nowSubModel.checked isEqualToString:@"1"]) {
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected4");
            }else{
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected");
            }
            
            __weak typeof(self)weakSelf = self;
            farmLiveTableViewCell.cellClick = ^(NSString *s) {
                
                for (NYNYangZhiFangAnModel *dModel in model.subArr) {
                    dModel.checked = @"0";
                }
                nowSubModel.checked = @"1";
                
                //                NSIndexPath *IP = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                //                [weakSelf.yangZhiFangAnTable reloadRowsAtIndexPaths:@[IP] withRowAnimation:UITableViewRowAnimationNone];
                
                NSIndexSet *st = [NSIndexSet indexSetWithIndex:indexPath.section];
                [weakSelf.yangZhiFangAnTable reloadSections:st withRowAnimation:UITableViewRowAnimationNone];
                
                [weakSelf reloadPrice];
                
            };
            
            return farmLiveTableViewCell;
        }
        
        
    }
    else if ([model.ctype isEqualToString:@"2"]){
        
        //播种
        if (indexPath.row == 0) {
            NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
            }
            if ([model.checked isEqualToString:@"1"]) {
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
            }else{
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",model.categoryName];
            
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.price doubleValue] * self.yangZhiCount];
            
            
            return farmLiveTableViewCell;
        }else{
            NYNBoZhongRiQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNBoZhongRiQiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",@"拍照日期"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设置格式：zzz表示时区
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            //NSDate转NSString
            NSString *currentDateString = [dateFormatter stringFromDate:model.chooseDate];
            farmLiveTableViewCell.riqiLabel.text = currentDateString;
            
            __weak typeof(self)weakSelf = self;
            farmLiveTableViewCell.cellClick = ^(NSString *s) {
                weakSelf.nowDateChooseModel = model;
                [weakSelf.pickerView showPickerView];
                
            };
            
            return farmLiveTableViewCell;
        }
        
    }
    else if ([model.ctype isEqualToString:@"3"]){
        NYNZhongZhiZhouQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNZhongZhiZhouQiTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        farmLiveTableViewCell.count = self.cycTime;
        
        __weak typeof(self)weakSelf = self;
        farmLiveTableViewCell.clickBlock = ^(int count) {
            weakSelf.cycTime = count;
        };
        
        
        if ([model.checked isEqualToString:@"1"]) {
            farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
        }else{
            farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
            
        }
        return farmLiveTableViewCell;
        
    }
    else if ([model.ctype isEqualToString:@"4"]){
        //拍照
        if (indexPath.row == 0) {
            NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            if ([model.checked isEqualToString:@"1"]) {
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
            }else{
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
            }
            
            farmLiveTableViewCell.iconLabel.text = model.categoryName;
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.price doubleValue] * ([model.duration intValue] / [model.interval intValue] * [model.count intValue])];
            
            return farmLiveTableViewCell;
        }
        else if(indexPath.row == 1){
            NYNMeiCiPaiZhaoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeiCiPaiZhaoTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.iconLabel.text = model.countTitle;
            farmLiveTableViewCell.danweiLabel.text= model.unitName;
            farmLiveTableViewCell.count = [model.count intValue];
            
            
            __weak typeof(self)WeakSelf = self;
            farmLiveTableViewCell.clickBlock = ^(int count) {
                model.count = [NSString stringWithFormat:@"%d",count];
                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                [WeakSelf.yangZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
                
                
                [WeakSelf reloadPrice];
                
            };
            
            return farmLiveTableViewCell;
        }
        else{
            NYNBoZhongRiQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNBoZhongRiQiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",@"拍照日期"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设置格式：zzz表示时区
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            //NSDate转NSString
            NSString *currentDateString = [dateFormatter stringFromDate:model.chooseDate];
            farmLiveTableViewCell.riqiLabel.text = currentDateString;
            
            __weak typeof(self)weakSelf = self;
            farmLiveTableViewCell.cellClick = ^(NSString *s) {
                weakSelf.nowDateChooseModel = model;
                [weakSelf.pickerView showPickerView];

            };
            
            return farmLiveTableViewCell;
        }
   }
    
    else if ([model.ctype isEqualToString:@"6"]){
        if (indexPath.row == 0) {
            NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
            }
            if ([model.checked isEqualToString:@"1"]) {
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
            }else{
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
            }
            
            //这里清理出来选中的子单元格
            NYNYangZhiFangAnModel *nowSubModel;
            for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                    nowSubModel = subFirstDataModel;
                }
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",nowSubModel.categoryName];
            
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[nowSubModel.price doubleValue] * self.yangZhiCount ];
            
            
            
            return farmLiveTableViewCell;
        }
        
        else{
            NYNShengWuFeiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShengWuFeiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            
            NYNYangZhiFangAnModel *nowSubModel = model.subArr[indexPath.row - 1];
            farmLiveTableViewCell.iconLabel.text = nowSubModel.farmArtName;
            farmLiveTableViewCell.danWeiLabel.text = [NSString stringWithFormat:@"￥%@/%@",nowSubModel.price,nowSubModel.unitName];
            if ([nowSubModel.checked isEqualToString:@"1"]) {
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected4");
            }else{
                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected");
            }
            
            
            __weak typeof(self)weakSelf = self;
            farmLiveTableViewCell.cellClick = ^(NSString *s) {
                
                for (NYNYangZhiFangAnModel *dModel in model.subArr) {
                    dModel.checked = @"0";
                }
                nowSubModel.checked = @"1";
                
                NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
                [weakSelf.yangZhiFangAnTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                
                [weakSelf reloadPrice];
                
            };
            
            return farmLiveTableViewCell;
        }
        
        
    }
    
    else{
        NYNMeiCiPaiZhaoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeiCiPaiZhaoTableViewCell class]) owner:self options:nil].firstObject;
        }
        farmLiveTableViewCell.iconLabel.text = model.countTitle;
        farmLiveTableViewCell.danweiLabel.text= model.unitName;
        farmLiveTableViewCell.count = [model.count intValue];
        
        
        __weak typeof(self)WeakSelf = self;
        farmLiveTableViewCell.clickBlock = ^(int count) {
            model.count = [NSString stringWithFormat:@"%d",count];
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
            [WeakSelf.yangZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        };
        
        return farmLiveTableViewCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NYNYangZhiFangAnModel *model = self.dataArr[indexPath.section];
    
    if (indexPath.row == 0) {
        if ([model.checked isEqualToString:@"1"] ) {
            model.checked = @"0";
        }else{
            model.checked = @"1";
        }
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
        [self.yangZhiFangAnTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        
        [self reloadPrice];
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,section == 0 ?  0.0001 : JZHEIGHT(5))];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }else{
        return JZHEIGHT(5);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.0001)];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}


#pragma 懒加载
-(UITableView *)yangZhiFangAnTable
{
    if (!_yangZhiFangAnTable) {
        _yangZhiFangAnTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(45) ) style:UITableViewStyleGrouped];
        //        _yangZhiFangAnTable.backgroundColor = [UIColor redColor];
    }
    return _yangZhiFangAnTable;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (void)reloadPrice{
    self.totlePrice = 0;
    for (NYNYangZhiFangAnModel *model in self.dataArr) {
        
        if ([model.checked isEqualToString:@"1"]) {
            
            if ([model.ctype isEqualToString:@"0"]) {
                double addPrice = [model.price doubleValue] * self.yangZhiCount;
                self.totlePrice = self.totlePrice + addPrice;
            }
            else if ([model.ctype isEqualToString:@"1"]){
                //这里清理出来选中的子单元格
                NYNYangZhiFangAnModel *nowSubModel;
                for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                    if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                        nowSubModel = subFirstDataModel;
                    }
                }
                double addPrice = [nowSubModel.price doubleValue] * self.yangZhiCount;
                self.totlePrice = self.totlePrice + addPrice;
            }
            else if ([model.ctype isEqualToString:@"2"]){
                double addPrice = [model.price doubleValue] * self.yangZhiCount;
                self.totlePrice = self.totlePrice + addPrice;
            }
            else if ([model.ctype isEqualToString:@"3"]){
                //养殖周期
            }
            else if ([model.ctype isEqualToString:@"4"]){
                double addPrice = [model.price doubleValue] * ([model.duration intValue] / [model.interval intValue] * [model.count intValue]);
                self.totlePrice = self.totlePrice + addPrice;
            }
            else if ([model.ctype isEqualToString:@"6"]){
                //这里清理出来选中的子单元格
                NYNYangZhiFangAnModel *nowSubModel;
                for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                    if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                        nowSubModel = subFirstDataModel;
                    }
                }
                double addPrice = [nowSubModel.price doubleValue] * self.yangZhiCount;
                self.totlePrice = self.totlePrice + addPrice;
            }
            else {
                JZLog(@"未知的ctype出现，编号为:%@",model.ctype);
            }
            
            
            
        }
        
        
        
    }
    
    JZLog(@"目前总价为:%.2f",self.totlePrice);
    
    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"¥%.2f",self.totlePrice];
}
- (void)history{
    NYNMyFarmNewHistoryViewController *vc = [[NYNMyFarmNewHistoryViewController alloc]init];
    vc.orderId = self.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (JZDatePickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[JZDatePickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, JZHEIGHT(200))];
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _pickerView;
}
@end
