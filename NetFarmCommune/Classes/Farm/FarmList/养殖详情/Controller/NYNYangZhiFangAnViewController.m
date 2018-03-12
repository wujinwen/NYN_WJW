//
//  NYNYangZhiFangAnViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/7/6.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNYangZhiFangAnViewController.h"
#import "NYNGouMaiView.h"
#import "NYNYangZhiFangAnModel.h"

#import "NYNFangAnHeaderViewTableViewCell.h"
#import "NYNBoZhongRiQiTableViewCell.h"
#import "NYNZhongZhiZhouQiTableViewCell.h"
#import "NYNShengWuFeiTableViewCell.h"
#import "NYNShiFeiCiShuTableViewCell.h"
#import "NYNMeiCiPaiZhaoTableViewCell.h"
#import "NYNDIYTableViewCell.h"

@interface NYNYangZhiFangAnViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *yangZhiFangAnTable;
@property (nonatomic,strong) NYNGouMaiView* bottomView;

//这里初始化的数据cycleTime单独放出来  不放在模型里面
@property (nonatomic,copy) NSString *cycleTime;



@property (nonatomic,assign) double totlePrice;
@end

@implementation NYNYangZhiFangAnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"养殖方案";
    
    [self showLoadingView:@""];
//    self.requireID = [NSString stringWithFormat:@"%d",1];
    
    [NYNNetTool GetMoRenFangAnWithparams:@{@"farmingId":self.farmingId} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        NSLog(@"%@",success);
        
        
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            
            [self.dataArr removeAllObjects];
            
            self.cycleTime = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",success[@"data"][@"cycleTime"]]];
            
            NSMutableArray *arr = [NSMutableArray arrayWithArray:success[@"data"][@"artOrderItemResults"]];
            
            NSMutableArray *lieBiaoArr = [[NSMutableArray alloc]init];
            for (NSDictionary *dc in arr) {
                NYNYangZhiFangAnModel *model = [NYNYangZhiFangAnModel mj_objectWithKeyValues:dc];
                [lieBiaoArr addObject:model];
            }
            
            NYNYangZhiFangAnModel *shiFeiModel = [[NYNYangZhiFangAnModel alloc]init];
            shiFeiModel.ctype = @"1";
            
            NYNYangZhiFangAnModel *caoNiMaModel = [[NYNYangZhiFangAnModel alloc]init];
            caoNiMaModel.ctype = @"6";
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

            //后台数据有多个check = 1
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
            [self showLoadingView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        
        [self hideLoadingView];
    }];
    
 
}


- (void)createYangZhiFangUI{
    
    [self createyangZhiFangAnTable];

    
    self.bottomView = [[NYNGouMaiView alloc]init];
    [self.bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) -64, SCREENWIDTH, JZHEIGHT(45))];
    [self.bottomView.goumaiBT setTitle:@"确定" forState:0];
    __weak typeof(self)weakSelf = self;
    self.bottomView.goumaiBlock = ^(NSString *strValue) {
        
        
        
        if (weakSelf.modelBack) {
            weakSelf.modelBack(weakSelf.chuShiHuaModel);
        }
        
        POST_NTF(@"yangZhiNotify", nil);
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:self.bottomView];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(0.00001))];
    footerView.backgroundColor = Colore3e3e3;
    self.yangZhiFangAnTable.tableFooterView = footerView;
    
    UILabel *textLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREENWIDTH - 20, 0.00001)];
//    footerView.height - 20
    textLB.text = @"";
    textLB.font = JZFont(12);
    textLB.textColor = Color888888;
    textLB.numberOfLines = 0;
    [footerView addSubview:textLB];

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
            double pc = [model.price doubleValue] * self.yangZhiCount * [model.count intValue];
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",pc];
            
            return farmLiveTableViewCell;
        }else{
            
            
            NYNShiFeiCiShuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShiFeiCiShuTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.count = [model.count intValue];
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",model.farmArtName];
            __weak typeof(self) weakSelf = self;
            farmLiveTableViewCell.tfInputBlock = ^(int count) {
                
                model.count = [NSString stringWithFormat:@"%d",count];
                NSIndexPath *IP = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                [weakSelf.yangZhiFangAnTable reloadRowsAtIndexPaths:@[IP] withRowAnimation:UITableViewRowAnimationNone];
                
                [weakSelf reloadPrice];
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
            
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[nowSubModel.price doubleValue] * self.yangZhiCount * [nowSubModel.count intValue]];
            
            return farmLiveTableViewCell;
        }
        else if(indexPath.row == model.subArr.count + 2 - 1){
            NYNShiFeiCiShuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShiFeiCiShuTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            //这里清理出来选中的子单元格
            NYNYangZhiFangAnModel *nowSubModel;
            for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                    nowSubModel = subFirstDataModel;
                }
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",nowSubModel.countTitle];
            farmLiveTableViewCell.count = [nowSubModel.count intValue];
            
            __weak typeof(self)weakSelf = self;
            farmLiveTableViewCell.tfInputBlock = ^(int count) {
                nowSubModel.count = [NSString stringWithFormat:@"%d",count];
                
                NSIndexPath *IP = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                [weakSelf.yangZhiFangAnTable reloadRowsAtIndexPaths:@[IP] withRowAnimation:UITableViewRowAnimationNone];
                
                [weakSelf reloadPrice];

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
            farmLiveTableViewCell.danWeiLabel.text = [NSString stringWithFormat:@"￥%.2f/%@",[nowSubModel.price doubleValue],nowSubModel.unitName];
            
            
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
            
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[model.price doubleValue] * self.yangZhiCount];
            
            
            return farmLiveTableViewCell;
        }else{
            NYNBoZhongRiQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNBoZhongRiQiTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",model.unionTitle];
            
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设置格式：zzz表示时区
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            //NSDate转NSString
            NSString *currentDateString = [dateFormatter stringFromDate:model.chooseDate];
            farmLiveTableViewCell.riqiLabel.text = currentDateString;
            
            return farmLiveTableViewCell;
        }
        
    }
    else if ([model.ctype isEqualToString:@"3"]){
        //3-周期style
        NYNZhongZhiZhouQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
        if (farmLiveTableViewCell == nil) {
            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNZhongZhiZhouQiTableViewCell class]) owner:self options:nil].firstObject;
        }
        
        farmLiveTableViewCell.iconLabel.text = @"养殖周期";
        farmLiveTableViewCell.count = self.chuShiHuaModel.cycTime;
        
        __weak typeof(self)weakSelf = self;
        farmLiveTableViewCell.clickBlock = ^(int count) {
            weakSelf.chuShiHuaModel.cycTime = count;
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
            int a =_yangzhiTime/ [model.interval intValue];
            int b = (a==0)?(a=1):a;
            
            
            farmLiveTableViewCell.iconLabel.text = model.categoryName;
//            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.price doubleValue] * ([model.duration intValue] / [model.interval intValue] * [model.count intValue])];
            farmLiveTableViewCell.priceLabel.text =[NSString stringWithFormat:@".2f%f",b* [model.count intValue]* [model.price doubleValue]] ;
            
            return farmLiveTableViewCell;
        }
        else if(indexPath.row == 1){
            NYNMeiCiPaiZhaoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeiCiPaiZhaoTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.iconLabel.text = @"每次拍照";
            
//            farmLiveTableViewCell.danweiLabel.text= model.unitName;
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
        else if(indexPath.row == 2){
            NYNMeiCiPaiZhaoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeiCiPaiZhaoTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.iconLabel.text = @"拍照间隔";
            farmLiveTableViewCell.danweiLabel.text= @"天";
            farmLiveTableViewCell.count = [model.interval intValue];
            
            __weak typeof(self)WeakSelf = self;
            __weak typeof(farmLiveTableViewCell)WeakFarmLiveTableViewCell = farmLiveTableViewCell;

            farmLiveTableViewCell.clickBlock = ^(int count) {

//                if (count > [model.duration intValue]){
//                    WeakFarmLiveTableViewCell.count = [model.duration intValue];
//
//                    [WeakSelf showTextProgressView:@"不能大于周期时间"];
//                    [WeakSelf hideLoadingView];
//                }
//                else
                
                    if (count < 1) {
                    WeakFarmLiveTableViewCell.count = 1;
                    
                    [WeakSelf showTextProgressView:@"不能为小于1"];
                    [WeakSelf hideLoadingView];
                }
                else{
                    model.interval = [NSString stringWithFormat:@"%d",count];
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                    [WeakSelf.yangZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
                }

                [WeakSelf reloadPrice];

            };
            
            return farmLiveTableViewCell;
        }
        else if(indexPath.row == 3){
            NYNMeiCiPaiZhaoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeiCiPaiZhaoTableViewCell class]) owner:self options:nil].firstObject;
            }
            farmLiveTableViewCell.iconLabel.text = model.durationTitle;
            farmLiveTableViewCell.danweiLabel.text= model.unitName;
            farmLiveTableViewCell.count = [model.duration intValue];
            
            
            __weak typeof(self)WeakSelf = self;
//            __weak typeof(farmLiveTableViewCell)WeakFarmLiveTableViewCell = farmLiveTableViewCell;

            farmLiveTableViewCell.clickBlock = ^(int count) {
                
                if(count < [model.interval intValue]){
                    
                    if (count < 1) {
                        
                    model.interval = @"1";
                    model.duration = @"1";
                        
                    }else{
                    
                    model.interval = [NSString stringWithFormat:@"%d",count];
                    model.duration = [NSString stringWithFormat:@"%d",count];
                        
                    }
                }else{
                
                    model.duration = [NSString stringWithFormat:@"%d",count];
                
                }
                
                
                

                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                [WeakSelf.yangZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
                
                NSIndexSet *st = [NSIndexSet indexSetWithIndex:indexPath.section];
                [WeakSelf.yangZhiFangAnTable reloadSections:st withRowAnimation:UITableViewRowAnimationNone];
                [WeakSelf reloadPrice];

            };
            
            return farmLiveTableViewCell;
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
                
                [WeakSelf reloadPrice];

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
            
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[nowSubModel.price doubleValue] * self.yangZhiCount ];
            
            
            
            return farmLiveTableViewCell;
        }

        else{
            NYNShengWuFeiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShengWuFeiTableViewCell class]) owner:self options:nil].firstObject;
            }

            
            NYNYangZhiFangAnModel *nowSubModel = model.subArr[indexPath.row - 1];
            farmLiveTableViewCell.iconLabel.text = nowSubModel.farmArtName;
            farmLiveTableViewCell.danWeiLabel.text = [NSString stringWithFormat:@"￥%.2f/%@",[nowSubModel.price doubleValue],nowSubModel.unitName];
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
                double addPrice = [model.price doubleValue] * self.yangZhiCount * [model.count intValue];
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
                double addPrice = [nowSubModel.price doubleValue] * self.yangZhiCount * [nowSubModel.count intValue];
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
                //拍照
//                double addPrice = [model.price doubleValue] * ([model.duration intValue] / [model.interval intValue] * [model.count intValue]);
//                self.totlePrice = self.totlePrice + addPrice;
                int a =_yangzhiTime / [model.interval intValue];
                int b = (a==0)?(a=1):a;
                
                //farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%d", b* [model.count intValue]];
                double addPrice = b* [model.count intValue]*[model.price doubleValue];
                self.totlePrice = self.totlePrice + addPrice;
                
                JZLog(@"ctype4 price = %f  yangZhiFangAnTotlePriceStr = %f",addPrice,self.totlePrice);
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
    
    self.chuShiHuaModel.yangZhiFangAnTotlePriceStr = self.totlePrice;
    
    JZLog(@"目前总价为:%.2f",self.totlePrice);
    
    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"%.2f元",self.totlePrice];
}
@end
