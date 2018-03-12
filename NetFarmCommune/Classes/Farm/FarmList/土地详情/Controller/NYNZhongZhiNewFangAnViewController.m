//
//  NYNZhongZhiNewFangAnViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/6.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNZhongZhiNewFangAnViewController.h"
#import "NYNGouMaiView.h"
#import "JZDatePickerView.h"

#import "NYNFangAnHeaderViewTableViewCell.h"
#import "NYNBoZhongRiQiTableViewCell.h"
#import "NYNZhongZhiZhouQiTableViewCell.h"
#import "NYNShengWuFeiTableViewCell.h"
#import "NYNShiFeiCiShuTableViewCell.h"
#import "NYNMeiCiPaiZhaoTableViewCell.h"
#import "NYNDIYTableViewCell.h"

#import "NYNYangZhiFangAnModel.h"
#import "FTJZSegumentView.h"
#import "NYNDIYTableViewCell.h"
#import "NYNJiaoShuiCiShuViewController.h"

@interface NYNZhongZhiNewFangAnViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *ZhongZhiFangAnTable;
@property (nonatomic,strong) NYNGouMaiView* bottomView;
@property (nonatomic,strong) JZDatePickerView *pickerView;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy)NSString * titleStr;

//当前使用的数组
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) double totlePrice;

@end

@implementation NYNZhongZhiNewFangAnViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"种植方案";
    self.type = @"0";
    [self createZhongZhiUI];
    
    [self reloadPrice];
    
    
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShoW:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

#pragma mark--键盘出现
-(void)keyboardWillShoW:(NSNotification*)note{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.ZhongZhiFangAnTable.frame = CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(45) - 50 - keyBoardRect.size.height);

}
#pragma mark--键盘消失

-(void)keyboardWillHide:(NSNotification*)note{
    self.ZhongZhiFangAnTable.frame = CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(45) - 50);
}

- (void)createZhongZhiUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.ZhongZhiFangAnTable.delegate = self;
    self.ZhongZhiFangAnTable.dataSource = self;
    self.ZhongZhiFangAnTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.ZhongZhiFangAnTable.showsVerticalScrollIndicator = NO;
    self.ZhongZhiFangAnTable.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:self.ZhongZhiFangAnTable];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(50))];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    FTJZSegumentView *ss = [[FTJZSegumentView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headerView.height)];
    
    __weak typeof(self)WeakSelf = self;
    ss.buttonAction = ^(UISegmentedControl *sender) {
        [WeakSelf showLoadingView:@""];
        
        if (sender.selectedSegmentIndex == 0) {
            WeakSelf.type = @"0";
            
            self.dataArr = self.chuShiHuaModel.zhongMoArr;
            
            [WeakSelf.ZhongZhiFangAnTable reloadData];
            
            [WeakSelf hideLoadingView];
            
            [self reloadPrice];
        }else{
            //自定义方案
            WeakSelf.type = @"1";
            
            self.dataArr = self.chuShiHuaModel.zhongZiMoArr;
            
            [WeakSelf.ZhongZhiFangAnTable reloadData];
            
            [WeakSelf hideLoadingView];
            
            [self reloadPrice];

        }
        
//        [self reloadTotlePrice];
    };
    [headerView addSubview:ss];
    
    UIView* xiaLineView = [[UIView alloc]initWithFrame:CGRectMake(0, headerView.height - 0.5, SCREENWIDTH, 0.5)];
    xiaLineView.backgroundColor = Colore3e3e3;
    [headerView addSubview:xiaLineView];
    
    
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(80))];
    footerView.backgroundColor = Colore3e3e3;
    self.ZhongZhiFangAnTable.tableFooterView = footerView;
    
    UILabel *textLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREENWIDTH - 20, footerView.height - 20)];
    textLB.text = @"提示：您选择了施肥，浇水次数后，农场会根据种植经验和作物实 况进行合理分配施肥，浇水时间，如果您想自己制定，可点击自定 义方案进行制定。";
    textLB.font = JZFont(12);
    textLB.textColor = Color888888;
    textLB.numberOfLines = 0;
    [footerView addSubview:textLB];
    
    
    self.bottomView = [[NYNGouMaiView alloc]init];
    [self.bottomView ConfigDataWithIndex:1 withFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) -64, SCREENWIDTH, JZHEIGHT(45))];
    [self.bottomView.goumaiBT setTitle:@"确定" forState:0];
    __weak typeof(self)weakSelf = self;
   
    self.bottomView.goumaiBlock = ^(NSString *strValue) {
        if ( [weakSelf.type  isEqualToString:@"0"]) {
            _titleStr = @"省心方案";
        }else if ([weakSelf.type  isEqualToString:@"1"]){
          _titleStr = @"自定义方案";
            
        }


        if (weakSelf.fangAnDataBack) {
            weakSelf.fangAnDataBack(weakSelf.dataArr,weakSelf.chuShiHuaModel.cycTime,weakSelf.titleStr);
        }
        
        POST_NTF(@"yangZhiNotify", nil);
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:self.bottomView];
    
    self.dataArr = self.chuShiHuaModel.zhongMoArr;
    [self.ZhongZhiFangAnTable reloadData];
    
    
    //这里最后创建pickerview
    [self.view addSubview:self.pickerView];
//    __weak typeof(self) weakSelf = self;
    self.pickerView.MakeClick = ^(NSDate *date) {
        
        for (NYNYangZhiFangAnModel *model in weakSelf.dataArr) {
            if ([model.ctype isEqualToString:@"2"]) {
                model.chooseDate = weakSelf.pickerView.nowDate;
            }
        }
        
        [weakSelf.ZhongZhiFangAnTable reloadData];
    };
    
}


-(UITableView *)ZhongZhiFangAnTable{
    if (!_ZhongZhiFangAnTable) {
        _ZhongZhiFangAnTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT - 64 - JZHEIGHT(45) - 50) style:UITableViewStyleGrouped];
    }
    return _ZhongZhiFangAnTable;
}

- (void)reloadPrice{
    self.totlePrice = 0;
    for (NYNYangZhiFangAnModel *model in self.dataArr) {
        
        if ([model.checked isEqualToString:@"1"]) {
            
            //ctype ==1浇水  ctype ==4拍照  ctype ==0sh'fe
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
                
                JZLog(@"ctype1 price = %f  yangZhiFangAnTotlePriceStr = %f",addPrice,self.totlePrice);

            }
            else if ([model.ctype isEqualToString:@"2"]){
                double addPrice = [model.price doubleValue] * self.yangZhiCount;
                self.totlePrice = self.totlePrice + addPrice;
                
                JZLog(@"ctype2 price = %f  yangZhiFangAnTotlePriceStr = %f",addPrice,self.totlePrice);

            }
            else if ([model.ctype isEqualToString:@"3"]){
                //养殖周期
                  double addPrice = [model.price doubleValue] *  [model.count intValue];
                    self.totlePrice = self.totlePrice + addPrice;
                
            }
            else if ([model.ctype isEqualToString:@"4"]){
                
                int a =_zhongzhiTime/ [model.interval intValue];
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
            }
            
            
            
        }
        
        
        
    }
    
    self.bottomView.heJiLabel.text = [NSString stringWithFormat:@"%.2f元",self.totlePrice];
}


#pragma table相关代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NYNYangZhiFangAnModel *model = self.dataArr[section];
    if ([model.ctype isEqualToString:@"0"]) {
        if ([model.checked isEqualToString:@"0"]) {
            return 1;
        }
        return 2;
    }
    else if ([model.ctype isEqualToString:@"1"]){
        if ([model.checked isEqualToString:@"0"]) {
            return 1;
        }
        return model.subArr.count + 2;
    }
    else if ([model.ctype isEqualToString:@"2"]){
        if ([model.checked isEqualToString:@"0"]) {
            return 1;
        }
        return 2;
    }
//    else if ([model.ctype isEqualToString:@"3"]){
//        if ([model.checked isEqualToString:@"0"]) {
//            return 1;
//        }
//        return 1;
//    }
    else if ([model.ctype isEqualToString:@"4"]){
        if ([model.checked isEqualToString:@"0"]) {
            return 1;
        }
        return 3;
    }
    else{
        
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     //为什么cell要这样写我也不知道，慢慢找
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
            //* self.yangZhiCount
            double pc = [model.price doubleValue] * [model.count intValue]*_yangZhiCount;
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",pc];
            
            return farmLiveTableViewCell;
        }else{
            if ([self.type isEqualToString:@"0"]) {
                NYNShiFeiCiShuTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShiFeiCiShuTableViewCell class]) owner:self options:nil].firstObject;
                }
                
                farmLiveTableViewCell.count = [model.count intValue];
                farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",model.countTitle];
                __weak typeof(self) weakSelf = self;
                farmLiveTableViewCell.tfInputBlock = ^(int count) {
                    model.count = [NSString stringWithFormat:@"%d",count];
                    
                    
                    NSIndexPath *IP = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                    [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[IP] withRowAnimation:UITableViewRowAnimationNone];
                    
                    [weakSelf reloadPrice];
                };
                
                return farmLiveTableViewCell;
            }else{
                NYNDIYTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNDIYTableViewCell class]) owner:self options:nil].firstObject;
                }

                farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",model.countTitle];
                //这里是高度自定义
                farmLiveTableViewCell.countLabel.text = model.count;

                
                __weak typeof(self) weakSelf = self;

                __strong typeof(model) strongModel = model;
                farmLiveTableViewCell.cellClick = ^(NSString *str) {
                    NYNJiaoShuiCiShuViewController *vc = [[NYNJiaoShuiCiShuViewController alloc]init];
                    vc.type = strongModel.farmArtName;
                    vc.monthArr = strongModel.dateArr;

                    vc.clickBack = ^(NSMutableArray *chooseArr, NSMutableArray *chooseDataArr) {
                        JZLog(@"chooseArr:%@ \n  chooseDataArr:%@",chooseArr,chooseDataArr);
                        strongModel.dateArr = chooseArr;
                        strongModel.yiChuLiDataArr = chooseDataArr;
                        strongModel.count = [NSString stringWithFormat:@"%lu",(unsigned long)chooseArr.count];
                        [weakSelf reloadPrice];
                        [weakSelf.ZhongZhiFangAnTable reloadData];
                    };
                    
                    [weakSelf.navigationController pushViewController:vc animated:YES];

                    
                };
                
                return farmLiveTableViewCell;

                
            }
            
            
        }
        
    }
    else if ([model.ctype isEqualToString:@"1"]){
        //施肥
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
            if ([self.type isEqualToString:@"0"]) {
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
                    [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[IP] withRowAnimation:UITableViewRowAnimationNone];
                    
                    [weakSelf reloadPrice];
                    
                };
                
                return farmLiveTableViewCell;
            
            }else{
                NYNDIYTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
                if (farmLiveTableViewCell == nil) {
                    farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNDIYTableViewCell class]) owner:self options:nil].firstObject;
                }
                
                //这里清理出来选中的子单元格
                NYNYangZhiFangAnModel *nowSubModel;
                for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
                    if ([subFirstDataModel.checked isEqualToString:@"1"]) {
                        nowSubModel = subFirstDataModel;
                    }
                }
                
                
                farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",nowSubModel.countTitle];
                //这里是高度自定义
                farmLiveTableViewCell.countLabel.text = nowSubModel.count;
                
                
                __weak typeof(self) weakSelf = self;
                
                __strong typeof(model) strongModel = nowSubModel;
                farmLiveTableViewCell.cellClick = ^(NSString *str) {
                    NYNJiaoShuiCiShuViewController *vc = [[NYNJiaoShuiCiShuViewController alloc]init];
                    vc.type = strongModel.farmArtName;
                    vc.monthArr = strongModel.dateArr;
                    
                    vc.clickBack = ^(NSMutableArray *chooseArr, NSMutableArray *chooseDataArr) {
                        JZLog(@"chooseArr:%@ \n  chooseDataArr:%@",chooseArr,chooseDataArr);
                        strongModel.dateArr = chooseArr;
                        strongModel.yiChuLiDataArr = chooseDataArr;
//                        strongModel.count = [NSString stringWithFormat:@"%lu",(unsigned long)chooseArr.count];
//                        [weakSelf reloadPrice];
//                        [weakSelf.ZhongZhiFangAnTable reloadData];
                        
                        
                        
                        strongModel.count = [NSString stringWithFormat:@"%lu",(unsigned long)chooseArr.count];
                        
//                        NSIndexPath *IP = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
//                        [weakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[IP] withRowAnimation:UITableViewRowAnimationNone];
                        
                        [weakSelf reloadPrice];
                        [weakSelf.ZhongZhiFangAnTable reloadData];
                        
                        
                        
                    };
                    
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                    
                    
                };
                
                return farmLiveTableViewCell;
                
                
            }
            
           
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
                [weakSelf.ZhongZhiFangAnTable reloadSections:st withRowAnimation:UITableViewRowAnimationNone];
                
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
            __weak typeof(self)weakSelf = self;

            farmLiveTableViewCell.cellClick = ^(NSString *s) {
                [weakSelf.pickerView showPickerView];
            };
            
            return farmLiveTableViewCell;
        }
        
    }
//    else if ([model.ctype isEqualToString:@"3"]){
//        //种植zhou'q
//        NYNZhongZhiZhouQiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//        if (farmLiveTableViewCell == nil) {
//            farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNZhongZhiZhouQiTableViewCell class]) owner:self options:nil].firstObject;
//        }
//
//
//        farmLiveTableViewCell.count = self.chuShiHuaModel.cycTime;
//
//        __weak typeof(self)weakSelf = self;
//        farmLiveTableViewCell.clickBlock = ^(int count) {
//            weakSelf.chuShiHuaModel.cycTime = count;
//        };
//
//
//        if ([model.checked isEqualToString:@"1"]) {
//            farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
//        }else{
//            farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
//
//        }
//        return farmLiveTableViewCell;
//
//    }
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
//            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.price doubleValue] * ([model.duration intValue] / [model.interval intValue] * [model.count intValue])];
            
//            int a =_zhongzhiTime/ [model.interval intValue];
       
            int a =_zhongzhiTime/ [model.interval intValue];
            int b = (a==0)?(a=1):a;
            
            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"%f元", b* [model.count intValue]*[model.price doubleValue]];
            
            return farmLiveTableViewCell;
        }
        else if(indexPath.row == 1){
            NYNMeiCiPaiZhaoTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
            if (farmLiveTableViewCell == nil) {
                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNMeiCiPaiZhaoTableViewCell class]) owner:self options:nil].firstObject;
            }
            
            farmLiveTableViewCell.iconLabel.text =@"每次拍照";
            farmLiveTableViewCell.danweiLabel.text= model.unitName;
            farmLiveTableViewCell.count = [model.count intValue];
            
            
            __weak typeof(self)WeakSelf = self;
            farmLiveTableViewCell.clickBlock = ^(int count) {
                model.count = [NSString stringWithFormat:@"%d",count];
                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                [WeakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
                
                
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
            farmLiveTableViewCell.danweiLabel.text= model.unitName;
            farmLiveTableViewCell.count = [model.interval intValue];
            
            __weak typeof(self)WeakSelf = self;
            __weak typeof(farmLiveTableViewCell)WeakFarmLiveTableViewCell = farmLiveTableViewCell;
            
            farmLiveTableViewCell.clickBlock = ^(int count) {
                //[model.duration intValue]
                if ( count>=_zhongzhiTime){
                    WeakFarmLiveTableViewCell.count = [model.duration intValue];
                    
                    [WeakSelf showTextProgressView:@"不能大于周期时间"];
                    [WeakSelf hideLoadingView];
                }
                else if (_zhongzhiTime < 1) {
                    WeakFarmLiveTableViewCell.count = 1;
                    
                    [WeakSelf showTextProgressView:@"不能为小于1"];
                    [WeakSelf hideLoadingView];
                }
                else{
                    model.interval = [NSString stringWithFormat:@"%d",count];
                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                    [WeakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
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
                [WeakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
                
                NSIndexSet *st = [NSIndexSet indexSetWithIndex:indexPath.section];
                [WeakSelf.ZhongZhiFangAnTable reloadSections:st withRowAnimation:UITableViewRowAnimationNone];
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
                [WeakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
                
                [WeakSelf reloadPrice];
                
            };
            
            return farmLiveTableViewCell;
        }
    }
    
//    else if ([model.ctype isEqualToString:@"6"]){
//        if (indexPath.row == 0) {
//            NYNFangAnHeaderViewTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//            if (farmLiveTableViewCell == nil) {
//                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNFangAnHeaderViewTableViewCell class]) owner:self options:nil].firstObject;
//            }
//            if ([model.checked isEqualToString:@"1"]) {
//                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected3");
//            }else{
//                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected2");
//            }
//
//            //这里清理出来选中的子单元格
//            NYNYangZhiFangAnModel *nowSubModel;
//            for (NYNYangZhiFangAnModel *subFirstDataModel in model.subArr) {
//                if ([subFirstDataModel.checked isEqualToString:@"1"]) {
//                    nowSubModel = subFirstDataModel;
//                }
//            }
//
//            farmLiveTableViewCell.iconLabel.text = [NSString stringWithFormat:@"%@",nowSubModel.categoryName];
//
//            farmLiveTableViewCell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[nowSubModel.price doubleValue] * self.yangZhiCount ];
//
//
//
//            return farmLiveTableViewCell;
//        }
//
//        else{
//            NYNShengWuFeiTableViewCell *farmLiveTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
//            if (farmLiveTableViewCell == nil) {
//                farmLiveTableViewCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NYNShengWuFeiTableViewCell class]) owner:self options:nil].firstObject;
//            }
//
//
//            NYNYangZhiFangAnModel *nowSubModel = model.subArr[indexPath.row - 1];
//            farmLiveTableViewCell.iconLabel.text = nowSubModel.farmArtName;
//            farmLiveTableViewCell.danWeiLabel.text = [NSString stringWithFormat:@"￥%@/%@",nowSubModel.price,nowSubModel.unitName];
//            if ([nowSubModel.checked isEqualToString:@"1"]) {
//                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_selected4");
//            }else{
//                farmLiveTableViewCell.chooseImageView.image = Imaged(@"farm_icon_notselected");
//            }
//
//
//            __weak typeof(self)weakSelf = self;
//            farmLiveTableViewCell.cellClick = ^(NSString *s) {
//
//                for (NYNYangZhiFangAnModel *dModel in model.subArr) {
//                    dModel.checked = @"0";
//                }
//                nowSubModel.checked = @"1";
//
//                NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
//                [weakSelf.ZhongZhiFangAnTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
//
//                [weakSelf reloadPrice];
//
//            };
//
//            return farmLiveTableViewCell;
//        }
//
//
//    }
    
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
            [WeakSelf.ZhongZhiFangAnTable reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        };
        
        return farmLiveTableViewCell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {

    }
    return 60;

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
        [self.ZhongZhiFangAnTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        
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

- (JZDatePickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[JZDatePickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, JZHEIGHT(200))];
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _pickerView;
}
@end
